package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:12
 */
public interface SkuSaleAttrValueService extends IService<SkuSaleAttrValueEntity> {

    /**
     * 获取指定Spu下的所有销售属性
     *
     * @param spuId 商品id
     * @return 指定商品的所有销售属性
     */
    List<SkuDetailInfoVo.SkuItemSaleAttrVo> getSaleAttrBySpuId(Long spuId);
}
