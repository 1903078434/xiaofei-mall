package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.SpuInfoEntity;
import com.xiaofei.common.product.vo.spu.SpuVo;

/**
 * spu信息
 * User: 李飞
 * Date: 2021/7/30
 */
public interface SpuInfoService extends IService<SpuInfoEntity> {

    /**
     * 添加spu的信息和sku的信息
     *
     * @param spuVo 商品信息
     */
    void addSpuInfo(SpuVo spuVo);
}
