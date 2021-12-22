package com.xiaofei.auth.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class AuthServiceTest {

    @Autowired
    private AuthService authService;

    @Test
    void userRegister() {
    }

    @Test
    void userLogin() {
    }

    @Test
    void loginOut() {
    }

    @Test
    void sendSimpleEmail() {
        authService.sendSimpleEmail("1903078434@qq.com");
    }
}
