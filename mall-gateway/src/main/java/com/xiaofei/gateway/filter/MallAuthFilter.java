package com.xiaofei.gateway.filter;


import com.alibaba.fastjson.JSON;
import com.ruoyi.common.core.constant.CacheConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.utils.ServletUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.xiaofei.common.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * 网关过滤，用于权限认证，限流，日志管理，负载均衡等功能
 * User: 李飞
 * Date: 2021/8/14
 * Time: 19:58
 */
@Component
@Slf4j
public class MallAuthFilter implements GlobalFilter, Ordered {

    //设置过期时间
    private static final long EXPIRE_TIME = 60 * 30;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {

        //获取请求路径
        String url = exchange.getRequest().getURI().getPath();

        //判断是否是内部接口
        if (url.contains("internal")) {
            return setUnauthorizedResponse(exchange, "内部接口不能访问");
        }

        //判断请求的资源是否需要登录
        if (url.contains("auth")) {

            //判断token是否为空
            String token = getToken(exchange.getRequest());
            if (StringUtils.isBlank(token)) {
                return setUnauthorizedResponse(exchange, "令牌不能为空");
            }

            //判断token是否过期
            String userName = JwtUtils.getUserName(token);
            Long userId = JwtUtils.getUserId(token);
            Object redisToken = redisTemplate.opsForValue().get(userName + "token");
            if (StringUtils.isNull(redisToken)) {
                return setUnauthorizedResponse(exchange, "登录状态已过期");
            }

            //解析redis中获取的token
            String redisUsername = JwtUtils.getUserName((String) redisToken);
            Long redisUserId = JwtUtils.getUserId((String) redisToken);

            if (StringUtils.isBlank(redisUsername) || redisUserId == null || redisUserId < 1
                    || !Objects.equals(userId, redisUserId) || !userName.equals(redisUsername)) {
                return setUnauthorizedResponse(exchange, "令牌验证失败，请重新登录");
            }

            //给token续过期时间，避免用户操作过程中出现token过期情况
            redisTemplate.expire(redisUsername + "token", EXPIRE_TIME, TimeUnit.SECONDS);

            // 设置用户信息到请求
            ServerHttpRequest mutableReq = exchange.getRequest().mutate().header(CacheConstants.DETAILS_USER_ID, redisUserId + "")
                    .header(CacheConstants.DETAILS_USERNAME, ServletUtils.urlEncode(redisUsername)).build();
            ServerWebExchange mutableExchange = exchange.mutate().request(mutableReq).build();

            return chain.filter(mutableExchange);
        }

        return chain.filter(exchange);
    }

    /**
     * 当没有授权的时候返回给用户的信息
     */
    private Mono<Void> setUnauthorizedResponse(ServerWebExchange exchange, String msg) {
        //获取响应信息
        ServerHttpResponse response = exchange.getResponse();
        //设置请求头内容类型
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);
        //设置响应的状态码
        response.setStatusCode(HttpStatus.OK);

        log.error("未尽授权信息为：{}", msg);
        log.error("[鉴权异常处理]请求路径:{}", exchange.getRequest().getPath());

        // 当请求没有权限的时候返回的信息
        return response.writeWith(Mono.fromSupplier(() -> {
            DataBufferFactory bufferFactory = response.bufferFactory();
            return bufferFactory.wrap(JSON.toJSONBytes(R.fail(HttpStatus.UNAUTHORIZED.value(), msg)));
        }));
    }

    /**
     * 获取请求token
     */
    private String getToken(ServerHttpRequest request) {
        //工具指定的键从请求头中获取信息
        String token = request.getHeaders().getFirst(CacheConstants.HEADER);
        //判断token是否为空，如果不为空，将token添加的前缀替换掉，前端会在token原有的基础上加上一个字符串，防止伪造token
        if (StringUtils.isNotEmpty(token) && token.startsWith(CacheConstants.TOKEN_PREFIX)) {
            token = token.replace(CacheConstants.TOKEN_PREFIX, "");
        }
        return token;
    }

    @Override
    public int getOrder() {
        return 0;
    }
}
