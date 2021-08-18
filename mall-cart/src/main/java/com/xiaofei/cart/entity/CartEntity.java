package com.xiaofei.cart.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.math.BigDecimal;

/**
 * User: 李飞
 * Date: 2021/8/18
 * Time: 21:58
 */
@Data
@Document("cart")
public class CartEntity {
    @Id
    private String id;

    private Long skuId;

    private boolean check;

    private String skuTitle;

    private String defaultImage;

    private BigDecimal price;

    private Integer count = 1;

    private BigDecimal totalPrice;

    private SkuSaleInfo skuSaleInfo;

    public static class  SkuSaleInfo{
    }
}
