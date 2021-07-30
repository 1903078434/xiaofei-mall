package com.xiaofei.coupon.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.coupon.entity.MemberPriceEntity;
import com.xiaofei.common.coupon.entity.SkuFullReductionEntity;
import com.xiaofei.common.coupon.entity.SkuLadderEntity;
import com.xiaofei.common.dto.SkuReductionDto;
import com.xiaofei.common.product.vo.spu.MemberPrice;
import com.xiaofei.coupon.mapper.SkuFullReductionDao;
import com.xiaofei.coupon.service.MemberPriceService;
import com.xiaofei.coupon.service.SkuFullReductionService;
import com.xiaofei.coupon.service.SkuLadderService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:17
 */
@Service
public class SkuFullReductionServiceImpl extends ServiceImpl<SkuFullReductionDao, SkuFullReductionEntity> implements SkuFullReductionService {

    @Autowired
    private SkuLadderService skuLadderService;

    @Autowired
    private MemberPriceService memberPriceService;

    /**
     * 保存商品的折扣信息和优惠信息
     *
     * @param skuReductionDto 商品的优惠信息
     */
    @Transactional
    @Override
    public boolean saveSkuReduction(SkuReductionDto skuReductionDto) {
        //1、sku的优惠、满减信息【mall_sms --> sms_sku_ladder / sms_sku_full_reduction / sms_member_price】

        //1.1、sms_sku_ladder【折扣】
        SkuLadderEntity skuLadderEntity = new SkuLadderEntity();
        skuLadderEntity.setSkuId(skuReductionDto.getSkuId());//sku的id
        skuLadderEntity.setFullCount(skuReductionDto.getFullCount());//满多少件
        skuLadderEntity.setDiscount(skuReductionDto.getDiscount());//满足条件打几折
        skuLadderEntity.setAddOther(skuReductionDto.getCountStatus());//是否叠加优惠

        //判断打折信息是否为空，不为空才调用方法保存
        if (skuReductionDto.getFullCount() > 0) {
            skuLadderService.save(skuLadderEntity);
        }

        //1.2、sms_sku_full_reduction【满减】
        SkuFullReductionEntity skuFullReductionEntity = new SkuFullReductionEntity();
        BeanUtils.copyProperties(skuReductionDto, skuFullReductionEntity);//复制bean
        //判断打折信息是否为空，不为空才调用方法保存
        if (skuReductionDto.getFullPrice().compareTo(new BigDecimal(0)) > 0) {
            this.save(skuFullReductionEntity);
        }

        //1.3、sms_member_price【会员价格】
        List<MemberPrice> memberPrice = skuReductionDto.getMemberPrice();
        List<MemberPriceEntity> memberPriceEntities = memberPrice.stream().map(memberPriceItem -> {
            MemberPriceEntity memberPriceEntity = new MemberPriceEntity();
            memberPriceEntity.setSkuId(skuReductionDto.getSkuId());//sku的id
            memberPriceEntity.setMemberLevelId(memberPriceItem.getId());//会员id
            memberPriceEntity.setMemberLevelName(memberPriceItem.getName());//会员名称
            memberPriceEntity.setMemberPrice(memberPriceItem.getPrice());//会员价格
            memberPriceEntity.setAddOther(1);//是否叠加优惠
            return memberPriceEntity;
        }).filter(memberPriceItem -> {
            //当存在会员价格的是否才保存将信息保存
            return memberPriceItem.getMemberPrice().compareTo(new BigDecimal(0)) > 0;
        }).collect(Collectors.toList());

        //如果有会员价格的时候才添加
        return memberPriceService.saveBatch(memberPriceEntities);
    }
}
