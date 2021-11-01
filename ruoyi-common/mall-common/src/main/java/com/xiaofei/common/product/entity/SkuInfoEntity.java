package com.xiaofei.common.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * sku信息
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-26 23:39:45
 */
@Data
@TableName("pms_sku_info")
@ApiModel("sku基本信息")
public class SkuInfoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    @ApiModelProperty("skuId")
    private Long skuId;

    @ApiModelProperty("spuId")
    private Long spuId;

    @ApiModelProperty("sku名称")
    private String skuName;

    @ApiModelProperty("sku介绍描述")
    private String skuDesc;

    @ApiModelProperty("所属分类id")
    private Long catalogId;

    @ApiModelProperty("品牌id")
    private Long brandId;

    @ApiModelProperty("默认图片")
    private String skuDefaultImg;

    @ApiModelProperty("标题")
    private String skuTitle;

    @ApiModelProperty("副标题")
    private String skuSubtitle;

    @ApiModelProperty("价格")
    private BigDecimal price;

    @ApiModelProperty("销量")
    private Long saleCount = 0L;

}
