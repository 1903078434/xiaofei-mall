package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 14:49
 */
@Data
@ApiModel("属性分组和分组下的属性")
public class AttrAndAttrGroupVo implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty("分组id")
    private Long attrGroupId;

    @ApiModelProperty("组名")
    private String attrGroupName;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("描述")
    private String descript;

    @ApiModelProperty("组图标")
    private String icon;

    @ApiModelProperty("所属分类id")
    private Long catelogId;

    @ApiModelProperty("该分组下的属性")
    private List<Attr> attrs;

    @ApiModel("属性类别类")
    @Data
    public static class Attr implements Serializable {
        private static final long serialVersionUID = 1L;

        @ApiModelProperty("属性id")
        private Long attrId;

        @ApiModelProperty("属性名")
        private String attrName;

        @ApiModelProperty("是否需要检索[0-不需要，1-需要]")
        private Byte searchType;

        @ApiModelProperty("值类型。【1：多选。0：单选】")
        private Byte valueType;

        @ApiModelProperty("属性图标")
        private String icon;

        @ApiModelProperty("可选值列表[用逗号分隔]")
        private String valueSelect;

        @ApiModelProperty("属性类型[0-销售属性，1-基本属性]")
        private Byte attrType;

        @ApiModelProperty("启用状态[0 - 禁用，1 - 启用]")
        private Long enable;

        @ApiModelProperty("所属分类")
        private Long catelogId;

        @ApiModelProperty("快速展示【是否展示在介绍上；0-否 1-是】")
        private Byte showDesc;

        @ApiModelProperty("分组id")
        private Long attrGroupId;
    }
}
