package com.xiaofei.cart.comfig;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.MongoDatabaseFactory;
import org.springframework.data.mongodb.MongoTransactionManager;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 10:38
 */
@Configuration
public class MongoTransactionConfig {

    /**
     * MongoDB的事务配置
     */
    @Bean
    MongoTransactionManager transactionManager(MongoDatabaseFactory dbFactory) {
        return new MongoTransactionManager(dbFactory);
    }
}
