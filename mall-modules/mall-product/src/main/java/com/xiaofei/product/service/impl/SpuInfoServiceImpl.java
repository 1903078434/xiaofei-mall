package com.xiaofei.product.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.coupon.entity.SpuBoundsEntity;
import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.dto.SkuReductionDto;
import com.xiaofei.common.dto.SpuBoundsDto;
import com.xiaofei.common.product.entity.*;
import com.xiaofei.common.product.vo.SpuInfoVo;
import com.xiaofei.common.product.vo.spu.*;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.feign.CouponFeignService;
import com.xiaofei.feign.SearchFeignService;
import com.xiaofei.feign.WareFeignService;
import com.xiaofei.product.mapper.SpuInfoDao;
import com.xiaofei.product.service.*;
import io.seata.spring.annotation.GlobalTransactional;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 17:20
 */
@Service
@Slf4j
public class SpuInfoServiceImpl extends ServiceImpl<SpuInfoDao, SpuInfoEntity> implements SpuInfoService {

    @Autowired
    private SpuImagesService spuImagesService;
    @Autowired
    private AttrService attrService;
    @Autowired
    private CouponFeignService couponFeignService;
    @Autowired
    private ProductAttrValueService productAttrValueService;
    @Autowired
    private SkuInfoService skuInfoService;
    @Autowired
    private SkuImagesService skuImagesService;
    @Autowired
    private SkuSaleAttrValueService skuSaleAttrValueService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private BrandService brandService;
    @Autowired
    private WareFeignService wareFeignService;
    @Autowired
    private SpuInfoDescService spuInfoDescService;
    @Autowired
    private SearchFeignService searchFeignService;
    @Autowired
    private ThreadPoolExecutor threadPoolExecutor;


    /**
     * 添加spu的信息和sku的信息
     *
     * @param spuVo 商品信息
     */
    @GlobalTransactional//Seata的分布式事务锁
    @Override
    public void addSpuInfo(SpuVo spuVo) {

        //1、保存spu基本信息【pms_spu_info】
        SpuInfoEntity spuInfoEntity = new SpuInfoEntity();
        //复制商品的spu基本信息到和数据库对接的entity实体类里面
        BeanUtils.copyProperties(spuVo, spuInfoEntity);
        //将没有复制到的信息手动添加
        spuInfoEntity.setCreateTime(new Date());
        spuInfoEntity.setUpdateTime(new Date());
        this.save(spuInfoEntity);

        //2、保存保存spu描述图片【pms_spu_info_desc】
        List<String> decriptImg = spuVo.getDecript();//商品介绍图片
        SpuInfoDescEntity spuInfoDescEntity = new SpuInfoDescEntity();
        spuInfoDescEntity.setSpuId(spuInfoEntity.getId());
        //String.join方法用于将集合或数组中的每一个元素用指定的分隔符分开之后拼接，然后将拼接的字符串返回
        spuInfoDescEntity.setDecript(String.join(",", decriptImg));
        spuInfoDescService.save(spuInfoDescEntity);

        //3、保存spu图片集【pms_spu_images】
        List<String> spuImages = spuVo.getImages();//获取商品的图片合集
        spuImagesService.saveImages(spuInfoEntity.getId(), spuVo.getSpuName(), spuImages);

        //4、保存spu的规格参数【pms_product_attr_value】
        List<BaseAttr> spuInfoBaseAttrs = spuVo.getBaseAttrs();//商品的基本属性，不包含销售属性，spu保存基本信息，sku保存销售属性
        List<ProductAttrValueEntity> productAttrValueEntities = spuInfoBaseAttrs.stream().map(attr -> {
            //设置商品属性的基本信息
            ProductAttrValueEntity productAttrValueEntity = new ProductAttrValueEntity();
            productAttrValueEntity.setAttrId(attr.getAttrId());//设置商品属性id
            AttrEntity attrEntity = attrService.getById(attr.getAttrId()); //根据属性id查询属性信息
            productAttrValueEntity.setAttrName(attrEntity.getAttrName());//设置商品属性名称
            productAttrValueEntity.setAttrValue(attr.getAttrValues());//设置商品属性值
            productAttrValueEntity.setQuickShow(attr.getShowDesc());//设置商品是否快速显示
            productAttrValueEntity.setSpuId(spuInfoEntity.getId());//设置商品的id
            return productAttrValueEntity;
        }).collect(Collectors.toList());
        //保存构造好的商品属性信息
        productAttrValueService.addSpuAttr(spuInfoEntity.getId(), productAttrValueEntities);

        //5、保存spu的积分信息【mall_sms --> sms_spu_bounds】
        Bounds bounds = spuVo.getBounds();
        SpuBoundsDto spuBoundsDto = new SpuBoundsDto();
        spuBoundsDto.setSpuId(spuInfoEntity.getId());//设置spu的id
        BeanUtils.copyProperties(bounds, spuBoundsDto);//复制bounds到 spuBoundsTo
        AjaxResult ajaxResult = couponFeignService.addSpuBounds(spuBoundsDto);//远程调用优惠券服务
        if (!(boolean) ajaxResult.get("data")) {
            log.info("\n");
            log.debug("========================错误信息 --begin-- ==============================");
            log.error("远程保存spu积分信息失败");
            log.debug("========================错误信息 --end-- ==============================\n");
        }
        //6、保存当前spu对应的sku信息
        List<Sku> skus = spuVo.getSkus();//商品的skus的全部信息
        if (skus != null && skus.size() > 0) {
            skus.forEach(item -> {

                //获取sku的默认图片
                String defaultImg = "";
                for (Image image : item.getImages()) {
                    if (image.getDefaultImg() == 1) {
                        defaultImg = image.getImgUrl();
                    }
                }

                //6.1、sku的基本信息【pms_sku_info】
                SkuInfoEntity skuInfoEntity = new SkuInfoEntity();//创建一个sku信息的实体类
                BeanUtils.copyProperties(item, skuInfoEntity);//复制vo中sku的对应的信息
                skuInfoEntity.setBrandId(spuInfoEntity.getBrandId());//设置sku的商家信息
                skuInfoEntity.setSpuId(spuInfoEntity.getId());//设置spu商品id
                skuInfoEntity.setCatalogId(spuInfoEntity.getCatalogId());//设置三级分类id
                skuInfoEntity.setSkuDefaultImg(defaultImg);//设置商品的默认图片
                skuInfoEntity.setSaleCount(0L);//设置销售数量为0
                skuInfoService.save(skuInfoEntity);//保存sku的基本信息，下面的操作因为需要sku的id，所以这里需要先将sku的信息保存获取id

                //6.2、sku的图片信息【pms_sku_images】
                List<Image> images = item.getImages();//获取sku的全部图片信息
                List<SkuImagesEntity> skuImagesEntities = images.stream().map(image -> {
                    SkuImagesEntity skuImagesEntity = new SkuImagesEntity();
                    skuImagesEntity.setSkuId(skuInfoEntity.getSkuId());//设置保存之后的sku的id
                    skuImagesEntity.setImgUrl(image.getImgUrl());//设置图片地址
                    skuImagesEntity.setDefaultImg(image.getDefaultImg());//设置是否为默认图片
                    return skuImagesEntity;
                }).filter(entity -> {
                    //过滤操作：返回true就是需要，返回false就是删除掉
                    return !StringUtils.isEmpty(entity.getImgUrl());
                }).collect(Collectors.toList());

                skuImagesService.saveBatch(skuImagesEntities);//保存sku的所有图片信息

                //6.3、sku的销售属性信息【pms_sku_sale_attr_value】

                List<SaleAttr> skuSaleAttr = item.getAttr();//获取每一项sku的销售属性
                //设置sku的销售属性
                List<SkuSaleAttrValueEntity> skuSaleAttrValueEntities = skuSaleAttr.stream().map(skuSaleAttrItem -> {
                    SkuSaleAttrValueEntity skuSaleAttrValueEntity = new SkuSaleAttrValueEntity();
                    BeanUtils.copyProperties(skuSaleAttrItem, skuSaleAttrValueEntity);
                    skuSaleAttrValueEntity.setSkuId(skuInfoEntity.getSkuId());
                    return skuSaleAttrValueEntity;
                }).collect(Collectors.toList());

                skuSaleAttrValueService.saveBatch(skuSaleAttrValueEntities);//保存sku的每一项销售属性

                //6.4、sku的优惠、满减信息【mall_sms --> sms_sku_ladder / sms_sku_full_reduction / sms_member_price】
                SkuReductionDto skuReductionDto = new SkuReductionDto();
                BeanUtils.copyProperties(item, skuReductionDto);
                skuReductionDto.setSkuId(skuInfoEntity.getSkuId());

                //是满足满减或折扣中的一种优惠的时候才调用远程服务，添加优惠信息
                if (skuReductionDto.getFullCount() > 0 || skuReductionDto.getFullPrice().compareTo(new BigDecimal(0)) > 0) {
                    AjaxResult response = couponFeignService.saveSkuReduction(skuReductionDto);
                    if (!(boolean) response.get("data")) {
                        log.info("\n");
                        log.debug("========================错误信息 --begin-- ==============================");
                        log.error("远程保存sku优惠信息失败");
                        log.debug("========================错误信息 --end-- ==============================\n");
                    }
                }
            });
        }

    }

    /**
     * 商品上架
     *
     * @param spuId 商品id
     */
    @Transactional
    @Override
    public Boolean spuUp(Long spuId) {

        //1.1、查询指定spu商品下面的所有商品属性
        List<ProductAttrValueEntity> productAttrValueEntities = productAttrValueService.getBySpuId(spuId);

        //1.2、将所有的属性id提取出来
        List<Long> attrIds = productAttrValueEntities.stream()
                .map(ProductAttrValueEntity::getAttrId)
                .collect(Collectors.toList());

        //1.3、获取可以被检索的属性（检索页可以根据属性搜索商品的属性）
        List<AttrEntity> attrs = null;
        if (attrIds.size() > 0) {
            attrs = attrService.list(new QueryWrapper<AttrEntity>().in("attr_id", attrIds)
                    .eq("search_type", 1));
        } else {
            attrs = attrService.list(new QueryWrapper<AttrEntity>()
                    .eq("search_type", 1));
        }


        //1.4、提取可检索属性的id
        List<Long> searchAttrIds = attrs.stream().map(AttrEntity::getAttrId).collect(Collectors.toList());
        //1.5、根据提取出来的可检索属性的id过滤掉其他不可查询的商品属性
        productAttrValueEntities =
                productAttrValueEntities.stream().filter(productAttrValueEntity ->
                        searchAttrIds.contains(productAttrValueEntity.getAttrId()))
                        .collect(Collectors.toList());

        //1.5、提取可检索属性——将过滤出来的可检索的属性组装成为所需要的格式
        List<SkuESDto.Attr> skuESAttrs = productAttrValueEntities.stream().map(item -> {
            SkuESDto.Attr skuESAttr = new SkuESDto.Attr();
            BeanUtils.copyProperties(item, skuESAttr);
            return skuESAttr;
        }).collect(Collectors.toList());

        //2.1、sku查询——根据spuId查询该spu下的所有sku
        List<SkuInfoEntity> skus = skuInfoService.list(new QueryWrapper<SkuInfoEntity>().eq("spu_id", spuId));

        //2.2、提取skuId——将所有sku的id提取出来
        List<Long> skuIds = skus.stream().map(SkuInfoEntity::getSkuId).collect(Collectors.toList());

        //2.3、库存查询——根据提取出来的skuId调用库存服务。库存查询
        Map<Long, Boolean> skuHasStocks = null;
        try {
            ResponseResult<List<SkuHasStockDto>> wareResponse = wareFeignService.hasStock(skuIds);
            skuHasStocks = wareResponse.getData().stream().collect(Collectors.toMap(SkuHasStockDto::getSkuId, SkuHasStockDto::getHasStock));
        } catch (Exception e) {
            log.error("库存服务调用失败：，异常原因{}", e);
        }

        //3、封装数据
        Map<Long, Boolean> finalSkuHasStocks = skuHasStocks;
        List<SkuESDto> items = skus.stream().map(sku -> {
            SkuESDto skuESDto = new SkuESDto();
            BeanUtils.copyProperties(sku, skuESDto);
            skuESDto.setSkuTitle(sku.getSkuName());
            skuESDto.setSkuPrice(sku.getPrice());
            skuESDto.setSkuImg(sku.getSkuDefaultImg());

            //设置库存
            /*if (finalSkuHasStocks != null) {
                skuESDto.setHasStock(finalSkuHasStocks.get(sku.getSkuId()));
            } else {
                skuESDto.setHasStock(true);
            }*/
            skuESDto.setHasStock(true);

            // TODO hotScore热度评分设置，该操作优点复杂，应该设置为后台可控，比如置顶的商品，热度设置为最高。但是，这里先全部上架的商品热度设置为随机数，以后再来补全
            skuESDto.setHotScore(RandomUtils.nextLong(0L, 999L));

            //查询商家和类别的信息
            CategoryEntity categoryEntity = categoryService.getById(sku.getCatalogId());
            skuESDto.setCategoryId(sku.getCatalogId());
            skuESDto.setCategoryName(categoryEntity.getName());

            BrandEntity brandEntity = brandService.getById(sku.getBrandId());
            skuESDto.setBrandName(brandEntity.getName());
            skuESDto.setBrandImg(brandEntity.getLogo());

            //设置基本属性
            skuESDto.setAttrs(skuESAttrs);

            //设置上架时间
            skuESDto.setAddTime(LocalDateTime.now());

            //设置评论数量
            skuESDto.setCommentNum(sku.getSaleCount());

            return skuESDto;
        }).collect(Collectors.toList());

        System.out.println(JSON.toJSONString(items));

        //将数据发送给mall-elasticsearch模块，保存在ElasticSearch
        ResponseResult<Boolean> addProductResp = searchFeignService.addProduct(items);
        Boolean isSave = addProductResp.getData();
        if (isSave) {
            log.info("商品上架成功");
            //修改商品的上架状态
            this.baseMapper.updateSpuStatus(spuId, 1);
        } else {
            //商品上架失败
            log.error("商品上架失败");
        }
        return isSave;
    }

    /**
     * 分页查询商品信息
     *
     * @param spuInfoVo 查询条件
     * @return 返回查询到的商品信息
     */
    @Override
    public PageVo<SpuInfoVo> queryByPage(SpuInfoVo spuInfoVo) {
        PageHelper.startPage(spuInfoVo.getPageNo(), spuInfoVo.getPageSize());

        //查询条件选择器
        QueryWrapper<SpuInfoEntity> queryWrapper = new QueryWrapper<>();

        //判断是否传入了分类信息
        if (spuInfoVo.getCatalogId() != null && spuInfoVo.getCatalogId() > 0) {
            queryWrapper.eq("catalog_id", spuInfoVo.getCatalogId());
        }

        //判断是否传入了商家信息
        if (spuInfoVo.getBrandId() != null && spuInfoVo.getBrandId() > 0) {
            queryWrapper.eq("brand_id", spuInfoVo.getBrandId());
        }

        //判断是否传入了上架状态，0：下架。1：下架
        if (spuInfoVo.getPublishStatus() != null) {
            queryWrapper.eq("publish_status", spuInfoVo.getPublishStatus());
        }

        //判断搜索条件是否为空
        if (!StringUtils.isEmpty(spuInfoVo.getSearchValue())) {
            queryWrapper.and(wrapper -> {
                wrapper.like("spu_name", spuInfoVo.getSearchValue());
            });
        }


        //根据搜索条件查询
        List<SpuInfoEntity> spuInfos = this.list(queryWrapper);

        PageInfo<SpuInfoEntity> pageInfo = new PageInfo<>(spuInfos);

        PageVo<SpuInfoVo> page = new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal());

        //将查询出来的结果再次查询数据库，根据属性id查询属性分组信息，根据分类id查询分类名称

        List<SpuInfoVo> items = pageInfo.getList().stream().map(spuInfoEntity -> {
            SpuInfoVo spuVo = new SpuInfoVo();
            BeanUtils.copyProperties(spuInfoEntity, spuVo);
            return spuVo;
        }).collect(Collectors.toList());

        page.setItems(items);

        return page;
    }

    /**
     * 根据spuId查询Spu的基本信息
     *
     * @param spuId 商品id
     * @return 返回商品信息
     */
    @Override
    public PageVo<SpuInfoVo> querySpuInfoById(Long spuId) {
        PageVo<SpuInfoVo> page = new PageVo<>();
        this.getById(spuId);
        return page;
    }

    /**
     * 根据spuId查询spu的全部商品信息【商品图片，优惠信息等】
     *
     * @param spuId 商品id
     * @return 返回指定spu下的所有商品信息
     */
    @Override
    public SpuVo internalQuerySpuInfoById(Long spuId) throws ExecutionException, InterruptedException {
        SpuVo spuVo = new SpuVo();

        // 1、设置spu的基本信息
        CompletableFuture<Void> spuInfoFuture = CompletableFuture.runAsync(() -> {
            SpuInfoEntity spuInfoEntity = getById(spuId);
            BeanUtils.copyProperties(spuInfoEntity, spuVo);
            spuVo.setSpuId(spuInfoEntity.getId());
        }, threadPoolExecutor);

        // 2、设置spu详情图片
        CompletableFuture<Void> spuDescImgFuture = CompletableFuture.runAsync(() -> {
            SpuInfoDescEntity spuInfoDescEntity = spuInfoDescService.getOne(new QueryWrapper<SpuInfoDescEntity>().eq("spu_id", spuId));
            List<String> decript = Arrays.asList(spuInfoDescEntity.getDecript().split(","));
            spuVo.setDecript(decript);
        }, threadPoolExecutor);

        // 3、设置商品图片集合
        CompletableFuture<Void> spuImagesFuture = CompletableFuture.runAsync(() -> {
            List<SpuImagesEntity> spuImagesEntities = spuImagesService.list(new QueryWrapper<SpuImagesEntity>().eq("spu_id", spuId));
            List<String> images = spuImagesEntities.stream().map(SpuImagesEntity::getImgUrl).collect(Collectors.toList());
            spuVo.setImages(images);
        }, threadPoolExecutor);

        // 4、设置购买所得积分
        CompletableFuture<Void> spuBountsFuture = CompletableFuture.runAsync(() -> {
            ResponseResult<SpuBoundsEntity> response = couponFeignService.queryBoundInfoById(spuId);
            if (response.getCode() == 200) {
                Bounds bounds = new Bounds();
                BeanUtils.copyProperties(response.getData(), bounds);
                spuVo.setBounds(bounds);
            }
        }, threadPoolExecutor);

        // 5、设置基本属性
        CompletableFuture<Void> baseAttrFuture = CompletableFuture.runAsync(() -> {
            List<ProductAttrValueEntity> productAttrs = productAttrValueService.list(
                    new QueryWrapper<ProductAttrValueEntity>()
                            .eq("spu_id", spuId));
            List<BaseAttr> baseAttrs = productAttrs.stream().map(productAttr -> {
                BaseAttr baseAttr = new BaseAttr();
                BeanUtils.copyProperties(productAttr, baseAttr);
                baseAttr.setAttrValues(productAttr.getAttrValue());
                baseAttr.setShowDesc(productAttr.getQuickShow());
                return baseAttr;
            }).collect(Collectors.toList());
            spuVo.setBaseAttrs(baseAttrs);
        }, threadPoolExecutor);

        // 6、设置sku信息
        CompletableFuture<Void> skuInfoFuture = CompletableFuture.runAsync(() -> {
            // 6.1、获取指定spu下面的所有销售属性
            List<SkuInfoEntity> skus = skuInfoService.list(new QueryWrapper<SkuInfoEntity>().eq("spu_id", spuId));
            //6.2、遍历所有的sku，组合所需格式的sku信息
            List<Sku> respSkus = skus.stream().map(sku -> {
                Sku respSku = new Sku();
                // 6.3、将sku的信息复制给需要返回的sku中
                BeanUtils.copyProperties(sku, respSku);
                //6、4、查询指定sku下面的图片信息
                List<SkuImagesEntity> skuImages = skuImagesService.list(new QueryWrapper<SkuImagesEntity>().eq("sku_id", sku.getSkuId()));
                List<Image> respImages = skuImages.stream().map(skuImage -> {
                    Image respImage = new Image();
                    BeanUtils.copyProperties(skuImage, respImage);
                    return respImage;
                }).collect(Collectors.toList());
                respSku.setImages(respImages);
                // 6.5、设置销售属性
                List<SkuSaleAttrValueEntity> saleAttrs = skuSaleAttrValueService.list(new QueryWrapper<SkuSaleAttrValueEntity>().eq("sku_id", sku.getSkuId()));
                List<SaleAttr> respSaleAttrs = saleAttrs.stream().map(saleAttr -> {
                    SaleAttr respSaleAttr = new SaleAttr();
                    BeanUtils.copyProperties(saleAttr, respSaleAttr);
                    return respSaleAttr;
                }).collect(Collectors.toList());
                respSku.setAttr(respSaleAttrs);
                //6.6、提取出所有销售属性的值
                List<String> attrValues = saleAttrs.stream().map(SkuSaleAttrValueEntity::getAttrValue).collect(Collectors.toList());
                respSku.setDescar(attrValues);

                //6.7、设置商品的折扣信息
                ResponseResult<SkuReductionDto> discountResponse = couponFeignService.querySkuDiscountBySkuId(sku.getSkuId());
                BeanUtils.copyProperties(discountResponse, respSku);

                return respSku;
            }).collect(Collectors.toList());
            spuVo.setSkus(respSkus);
        }, threadPoolExecutor);

        // 7、等所有线程完成之后再返回
        CompletableFuture.allOf(spuInfoFuture, spuDescImgFuture, spuImagesFuture, spuBountsFuture, baseAttrFuture, skuInfoFuture).get();


        return spuVo;
    }
}
