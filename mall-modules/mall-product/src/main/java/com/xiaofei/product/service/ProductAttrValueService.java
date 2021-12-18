package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.ProductAttrValueEntity;
import com.xiaofei.common.product.vo.ProductAttrValueVo;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 19:43
 */
public interface ProductAttrValueService extends IService<ProductAttrValueEntity> {

    /**
     * 添加spu的基本属性
     *
     * @param spuId    spuId
     * @param entities 指定spuId设置的所有基本属性
     */
    boolean addSpuAttr(Long spuId, List<ProductAttrValueEntity> entities);

    /**
     * 修改商品的基本属性
     *
     * @param items 信息属性
     * @return true：修改成功。false：修改失败
     */
    boolean updateProductAttrValue(List<ProductAttrValueVo> items, Long spuId);

    /**
     * 查询指定spu的所有基本属性
     *
     * @param spuId 商品id
     * @return 指定spu的所有基本属性
     */
    List<ProductAttrValueEntity> getBySpuId(Long spuId);

}
