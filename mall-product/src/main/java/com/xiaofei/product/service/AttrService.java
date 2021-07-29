package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.AttrEntity;
import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;

import java.util.List;

/**
 * 商品类别
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:Attr
 */
public interface AttrService extends IService<AttrEntity> {


    /**
     * 根据属性id集合删除
     *
     * @param attrId 属性id集合拼接的id
     * @return true：删除成功。false：删除失败
     */
    boolean deleteAttrById(String attrId);

    /**
     * 修改属性的基本信息
     *
     * @param attrVo 新的数据
     * @return true：修改成功。false：修改失败
     */
    boolean updateAttr(AttrVo attrVo);

    /**
     * 根据属性类别查询属性信息
     *
     * @param attrId 属性id
     * @return 返回属性的信息
     */
    AttrVo queryAttrById(Long attrId);

    /**
     * 添加属性的基本信息
     *
     * @param attrVo 属性的信息
     * @return true：添加成功。false：添加失败
     */
    boolean addAttr(AttrVo attrVo);

    /**
     * 查询基本属性
     */
    PageVo<AttrVo> queryBaseAttr(AttrVo attrVo, int attrType);

    /**
     * 查询未关联的属性
     *
     * @param attrIds 已关联的属性集合
     * @return 返回未关联的属性集合
     */
    PageVo<AttrVo> queryNotRelationAttr(AttrVo attrVo, List<Long> attrIds);
}
