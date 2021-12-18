package com.xiaofei.member;

import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;
import com.ruoyi.common.swagger.annotation.EnableCustomSwagger2;
import com.xiaofei.feign.OrderFeignService;
import com.xiaofei.feign.ProductFeignService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = {"com.xiaofei.**", "com.ruoyi.**"})
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients(clients =
        {ProductFeignService.class, OrderFeignService.class})
@SpringBootApplication
public class MallMemberApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallMemberApplication.class, args);
    }

}
