package com.xiaofei.common.cart.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 10:49
 */
@Data
@ApiModel("购物车参数接收")
public class CartReqVo {

    @ApiModelProperty("购物车id")
    private Long id;

    @ApiModelProperty("skuId")
    private Long skuId;

    @ApiModelProperty("spuId")
    private Long spuId;

    @ApiModelProperty("购买数量")
    private Integer buyNum = 1;

    @ApiModelProperty("是否选中")
    private boolean check = true;

    @ApiModelProperty("sku默认图片")
    private String defaultImage;

}
