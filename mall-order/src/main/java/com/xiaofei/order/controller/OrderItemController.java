package com.xiaofei.order.controller;

import com.xiaofei.common.utils.ResponseResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * User: 李飞
 * Date: 2021/8/23
 * Time: 19:52
 */
@Api(tags = "订单项")
@RestController
@RequestMapping("/order/orderitem")
public class OrderItemController {


    @ApiOperation(value = "生成订单项", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping
    public ResponseResult<Object> crateCartItem() {
        return new ResponseResult<>();
    }

}
