package com.xiaofei.system;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.xiaofei.common.security.annotation.EnableCustomConfig;
import com.xiaofei.common.security.annotation.EnableRyFeignClients;
import com.xiaofei.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 系统模块
 *
 * @author 李飞
 */
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients
@SpringBootApplication
public class MallSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallSystemApplication.class, args);
    }
}
