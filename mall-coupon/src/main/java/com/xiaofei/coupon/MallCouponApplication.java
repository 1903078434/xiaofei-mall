package com.xiaofei.coupon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 20:23
 */
@EnableDiscoveryClient //将服务注册到nacos中,需要设置spring.application.name的值
@SpringBootApplication
public class MallCouponApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallCouponApplication.class, args);
    }

}
