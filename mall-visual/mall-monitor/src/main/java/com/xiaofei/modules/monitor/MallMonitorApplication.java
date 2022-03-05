package com.xiaofei.modules.monitor;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import de.codecentric.boot.admin.server.config.EnableAdminServer;

/**
 * 监控中心
 *
 * @author 李飞
 */
@EnableAdminServer
@SpringBootApplication
public class MallMonitorApplication {
    public static void main(String[] args) {
        SpringApplication.run(MallMonitorApplication.class, args);
    }
}
