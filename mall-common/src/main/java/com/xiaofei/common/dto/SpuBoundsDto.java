package com.xiaofei.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 20:40
 */
@Data
@ApiModel("spu积分Dto")
public class SpuBoundsDto {

    @ApiModelProperty("spuId")
    private Long spuId;

    @ApiModelProperty("购物积分")
    private BigDecimal buyBounds;

    @ApiModelProperty("成长积分")
    private BigDecimal growBounds;
}
