package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/8/2
 * Time: 16:29
 */
@ApiModel("产品的基本属性")
@Data
public class ProductAttrValueVo {

    @ApiModelProperty("属性id")
    private Long attrId;

    @ApiModelProperty("属性名")
    private String attrName;

    @ApiModelProperty("属性值")
    private String attrValue;

    @ApiModelProperty("快速展示【是否展示在介绍上；0-否 1-是】")
    private Integer quickShow;
}
