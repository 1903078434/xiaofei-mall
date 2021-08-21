package com.xiaofei.member.feign;

import com.xiaofei.common.product.entity.ProvincesEntity;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 11:25
 */
@FeignClient("mall-product")
public interface ProductFeign {

    @GetMapping("/product/provinces/{id}")
    ResponseResult<ProvincesEntity> queryProvincesById(@PathVariable("id") Long id);
}
