package com.xiaofei.cart.feign;

import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 11:25
 */
@FeignClient("mall-product")
public interface ProductFeign {

    /**
     * 根据skuId查询商品信息
     *
     * @param skuId 商品id
     * @return 返回商品信息
     */
    @GetMapping("/product/skuinfo/{skuId}")
    ResponseResult<SkuInfoEntity> querySkuInfoById(@PathVariable("skuId") Long skuId);

    /**
     * 查询商品的销售属性
     *
     * @param skuId 商品id
     * @return 返回指定商品的销售属性
     */
    @GetMapping("/product/saleattr/{skuId}")
    ResponseResult<List<SkuSaleAttrValueEntity>> querySkuSaleAttrBySkuId(@PathVariable("skuId") Long skuId);

}
