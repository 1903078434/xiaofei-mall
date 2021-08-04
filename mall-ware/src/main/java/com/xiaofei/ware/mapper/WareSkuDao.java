package com.xiaofei.ware.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.ware.entity.WareSkuEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 商品库存
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-27 13:47:52
 */
@Mapper
public interface WareSkuDao extends BaseMapper<WareSkuEntity> {

    Long getSkuStock(@Param("skuId") Long skuId);

}
