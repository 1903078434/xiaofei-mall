package com.xiaofei.common.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 16:06
 */
@Data
@ApiModel("商品上架")
public class SkuESDto {

    @ApiModelProperty("skuId----在ES中是唯一的")
    private Long skuId;

    @ApiModelProperty("spuId")
    private Long spuId;

    @ApiModelProperty("商品名称")
    private String skuTitle;//

    @ApiModelProperty("商品价格")
    private BigDecimal skuPrice;//

    @ApiModelProperty("商品默认图片")
    private String skuImg;

    @ApiModelProperty("销量")
    private Long saleCount;

    @ApiModelProperty("是否有库存")
    private Boolean hasStock;

    @ApiModelProperty("热度评分")
    private Long hotScore;

    @ApiModelProperty("品牌Id")
    private Long brandId;

    @ApiModelProperty("商品分类Id")
    private Long catalogId;

    @ApiModelProperty("品牌名称")
    private String brandName;

    @ApiModelProperty("品牌图片")
    private String brandImg;

    @ApiModelProperty("类别名称")
    private String catalogName;

    @ApiModelProperty("属性集合")
    private List<Attr> attrs;

    @Data
    @ApiModel("属性")
    public static class Attr {
        @ApiModelProperty("属性Id")
        private Long attrId;

        @ApiModelProperty("属性名称")
        private String attrName;

        @ApiModelProperty("属性值")
        private String attrValue;

    }
}
