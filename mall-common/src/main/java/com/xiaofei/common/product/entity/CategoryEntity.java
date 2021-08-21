package com.xiaofei.common.product.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 商品三级分类
 *
 * @author xiaofei
 * @date 2021-06-26 23:39:45
 */
@ApiModel(description = "Category类")
@Data
@TableName("pms_category")
public class CategoryEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 分类id
     */
    @TableId
    @ApiModelProperty("商品类别id")
    private Long catId;

    /**
     * 分类名称
     */
    @ApiModelProperty("商品类别名称")
    private String name;

    /**
     * 父分类id
     */
    @ApiModelProperty("父分类id")
    private Long parentCid;

    /**
     * 层级
     */
    @ApiModelProperty("商品类别层级")
    private Integer catLevel;

    /**
     * 是否显示[1-未删除，0-已删除]
     */
    @ApiModelProperty("是否删除")
    @TableLogic(value = "1", delval = "0")
    private Integer showStatus=1;

    /**
     * 排序
     */
    @ApiModelProperty("排序等级")
    private Integer sort;

    /**
     * 图标地址
     */
    @ApiModelProperty("图标地址")
    private String icon;

    /**
     * 计量单位
     */
    @ApiModelProperty("计量单位")
    private String productUnit;

    /**
     * 商品数量
     */
    @ApiModelProperty("商品数量")
    private Integer productCount;

    /**
     * 将当前菜单的所有子分类都放到这个children属性里面
     */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)//如果该属性的值为空，将不会带上该值
    @ApiModelProperty("商品类别的子节点")
    private List<CategoryEntity> children;

}
