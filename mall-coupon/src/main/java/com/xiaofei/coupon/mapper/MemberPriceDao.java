package com.xiaofei.coupon.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.coupon.entity.MemberPriceEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商品会员价格
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-27 12:04:05
 */
@Mapper
public interface MemberPriceDao extends BaseMapper<MemberPriceEntity> {

}
