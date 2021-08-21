package com.xiaofei.order.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:27
 */
@Configuration
@EnableTransactionManagement//开始事务管理，开启之后，只要在方法上标注@Transaction即可使用注解
@MapperScan("com.xiaofei.order.mapper")
public class MyBatisConfig {
}

