package com.xiaofei.common.order.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/8/21
 * Time: 14:41
 */
@Data
@ApiModel("获取订单信息请求")
public class OrderInfoReqVo{

    @ApiModelProperty("购物车id")
    private String cartId;

    //如果还有其他条件再添加了
}
