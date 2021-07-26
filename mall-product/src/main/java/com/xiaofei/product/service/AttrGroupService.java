package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.vo.AttrGroupVo;
import com.xiaofei.common.vo.PageVo;

/**
 * 商品类别
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:48
 */
public interface AttrGroupService extends IService<AttrGroupEntity> {

    /**
     * 属性分组信息的添加
     *
     * @param attrGroupVo 属性分组信息
     * @return true：添加成功。false：添加失败
     */
    boolean addAttrGroup(AttrGroupVo attrGroupVo);

    /**
     * 批量删除分组信息，或单个删除属性分组信息，根据id
     *
     * @param attrgroupId id字符串，多个id使用 ， 分割的
     * @return true:删除成功。false：删除失败
     */
    boolean deleteAttrGroupById(String attrgroupId);

    /**
     * 根据属性分组id修改属性分组信息
     *
     * @param attrGroupVo 属性分组的信息
     * @return true：修改成功，false：修改数百
     */
    boolean updateAttrGroupById(AttrGroupVo attrGroupVo);

    /**
     * 根据属性类别id查询属性的相关信息
     *
     * @param attrgroupId 属性类别id
     * @return 返回需要查询的属性类别id
     */
    AttrGroupVo queryAttrGroupById(Long attrgroupId);

    /**
     * 分页查询和搜索查询
     *
     * @param attrGroupVo 分页信息和搜索条件
     * @return 返回查询到的相关信息
     */
    PageVo<AttrGroupEntity> queryByPage(AttrGroupVo attrGroupVo);

}
