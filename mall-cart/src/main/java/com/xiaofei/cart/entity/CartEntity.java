package com.xiaofei.cart.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.math.BigDecimal;

/**
 * 购物车的每一项
 * User: 李飞
 * Date: 2021/8/18
 * Time: 21:58
 */
@Data
@Document("cart")
public class CartEntity {
    @Id
    private String id;//购物车id

    @Field(name = "userId")
    private Long userId;//用户id-

    @Field(name = "check")
    private boolean check = true;//是否选中，默认选中-

    @Field(name = "spuId")
    private Long spuId;//spuId-

    @Field(name = "skuId")
    private Long skuId;//商品id-

    @Field(name = "defaultImage")
    private String defaultImage;//显示的默认图片-

    @Field(name = "skuName")
    private String skuName;//商品名称

    @Field(name = "saleAttr")
    private String saleAttr;//销售属性集合，字符串化的数组或集合

    @Field(name = "skuPrice")
    private BigDecimal skuPrice;//商品单价

    @Field(name = "buyNum")
    private Integer buyNum = 1;//购物车中的商品数量，默认为一件-

    @Field(name = "totalSkuPrice")
    private BigDecimal totalSkuPrice;//商品总价格

}
