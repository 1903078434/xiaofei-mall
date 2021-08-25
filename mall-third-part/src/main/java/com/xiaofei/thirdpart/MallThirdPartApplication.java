package com.xiaofei.thirdpart;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

/**
 * User: 李飞
 * Date: 2021/7/3
 * Time: 14:41
 */
@EnableDiscoveryClient//注册到nacos中
@ComponentScan({"com.xiaofei.common","com.xiaofei.thirdpart"})
@SpringBootApplication
public class MallThirdPartApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallThirdPartApplication.class, args);
    }
}
