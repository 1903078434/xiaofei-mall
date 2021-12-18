package com.xiaofei.auth.service.impl;

import cn.hutool.core.util.RandomUtil;
import com.ruoyi.common.redis.service.RedisService;
import com.xiaofei.auth.service.MallService;
import com.xiaofei.common.auth.vo.MallInfoVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 18:25
 */
@Service
@Slf4j
public class MallServiceImpl implements MallService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private RedisService redisService;

    @Value("${spring.mail.username}")
    private String mallUsername;

    /**
     * 发送简单的邮件
     *
     * @param mallInfoVo 注册用户的信息
     * @return true：发送成功。false：发送失败
     */
    @Override
    public Map<String, Object> sendSimpleEmail(MallInfoVo mallInfoVo) {
        Map<String, Object> resp = new HashMap<>();
        try {

            //判断redis中是否已经存在了
            String key = redisService.getCacheObject(mallInfoVo.getRegisterEmail());
            //redisTemplate.opsForValue().get(mallInfoVo.getRegisterEmail());
            if (key != null) {
                resp.put("isSuccess", false);
                resp.put("message", "请2分钟后再发送");
                return resp;
            }

            Random random = new Random();
            //生成一个六位数的随机数
            key = RandomUtil.randomInt(100000, 999999) + "";

            //将key保存到redis中
            redisService.setCacheObject(mallInfoVo.getRegisterEmail()+"registercode"
                    , key, 120L, TimeUnit.SECONDS);
            /*redisTemplate.opsForValue().set(mallInfoVo.getRegisterEmail()+"registercode"
                    , key, 120, TimeUnit.SECONDS);*/

            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false);

            helper.setSubject("通知");
            helper.setText("你的注册验证码为：【 " + key + " 】", true);

            helper.setTo(mallInfoVo.getRegisterEmail());
            helper.setFrom(mallUsername);
            javaMailSender.send(mimeMessage);
        } catch (MessagingException e) {
            log.error("邮件发送错误，错误信息为：{}", e.getMessage());

            //删除redis中的验证码
            redisService.deleteObject(mallInfoVo.getRegisterEmail());
            //redisTemplate.delete(mallInfoVo.getRegisterEmail());

            resp.put("isSuccess", false);
            resp.put("message", "发送失败，系统发生错误");
            return resp;
        }
        resp.put("isSuccess", true);
        resp.put("message", "发送成功");
        return resp;
    }
}
