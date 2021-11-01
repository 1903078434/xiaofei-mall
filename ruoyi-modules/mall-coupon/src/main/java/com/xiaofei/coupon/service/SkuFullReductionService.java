package com.xiaofei.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.coupon.entity.SkuFullReductionEntity;
import com.xiaofei.common.dto.SkuReductionDto;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:17
 */
public interface SkuFullReductionService extends IService<SkuFullReductionEntity> {

    /**
     * 保存商品的折扣信息和优惠信息
     *
     * @param skuReductionDto 商品的优惠信息
     */
    boolean saveSkuReduction(SkuReductionDto skuReductionDto);
}
