package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.utils.StringUtils;
import com.xiaofei.common.product.entity.BrandEntity;
import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
import com.xiaofei.common.product.vo.BrandVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.BrandDao;
import com.xiaofei.product.service.BrandService;
import com.xiaofei.product.service.CategoryBrandRelationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
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
public class BrandServiceImpl extends ServiceImpl<BrandDao, BrandEntity> implements BrandService {

    @Autowired
    private CategoryBrandRelationService categoryBrandRelationService;

    /**
     * 添加商品
     *
     * @param brandVo 商品信息
     * @return true：添加成功。false：添加失败
     */
    @Override
    public boolean addBrand(BrandVo brandVo) {
        BrandEntity brandEntity = new BrandEntity();
        BeanUtils.copyProperties(brandVo, brandEntity);
        return this.save(brandEntity);
    }

    /**
     * 根据商家id删除商家的信息
     *
     * @param brandId 商家id
     * @return true：修改成功。false：修改失败
     */
    @Transactional
    @Override
    public boolean deleteBrandById(String brandId) {
        //TODO 商家删除操作，需完善

        List<String> brandIds = Arrays.stream(brandId.split(",")).collect(Collectors.toList());
        //this.baseMapper.deleteBatchIds(brandIds);

        return false;
    }

    /**
     * 分页查询商品信息
     *
     * @param brandVo 所搜条件
     * @return 返回根据分页查询到的信息
     */
    @Override
    public PageVo<BrandEntity> queryByPage(BrandVo brandVo) {
        PageHelper.startPage(brandVo.getPageNo(), brandVo.getPageSize());

        //判断搜索条件是否为空
        QueryWrapper<BrandEntity> queryWrapper = null;
        //搜索条件不为空，则拼接查询条件
        if (!StringUtils.isEmpty(brandVo.getSearchValue())) {
            queryWrapper = new QueryWrapper<BrandEntity>()
                    .eq("brand_id", brandVo.getSearchValue()).or()
                    .like("name", brandVo.getSearchValue()).or()
                    .like("descript", brandVo.getSearchValue()).or()
                    .eq("first_letter", brandVo.getSearchValue()).or();
        }
        //根据搜索条件查询
        List<BrandEntity> brands = this.list(queryWrapper);

        PageInfo<BrandEntity> page = new PageInfo<>(brands);

        return new PageVo<>(page.getPageNum(), page.getPageSize(), page.getPages(), page.getTotal(), page.getList());
    }

    /**
     * 修改商家信息
     */
    @Transactional
    @Override
    public boolean updateBrandById(BrandVo brand) {
        //TODO　商家信息修改，未完善
        BrandEntity brandEntity = new BrandEntity();
        BeanUtils.copyProperties(brand, brandEntity);

        //修改商家表和类别表的关联表
        CategoryBrandRelationEntity relationEntity = new CategoryBrandRelationEntity();
        relationEntity.setBrandName(brand.getName());
        relationEntity.setBrandId(brand.getBrandId());

        //修改关联表
        boolean isUpdate = categoryBrandRelationService.update(relationEntity,
                new QueryWrapper<CategoryBrandRelationEntity>().eq("brand_id", brand.getBrandId()));


        return this.updateById(brandEntity) && isUpdate;
    }
}
