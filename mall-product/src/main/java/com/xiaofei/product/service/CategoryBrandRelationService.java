package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
import com.xiaofei.common.product.vo.CategoryBrandRelationVo;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/25
 * Time: 22:53
 */
public interface CategoryBrandRelationService extends IService<CategoryBrandRelationEntity> {

    /**
     * 新增商家和商家的关联信息
     */
    boolean addCategoryAndBrandRelation(CategoryBrandRelationVo categoryBrandRelationVo);

    /**
     * 移除商家和类别关系
     */
    boolean deleteCategoryAndBrandRelation(Long id, Long brandId);

    /**
     * 根据品牌查询该品牌关联的所有类别
     *
     * @param brandId 商家id
     * @return 返回指定品牌的所有关联属性
     */
    List<CategoryBrandRelationEntity> getByBrandId(Long brandId);
}
