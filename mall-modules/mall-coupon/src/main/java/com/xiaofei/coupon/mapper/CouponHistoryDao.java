package com.xiaofei.coupon.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.coupon.entity.CouponHistoryEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 优惠券领取历史记录
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-27 12:04:06
 */
@Mapper
public interface CouponHistoryDao extends BaseMapper<CouponHistoryEntity> {

}
