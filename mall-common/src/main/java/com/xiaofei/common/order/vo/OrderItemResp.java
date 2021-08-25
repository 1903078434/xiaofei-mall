package com.xiaofei.common.order.vo;

import com.xiaofei.common.order.entity.OrderEntity;
import com.xiaofei.common.order.entity.OrderItemEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/24
 * Time: 13:18
 */
@Data
@ApiModel("返回的订单信息")
public class OrderItemResp {

    @ApiModelProperty("订单信息")
    private OrderEntity orderEntity;

    @ApiModelProperty("指定订单下面的订单项")
    private List<OrderItemEntity> orderItemEntitys;

}
