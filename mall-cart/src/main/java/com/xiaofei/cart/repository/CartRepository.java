package com.xiaofei.cart.repository;

import com.xiaofei.cart.entity.CartEntity;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 11:03
 */
@Repository
public interface CartRepository extends MongoRepository<CartEntity, String> {

    /**
     * 根据用户id和购物车项id查询购物车信息
     *
     * @param userId 用户id
     * @param spuId  spuId
     * @param skuId  skuId
     * @return 返回查询到的用户信息
     */
    CartEntity findByUserIdAndSpuIdAndSkuId(Long userId, Long spuId, Long skuId);

    /**
     * 根据用户id查询用户购物车信息
     *
     * @param userId 用户id
     * @return 返回指定用户的购物车信息
     */
    List<CartEntity> findByUserId(Long userId);

    /**
     * 查询指定用户下面的选中的商品信息
     *
     * @param userId 用户id
     * @param check  true：选中。false：未选中
     * @return 返回被选中的商品信息
     */
    List<CartEntity> findByUserIdAndCheck(Long userId, boolean check);

}
