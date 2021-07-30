package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.ProductAttrValueEntity;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 19:43
 */
public interface ProductAttrValueService extends IService<ProductAttrValueEntity> {

    /**
     * 添加spu的基本属性
     *
     * @param spuId    spuId
     * @param entities 指定spuId设置的所有基本属性
     */
    void updateSpuAttr(Long spuId, List<ProductAttrValueEntity> entities);
}
