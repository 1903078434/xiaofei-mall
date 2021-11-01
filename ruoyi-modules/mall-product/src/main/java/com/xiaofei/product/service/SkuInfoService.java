package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;
import com.xiaofei.common.product.vo.SkuInfoVo;
import com.xiaofei.common.vo.PageVo;

import java.util.concurrent.ExecutionException;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:03
 */
public interface SkuInfoService extends IService<SkuInfoEntity> {

    /**
     * 分页查询sku信息
     *
     * @param skuInfoVo 查询条件
     * @return 返回查询的sku信息
     */
    PageVo<SkuInfoEntity> queryByPage(SkuInfoVo skuInfoVo);

    /**
     * 根据skuId查询商品详情页面的信息
     *
     * @param skuId 商品id
     * @return 商品详情页面的信息
     */
    SkuDetailInfoVo querySkuItemInfo(Long skuId) throws ExecutionException, InterruptedException;
}
