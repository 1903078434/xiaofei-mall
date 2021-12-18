package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.constant.MQConstants;
import com.xiaofei.common.product.entity.SkuImagesEntity;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.entity.SpuInfoDescEntity;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;
import com.xiaofei.common.product.vo.SkuInfoVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.SkuInfoDao;
import com.xiaofei.product.service.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:04
 */
@Service
public class SkuInfoServiceImpl extends ServiceImpl<SkuInfoDao, SkuInfoEntity> implements SkuInfoService {

    @Autowired
    private SkuImagesService skuImagesService;

    @Autowired
    private SpuInfoDescService spuInfoDescService;

    @Autowired
    private AttrGroupService attrGroupService;

    @Autowired
    private BrandService brandService;

    @Autowired
    private SkuSaleAttrValueService skuSaleAttrValueService;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private ThreadPoolExecutor threadPoolExecutor;

    /**
     * 商品修改
     *
     * @param skuInfo 商品信息
     * @return true：修改成功。false：修改失败
     */
    @Override
    public Boolean skuEdit(SkuInfoEntity skuInfo) {
        boolean isSuccess = this.updateById(skuInfo);
        //TODO 修改之后，需要发布MQ，修改ES中的商品信息
        rabbitTemplate.convertAndSend(MQConstants.PRODUCT_EXCHANGE, MQConstants.PRODUCT_DELETE_KEY, skuInfo.getSkuId());
        //return true;
        return isSuccess;
    }

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
            queryWrapper.like("sku_name", skuInfoVo.getSearchValue());
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
        if (skuInfoVo.getSaleCount() != null && skuInfoVo.getSaleCount() == -1) {
            //降序
            queryWrapper.orderByDesc("sale_count");
        } else if (skuInfoVo.getSaleCount() != null && skuInfoVo.getSaleCount() == 1) {
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


        List<SkuInfoEntity> items = this.list(queryWrapper.orderByDesc("sku_id"));

        PageInfo<SkuInfoEntity> pageInfo = new PageInfo<>(items);
        return new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getList());

    }

    /**
     * 根据skuId查询商品详情页面的信息
     *
     * @param skuId 商品id
     * @return 商品详情页面的信息
     */
    @Override
    public SkuDetailInfoVo querySkuItemInfo(Long skuId) throws ExecutionException, InterruptedException {

        SkuDetailInfoVo skuDetailInfoVo = new SkuDetailInfoVo();

        //sku基本信息获取，不需要依赖任何线程执行完成后的结果
        CompletableFuture<SkuInfoEntity> skuInfoFuture = CompletableFuture.supplyAsync(() -> {
            //sku基本信息获取
            SkuInfoEntity skuInfoEntity = this.getById(skuId);
            skuDetailInfoVo.setSkuInfo(skuInfoEntity);
            return skuInfoEntity;
        }, threadPoolExecutor);

        //获取sku的图片信息，不需要依赖任何线程执行完成后的结果
        CompletableFuture<Void> skuImgFuture = CompletableFuture.runAsync(() -> {
            //获取sku的图片信息
            List<SkuImagesEntity> skuImagesEntities = skuImagesService.list(new QueryWrapper<SkuImagesEntity>().eq("sku_id", skuId));
            skuDetailInfoVo.setSkuImages(skuImagesEntities);
        }, threadPoolExecutor);

        //随机获取10条数据
        CompletableFuture<Void> randSkuInfoFuture = skuInfoFuture.thenAcceptAsync(result -> {
            //随机获取10条数据
            List<SkuInfoEntity> randSkuInfos = this.baseMapper.getRandSkuInfos(result.getBrandId());
            skuDetailInfoVo.setRandSkuInfos(randSkuInfos);
        }, threadPoolExecutor);

        //销售属性，需要等待skuInfoFuture线程完成，拿到该线程返回的结果才能执行
        CompletableFuture<Void> skuSaleAttrFuture = skuInfoFuture.thenAcceptAsync(result -> {
            //销售属性
            List<SkuDetailInfoVo.SkuItemSaleAttrVo> saleAttrVos = skuSaleAttrValueService.getSaleAttrBySpuId(result.getSpuId());
            skuDetailInfoVo.setSaleAttr(saleAttrVos);
        }, threadPoolExecutor);

        //获取spu的所有介绍图片，需要等待skuInfoFuture线程完成，拿到该线程返回的结果才能执行
        CompletableFuture<Void> skuDescFuture = skuInfoFuture.thenAcceptAsync(result -> {
            //获取spu的所有介绍图片
            SpuInfoDescEntity spuInfoDescEntity = spuInfoDescService.getOne(new QueryWrapper<SpuInfoDescEntity>().eq("spu_id", result.getSpuId()));
            skuDetailInfoVo.setSpuInfoDesc(spuInfoDescEntity);
        }, threadPoolExecutor);

        //获取spu的基本属性，需要等待skuInfoFuture线程完成，拿到该线程返回的结果才能执行
        CompletableFuture<Void> skuBaseAttrFuture = skuInfoFuture.thenAcceptAsync(result -> {
            //获取spu的基本属性
            List<SkuDetailInfoVo.SpuItemBaseAttrGroupVo> attrGroupVos = attrGroupService.getAttrGroupWithAttrsBySpuId(result.getSpuId(), result.getCatalogId());
            skuDetailInfoVo.setGroupAttrs(attrGroupVos);
        }, threadPoolExecutor);

        //获取品牌信息
        CompletableFuture<Void> brandFuture = skuInfoFuture.thenAcceptAsync(result -> {
            //获取品牌信息
            skuDetailInfoVo.setBrand(brandService.getById(result.getBrandId()));
        }, threadPoolExecutor);

        //TODO 查询商品是否有货

        //等待所有的异步任务都完成之后再返回数据
        CompletableFuture.allOf(skuImgFuture, skuSaleAttrFuture, randSkuInfoFuture, skuDescFuture, skuBaseAttrFuture, brandFuture).get();

        return skuDetailInfoVo;
    }

}
