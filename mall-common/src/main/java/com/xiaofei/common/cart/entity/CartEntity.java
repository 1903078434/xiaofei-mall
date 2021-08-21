package com.xiaofei.common.cart.entity;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 购物车的每一项
 * User: 李飞
 * Date: 2021/8/18
 * Time: 21:58
 */
@Data
public class CartEntity {

    private String id;//购物车id


    private Long userId;//用户id-


    private boolean check = true;//是否选中，默认选中-


    private Long spuId;//spuId-


    private Long skuId;//商品id-


    private String defaultImage;//显示的默认图片-


    private String skuName;//商品名称


    private String saleAttr;//销售属性集合，字符串化的数组或集合


    private BigDecimal skuPrice;//商品单价


    private Integer buyNum = 1;//购物车中的商品数量，默认为一件-


    private BigDecimal totalSkuPrice;//商品总价格


    private Long addTime;//添加时间，保存时间戳

}
