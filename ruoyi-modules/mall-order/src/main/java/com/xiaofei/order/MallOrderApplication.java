package com.xiaofei.order;

import com.ruoyi.common.security.annotation.EnableCustomConfig;
import com.ruoyi.common.security.annotation.EnableRyFeignClients;
import com.ruoyi.common.swagger.annotation.EnableCustomSwagger2;
import com.xiaofei.feign.CartFeignService;
import com.xiaofei.feign.MemberFeignService;
import com.xiaofei.feign.ProductFeignService;
import com.xiaofei.feign.WareFeignService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = {"com.xiaofei.**","com.ruoyi.**"})
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients(clients = {
        CartFeignService.class, WareFeignService.class,
        ProductFeignService.class, MemberFeignService.class
})
@SpringBootApplication
public class MallOrderApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallOrderApplication.class, args);
    }

}
