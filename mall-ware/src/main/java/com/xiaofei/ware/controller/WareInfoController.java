package com.xiaofei.ware.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 15:23
 */
@Api(tags = "wareInfo-仓库信息接口")
@RestController
@RequestMapping("/ware/wareinfo")
public class WareInfoController {

    @ApiOperation("测试接口")
    @GetMapping("test")
    public String test() {
        return "Hello World";
    }
}
