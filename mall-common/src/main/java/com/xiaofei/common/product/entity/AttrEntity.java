package com.xiaofei.common.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 商品属性
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-26 23:39:45
 */
@Data
@ApiModel("商品属性")
@TableName("pms_attr")
public class AttrEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@TableId(type = IdType.AUTO)
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

}
