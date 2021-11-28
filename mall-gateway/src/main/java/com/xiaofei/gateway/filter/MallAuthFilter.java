package com.xiaofei.gateway.filter;


import com.ruoyi.common.core.constant.CacheConstants;
import com.ruoyi.common.core.constant.HttpStatus;
import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.constant.TokenConstants;
import com.ruoyi.common.core.utils.ServletUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.redis.service.RedisService;
import com.xiaofei.gateway.utils.JwtUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.server.reactive.ServerHttpRequest;
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
@Order(-1)
@Component
public class MallAuthFilter implements GlobalFilter, Ordered {
    private static final Logger log = LoggerFactory.getLogger(MallAuthFilter.class);


    @Autowired
    private RedisService redisService;


    //设置过期时间
    private static final long EXPIRE_TIME = 60 * 30;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        ServerHttpRequest request = exchange.getRequest();
        ServerHttpRequest.Builder mutate = request.mutate();

        String url = request.getURI().getPath();

        //判断是否是内部接口
        if (url.contains("internal")) {
            return unauthorizedResponse(exchange, "内部接口不能访问");
        }

        //判断请求的资源是否需要登录
        if (url.contains("auth")) {

            //判断token是否为空
            String token = getToken(request);
            if (StringUtils.isBlank(token)) {
                return unauthorizedResponse(exchange, "令牌不能为空");
            }

            //判断token是否过期
            String userName = JwtUtils.getUserName(token);
            Long userId = JwtUtils.getUserId(token);
            Object redisToken = redisService.getCacheObject(userName + "token");
            if (StringUtils.isNull(redisToken)) {
                return unauthorizedResponse(exchange, "登录状态已过期");
            }

            //解析redis中获取的token
            String redisUsername = JwtUtils.getUserName((String) redisToken);
            Long redisUserId = JwtUtils.getUserId((String) redisToken);

            if (StringUtils.isBlank(redisUsername) || redisUserId == null || redisUserId < 1
                    || !Objects.equals(userId, redisUserId) || !userName.equals(redisUsername)) {
                return unauthorizedResponse(exchange, "令牌验证失败，请重新登录");
            }

            //给token续过期时间，避免用户操作过程中出现token过期情况
            redisService.expire(redisUsername + "token", EXPIRE_TIME, TimeUnit.SECONDS);

            // 设置用户信息到请求
            addHeader(mutate, SecurityConstants.DETAILS_USER_ID, userId);
            addHeader(mutate, SecurityConstants.DETAILS_USERNAME, userName);
            // 内部请求来源参数清除
            removeHeader(mutate);
            return chain.filter(exchange.mutate().request(mutate.build()).build());
        }

        // 内部请求来源参数清除
        removeHeader(mutate);
        return chain.filter(exchange.mutate().request(mutate.build()).build());
    }


    private void addHeader(ServerHttpRequest.Builder mutate, String name, Object value) {
        if (value == null) {
            return;
        }
        String valueStr = value.toString();
        String valueEncode = ServletUtils.urlEncode(valueStr);
        mutate.header(name, valueEncode);
    }

    private void removeHeader(ServerHttpRequest.Builder mutate) {
        mutate.headers(httpHeaders -> httpHeaders.remove(SecurityConstants.FROM_SOURCE)).build();
    }

    private Mono<Void> unauthorizedResponse(ServerWebExchange exchange, String msg) {
        log.error("[鉴权异常处理]请求路径:{}", exchange.getRequest().getPath());
        return ServletUtils.webFluxResponseWriter(exchange.getResponse(), msg, HttpStatus.UNAUTHORIZED);
    }

    /**
     * 获取缓存key
     */
    private String getTokenKey(String token) {
        return CacheConstants.LOGIN_TOKEN_KEY + token;
    }

    /**
     * 获取请求token
     */
    private String getToken(ServerHttpRequest request) {
        String token = request.getHeaders().getFirst(TokenConstants.AUTHENTICATION);
        // 如果前端设置了令牌前缀，则裁剪掉前缀
        if (StringUtils.isNotEmpty(token)) {
            assert token != null;
            if (token.startsWith(TokenConstants.PREFIX)) {
                token = token.replaceFirst(TokenConstants.PREFIX, StringUtils.EMPTY);
            }
        }
        return token;
    }

    @Override
    public int getOrder() {
        return -200;
    }
}
