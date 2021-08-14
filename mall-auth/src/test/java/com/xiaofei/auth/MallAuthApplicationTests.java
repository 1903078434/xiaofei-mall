package com.xiaofei.auth;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.concurrent.TimeUnit;

@SpringBootTest
class MallAuthApplicationTests {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @DisplayName("redis使用测试")
    @Test
    void redisTest() {
        redisTemplate.opsForValue().set("1903078434@qq.com", "827333", 600, TimeUnit.SECONDS);
        System.out.println("存入redis中的值为："+redisTemplate.opsForValue().get("190307822434@qq.com"));
    }

    @Test
    void contextLoads() {
        //邮件设置1：一个简单的邮件
        SimpleMailMessage message = new SimpleMailMessage();
        message.setSubject("哈哈哈哈");
        message.setText("收到没，收到没");

        message.setTo("2388412425@qq.com");
        message.setFrom("1903078434@qq.com");
        mailSender.send(message);
    }

    @Test
    public void contextLoads2() throws MessagingException {
        //邮件设置2：一个复杂的邮件
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false);

        helper.setSubject("通知");
        helper.setText("<!doctype html>\n" +
                "<html lang=\"en\">\n" +
                "    <head>\n" +
                "        <meta charset=\"UTF-8\">\n" +
                "        <meta name=\"viewport\"\n" +
                "              content=\"width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0\">\n" +
                "        <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n" +
                "        <title>Document</title>\n" +
                "    </head>\n" +
                "    <body>\n" +
                "\n" +
                "        <div>\n" +
                "            <includetail>\n" +
                "                <div align=\"center\">\n" +
                "                    <div class=\"open_email\"\n" +
                "                         style=\"margin-left: 8px; margin-top: 8px; margin-bottom: 8px; margin-right: 8px;\">\n" +
                "                        <div>\n" +
                "                            <br>\n" +
                "                            <span class=\"genEmailContent\">\n" +
                "                        <div id=\"cTMail-Wrap\"\n" +
                "                             style=\"word-break: break-all;box-sizing:border-box;text-align:center;min-width:320px; max-width:660px; border:1px solid #f6f6f6; background-color:#f7f8fa; margin:auto; padding:20px 0 30px; font-family:'helvetica neue',PingFangSC-Light,arial,'hiragino sans gb','microsoft yahei ui','microsoft yahei',simsun,sans-serif\">\n" +
                "                            <div class=\"main-content\" style=\"\">\n" +
                "                                <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse\">\n" +
                "                                    <tbody>\n" +
                "                                    <tr style=\"font-weight:300\">\n" +
                "                                        <td style=\"width:3%;max-width:30px;\"></td>\n" +
                "                                            小飞商城注册邮件发送\n" +
                "                                            <p style=\"height:2px;background-color: #00a4ff;border: 0;font-size:0;padding:0;width:100%;margin-top:20px;\"></p>\n" +
                "\n" +
                "                                            <div id=\"cTMail-inner\"\n" +
                "                                                 style=\"background-color:#fff; padding:23px 0 20px;box-shadow: 0px 1px 1px 0px rgba(122, 55, 55, 0.2);text-align:left;\">\n" +
                "                                                <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse;text-align:left;\">\n" +
                "                                                    <tbody>\n" +
                "\n" +
                "                                                    <tr style=\"font-weight:300\">\n" +
                "                                                        <td style=\"width:3.2%;max-width:30px;\"></td>\n" +
                "                                                        <td style=\"max-width:480px;text-align:left;\">\n" +
                "                                                            <h1 id=\"cTMail-title\"\n" +
                "                                                                style=\"font-size: 20px; line-height: 36px; margin: 0px 0px 22px;\">\n" +
                "                                                                【XX平台】欢迎注册XXXXXX\n" +
                "                                                            </h1>\n" +
                "\n" +
                "                                                            <p id=\"cTMail-userName\"\n" +
                "                                                               style=\"font-size:14px;color:#333; line-height:24px; margin:0;\">\n" +
                "                                                                尊敬的XXX用户，您好！\n" +
                "                                                            </p>\n" +
                "\n" +
                "                                                            <p class=\"cTMail-content\"\n" +
                "                                                               style=\"line-height: 24px; margin: 6px 0px 0px; overflow-wrap: break-word; word-break: break-all;\">\n" +
                "                                                                <span style=\"color: rgb(51, 51, 51); font-size: 14px;\">\n" +
                "                                                                    欢迎注册小飞商城\n" +
                "                                                                </span>\n" +
                "                                                            </p>\n" +
                "\n" +
                "                                                            <p class=\"cTMail-content\"\n" +
                "                                                               style=\"line-height: 24px; margin: 6px 0px 0px; overflow-wrap: break-word; word-break: break-all;\">\n" +
                "                                                                <span style=\"color: rgb(51, 51, 51); font-size: 14px;\">你的注册验证码为\n" +
                "                                                                    <span style=\"font-weight: bold;\">\n" +
                "                                                                        <span style=\"color: deepskyblue;padding: 0 20px\">888888</span>\n" +
                "                                                                        非本人操作可忽略。</span>\n" +
                "                                                                </span>\n" +
                "                                                            </p>\n" +
                "                                                        </td>\n" +
                "                                                        <td style=\"width:3.2%;max-width:30px;\"></td>\n" +
                "                                                    </tr>\n" +
                "                                                    </tbody>\n" +
                "                                                </table>\n" +
                "                                            </div>\n" +
                "\n" +
                "\n" +
                "                                        <strong style=\"margin-top: 30px;display: inline-block\">可以扫下方二维码，多多支持</strong>\n" +
                "                                            <div id=\"cTMail-copy\"\n" +
                "                                                 style=\"text-align:center; font-size:12px; line-height:18px; color:#999\">\n" +
                "                                                <table style=\"width:100%;font-weight:300;margin-bottom:10px;border-collapse:collapse\">\n" +
                "                                                    <tbody>\n" +
                "                                                    <tr style=\"font-weight:300\">\n" +
                "                                                        <td style=\"width:3.2%;max-width:30px;\"></td>\n" +
                "                                                        <td style=\"max-width:540px;\">\n" +
                "\n" +
                "                                                            <p style=\"text-align:center; margin:20px auto 14px auto;font-size:12px;color:#999;\">\n" +
                "                                                                此为系统邮件，请勿回复。\n" +
                "                                                            </p>\n" +
                "\n" +
                "                                                            <p id=\"cTMail-rights\"\n" +
                "                                                               style=\"max-width: 100%; margin:auto;font-size:12px;color:#999;text-align:center;line-height:22px;\">\n" +
                "                                                             <img border=\"0\"\n" +
                "                                                                  src=\"https://xiaofei-mall.oss-cn-beijing.aliyuncs.com/2021-08-14/weixin-pay.png\"\n" +
                "                                                                  style=\"max-width: 100%;max-height: 240px; margin:0 auto;\">\n" +
                "                                                                 <img border=\"0\"\n" +
                "                                                                      src=\"https://xiaofei-mall.oss-cn-beijing.aliyuncs.com/2021-08-14/zfb-pay.jpg\"\n" +
                "                                                                      style=\"max-width: 100%;max-height: 240px;margin-left: 30px \">\n" +
                "\n" +
                "                                                            </p>\n" +
                "                                                        </td>\n" +
                "                                                        <td style=\"width:3.2%;max-width:30px;\"></td>\n" +
                "                                                    </tr>\n" +
                "                                                    </tbody>\n" +
                "                                                </table>\n" +
                "                                            </div>\n" +
                "                                        </td>\n" +
                "                                        <td style=\"width:3%;max-width:30px;\"></td>\n" +
                "                                    </tr>\n" +
                "                                    </tbody>\n" +
                "                                </table>\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                    </span>\n" +
                "                        </div>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </includetail>\n" +
                "        </div>\n" +
                "\n" +
                "\n" +
                "    </body>\n" +
                "</html>\n", true);

        //发送附件
        /*helper.addAttachment("C:\\Users\\LF\\Desktop\\imag\\图片2.jpg",new File(""));
        helper.addAttachment("2.jpg\\5.png",new File(""));*/

        helper.setTo("2640076979@qq.com");
        helper.setFrom("1903078434@qq.com");

        mailSender.send(mimeMessage);
    }

}
