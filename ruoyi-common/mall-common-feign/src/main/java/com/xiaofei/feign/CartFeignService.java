package com.xiaofei.feign;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.xiaofei.common.cart.entity.CartEntity;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/11/23
 * Time: 15:45
 */
@FeignClient("mall-cart")
public interface CartFeignService {

    @PostMapping("/cart/auth/querybyids")
    ResponseResult<List<CartEntity>> queryCartByUserIds(@RequestBody String ids);

    @PostMapping("/cart/auth/querycheckcart")
    ResponseResult<List<CartEntity>> queryCheckCart(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId);

    @DeleteMapping("/cart/auth/byskuids")
    ResponseResult<Boolean> deleteCartBySkuId(@RequestHeader(SecurityConstants.DETAILS_USER_ID) Long userId,
                                              @RequestBody List<Long> skuIds);
}
