package com.xiaofei.thirdpart;

import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;
import com.ruoyi.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

/**
 * User: 李飞
 * Date: 2021/7/3
 * Time: 14:41
 */
@ComponentScan(basePackages = {"com.xiaofei.**","com.ruoyi.**"})
@EnableCustomConfig
@EnableRyFeignClients
@EnableCustomSwagger2
@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
public class MallThirdPartApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallThirdPartApplication.class, args);
    }
}
