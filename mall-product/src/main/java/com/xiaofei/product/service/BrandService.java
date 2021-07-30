package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.BrandEntity;
import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
import com.xiaofei.common.product.vo.BrandVo;
import com.xiaofei.common.vo.PageVo;

import java.util.List;

/**
 * 商品类别
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:48
 */
public interface BrandService extends IService<BrandEntity> {

    /**
     * 分页查询商品信息
     *
     * @param brandVo 搜索的条件
     * @return 返回根据分页查询到的信息
     */
    PageVo<BrandEntity> queryByPage(BrandVo brandVo);

    /**
     * 根据商家id删除商家的信息
     *
     * @param brandId 商家id集合
     * @return true：修改成功。false：修改失败
     */
    boolean deleteBrandById(String brandId);

    /**
     * 根据商家id修改商家的信息
     *
     * @return true：修改成功。false：修改失败
     */
    boolean updateBrandById(BrandVo brand);

    /**
     * 添加商品
     *
     * @param brandVo 商品信息
     * @return true：添加成功。false：添加失败
     */
    boolean addBrand(BrandVo brandVo);

    /**
     * 根据类别id查询该类别下的所有商家信息
     *
     * @param categoryId 类别id
     * @return 返回指定类别的商家信息
     */
    List<CategoryBrandRelationEntity> getByCategoryId(Long categoryId);
}
