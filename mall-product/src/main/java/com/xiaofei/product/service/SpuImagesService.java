package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.SpuImagesEntity;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 19:38
 */
public interface SpuImagesService extends IService<SpuImagesEntity> {

    /**
     * 保存商品的图片合集
     *
     * @param id        商品id
     * @param spuImages 商品的图片集
     */
    void saveImages(Long id, List<String> spuImages);
}
