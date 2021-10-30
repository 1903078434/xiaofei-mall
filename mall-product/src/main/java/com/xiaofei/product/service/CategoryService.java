package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.CategoryEntity;
import com.xiaofei.common.product.vo.CategoryVo;

import java.util.List;

/**
 * 商品类别
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:48
 */
public interface CategoryService extends IService<CategoryEntity> {

    /**
     * 添加商品类别
     *
     * @param categoryVo 传入的商品类别信息
     * @return 返回是否添加成功
     */
    boolean addCategory(CategoryVo categoryVo);

    /**
     * 修改商品类别
     *
     * @param categoryVo 传入的商品类别信息
     * @return 返回是否修改成功
     */
    boolean updateCategory(CategoryVo categoryVo);

    /**
     * 根据id修改类别信息
     *
     * @param categoryId 商品类别id
     * @return true：删除成功。false：删除失败
     */
    boolean deleteCategoryById(Long categoryId);

    /**
     * 根据子节点查找父节点，找到categoryPath的完整路径
     */
    Long[] findCategoryPath(Long categoryId);

    /**
     * 查询所有分类及其子分类，以树形结构组装起来，级联选择器中的值
     */
    List<CategoryEntity> listWithTree();

    /**
     * 查询所有商品分类
     *
     * @return 三级分类
     */
    List<CategoryEntity> queryAllCategory();

    /**
     * 查询缓存中的三级分类
     *
     * @return 三级分类
     */
    List<CategoryEntity> queryCacheCategory();

    /**
     * 根据父id子类别
     *
     * @return 返回查询到的数据
     */
    List<CategoryEntity> queryByParentId(Long parentId);
}
