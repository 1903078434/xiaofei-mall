package com.xiaofei.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 17:40
 */
@Data
@ApiModel("保存对应的sku是否有库存")
public class SkuHasStockDto {

    @ApiModelProperty("商品id")
    private Long skuId;

    @ApiModelProperty("是否有库存")
    private Boolean hasStock = true;
}
