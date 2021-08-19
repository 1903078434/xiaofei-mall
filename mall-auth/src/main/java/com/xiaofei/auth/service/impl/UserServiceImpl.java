package com.xiaofei.auth.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.exception.MallLoginException;
import com.xiaofei.auth.mapper.MemberMapper;
import com.xiaofei.auth.service.UserService;
import com.xiaofei.common.auth.entity.MemberEntity;
import com.xiaofei.common.auth.vo.UserInfoVo;
import com.xiaofei.common.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;
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
public class UserServiceImpl extends ServiceImpl<MemberMapper, MemberEntity> implements UserService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 用户注册
     *
     * @param userInfoVo 用户注册信息
     * @return 返回用户注册是否成功
     */
    @Override
    public Map<String, Object> userRegister(UserInfoVo userInfoVo) {
        Map<String, Object> resp = new HashMap<>();

        //判断用户名或密码是否为空
        if (StringUtils.isEmpty(userInfoVo.getUsername()) || StringUtils.isEmpty(userInfoVo.getPassword())
                || StringUtils.isEmpty(userInfoVo.getEmail()) || userInfoVo.getCode() == null) {
            resp.put("isSuccess", false);
            resp.put("msg", "用户信息必须填写完整");
            return resp;
        }

        //判断用户是否已经注册
        MemberEntity memberEntity = this.getOne(new QueryWrapper<MemberEntity>().eq("username", userInfoVo.getUsername())
                .or().eq("email", userInfoVo.getEmail()));

        //已经被注册
        if (memberEntity != null) {
            resp.put("isSuccess", false);
            resp.put("message", "用户名或邮箱已经被注册，请重新注册");
            return resp;
        }

        //判断验证码是否过期
        Object redisCode = redisTemplate.opsForValue().get(userInfoVo.getEmail() + "registercode");
        if (redisCode == null) {
            resp.put("isSuccess", false);
            resp.put("message", "验证码未发送，请先发送验证码");
            return resp;
        }

        //判断验证码是否正确
        if (userInfoVo.getCode() == redisCode) {
            resp.put("isSuccess", false);
            resp.put("message", "验证码错误");
            return resp;
        }

        //保存用户信息
        memberEntity = new MemberEntity();
        BeanUtils.copyProperties(userInfoVo, memberEntity);
        //密码加密
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String password = passwordEncoder.encode(userInfoVo.getPassword());
        memberEntity.setPassword(password);
        memberEntity.setHeader("https://img0.baidu.com/it/u=4925141,1914114694&fm=26&fmt=auto&gp=0.jpg");//设置头像
        memberEntity.setIntegration(0);//设置初始积分
        memberEntity.setGrowth(0);//设置成长值
        memberEntity.setStatus(1);//设置账号启用状态
        memberEntity.setCreateTime(new Date());//设置注册时间
        this.save(memberEntity);

        resp.put("isSuccess", true);
        resp.put("message", "注册成功");
        return resp;
    }

    /**
     * 用户登录
     *
     * @param userInfoVo 用户登录信息
     * @return 返回token和用户名
     */
    @Override
    public Map<String, Object> userLogin(UserInfoVo userInfoVo) throws MallLoginException {

        String username = userInfoVo.getUsername();
        String password = userInfoVo.getPassword();

        Map<String, Object> resp = new HashMap<>();

        //判断是否输入了用户名或密码
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            resp.put("isSuccess", false);
            resp.put("message", "用户名和密码必须填写");
            return resp;
        }

        //判断用户名或密码的长度是否正确
        if (username.length() < 6 || username.length() > 11 ||
                password.length() < 6 || password.length() > 11) {
            resp.put("isSuccess", false);
            resp.put("message", "用户名或密码格式错误");
            return resp;
        }

        //查询用户信息
        MemberEntity memberEntity = this.getOne(new QueryWrapper<MemberEntity>().eq("username", username));
        if (memberEntity == null) {
            resp.put("isSuccess", false);
            resp.put("message", "用户不存在");
            return resp;
        }

        //判断账号是否是启用状态
        if (memberEntity.getStatus() == null || memberEntity.getStatus() != 1) {
            resp.put("isSuccess", false);
            resp.put("message", "账号已被停用");
            return resp;
        }

        //判断密码是否正确
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if (!passwordEncoder.matches(password, memberEntity.getPassword())) {
            resp.put("isSuccess", false);
            resp.put("message", "密码错误");
            return resp;
        }

        String token = JwtUtils.createToken(memberEntity.getId(), memberEntity.getUsername());

        //将token保存到redis中，设置三十分钟过期
        redisTemplate.opsForValue().set(memberEntity.getUsername() + "token", token, 60 * 30, TimeUnit.SECONDS);

        resp.put("isSuccess", true);
        resp.put("message", "用户登录成功");
        resp.put("username", memberEntity.getUsername());
        resp.put("token", JwtUtils.createToken(memberEntity.getId(), memberEntity.getUsername()));

        return resp;
    }

    /**
     * 退出登录
     *
     * @param username 用户名
     * @return 返回退出信息
     */
    @Override
    public Map<String, Object> loginOut(String username) {

        Map<String, Object> resp = new HashMap<>();

        redisTemplate.delete(username + "token");
        return resp;
    }
}
