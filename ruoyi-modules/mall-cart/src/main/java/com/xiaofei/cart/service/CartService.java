package com.xiaofei.cart.service;

import com.ruoyi.common.core.exception.mall.MallCartException;
import com.xiaofei.cart.entity.CartEntity;
import com.xiaofei.cart.vo.CartReqVo;
import com.xiaofei.cart.vo.CartRespVo;

import java.util.List;

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
     * @param cartReqVos 新的购物车信息集合
     * @return true：添加成功。false：添加失败
     */
    List<String> addCart(Long userId,List<CartReqVo>  cartReqVos) throws MallCartException;

    /**
     * 删除购物车信息
     */
    void deleteCart(String id);

    /**
     * 根据用户id和商品id删除购物车信息
     *
     * @param userId 用户id
     * @param skuIds  商品id
     */
    void deleteCartBySkuId(Long userId, List<Long> skuIds);

    /**
     * 全选和全不选修改
     *
     * @param isCheckAll true：全选。false：全不选
     * @param userId     用户id
     */
    boolean checkAll(boolean isCheckAll, Long userId);

    /**
     * 修改购物车信息
     *
     *
     * @param userId 用户id
     * @param cartReqVo 新的购物车信息
     * @return true：修改成功。false：修改失败
     */
    String updateCart(Long userId, CartReqVo cartReqVo) throws MallCartException;

    /**
     * 根据购物车id查询对应的购物车商品信息
     *
     * @param id 购物车id
     * @return 返回对应的购物车信息
     */
    List<CartEntity> queryCartInfoById(String id);

    /**
     * 根据用户id查询用户购物车信息
     *
     * @param userId 用户id
     * @return 返回指定用户的购物车信息
     */
    CartRespVo queryCartByUserId(Long userId);

    /**
     * 根据id集合查询信息
     */
    List<CartEntity> queryCartsByIds(String id);

    /**
     * 查询指定用户下面的选中的商品信息
     *
     * @param userId 用户id
     * @return 返回被选中的商品信息
     */
    List<CartEntity> queryCheckCart(Long userId);

}
