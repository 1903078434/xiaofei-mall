package com.ruoyi.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 网关启动程序
 *
 * @author 李飞
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class RuoYiGatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(RuoYiGatewayApplication.class, args);
    }
}
