package com.xiaofei.product.mapper;

 import com.baomidou.mybatisplus.core.mapper.BaseMapper;
 import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
 import org.apache.ibatis.annotations.Mapper;

/**
 * 品牌分类关联
 *
 * @author xiaofei
 */
@Mapper
public interface CategoryBrandRelationDao extends BaseMapper<CategoryBrandRelationEntity> {

}
