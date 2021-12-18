package com.xiaofei.common.cart.vo;

import com.xiaofei.common.cart.entity.CartEntity;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * 返回购物车信息
 * User: 李飞
 * Date: 2021/8/20
 * Time: 10:56
 */
@Data
public class CartRespVo {

    private List<CartEntity> items;

    private Integer totalCount;//购物车商品数量

    private BigDecimal totalPrice;//选中商品的价格总数

    private boolean checkAll = false;//是否全部选中了

    private Integer totalCheck;//选中的数量

}
