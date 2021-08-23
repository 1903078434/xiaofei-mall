package com.xiaofei.common.order.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/23
 * Time: 20:00
 */
@Data
@ApiModel("订单生成")
public class OrderVo {

    private List<OrderItemInfo> orderItemInfos;

    @ApiModelProperty("订单总金额")
    private BigDecimal totalAmount;

    private ReceivingInfo receivingInfo;

    @Data
    @ApiModel("每一项商品项")
    public static class OrderItemInfo {
        @ApiModelProperty("商品id")
        private Long skuId;

        @ApiModelProperty("spuId")
        private Long spuId;

        @ApiModelProperty("商品名称")
        private String skuName;

        @ApiModelProperty("商品图片")
        private String skuPic;

        @ApiModelProperty("商品单价")
        private BigDecimal skuPrice;

        @ApiModelProperty("购买数量")
        private Integer skuQuantity = 1;

        @ApiModelProperty("商品销售属性值，保存JSON")
        private String skuAttrsVals;

    }

    @Data
    @ApiModel("收货信息")
    public static class ReceivingInfo {
        @ApiModelProperty("收货人姓名")
        private String receiverName;

        @ApiModelProperty("收货人电话")
        private String receiverPhone;

        @ApiModelProperty("收货人邮编")
        private String receiverPostCode;

        @ApiModelProperty("省份/直辖市")
        private String receiverProvince;

        @ApiModelProperty("城市")
        private String receiverCity;

        @ApiModelProperty("区")
        private String receiverRegion;

        @ApiModelProperty("详细地址")
        private String receiverDetailAddress;
    }

}
