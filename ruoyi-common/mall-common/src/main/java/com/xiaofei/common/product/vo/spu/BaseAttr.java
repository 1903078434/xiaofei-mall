package com.xiaofei.common.product.vo.spu;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("基本属性")
public class BaseAttr {

    @ApiModelProperty("基本属性id")
    private Long attrId;

    @ApiModelProperty("基本属性值")
    private String attrValues;

    @ApiModelProperty("是否快速展示")
    private int showDesc;
}
