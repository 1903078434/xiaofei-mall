package com.xiaofei.es.entity;

import com.xiaofei.common.dto.SkuESDto;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

/**
 * 商品的检索信息
 * User: 李飞
 * Date: 2021/8/3
 * Time: 15:24
 */
@Data
@NoArgsConstructor
@Document(indexName = "product")//指定和es中哪个索引绑定
public class Product {

    @Id
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

    public Product(Long skuId, Long spuId, String skuTitle, BigDecimal skuPrice, String skuImg, Long saleCount, Boolean hasStock, Long hotScore, Long brandId, Long categoryId, String brandName, String brandImg, String categoryName, List<SkuESDto.Attr> attrs, LocalDateTime addTime, Long commentNum, List<String> suggestion) {
        this.skuId = skuId;
        this.spuId = spuId;
        this.skuTitle = skuTitle;
        this.skuPrice = skuPrice;
        this.skuImg = skuImg;
        this.saleCount = saleCount;
        this.hasStock = hasStock;
        this.hotScore = hotScore;
        this.brandId = brandId;
        this.categoryId = categoryId;
        this.brandName = brandName;
        this.brandImg = brandImg;
        this.categoryName = categoryName;
        this.attrs = attrs;
        this.addTime = addTime;
        this.commentNum = commentNum;
        // 组装suggestion
        if (this.skuTitle.contains(" ")) {
            // business有多个值，需要切割
            String[] arr = this.skuTitle.split(" ");
            // 添加元素
            this.suggestion = new ArrayList<>();
            this.suggestion.add(this.brandName);
            for (String s : arr) {
                if (s.length() > 0) {
                    this.suggestion.add(s);
                }
            }
            Collections.addAll(this.suggestion, arr);
        } else {
            this.suggestion = Arrays.asList(this.brandName, this.skuTitle, this.categoryName);
        }
    }
}
