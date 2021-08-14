package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.CategoryEntity;
import com.xiaofei.common.product.vo.CategoryVo;
import com.xiaofei.product.mapper.CategoryDao;
import com.xiaofei.product.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 商品类别
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:50
 */
@Service
@Slf4j
public class CategoryServiceImpl extends ServiceImpl<CategoryDao, CategoryEntity> implements CategoryService {
    /**
     * 查询所有商品分类
     *
     * @return 三级分类
     */
    @Override
    public List<CategoryEntity> queryAllCategory() {
        //1、查出所有分类
        List<CategoryEntity> categorys = this.list();

        //2、组装成父子的树形结构，2.1、找到一级分类，lambda写法
        return categorys.stream().filter(categoryEntity -> {
            //当父节点为parentCid=0时返回节点
            return categoryEntity.getParentCid().equals(0L);
        })
                //获取根集合下的子节点，peek方法将每一项中的children属性中的值修改之后再返回，和stream中的map方法使用差不多
                .peek(categoryEntity -> categoryEntity.setChildren(getChildrens(categoryEntity, categorys)))

                //使用自定义排序
                .sorted(Comparator.comparingInt(CategoryEntity::getSort))//排序

                //将查询的结果转换为集合
                .collect(Collectors.toList());//将结果作为一个集合返回
    }

    /**
     * 根据id删除商品类别
     *
     * @param categoryId 商品类别id
     * @return true：删除成功。false：删除失败
     */
    @CacheEvict(value = "category",allEntries = true)//类别删除，删除redis缓存中的类别信息
    @Transactional
    @Override
    public boolean deleteCategoryById(Long categoryId) {
        //TODO 商品类别删除操作，未完善
        //this.removeById(categoryId);
        return false;
    }

    /**
     * 修改商品类别
     *
     * @param categoryVo 传入的商品类别信息
     * @return 返回是否修改成功
     */
    @CacheEvict(value = "category",allEntries = true)//类别修改，重新删除缓存中的商品类别信息
    @Transactional
    @Override
    public boolean updateCategory(CategoryVo categoryVo) {
        //TODO 商品类别修改操作，未完善
        /*CategoryEntity categoryEntity = new CategoryEntity();
        BeanUtils.copyProperties(categoryVo, categoryEntity);
        return this.updateById(categoryEntity);*/
        return false;
    }

    /**
     * 递归获取获取子节点
     *
     * @param root 根节点
     * @param all  所有阶段的节点
     * @return 返回子节点
     */
    private List<CategoryEntity> getChildrens(CategoryEntity root, List<CategoryEntity> all) {

        return all.stream().filter(categoryEntity -> {
            //Long使用equals比较，long使用 == 来比较
            return categoryEntity.getParentCid().equals(root.getCatId());
        })
                .peek(categoryEntity -> categoryEntity.setChildren(getChildrens(categoryEntity, all)))//设置子节点
                .sorted(Comparator.comparingInt(o -> (o.getSort() == null ? 0 : o.getSort())))//排序
                .collect(Collectors.toList());//将结果作为一个集合返回

    }

    /**
     * 添加商品类别
     *
     * @param categoryVo 传入的商品类别信息
     * @return 返回是否添加成功
     */
    @Override
    public boolean addCategory(CategoryVo categoryVo) {
        CategoryEntity categoryEntity = new CategoryEntity();
        BeanUtils.copyProperties(categoryVo, categoryEntity);
        return this.save(categoryEntity);
    }

    /**
     * 根据类别id获取级联选择器的路径
     */
    @Override
    public Long[] findCategoryPath(Long categoryId) {
        List<Long> paths = new ArrayList<>();
        List<Long> parentPath = findParentPath(categoryId, paths);
        Collections.reverse(parentPath);
        return parentPath.toArray(new Long[0]);
    }

    /**
     * 根据子节点查找父节点
     */
    private List<Long> findParentPath(Long categoryId, List<Long> paths) {
        paths.add(categoryId);
        CategoryEntity byId = this.getById(categoryId);
        if (byId.getParentCid() != 0) {
            //收集当前节点id
            findParentPath(byId.getParentCid(), paths);
        }
        return paths;
    }

    /**
     * 查询所有分类及其子分类，以树形结构组装起来，级联选择器中的值
     */
    @Override
    public List<CategoryEntity> listWithTree() {
        //1、查出所有分类
        List<CategoryEntity> entities = baseMapper.selectList(null);

        //2、组装成父子的树形结构，2.1、找到一级分类，lambda写法
        return entities.stream().filter(categoryEntity -> {
            //当父节点为parentCid=0时返回节点
            return categoryEntity.getParentCid().equals(0L);
        })
                //获取根集合下的子节点，peek方法将每一项中的children属性中的值修改之后再返回，和stream中的map方法使用差不多
                .peek(categoryEntity -> categoryEntity.setChildren(getChildrens(categoryEntity, entities)))

                //使用自定义排序
                .sorted(Comparator.comparingInt(CategoryEntity::getSort))//排序

                //将查询的结果转换为集合
                .collect(Collectors.toList());//将结果作为一个集合返回
    }

    /**
     * 查询缓存中的三级分类
     *
     * @return 三级分类
     */
    //@Cacheable(value = "category", key = "'categoryJson'")//开启之后会先去redis中寻找对应的数据，如果没有再从数据库中查询
    @Override
    public List<CategoryEntity> queryCacheCategory() {
        return this.queryAllCategory();
    }
}
