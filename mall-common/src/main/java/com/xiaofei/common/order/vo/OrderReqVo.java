package com.xiaofei.common.order.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/24
 * Time: 14:52
 */
@Data
@ApiModel("支付需要的参数")
public class OrderReqVo {

    @ApiModelProperty("订单id")
    private Long orderId;

    @ApiModelProperty("订单号")
    private String orderSn;

    @ApiModelProperty("商品信息")
    private List<OrderReqSkuInfo> skuInfos;

    @Data
    @ApiModel("商品信息")
    public static class OrderReqSkuInfo {
        @ApiModelProperty("商品id")
        private Long skuId;
        @ApiModelProperty("spuId")
        private Long spuId;
        @ApiModelProperty("购买数量")
        private Integer skuQuantity;
    }

    //TODO 等完善支付系统再添加参数
}
