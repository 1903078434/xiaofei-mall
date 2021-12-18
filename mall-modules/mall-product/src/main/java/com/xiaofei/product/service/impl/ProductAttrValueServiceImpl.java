package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.ProductAttrValueEntity;
import com.xiaofei.common.product.vo.ProductAttrValueVo;
import com.xiaofei.product.mapper.ProductAttrValueDao;
import com.xiaofei.product.service.ProductAttrValueService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

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
    @Transactional
    @Override
    public boolean addSpuAttr(Long spuId, List<ProductAttrValueEntity> entities) {
        //TODO SPU的添加操作，未完成

        //1、删除这个spuId之前对应的所有属性
        this.baseMapper.delete(new QueryWrapper<ProductAttrValueEntity>().eq("spu_id", spuId));

        List<ProductAttrValueEntity> collect = entities.stream()
                .peek(item -> item.setSpuId(spuId))
                .collect(Collectors.toList());
        return this.saveBatch(collect);
    }

    /**
     * 修改商品的基本属性
     *
     * @param items 信息属性
     * @return true：修改成功。false：修改失败
     */
    @Transactional
    @Override
    public boolean updateProductAttrValue(List<ProductAttrValueVo> items, Long spuId) {
        // TODO SPU的基本属性修改
        List<ProductAttrValueEntity> productAttrValueEntitys = items.stream().map(productAttrValueVo -> {
            ProductAttrValueEntity productAttrValueEntity = new ProductAttrValueEntity();
            BeanUtils.copyProperties(productAttrValueVo, productAttrValueEntity);
            productAttrValueEntity.setSpuId(spuId);
            return productAttrValueEntity;
        }).collect(Collectors.toList());
        return this.addSpuAttr(spuId, productAttrValueEntitys);
    }

    /**
     * 查询指定spu的所有基本属性
     *
     * @param spuId 商品id
     * @return 指定spu的所有基本属性
     */
    @Override
    public List<ProductAttrValueEntity> getBySpuId(Long spuId) {
        return this.list(new QueryWrapper<ProductAttrValueEntity>().eq("spu_id", spuId));
    }
}
