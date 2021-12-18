package com.xiaofei.common.order.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 查询订单项信息
 * User: 李飞
 * Date: 2021/8/24
 * Time: 18:04
 */
@Data
@ApiModel("查询订单信息的条件")
public class OrderItemQueryVo extends BasePage {

    @ApiModelProperty("订单id")
    private String orderId;

    @ApiModelProperty("订单号")
    private String orderSn;

    @ApiModelProperty("订单状态【0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单】")
    private Byte orderStatus;

    @ApiModelProperty("订单产生时间")
    private LocalDateTime addTime;


}
