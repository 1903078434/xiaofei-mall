package com.xiaofei.order.controller;

import com.ruoyi.common.core.constant.CacheConstants;
import com.xiaofei.common.exception.OrderException;
import com.xiaofei.common.order.vo.OrderInfoResp;
import com.xiaofei.common.order.vo.OrderVo;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.order.service.OrderService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

/**
 * User: 李飞
 * Date: 2021/8/21
 * Time: 14:14
 */
@Api(tags = "属性和属性分组关联接口")
@RequestMapping("/order/order")
@RestController
public class OrderController {

    @Autowired
    private OrderService orderService;

    @ApiOperation(value = "确认订单信息", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth/orderinfo")
    public ResponseResult<OrderInfoResp> queryOrderInfo(@RequestHeader(name = CacheConstants.DETAILS_USER_ID) Long userId) throws ExecutionException, InterruptedException {
        OrderInfoResp item = orderService.queryOrderInfo(userId);
        return new ResponseResult<OrderInfoResp>().success(item);
    }

    @ApiOperation(value = "生成订单", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth/crate")
    public ResponseResult<Object> crateOrder(@RequestHeader(name = CacheConstants.DETAILS_USER_ID) Long userId,
                                            @RequestHeader(name = CacheConstants.DETAILS_USERNAME) String username,
                                            @RequestBody OrderVo orderVo) throws OrderException {
        orderService.crateOrder(userId,username,orderVo);
        return new ResponseResult<>();
    }

}
