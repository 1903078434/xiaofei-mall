package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.product.entity.AttrAttrgroupRelationEntity;
import com.xiaofei.common.product.entity.AttrEntity;
import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.entity.CategoryEntity;
import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.AttrDao;
import com.xiaofei.product.service.AttrAttrgroupRelationService;
import com.xiaofei.product.service.AttrGroupService;
import com.xiaofei.product.service.AttrService;
import com.xiaofei.product.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 商品类别
 * User: 李飞
 * Date: 2021/7/23
 * Time: 22:50
 */
@Service
@Slf4j
public class AttrServiceImpl extends ServiceImpl<AttrDao, AttrEntity> implements AttrService {

    @Autowired
    private AttrAttrgroupRelationService attrAttrgroupRelationService;

    @Autowired
    private AttrGroupService attrGroupService;

    @Autowired
    private CategoryService categoryService;

    /**
     * 添加属性的基本信息
     *
     * @param attrVo 属性的信息
     * @return true：添加成功。false：添加失败
     */
    @Transactional
    @Override
    public boolean addAttr(AttrVo attrVo) {
        AttrEntity attrEntity = new AttrEntity();
        BeanUtils.copyProperties(attrVo, attrEntity);
        //保存属性的基本信息
        boolean saveAttr = this.save(attrEntity);

        boolean saveRelation = false;
        //保存属性分组和属性的信息，判断是否选择了属性分组
        if (!StringUtils.isEmpty(attrVo.getAttrGroupId().toString())) {
            AttrAttrgroupRelationEntity relation = new AttrAttrgroupRelationEntity();
            relation.setAttrId(attrEntity.getAttrId());
            relation.setAttrGroupId(attrVo.getAttrGroupId());
            saveRelation = attrAttrgroupRelationService.save(relation);
        }
        return saveAttr && saveRelation;
    }

    /**
     * 根据属性id集合删除
     *
     * @param attrId 属性id集合拼接的id
     * @return true：删除成功。false：删除失败
     */
    @Override
    public boolean deleteAttrById(String attrId) {
        //TODO　属性的删除功能，未完善
        List<String> attrIds = Arrays.stream(attrId.split(",")).collect(Collectors.toList());

        //return this.removeByIds(attrIds);

        return true;
    }

    /**
     * 修改属性的基本信息
     *
     * @param attrVo 新的数据
     * @return true：修改成功。false：修改失败
     */
    @Transactional
    @Override
    public boolean updateAttr(AttrVo attrVo) {
        //TODO　属性的修改功能，未完善
        if (attrVo.getAttrId() < 1) {
            return false;
        }
        AttrEntity attrEntity = new AttrEntity();
        BeanUtils.copyProperties(attrVo, attrEntity);
        //保存属性的基本信息
        boolean updateAttr = this.updateById(attrEntity);

        boolean updateRelation = false;
        //保存属性分组和属性的信息，判断是否选择了属性分组
        if (!StringUtils.isEmpty(attrVo.getAttrGroupId().toString())) {
            AttrAttrgroupRelationEntity relation = new AttrAttrgroupRelationEntity();
            relation.setAttrId(attrEntity.getAttrId());
            relation.setAttrGroupId(attrVo.getAttrGroupId());

            //判断在此之前有没有保存过属性和属性分组的相关信息，如果没有添加过，则做添加操作，否则做修改操作
            QueryWrapper<AttrAttrgroupRelationEntity> queryWrapper = new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_id", attrVo.getAttrId());
            AttrAttrgroupRelationEntity attrgroupRelationEntity = attrAttrgroupRelationService.getOne(queryWrapper);

            if (attrgroupRelationEntity != null) {
                updateRelation = attrAttrgroupRelationService.update(relation, queryWrapper);
            } else {
                updateRelation = attrAttrgroupRelationService.save(relation);
            }
        }
        return updateAttr && updateRelation;
    }

    /**
     * 查询基本属性
     */
    @Override
    public PageVo<AttrVo> queryBaseAttr(AttrVo attrVo, int attrType) {

        PageHelper.startPage(attrVo.getPageNo(), attrVo.getPageSize());

        //查询条件选择器
        QueryWrapper<AttrEntity> queryWrapper = new QueryWrapper<>();


        //判断是基本属性还是销售属性【1：基本属性。0：销售属性】
        if (1 == attrType) {
            queryWrapper.eq("attr_type", attrType);
        } else {
            if (0 == attrType) {
                queryWrapper.eq("attr_type", attrType);
            } else {
                //如果没有传入是销售属性还是基本属性，或传入其他无用值，直接返回
                return new PageVo<>();
            }
        }

        //判断搜索条件是否为空
        if (!StringUtils.isEmpty(attrVo.getSearchValue())) {
            queryWrapper.and(wrapper ->
                    wrapper.like("attr_name", attrVo.getSearchValue()).or()
                            .eq("attr_id", attrVo.getSearchValue())
            );
        }

        //判断类别是否为空
        if (attrVo.getCatelogId() > 0) {
            queryWrapper.eq("catelog_id", attrVo.getCatelogId());
        }


        //根据搜索条件查询
        List<AttrEntity> attrs = this.list(queryWrapper);

        PageInfo<AttrEntity> pageInfo = new PageInfo<>(attrs);

        PageVo<AttrVo> page = new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal());

        //将查询出来的结果再次查询数据库，根据属性id查询属性分组信息，根据分类id查询分类名称
        List<AttrVo> items = attrs.stream().map(attr -> {
            AttrVo item = new AttrVo();
            BeanUtils.copyProperties(attr, item);
            //查询属性分组的信息
            AttrAttrgroupRelationEntity attrAttrgroupRelationEntity = attrAttrgroupRelationService.getOne(
                    new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_id", attr.getAttrId()));

            if (attrAttrgroupRelationEntity != null) {
                AttrGroupEntity attrGroupEntity = attrGroupService.getById(attrAttrgroupRelationEntity.getAttrGroupId());
                if (attrGroupEntity != null) {
                    item.setAttrGroupId(attrGroupEntity.getAttrGroupId());
                    item.setAttrGroupName(attrGroupEntity.getAttrGroupName());
                }
            }

            //查询分类名称
            CategoryEntity categoryEntity = categoryService.getById(attr.getCatelogId());
            if (categoryEntity != null) {
                //设置属性分组名称和分类名称
                item.setCatelogId(categoryEntity.getCatId());
                item.setCategoryName(categoryEntity.getName());
            }

            return item;
        }).collect(Collectors.toList());
        page.setItems(items);
        return page;
    }

    /**
     * 根据属性类别查询属性信息
     *
     * @param attrId 属性id
     * @return 返回属性的信息
     */
    @Override
    public AttrVo queryAttrById(Long attrId) {
        AttrVo attrVo = new AttrVo();//返回的数据

        if (attrId == 0) {
            return attrVo;
        }

        //查询商品规格参数
        AttrEntity attrEntity = this.getById(attrId);
        //复制数据
        BeanUtils.copyProperties(attrEntity, attrVo);

        //查询商品属性分组和商品规格参数的总表
        AttrAttrgroupRelationEntity attrgroupRelationEntity = attrAttrgroupRelationService.
                getOne(new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_id", attrEntity.getAttrId()));
        if (attrgroupRelationEntity != null) {
            attrVo.setAttrGroupId(attrgroupRelationEntity.getAttrGroupId());
            //查询规格参数的分组信息
            AttrGroupEntity attrGroupEntity = attrGroupService.getBaseMapper().selectById(attrgroupRelationEntity.getAttrGroupId());
            if (attrGroupEntity != null) {
                attrVo.setAttrGroupName(attrGroupEntity.getAttrGroupName());
            }
        }

        //调用categoryService中封装好的查找父分类信息的方法
        Long catelogId = attrEntity.getCatelogId();
        Long[] catelogPath = categoryService.findCategoryPath(catelogId);
        attrVo.setCatelogPath(catelogPath);

        attrVo.setCategoryName(categoryService.getById(catelogId).getName());

        return attrVo;
    }
}
