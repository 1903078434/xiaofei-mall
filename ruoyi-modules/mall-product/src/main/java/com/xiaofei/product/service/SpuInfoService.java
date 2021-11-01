package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.SpuInfoEntity;
import com.xiaofei.common.product.vo.SpuInfoVo;
import com.xiaofei.common.product.vo.spu.SpuVo;
import com.xiaofei.common.vo.PageVo;

/**
 * spu信息
 * User: 李飞
 * Date: 2021/7/30
 */
public interface SpuInfoService extends IService<SpuInfoEntity> {

    /**
     * 添加spu的信息和sku的信息
     *
     * @param spuVo 商品信息
     */
    void addSpuInfo(SpuVo spuVo);

    /**
     * 商品上架
     *
     * @param spuId 商品id
     */
    Boolean spuUp(Long spuId);

    /**
     * 分页查询商品信息
     *
     * @param spuInfoVo 查询条件
     * @return 返回查询到的商品信息
     */
    PageVo<SpuInfoVo> queryByPage(SpuInfoVo spuInfoVo);

    /**
     * 根据spuId查询Spu的基本信息
     *
     * @param spuId 商品id
     * @return 返回商品信息
     */
    PageVo<SpuInfoVo> querySpuInfoById(Long spuId);

}
