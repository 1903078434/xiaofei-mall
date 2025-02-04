package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.vo.AttrAndAttrGroupVo;
import com.xiaofei.common.product.vo.AttrGroupVo;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;
import com.xiaofei.common.vo.PageVo;

import java.util.List;

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

    /**
     * 根据类别查询属性分组信息
     *
     * @param categoryId 类别id
     * @return 返回指定类别的属性分组
     */
    List<AttrGroupVo> queryAttrGroupByCategoryId(Long categoryId);

    /**
     * 获取指定类别下的属性，和分组信息
     *
     * @param categoryId 类别id
     * @return 返回属性分组和属性的结合信息
     */
    List<AttrAndAttrGroupVo> queryAttrGroupWithAttr(Long categoryId);

    /**
     * 查询指定spu的，属性分组，及其属性分组下对应的属性信息
     *
     * @param spuId      商品id
     * @param categoryId 商品类别
     * @return 返回指定spu的属性分组和对应分组下的信息
     */
    List<SkuDetailInfoVo.SpuItemBaseAttrGroupVo> getAttrGroupWithAttrsBySpuId(Long spuId, Long categoryId);
}
