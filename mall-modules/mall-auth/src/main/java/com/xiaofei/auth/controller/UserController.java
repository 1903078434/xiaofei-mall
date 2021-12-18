package com.xiaofei.auth.controller;

import com.ruoyi.common.core.exception.mall.MallLoginException;
import com.xiaofei.auth.service.UserService;
import com.xiaofei.common.auth.vo.UserInfoVo;
import com.xiaofei.common.utils.ResponseResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:32
 */
@Api(tags = "用户接口")
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService memberService;

    @ApiOperation(value = "用户登录", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/login")
    public ResponseResult<Map<String, Object>> userLogin(@RequestBody UserInfoVo userInfoVo) throws MallLoginException {
        Map<String, Object> resp = memberService.userLogin(userInfoVo);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }

    @ApiOperation(value = "用户注册", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/register")
    public ResponseResult<Map<String, Object>> registerLogin(@RequestBody UserInfoVo userInfoVo) throws MallLoginException {
        Map<String, Object> resp = memberService.userRegister(userInfoVo);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }

    @ApiOperation(value = "退出登录", httpMethod = "DELETE", response = ResponseResult.class, produces = "application/json")
    @DeleteMapping("/auth/logout")
    public ResponseResult<Map<String, Object>> loginOut(@RequestHeader(name = "username",required = true) String username) throws MallLoginException {
        Map<String, Object> resp = memberService.loginOut(username);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }


}
