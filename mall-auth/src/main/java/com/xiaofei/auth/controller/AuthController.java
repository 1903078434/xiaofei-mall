package com.xiaofei.auth.controller;

import com.ruoyi.common.core.exception.mall.MallLoginException;
import com.xiaofei.auth.service.AuthService;
import com.xiaofei.auth.vo.EmailVo;
import com.xiaofei.auth.vo.UserInfoVo;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/12/22
 * Time: 13:47
 */
@RestController
@RequestMapping("/user")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/sendSimpleEmail")
    public ResponseResult<Map<String, Object>> sendSimpleEmail(@RequestBody EmailVo emailVo) {
        Map<String, Object> resp = authService.sendSimpleEmail(emailVo.getRegisterEmail());
        return new ResponseResult<Map<String, Object>>().success(resp);
    }

    @PostMapping("/login")
    public ResponseResult<Map<String, Object>> userLogin(@RequestBody UserInfoVo userInfoVo) throws MallLoginException {
        Map<String, Object> resp = authService.userLogin(userInfoVo);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }

    @PostMapping("/register")
    public ResponseResult<Map<String, Object>> registerLogin(@RequestBody UserInfoVo userInfoVo) throws MallLoginException {
        Map<String, Object> resp = authService.userRegister(userInfoVo);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }

    @DeleteMapping("/auth/logout")
    public ResponseResult<Map<String, Object>> loginOut(@RequestHeader(name = "username", required = true) String username) throws MallLoginException {
        Map<String, Object> resp = authService.loginOut(username);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }

}
