package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/7/27
 * Time: 12:38
 */
@Data
@ApiModel("商家和类别关联操作")
public class CategoryBrandRelationVo {

    @ApiModelProperty("商家id")
    private Long brandId;

    @ApiModelProperty("分类id")
    private Long catelogId;

}
