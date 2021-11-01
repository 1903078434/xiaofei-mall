package com.xiaofei.ware;

import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;
import com.ruoyi.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 15:20
 */
//@EnableFeignClients(basePackages = "com.xiaofei.ware.feign")//开启远程调用服务
//@EnableDiscoveryClient //将服务注册到nacos中,需要设置spring.application.name的值
//@ComponentScan(basePackages = {"com.xiaofei.common","com.xiaofei.ware"})
//@SpringBootApplication
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients
@SpringBootApplication
public class MallWareApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallWareApplication.class, args);
    }

}
