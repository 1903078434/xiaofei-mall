package com.xiaofei.common.order.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/8/25
 * Time: 13:51
 */
@Data
@ApiModel("订单修改需要的参数")
public class OrderUpdateVo {
    @ApiModelProperty("订单id")
    private Long id;

    @ApiModelProperty("订单编号")
    private String orderSn;

    @ApiModelProperty("订单修改状态")
    private Byte status;
}
