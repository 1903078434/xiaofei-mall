package com.xiaofei.auth.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.auth.exception.LoginException;
import com.xiaofei.auth.mapper.MemberMapper;
import com.xiaofei.auth.service.MemberService;
import com.xiaofei.common.auth.entity.MemberEntity;
import com.xiaofei.common.auth.vo.UserLoginVo;
import com.xiaofei.common.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:22
 */
@Service
@Slf4j
public class MemberServiceImpl extends ServiceImpl<MemberMapper, MemberEntity> implements MemberService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 用户登录
     *
     * @param userLoginVo 用户登录信息
     * @return 返回token和用户名
     */
    @Override
    public Map<String, Object> memberLogin(UserLoginVo userLoginVo) throws LoginException {

        Map<String, Object> resp = new HashMap<>();

        //从redis中获取token
        String token = (String) redisTemplate.opsForValue().get(userLoginVo.getUsername() + "token");
        //如果redis中获取到了token，
        if (token != null) {
            //重新设置超时时间，避免用户使用过程中，直接登录过期
            redisTemplate.expire(userLoginVo.getUsername() + "token", 60 * 30, TimeUnit.SECONDS);
            resp.put("username", userLoginVo.getUsername());
            resp.put("token", token);
        }


        //TODO 判断验证码是否一致，如果不一致，也直接抛出异常

        MemberEntity memberEntity = this.getOne(new QueryWrapper<MemberEntity>()
                .eq("username", userLoginVo.getUsername())
                .eq("password", userLoginVo.getPassword()));

        //如果发生错误，则直接返回一个自定义异常
        if (memberEntity == null) {
            throw new LoginException("用户名或密码错误");
        }

        token = JwtUtils.createToken(memberEntity.getId(), memberEntity.getUsername());

        //将token保存到redis中，设置三十分钟过期
        redisTemplate.opsForValue().set(memberEntity.getUsername() + "token", token, 60 * 30, TimeUnit.SECONDS);

        resp.put("username", userLoginVo.getUsername());
        resp.put("token", JwtUtils.createToken(memberEntity.getId(), token));

        return resp;
    }
}
