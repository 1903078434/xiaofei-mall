package com.xiaofei.cart.repository;

import com.xiaofei.cart.entity.CartEntity;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

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

}
