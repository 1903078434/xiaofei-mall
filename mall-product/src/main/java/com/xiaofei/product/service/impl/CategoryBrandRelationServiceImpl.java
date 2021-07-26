package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
import com.xiaofei.product.mapper.CategoryBrandRelationDao;
import com.xiaofei.product.service.CategoryBrandRelationService;
import org.springframework.stereotype.Service;

/**
 * User: 李飞
 * Date: 2021/7/25
 * Time: 22:54
 */
@Service
public class CategoryBrandRelationServiceImpl extends ServiceImpl<CategoryBrandRelationDao, CategoryBrandRelationEntity> implements CategoryBrandRelationService {
}
