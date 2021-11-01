package com.xiaofei.ware.feign;

import com.ruoyi.common.core.web.domain.AjaxResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 21:25
 */
@FeignClient("mall-product")
public interface ProductFeignService {

    @GetMapping("/product/skuinfo/{skuId}")
    AjaxResult querySpuInfoById(@PathVariable("skuId") Long skuId);

}
