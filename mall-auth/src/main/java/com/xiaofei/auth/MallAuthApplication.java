package com.xiaofei.auth;

import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;
import com.xiaofei.feign.MemberFeignService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = {"com.xiaofei.**", "com.ruoyi.**"})
@EnableCustomConfig
@EnableRyFeignClients(clients =
        {MemberFeignService.class})
@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
public class MallAuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallAuthApplication.class, args);
    }

}
