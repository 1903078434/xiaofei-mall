package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.vo.SkuInfoVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.SkuInfoDao;
import com.xiaofei.product.service.SkuInfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:04
 */
@Service
public class SkuInfoServiceImpl extends ServiceImpl<SkuInfoDao, SkuInfoEntity> implements SkuInfoService {

    /**
     * 分页查询sku信息
     *
     * @param skuInfoVo 查询条件
     * @return 返回查询的sku信息
     */
    @Override
    public PageVo<SkuInfoEntity> queryByPage(SkuInfoVo skuInfoVo) {

        PageHelper.startPage(skuInfoVo.getPageNo(), skuInfoVo.getPageSize());

        //创建查询条件
        QueryWrapper<SkuInfoEntity> queryWrapper = new QueryWrapper<>();

        //判断搜索条件是否为空
        if (!StringUtils.isEmpty(skuInfoVo.getSearchValue())) {
            queryWrapper.eq("sku_name", skuInfoVo.getSearchValue());
        }

        //判断传入了类别id没有
        if (skuInfoVo.getCatalogId() != null && skuInfoVo.getCatalogId() > 0) {
            queryWrapper.eq("catalog_id", skuInfoVo.getCatalogId());
        }

        //判断品牌Id有没有
        if (skuInfoVo.getBrandId() != null && skuInfoVo.getBrandId() > 0) {
            queryWrapper.eq("brand_id", skuInfoVo.getBrandId());
        }

        //判断是否传入销量排序没有
        if (skuInfoVo.getSaleCount() == -1) {
            //降序
            queryWrapper.orderByDesc("sale_count");
        } else if (skuInfoVo.getSaleCount() == 1) {
            //升序
            queryWrapper.orderByAsc("sale_count");
        }

        //判断搜索条件
        BigDecimal minPrice = skuInfoVo.getMinPrice() == null ? new BigDecimal(0) : skuInfoVo.getMinPrice();
        BigDecimal maxPrice = skuInfoVo.getMaxPrice() == null ? new BigDecimal(99999999999L) : skuInfoVo.getMaxPrice();

        //判断最小价格是否小于最大价格
        if (minPrice.compareTo(maxPrice) > 0) {
            BigDecimal price = minPrice;
            minPrice = maxPrice;
            maxPrice = price;
        }
        BigDecimal finalMinPrice = minPrice;
        BigDecimal finalMaxPrice = maxPrice;
        //此时价格区间正常
        queryWrapper.ge("price", finalMinPrice).le("price", finalMaxPrice);


        List<SkuInfoEntity> items = this.list(queryWrapper);

        PageInfo<SkuInfoEntity> pageInfo = new PageInfo<>(items);
        return new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getList());

    }
}
