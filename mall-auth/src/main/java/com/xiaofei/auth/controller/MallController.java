package com.xiaofei.auth.controller;

import com.xiaofei.auth.service.MallService;
import com.xiaofei.common.auth.vo.MallInfoVo;
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
 * Time: 18:20
 */
@RestController
@RequestMapping("/user/email")
@Api("邮件发送")
public class MallController {

    @Autowired
    private MallService mallService;

    @ApiOperation("发送简单邮件")
    @PostMapping("/sendSimpleEmail")
    public ResponseResult<Map<String, Object>> sendSimpleEmail(@RequestBody MallInfoVo mallInfoVo) {
        Map<String, Object> resp = mallService.sendSimpleEmail(mallInfoVo);
        return new ResponseResult<Map<String, Object>>().success(resp);
    }

}
