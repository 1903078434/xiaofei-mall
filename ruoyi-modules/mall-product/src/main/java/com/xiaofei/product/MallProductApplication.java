package com.xiaofei.product;

import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;
import com.xiaofei.feign.CouponFeignService;
import com.xiaofei.feign.SearchFeignService;
import com.xiaofei.feign.WareFeignService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

/**
 * User: 李飞
 * Date: 2021/11/23
 * Time: 11:15
 */
@ComponentScan(basePackages = {"com.xiaofei.**", "com.ruoyi.**"})
@EnableCustomConfig
@EnableRyFeignClients(clients =
        {CouponFeignService.class, WareFeignService.class, SearchFeignService.class})
@SpringBootApplication
public class MallProductApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallProductApplication.class, args);
    }
}
