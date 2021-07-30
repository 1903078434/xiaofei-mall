package com.xiaofei.coupon.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.coupon.entity.HomeSubjectEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 首页专题表【jd首页下面很多专题，每个专题链接新的页面，展示专题商品信息】
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-27 12:04:06
 */
@Mapper
public interface HomeSubjectDao extends BaseMapper<HomeSubjectEntity> {

}
