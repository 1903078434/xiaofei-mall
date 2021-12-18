package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.AttrAttrgroupRelationEntity;
import com.xiaofei.common.product.entity.AttrEntity;
import com.xiaofei.common.product.vo.AttrAttrGroupRelationVo;
import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.AttrAttrgroupRelationDao;
import com.xiaofei.product.service.AttrAttrgroupRelationService;
import com.xiaofei.product.service.AttrService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/7/28
 * Time: 17:02
 */
@Service
public class AttrAttrgroupRelationImpl extends ServiceImpl<AttrAttrgroupRelationDao, AttrAttrgroupRelationEntity> implements AttrAttrgroupRelationService {

    @Autowired
    private AttrService attrService;

    /**
     * 添加属性分组和属性的关联关系
     *
     * @param relationVos 关联关系的信息
     * @return true：添加成功。false：添加失败
     */
    @Transactional
    @Override
    public boolean addRelation(List<AttrAttrGroupRelationVo> relationVos) {
        List<AttrAttrgroupRelationEntity> attrAttrgroupRelationEntitys = new ArrayList<>();
        relationVos.forEach(relation -> {
            AttrAttrgroupRelationEntity attrAttrgroupRelationEntity = new AttrAttrgroupRelationEntity();
            BeanUtils.copyProperties(relation, attrAttrgroupRelationEntity);
            attrAttrgroupRelationEntitys.add(attrAttrgroupRelationEntity);
        });
        return this.saveBatch(attrAttrgroupRelationEntitys);
    }

    /**
     * 根据关系集合id批量或单个删除关联关系
     *
     * @param relationVos 属性分组和属性关联id
     * @return true：删除成功。false：删除失败
     */
    @Transactional
    @Override
    public boolean deleteByRelation(List<AttrAttrGroupRelationVo> relationVos) {
        //TODO 删除关联关系，未完成

        //将传入的VO中的属性id提取出来
        List<Long> attrIds = relationVos.stream().map(AttrAttrGroupRelationVo::getAttrId).collect(Collectors.toList());
        return this.remove(new QueryWrapper<AttrAttrgroupRelationEntity>().in("attr_id", attrIds));
    }

    /**
     * 根据属性分组id查询该分组绑定的所有属性信息
     *
     * @param attrGroupId 属性分组id
     * @return 返回指定分组绑定的所有关联信息
     */
    @Override
    public List<AttrAttrGroupRelationVo> queryRelationByAttrGroupId(Long attrGroupId) {
        //查询指定分组的所有关联信息
        List<AttrAttrgroupRelationEntity> relations = this.list(new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_group_id", attrGroupId));

        //查询属性名称和属性值
        return relations.stream().map(relation -> {
            AttrAttrGroupRelationVo attrAttrGroupRelationVo = new AttrAttrGroupRelationVo();
            //查询属性信息
            AttrEntity attrEntity = attrService.getById(relation.getAttrId());
            attrAttrGroupRelationVo.setAttrGroupId(relation.getAttrGroupId());
            BeanUtils.copyProperties(attrEntity, attrAttrGroupRelationVo);
            return attrAttrGroupRelationVo;
        }).collect(Collectors.toList());

    }

    /**
     * 根据已关联的信息，查询未关联的属性
     */
    @Override
    public PageVo<AttrVo> queryNoRelationAttr(AttrVo attrVo) {

        //查询所有已经关联的属性id
        List<Long> attrIds = this.list(new QueryWrapper<AttrAttrgroupRelationEntity>()
                .select("attr_id"))
                .stream().map(AttrAttrgroupRelationEntity::getAttrId).collect(Collectors.toList());

        return attrService.queryNotRelationAttr(attrVo, attrIds);
    }
}
