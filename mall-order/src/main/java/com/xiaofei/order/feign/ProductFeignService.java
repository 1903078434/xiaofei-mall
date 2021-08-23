package com.xiaofei.order.feign;

import com.xiaofei.common.product.entity.SpuInfoEntity;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Set;

/**
 * User: 李飞
 * Date: 2021/8/21
 * Time: 15:10
 */
@FeignClient("mall-product")
public interface ProductFeignService {

    @GetMapping("/product/spuinfo/byids")
    ResponseResult<List<SpuInfoEntity>> querySpuInfoByIds( @RequestParam("skuIds") Set<Long> skuIds);

}
