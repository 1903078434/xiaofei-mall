package com.xiaofei.feign;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.coupon.entity.SpuBoundsEntity;
import com.xiaofei.common.dto.SkuReductionDto;
import com.xiaofei.common.dto.SpuBoundsDto;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

   @GetMapping("/coupon/spubounds/{spuId}")
    ResponseResult<SpuBoundsEntity> queryBoundInfoById(@PathVariable("spuId") Long spuId);

 /*    @GetMapping("/coupon/ladder/{skuId}")
    ResponseResult<SkuLadderEntity> querySkuLadderBySkuId(@PathVariable("skuId") Long skuId);*/

    @GetMapping("/coupon/skufullreduction/{skuId}")
    ResponseResult<SkuReductionDto> querySkuDiscountBySkuId(@PathVariable("skuId") Long skuId);

}
