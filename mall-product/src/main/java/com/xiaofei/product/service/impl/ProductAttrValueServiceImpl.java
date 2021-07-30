package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.ProductAttrValueEntity;
import com.xiaofei.product.mapper.ProductAttrValueDao;
import com.xiaofei.product.service.ProductAttrValueService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 19:44
 */
@Service
public class ProductAttrValueServiceImpl extends ServiceImpl<ProductAttrValueDao, ProductAttrValueEntity> implements ProductAttrValueService {

    /**
     * 添加spu的基本属性
     *
     * @param spuId    spuId
     * @param entities 指定spuId设置的所有基本属性
     */
    @Override
    public void updateSpuAttr(Long spuId, List<ProductAttrValueEntity> entities) {
        //TODO SPU的修改操作，未完成


        /*//1、删除这个spuId之前对应的所有属性
        this.baseMapper.delete(new QueryWrapper<ProductAttrValueEntity>().eq("spu_id", spuId));


        List<ProductAttrValueEntity> collect = entities.stream()
                .peek(item -> item.setSpuId(spuId))
                .collect(Collectors.toList());
        this.saveBatch(collect);*/
    }
}
