package com.xiaofei.thread.pool.config;

import com.xiaofei.thread.pool.bean.ThreadPoolProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.ThreadPoolExecutor;

/**
 * 线程池的自动配置类
 * User: 李飞
 * Date: 2021/12/24
 * Time: 11:49
 */
@Configuration
@EnableConfigurationProperties(ThreadPoolProperties.class)//默认会将ThreadPoolProperties放在容器中
public class ThreadPoolAutoConfiguration {

    @Autowired
    private ThreadPoolProperties threadPoolProperties;

    @Bean
    @ConditionalOnMissingBean(ThreadPoolExecutor.class)//当容器中没有该Bean的时候才创建
    public ThreadPoolExecutor threadPoolService() {
        //使用ThreadPoolExecutor创建一个线程池
        return new ThreadPoolExecutor(
                threadPoolProperties.getCorePoolSize(),
                threadPoolProperties.getMaximumPoolSize(),
                threadPoolProperties.getKeepAliveTime(),
                threadPoolProperties.getUnit(),
                threadPoolProperties.getWorkQueue(),
                threadPoolProperties.getThreadFactory(),
                threadPoolProperties.getHandler()
        );
    }
}
