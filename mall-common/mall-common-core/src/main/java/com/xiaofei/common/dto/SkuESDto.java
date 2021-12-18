package com.xiaofei.common.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 16:06
 */
@Data
public class SkuESDto {

    private Long skuId;//商品id
    private Long spuId;//spuId
    private String skuTitle;//商品名称
    private BigDecimal skuPrice;//商品价格
    private String skuImg;//商品默认图片
    private Long saleCount;//销量
    private Boolean hasStock;//是否有库存
    private Long hotScore;//热度评分
    private Long brandId;//品牌Id
    private Long categoryId;//商品分类Id
    private String brandName;//品牌名称
    private String brandImg;//品牌图片
    private String categoryName;//属性集合
    private LocalDateTime addTime;//时间上传时间戳
    private Long commentNum = 0L;//评论数量 ，如果不传入评论数量，默认为0条评论
    private List<String> suggestion;//自动补全提示功能
    private List<SkuESDto.Attr> attrs;//属性集合
    /**
     * 商品属性
     */
    @Data
    public static class Attr {
        private Long attrId;//属性Id
        private String attrName;//属性名称
        private String attrValue;//属性值
    }
}
