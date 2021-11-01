package com.xiaofei.es.entity;

import com.xiaofei.common.dto.SkuESDto;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.math.BigDecimal;
import java.util.List;

/**
 * 商品的检索信息
 * User: 李飞
 * Date: 2021/8/3
 * Time: 15:24
 */
@Data
@Document(indexName = "product")//指定和es中哪个索引绑定
public class Product {

    @Id
    private Long skuId;//商品id

    @Field(type = FieldType.Keyword)
    private Long spuId;//spuId

    @Field(type = FieldType.Text, analyzer = "ik_smart")
    private String skuTitle;//商品名称

    @Field(type = FieldType.Keyword)
    private BigDecimal skuPrice;//商品价格

    @Field(type = FieldType.Keyword)
    private String skuImg;//商品默认图片

    @Field(type = FieldType.Long)
    private Long saleCount;//销量

    @Field(type = FieldType.Boolean)
    private Boolean hasStock;//是否有库存

    @Field(type = FieldType.Long)
    private Long hotScore;//热度评分

    @Field(type = FieldType.Long)
    private Long brandId;//品牌Id

    @Field(type = FieldType.Long)
    private Long categoryId;//商品分类Id

    @Field(type = FieldType.Keyword, fielddata = true)
    private String brandName;//品牌名称

    @Field(type = FieldType.Long, fielddata = true)
    private String brandImg;//品牌图片

    @Field(type = FieldType.Long, fielddata = true)
    private String categoryName;//属性集合

    @Field(type = FieldType.Nested)
    private List<SkuESDto.Attr> attrs;//属性集合

    @Field(type = FieldType.Long)
    private Long addTime;//时间上传时间戳

    @Field(type = FieldType.Long)
    private Long commentNum = 0L;//评论数量 ，如果不传入评论数量，默认为0条评论

    /**
     * 商品属性
     */
    @Data
    public static class Attr {
        @Field(type = FieldType.Long)
        private Long attrId;//属性Id

        @Field(type = FieldType.Keyword, fielddata = true)
        private String attrName;//属性名称

        @Field(type = FieldType.Keyword)
        private String attrValue;//属性值

    }
}
