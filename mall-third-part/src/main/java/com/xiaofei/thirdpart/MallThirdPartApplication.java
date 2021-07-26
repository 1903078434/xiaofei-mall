package com.xiaofei.thirdpart;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * User: 李飞
 * Date: 2021/7/3
 * Time: 14:41
 */
@EnableDiscoveryClient//注册到nacos中
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, DruidDataSourceAutoConfigure.class})
public class MallThirdPartApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallThirdPartApplication.class, args);
    }
}
