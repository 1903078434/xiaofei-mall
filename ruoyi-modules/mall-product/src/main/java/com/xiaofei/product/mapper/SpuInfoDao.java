package com.xiaofei.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.product.entity.SpuInfoEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * spu信息
 *
 * @author xiaofei
 */
@Mapper
public interface SpuInfoDao extends BaseMapper<SpuInfoEntity> {

    /**
     * 修改商品的上架状态
     *
     * @param spuId  商品id
     * @param status 商品上架状态
     */
    void updateSpuStatus(@Param("spuId") Long spuId, @Param("status") int status);
}
