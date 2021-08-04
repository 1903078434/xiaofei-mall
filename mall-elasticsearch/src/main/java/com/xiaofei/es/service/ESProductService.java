package com.xiaofei.es.service;

import com.xiaofei.common.dto.SkuESDto;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:39
 */
public interface ESProductService {
    /**
     * 将商品信息保存到ES中
     *
     * @param skuESDtos 商品信息
     * @return true：保存成功。false：保存失败
     */
    boolean saveProduct(List<SkuESDto> skuESDtos);
}
