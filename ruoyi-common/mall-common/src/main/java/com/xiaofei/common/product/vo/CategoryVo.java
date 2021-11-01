package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 用于接收前端传过来商品类别的数据
 * User: 李飞
 * Date: 2021/7/24
 * Time: 16:12
 */
@ApiModel("商品类别")
@Data
public class CategoryVo implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty("商品类别id")
    private Long catId;

    @ApiModelProperty("商品类别名称")
    private String name;

    @ApiModelProperty("父分类id")
    private Long parentCid;

    @ApiModelProperty("商品类别层级")
    private Integer catLevel;

    @ApiModelProperty("排序等级")
    private Integer sort;



}
