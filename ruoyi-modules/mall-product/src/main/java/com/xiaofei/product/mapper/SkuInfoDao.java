package com.xiaofei.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * sku信息
 *
 * @author xiaofei
 */
@Mapper
public interface SkuInfoDao extends BaseMapper<SkuInfoEntity> {

    /**
     * 随机查询几条数据
     *
     * @param brandId 品牌id
     * @return 返回随机查询到的数据
     */
    List<SkuInfoEntity> getRandSkuInfos(@Param("brandId") Long brandId);
}
