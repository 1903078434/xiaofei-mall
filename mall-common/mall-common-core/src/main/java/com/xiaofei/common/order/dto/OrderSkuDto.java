package com.xiaofei.common.order.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 购买数量
 * User: 李飞
 * Date: 2021/8/23
 * Time: 21:57
 */
@ApiModel("购买数量")
@Data
public class OrderSkuDto {

    @ApiModelProperty("商品id")
    private Long skuId;

    @ApiModelProperty("购买的数量")
    private Integer buyNum;

    @ApiModelProperty("商品名称")
    private String skuName;
}
