package com.xiaofei.member;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

@EnableFeignClients //feign的远程调用功能
@EnableDiscoveryClient //将服务注册到nacos中,需要设置spring.application.name的值
@ComponentScan(basePackages = {"com.xiaofei.common","com.xiaofei.member"})
@SpringBootApplication
public class MallMemberApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallMemberApplication.class, args);
    }

}
