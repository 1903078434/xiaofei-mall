package com.xiaofei.file;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import com.xiaofei.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 文件服务
 *
 * @author 李飞
 */
@EnableCustomSwagger2
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class MallFileApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallFileApplication.class, args);
    }
}
