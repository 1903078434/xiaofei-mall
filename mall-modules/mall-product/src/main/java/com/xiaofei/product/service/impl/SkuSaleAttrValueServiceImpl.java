package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;
import com.xiaofei.product.mapper.SkuSaleAttrValueDao;
import com.xiaofei.product.service.SkuSaleAttrValueService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:12
 */
@Service
public class SkuSaleAttrValueServiceImpl extends ServiceImpl<SkuSaleAttrValueDao, SkuSaleAttrValueEntity> implements SkuSaleAttrValueService {

    /**
     * 获取指定Spu下的所有销售属性
     *
     * @param spuId 商品id
     * @return 指定商品的所有销售属性
     */
    @Override
    public List<SkuDetailInfoVo.SkuItemSaleAttrVo> getSaleAttrBySpuId(Long spuId) {
        return this.baseMapper.getSaleAttrBySpuId(spuId);
    }

    /**
     * 根据skuId查询销售属性信息
     *
     * @param skuId 商品id
     * @return 指定商品id的销售属性
     */
    @Override
    public List<SkuSaleAttrValueEntity> querySkuSaleAttrBySkuId(Long skuId) {
        return this.list(new QueryWrapper<SkuSaleAttrValueEntity>().eq("sku_id", skuId));
    }
}
