package com.xiaofei.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * sku销售属性&值
 *
 * @author xiaofei
 */
@Mapper
public interface SkuSaleAttrValueDao extends BaseMapper<SkuSaleAttrValueEntity> {

    /**
     * 获取指定Spu下的所有销售属性
     *
     * @param spuId 商品id
     * @return 指定商品的所有销售属性
     */
    List<SkuDetailInfoVo.SkuItemSaleAttrVo> getSaleAttrBySpuId(@Param("spuId") Long spuId);
}
