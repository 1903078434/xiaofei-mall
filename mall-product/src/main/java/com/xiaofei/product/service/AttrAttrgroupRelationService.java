package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.AttrAttrgroupRelationEntity;
import com.xiaofei.common.product.vo.AttrAttrGroupRelationVo;
import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/28
 * Time: 17:02
 */
public interface AttrAttrgroupRelationService extends IService<AttrAttrgroupRelationEntity> {

    /**
     * 添加属性分组和属性的关联关系
     *
     * @param relationVos 关联关系的信息
     * @return true：添加成功。false：添加失败
     */
    boolean addRelation(List<AttrAttrGroupRelationVo> relationVos);

    /**
     * 根据关系集合id批量或单个删除关联关系
     *
     * @param relationVos 属性分组和属性关联id
     * @return true：删除成功。false：删除失败
     */
    boolean deleteByRelation(List<AttrAttrGroupRelationVo> relationVos);

    /**
     * 根据属性分组id查询该分组绑定的所有属性信息
     *
     * @param attrGroupId 属性分组id
     * @return 返回指定分组绑定的所有关联信息
     */
    List<AttrAttrGroupRelationVo> queryRelationByAttrGroupId(Long attrGroupId);

    /**
     * 根据已关联的信息，查询未关联的属性
     */
    PageVo<AttrVo> queryNoRelationAttr(AttrVo attrVo);
}
