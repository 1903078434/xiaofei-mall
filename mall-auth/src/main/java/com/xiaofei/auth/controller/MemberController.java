package com.xiaofei.auth.controller;

import com.xiaofei.auth.exception.LoginException;
import com.xiaofei.auth.service.MemberService;
import com.xiaofei.common.auth.vo.UserLoginVo;
import com.xiaofei.common.utils.ResponseResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:32
 */
@Api(tags = "用户接口")
@RestController
@RequestMapping("/member/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @ApiOperation(value = "用户登录", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/login")
    public ResponseResult<Map<String, Object>> memberLogin(@RequestBody UserLoginVo userLoginVo) throws LoginException {
        Map<String, Object> resp = memberService.memberLogin(userLoginVo);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }
}
