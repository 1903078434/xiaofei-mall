package com.xiaofei.member.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * User: 李飞
 * Date: 2021/8/12
 * Time: 17:11
 */
@Configuration
public class MyThreadConfig {

    @Bean
    public ThreadPoolExecutor threadPoolExecutor() {
        // TODO 这里应该将这些参数的值设置为可配置的，具体的可以看SpringBoot的启动器怎么编写

        //使用ThreadPoolExecutor创建一个线程池
        return new ThreadPoolExecutor(20,
                200, 10, TimeUnit.SECONDS,
                new LinkedBlockingDeque<>(100000), Executors.defaultThreadFactory(),
                new ThreadPoolExecutor.AbortPolicy());
    }
}
