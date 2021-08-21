package com.xiaofei.order.config;

import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * 基础配置项
 * User: 李飞
 * Date: 2021/8/21
 * Time: 14:15
 */
@EnableFeignClients(basePackages = "com.xiaofei.order.feign")//开去远程调用功能
@EnableDiscoveryClient //将服务注册到nacos中,需要设置spring.application.name的值
@ComponentScan({"com.xiaofei.order","com.xiaofei.common"})
@Configuration
public class MallBaseConfig {
}
