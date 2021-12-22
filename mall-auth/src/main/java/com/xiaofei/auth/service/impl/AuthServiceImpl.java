package com.xiaofei.auth.service.impl;

import cn.hutool.core.util.RandomUtil;
import com.ruoyi.common.redis.service.RedisService;
import com.xiaofei.auth.service.AuthService;
import com.xiaofei.auth.vo.UserInfoVo;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.utils.JwtUtils;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.feign.MemberFeignService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

/**
 * User: 李飞
 * Date: 2021/12/22
 * Time: 13:48
 */
@Service
public class AuthServiceImpl implements AuthService {

    private static final Logger log = LoggerFactory.getLogger(AuthServiceImpl.class);

    @Autowired
    private RedisService redisService;

    @Autowired
    private MemberFeignService memberFeignService;

    @Autowired
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String mallUsername;

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
        ResponseResult<MemberEntity> memberResp = memberFeignService.queryMemberByUserNameOrEmail(userInfoVo.getUsername(), userInfoVo.getEmail());
        MemberEntity memberEntity = memberResp.getData();

        //已经被注册
        if (memberEntity != null) {
            resp.put("isSuccess", false);
            resp.put("message", "用户名或邮箱已经被注册，请重新注册");
            return resp;
        }

        //判断验证码是否过期
        Object redisCode = redisService.getCacheObject(userInfoVo.getEmail() + "registercode");
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
        ResponseResult<Boolean> registerResp = memberFeignService.registerLogin(memberEntity);

        resp.put("isSuccess", registerResp.getData());
        resp.put("message", registerResp.getData() ? "注册成功" : "注册失败");
        return resp;
    }

    /**
     * 用户登录
     *
     * @param userInfoVo 用户登录信息
     * @return 返回token和用户名
     */
    @Override
    public Map<String, Object> userLogin(UserInfoVo userInfoVo) {

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
        ResponseResult<MemberEntity> memberResp = memberFeignService.queryMemberByUserName(username);
        MemberEntity memberEntity = memberResp.getData();
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
        redisService.setCacheObject(memberEntity.getUsername() + "token", token, 60 * 30L, TimeUnit.SECONDS);

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

        //redisTemplate.delete(username + "token");
        redisService.deleteObject(username + "token");
        return resp;
    }

    /**
     * 发送简单的邮件
     *
     * @param registerEmail 用户注册的邮箱
     * @return true：发送成功。false：发送失败
     */
    @Override
    public Map<String, Object> sendSimpleEmail(String registerEmail) {
        Map<String, Object> resp = new HashMap<>();
        try {

            //判断redis中是否已经存在了
            String key = redisService.getCacheObject(registerEmail);
            if (key != null) {
                resp.put("isSuccess", false);
                resp.put("message", "请2分钟后再发送");
                return resp;
            }

            Random random = new Random();
            //生成一个六位数的随机数
            key = RandomUtil.randomInt(100000, 999999) + "";

            //将key保存到redis中
            redisService.setCacheObject(registerEmail + "registercode"
                    , key, 120L, TimeUnit.SECONDS);

            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false);

            helper.setSubject("通知");
            helper.setText("你的注册验证码为：【 " + key + " 】", true);

            helper.setTo(registerEmail);
            helper.setFrom(mallUsername);
            javaMailSender.send(mimeMessage);
        } catch (MessagingException e) {
            log.error("邮件发送错误，错误信息为：{}", e.getMessage());

            //删除redis中的验证码
            redisService.deleteObject(registerEmail);

            resp.put("isSuccess", false);
            resp.put("message", "发送失败，系统发生错误");
            return resp;
        }
        resp.put("isSuccess", true);
        resp.put("message", "发送成功");
        return resp;
    }
}
