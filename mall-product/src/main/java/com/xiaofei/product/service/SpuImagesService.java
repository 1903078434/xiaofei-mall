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
     * @param spuId     商品id
     * @param spuName   商品名称
     * @param spuImages 商品的图片集
     */
    void saveImages(Long spuId, String spuName, List<String> spuImages);
}
