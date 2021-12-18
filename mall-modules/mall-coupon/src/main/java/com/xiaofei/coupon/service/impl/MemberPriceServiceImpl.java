package com.xiaofei.coupon.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.coupon.entity.MemberPriceEntity;
import com.xiaofei.coupon.mapper.MemberPriceDao;
import com.xiaofei.coupon.service.MemberPriceService;
import org.springframework.stereotype.Service;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:34
 */
@Service
public class MemberPriceServiceImpl extends ServiceImpl<MemberPriceDao, MemberPriceEntity> implements MemberPriceService {
}
