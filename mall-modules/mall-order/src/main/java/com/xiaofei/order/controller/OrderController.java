package com.xiaofei.order.controller;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.exception.mall.OrderException;
import com.xiaofei.common.order.vo.*;
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
@Api(tags = "订单信息修该")
@RequestMapping("/order/order")
@RestController
public class OrderController {

    @Autowired
    private OrderService orderService;

    @ApiOperation(value = "确认订单信息", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth/orderinfo")
    public ResponseResult<OrderInfoResp> queryOrderInfo(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId) throws ExecutionException, InterruptedException {
        OrderInfoResp item = orderService.queryOrderInfo(userId);
        return new ResponseResult<OrderInfoResp>().success(item);
    }

    @ApiOperation(value = "生成订单", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth/crate")
    public ResponseResult<OrderRespVo> crateOrder(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                  @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                                  @RequestBody OrderVo orderVo) throws OrderException {
        OrderRespVo orderRespVo = orderService.crateOrder(userId, username, orderVo);
        return new ResponseResult<OrderRespVo>().success(orderRespVo);
    }

    @ApiOperation(value = "修改订单", httpMethod = "PUT", response = ResponseResult.class, produces = "application/json")
    @PutMapping("/auth")
    public ResponseResult<Boolean> updateOrder(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                               @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                               @RequestBody OrderUpdateVo orderUpdateVo) {
        boolean isUpdate = orderService.updateOrder(userId, username, orderUpdateVo);
        return new ResponseResult<Boolean>().success(isUpdate);
    }

    @ApiOperation(value = "管理员修改订单", httpMethod = "PUT", response = ResponseResult.class, produces = "application/json")
    @PutMapping("/internal")
    public ResponseResult<Boolean> updateOrder(@RequestBody OrderUpdateVo orderUpdateVo) {
        boolean isUpdate = orderService.updateOrder(orderUpdateVo);
        return new ResponseResult<Boolean>().success(isUpdate);
    }

    @ApiOperation(value = "订单支付", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth/orderpay")
    public ResponseResult<Boolean> orderPay(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                            @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                            @RequestBody OrderReqVo orderReqVo) throws OrderException {
        boolean isSuccess = orderService.orderPay(userId, username, orderReqVo);
        return new ResponseResult<Boolean>().success(isSuccess ? "支付成功" : "支付失败", isSuccess);
    }

    @ApiOperation(value = "查询付款的订单信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/auth/orderpay")
    public ResponseResult<OrderItemResp> payOrderInfo(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                      @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                                      OrderRespVo orderRespVo) throws OrderException {
        OrderItemResp item = orderService.payOrderInfo(userId, username, orderRespVo);
        return new ResponseResult<OrderItemResp>().success(item);
    }

}
