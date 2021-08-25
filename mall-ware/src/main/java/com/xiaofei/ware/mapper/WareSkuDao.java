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

    /**
     * 库存锁定
     *
     * @param skuId  商品id
     * @param buyNum 购买数量
     * @return true：锁定成功。false：锁定失败
     */
    boolean lockStock(@Param("skuId") Long skuId, @Param("buyNum") Integer buyNum);

    /**
     * 修改库存信息
     */
    boolean paySuccess(@Param("buyNum") Integer buyNum, @Param("skuId") Long skuId);
}
