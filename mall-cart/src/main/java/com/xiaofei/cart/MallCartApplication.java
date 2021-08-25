package com.xiaofei.cart;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

@EnableFeignClients(basePackages = "com.xiaofei.cart.feign")
@SpringBootApplication
@ComponentScan(basePackages = {"com.xiaofei.common", "com.xiaofei.cart"})//扫描Spring的资源在哪里
@EnableDiscoveryClient
public class MallCartApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallCartApplication.class, args);
    }

}
