package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.SpuImagesEntity;
import com.xiaofei.product.mapper.SpuImagesDao;
import com.xiaofei.product.service.SpuImagesService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 19:40
 */
@Service
public class SpuImagesServiceImpl extends ServiceImpl<SpuImagesDao, SpuImagesEntity> implements SpuImagesService {
    /**
     * 保存商品的图片合集
     *
     * @param id        商品id
     * @param spuImages 商品的图片合集
     */
    @Override
    public void saveImages(Long id, List<String> spuImages) {
        if (spuImages != null && spuImages.size() > 0) {

            //给每一张图片设置商品id
            List<SpuImagesEntity> spuImagesEntities = spuImages.stream().map(img -> {
                SpuImagesEntity spuImagesEntity = new SpuImagesEntity();
                spuImagesEntity.setSpuId(id);
                spuImagesEntity.setImgUrl(img);
                return spuImagesEntity;
            }).collect(Collectors.toList());

            //调用批量保存方法，保存每一张图片
            this.saveBatch(spuImagesEntities);
        }
    }
}
