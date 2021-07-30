package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * User: 李飞
 * Date: 2021/7/29
 * Time: 10:39
 */
@Data
@ApiModel("属性分组和属性的关联表")
public class AttrAttrGroupRelationVo implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty("属性id")
    private Long attrId;

    @ApiModelProperty("属性分组id")
    private Long attrGroupId;

    //@ApiModelProperty("属性组内排序")
    //private Integer attrSort = 0;

    @ApiModelProperty("属性名")
    private String attrName;

    @ApiModelProperty("可选值列表[用逗号分隔]")
    private String valueSelect;
}
