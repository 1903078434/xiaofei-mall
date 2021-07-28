package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * User: 李飞
 * Date: 2021/7/28
 * Time: 17:11
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("商品属性")
@AllArgsConstructor
@NoArgsConstructor
public class AttrVo extends BasePage {

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
    private Long catelogId = 0L;

    @ApiModelProperty("所属分类名称")
    private String categoryName;

    @ApiModelProperty("所属分组id")
    private Long attrGroupId;

    @ApiModelProperty("所属分组名称")
    private String attrGroupName;

    @ApiModelProperty("快速展示【是否展示在介绍上；0-否 1-是】")
    private Byte showDesc;

    @ApiModelProperty("所属分类的路径")
    private Long[] catelogPath;


}
