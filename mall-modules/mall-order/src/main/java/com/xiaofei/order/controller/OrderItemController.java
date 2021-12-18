package com.xiaofei.order.controller;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.xiaofei.common.order.vo.OrderItemQueryVo;
import com.xiaofei.common.order.vo.OrderItemResp;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.order.service.OrderItemService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
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

    @Autowired
    private OrderItemService orderItemService;

    @ApiOperation(value = "查询付款的订单信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/auth/orderitems")
    public ResponseResult<PageVo<OrderItemResp>> queryOrderItemInfo(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                                    @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                                                    OrderItemQueryVo orderItemQueryVo) {
        PageVo<OrderItemResp> page = orderItemService.queryOrderItemInfo(userId, username, orderItemQueryVo);

        return new ResponseResult<PageVo<OrderItemResp>>().success(page);
    }

    @ApiOperation(value = "内部管理员查询所有订单信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/internal/orderitems")
    public ResponseResult<PageVo<OrderItemResp>> queryAllByPage(OrderItemQueryVo orderItemQueryVo) {
        PageVo<OrderItemResp> page = orderItemService.queryAllByPage(orderItemQueryVo);

        return new ResponseResult<PageVo<OrderItemResp>>().success(page);
    }


}
