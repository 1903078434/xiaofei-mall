package com.xiaofei.product.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaofei.common.product.entity.AttrEntity;
import com.xiaofei.common.product.vo.AttrVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 商品属性
 *
 * @author xiaofei
 */
@Mapper
public interface AttrDao extends BaseMapper<AttrEntity> {

    /**
     * 查询未关联的属性
     *
     * @param attrIds 已关联的属性集合
     * @return 返回未关联的属性集合
     */
    List<AttrVo> selectNotRelationAttr(List<Long> attrIds);
}
