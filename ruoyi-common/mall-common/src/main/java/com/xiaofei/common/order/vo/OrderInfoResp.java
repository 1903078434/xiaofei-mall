package com.xiaofei.common.order.vo;

import com.xiaofei.common.cart.entity.CartEntity;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/21
 * Time: 14:45
 */
@Data
@ApiModel("订单确认页面需要的信息")
public class OrderInfoResp implements Serializable {
    private static final long serialVersionUID = 1L;

    //所有的收获地址
    private List<MemberReceiveAddressEntity> receiveAddress;

    //商品信息
    private CartInfo cartInfo;

    //是否有商品没有库存，false：没有商品没有库存的。true：有商品没有库存
    private boolean hasStock = false;


    @Data
    public static class CartInfo {
        private List<CartEntity> items;

        private Integer totalCount;//购物车商品数量

        private BigDecimal totalPrice;//选中商品的价格总数
    }
}
