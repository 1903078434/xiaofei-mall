package com.ruoyi.file;

import com.ruoyi.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import com.ruoyi.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 文件服务
 *
 * @author 李飞
 */
@EnableCustomSwagger2
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class RuoYiFileApplication {
    public static void main(String[] args) {
        SpringApplication.run(RuoYiFileApplication.class, args);
    }
}
