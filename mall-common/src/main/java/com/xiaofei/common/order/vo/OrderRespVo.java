package com.xiaofei.common.order.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 返回给用户需要的订单参数，用于结算部分
 * User: 李飞
 * Date: 2021/8/24
 * Time: 12:48
 */
@Data
@ApiModel("订单结算需要的参数")
public class OrderRespVo {

    @ApiModelProperty("订单id")
    private Long orderId;

    @ApiModelProperty("订单号")
    private String orderSn;
}
