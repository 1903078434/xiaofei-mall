package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.dto.SkuReductionDto;
import com.xiaofei.common.dto.SpuBoundsDto;
import com.xiaofei.common.product.entity.*;
import com.xiaofei.common.product.vo.spu.*;
import com.xiaofei.product.feign.CouponFeignService;
import com.xiaofei.product.mapper.SpuInfoDao;
import com.xiaofei.product.service.*;
import io.seata.spring.annotation.GlobalTransactional;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
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

    /**
     * 添加spu的信息和sku的信息
     *
     * @param spuVo 商品信息
     */
    @GlobalTransactional //Seata的分布式事务锁
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

        //3、保存spu图片集【pms_spu_images】
        List<String> spuImages = spuVo.getImages();//获取商品的图片合集
        spuImagesService.saveImages(spuInfoEntity.getId(), spuImages);

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
        productAttrValueService.saveBatch(productAttrValueEntities);

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
}
