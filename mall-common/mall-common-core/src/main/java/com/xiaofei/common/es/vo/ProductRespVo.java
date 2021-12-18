package com.xiaofei.common.es.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * User: 李飞
 * Date: 2021/8/10
 * Time: 22:02
 */
@Data
@ApiModel("返回查询出来的商品信息")
public class ProductRespVo {
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
    private Long categoryId;

    @ApiModelProperty("品牌名称")
    private String brandName;

    @ApiModelProperty("品牌图片")
    private String brandImg;

    @ApiModelProperty("类别名称")
    private String categoryName;

    @ApiModelProperty("商品添加的时间戳")
    private Long addTime;//时间上传时间戳

    @ApiModelProperty("评论数量 ，如果不传入评论数量，默认为0条评论")
    private Long commentNum = 0L;

    @ApiModelProperty("高亮属性值")
    private String highlightFields;
}
