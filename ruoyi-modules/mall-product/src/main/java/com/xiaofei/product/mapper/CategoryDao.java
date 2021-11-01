package com.xiaofei.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.product.entity.CategoryEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品三级分类
 *
 * @author xiaofei
 */
@Mapper
public interface CategoryDao extends BaseMapper<CategoryEntity> {
    /**
     * 根据父类别id查询子类别
     *
     * @param parentId 夫类别id
     * @return 返回查询到的数据
     */
    List<CategoryEntity> queryByParentId(@Param("parentId") Long parentId);
}
