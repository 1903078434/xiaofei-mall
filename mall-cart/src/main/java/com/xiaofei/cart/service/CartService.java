package com.xiaofei.cart.service;

import com.xiaofei.cart.entity.CartEntity;
import com.xiaofei.common.cart.vo.CartReqVo;
import com.xiaofei.common.exception.MallCartException;

/**
 * 购物车
 * User: 李飞
 * Date: 2021/8/19
 * Time: 10:58
 */
public interface CartService {

    /**
     * 添加购物车信息
     *
     * @param cartReqVo 新的购物车信息
     * @return true：添加成功。false：添加失败
     */
    String addCart(CartReqVo cartReqVo) throws MallCartException;

    /**
     * 删除购物车信息
     */
    void deleteCart(String id);

    /**
     * 修改购物车信息
     *
     * @param cartReqVo 新的购物车信息
     * @return true：修改成功。false：修改失败
     */
    String updateCart(CartReqVo cartReqVo) throws MallCartException;

    /**
     * 根据购物车id查询对应的购物车商品信息
     *
     * @param id 购物车id
     * @return 返回对应的购物车信息
     */
    CartEntity queryCartInfoById(String id);
}
