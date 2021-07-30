package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.BrandEntity;
import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
import com.xiaofei.common.product.entity.CategoryEntity;
import com.xiaofei.common.product.vo.CategoryBrandRelationVo;
import com.xiaofei.product.mapper.CategoryBrandRelationDao;
import com.xiaofei.product.service.BrandService;
import com.xiaofei.product.service.CategoryBrandRelationService;
import com.xiaofei.product.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/25
 * Time: 22:54
 */
@Service
@Slf4j
public class CategoryBrandRelationServiceImpl extends ServiceImpl<CategoryBrandRelationDao, CategoryBrandRelationEntity> implements CategoryBrandRelationService {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private BrandService brandService;

    /**
     * 新增商家和商家的关联信息
     */
    @Transactional
    @Override
    public boolean addCategoryAndBrandRelation(CategoryBrandRelationVo categoryBrandRelationVo) {
        //先查询品牌和分类是否已经绑定了
        CategoryBrandRelationEntity categoryBrandRelationEntity = this.getOne(new QueryWrapper<CategoryBrandRelationEntity>()
                .eq("brand_id", categoryBrandRelationVo.getBrandId())
                .eq("catelog_id", categoryBrandRelationVo.getCatelogId()));
        if (categoryBrandRelationEntity != null) {
            return false;
        }

        //查询类别信息
        Long catelogId = categoryBrandRelationVo.getCatelogId();
        CategoryEntity categoryEntity = categoryService.getById(catelogId);

        //查询商家信息
        Long brandId = categoryBrandRelationVo.getBrandId();
        BrandEntity brandEntity = brandService.getById(brandId);

        //保存品牌和类别的关联信息
        categoryBrandRelationEntity = new CategoryBrandRelationEntity();
        BeanUtils.copyProperties(categoryBrandRelationVo, categoryBrandRelationEntity);
        categoryBrandRelationEntity.setCatelogName(categoryEntity.getName());
        categoryBrandRelationEntity.setBrandName(brandEntity.getName());

        return this.save(categoryBrandRelationEntity);

    }


    /**
     * 移除商家和类别关系
     */
    @Transactional
    @Override
    public boolean deleteCategoryAndBrandRelation(Long id, Long brandId) {
        //TODO 商家和类别关联表的删除功能，未完善
        //return   this.remove(new QueryWrapper<CategoryBrandRelationEntity>().eq("id", id).eq("brand_id", brandId));

        return true;

    }

    /**
     * 根据品牌查询该品牌关联的所有类别
     *
     * @param brandId 商家id
     * @return 返回指定品牌的所有关联属性
     */
    @Override
    public List<CategoryBrandRelationEntity> getByBrandId(Long brandId) {
        return this.list(new QueryWrapper<CategoryBrandRelationEntity>().eq("brand_id", brandId));
    }
}
