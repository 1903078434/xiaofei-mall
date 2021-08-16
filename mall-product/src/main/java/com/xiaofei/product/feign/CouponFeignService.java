package com.xiaofei.product.feign;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.dto.SkuReductionDto;
import com.xiaofei.common.dto.SpuBoundsDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 20:51
 */
@FeignClient("mall-coupon")//设置调用哪个远程服务
public interface CouponFeignService {

    @PostMapping("/coupon/spubounds/internal")
    AjaxResult addSpuBounds(@RequestBody SpuBoundsDto spuBoundsDto);

    @PostMapping("/coupon/skufullreduction/internal")
    AjaxResult saveSkuReduction(@RequestBody SkuReductionDto skuReductionDto);
}
