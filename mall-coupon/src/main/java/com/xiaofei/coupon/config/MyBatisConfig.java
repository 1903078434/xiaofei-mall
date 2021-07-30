package com.xiaofei.coupon.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:27
 */
@Configuration
@EnableTransactionManagement//开启事务注解
@MapperScan("com.xiaofei.coupon.mapper")
public class MyBatisConfig {
}

