package com.xiaofei.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MallAuthApplication {

    /*static {
        System.setProperty("druid.mysql.usePingMethod", "false");
    }*/

    public static void main(String[] args) {
        SpringApplication.run(MallAuthApplication.class, args);
    }

}
