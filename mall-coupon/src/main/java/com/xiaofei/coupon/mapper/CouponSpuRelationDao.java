package com.xiaofei.coupon.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.coupon.entity.CouponSpuRelationEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 优惠券与产品关联
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-27 12:04:06
 */
@Mapper
public interface CouponSpuRelationDao extends BaseMapper<CouponSpuRelationEntity> {

}
