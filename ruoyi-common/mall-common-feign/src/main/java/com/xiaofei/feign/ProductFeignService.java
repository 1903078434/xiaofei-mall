package com.xiaofei.feign;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.ProvincesEntity;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.product.entity.SpuInfoEntity;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Set;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 21:25
 */
@FeignClient("mall-product")
public interface ProductFeignService {

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

    @GetMapping("/product/provinces/{id}")
    ResponseResult<ProvincesEntity> queryProvincesById(@PathVariable("id") Integer id);

    @GetMapping("/product/provinces/provincespath/{id}")
    ResponseResult<List<Integer>> findProvincesPath(@PathVariable("id") Integer id);

    @GetMapping("/product/spuinfo/byids")
    ResponseResult<List<SpuInfoEntity>> querySpuInfoByIds(@RequestParam("skuIds") Set<Long> skuIds);


}
