package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.product.entity.AttrAttrgroupRelationEntity;
import com.xiaofei.common.product.entity.AttrEntity;
import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.vo.AttrAndAttrGroupVo;
import com.xiaofei.common.product.vo.AttrGroupVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.AttrGroupDao;
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

import java.util.ArrayList;
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
public class AttrGroupServiceImpl extends ServiceImpl<AttrGroupDao, AttrGroupEntity> implements AttrGroupService {


    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AttrService attrService;

    @Autowired
    private AttrAttrgroupRelationService attrAttrgroupRelationService;

    /**
     * 属性分组信息的添加
     *
     * @param attrGroupVo 属性分组信息
     * @return true：添加成功。false：添加失败
     */
    @Override
    public boolean addAttrGroup(AttrGroupVo attrGroupVo) {
        //将AttrGroupVo中的参数信息，复制到 AttrGroupEntity中
        AttrGroupEntity attrGroupEntity = new AttrGroupEntity();

        BeanUtils.copyProperties(attrGroupVo, attrGroupEntity);

        //查询数据库
        return this.save(attrGroupEntity);
    }

    /**
     * 批量删除分组信息，或单个删除属性分组信息，根据id
     *
     * @param attrgroupId id字符串，多个id使用 ， 分割的
     * @return true:删除成功。false：删除失败
     */
    @Transactional
    @Override
    public boolean deleteAttrGroupById(String attrgroupId) {
        //TODO 属性分组删除功能尚未完善

        //将集合字符串转换为集合
        List<String> attrGroupIds = Arrays.stream(attrgroupId.split(",")).collect(Collectors.toList());

        // return this.baseMapper.deleteBatchIds(attrGroupIds);

        return false;
    }

    /**
     * 根据属性分组id修改属性分组信息
     *
     * @param attrGroupVo 属性分组的信息
     * @return true：修改成功，false：修改数百
     */
    @Transactional
    @Override
    public boolean updateAttrGroupById(AttrGroupVo attrGroupVo) {
        // TODO　属性分组修改功能未完成

        AttrGroupEntity attrGroupEntity = new AttrGroupEntity();

        BeanUtils.copyProperties(attrGroupVo, attrGroupEntity);

        //return this.updateById(attrGroupEntity);

        return false;
    }


    /**
     * 根据属性类别id查询属性的相关信息
     *
     * @param attrgroupId 属性类别id
     * @return 返回需要查询的属性类别id
     */
    @Override
    public AttrGroupVo queryAttrGroupById(Long attrgroupId) {
        //查询对应的属性分组信息
        AttrGroupEntity attrGroupEntity = this.getById(attrgroupId);
        AttrGroupVo attrGroupVo = new AttrGroupVo();
        //复制属性
        BeanUtils.copyProperties(attrGroupEntity, attrGroupVo);
        //查询级联选择器的路径
        Long[] categoryPath = categoryService.findCategoryPath(attrGroupEntity.getCatelogId());

        attrGroupVo.setCategoryPath(categoryPath);
        return attrGroupVo;
    }

    /**
     * 分页查询和搜索查询
     *
     * @param attrGroupVo 分页信息和搜索条件
     * @return 返回查询到的相关信息
     */
    @Override
    public PageVo<AttrGroupEntity> queryByPage(AttrGroupVo attrGroupVo) {
        PageHelper.startPage(attrGroupVo.getPageNo(), attrGroupVo.getPageSize());

        //判断搜索条件是否为空
        QueryWrapper<AttrGroupEntity> queryWrapper = new QueryWrapper<AttrGroupEntity>();

        //搜索条件不为空，则拼接查询条件
        if (!StringUtils.isEmpty(attrGroupVo.getSearchValue())) {
            queryWrapper.and(wrapper -> {
                wrapper.eq("attr_group_id", attrGroupVo.getSearchValue()).or()
                        .like("attr_group_name", attrGroupVo.getSearchValue()).or()
                        .like("descript", attrGroupVo.getSearchValue());
            });

        }

        //判断类别id是否为0
        if (attrGroupVo.getCatelogId() != 0) {
            queryWrapper.eq("catelog_id", attrGroupVo.getCatelogId());
        }

        //根据搜索条件查询
        List<AttrGroupEntity> items = this.list(queryWrapper);

        PageInfo<AttrGroupEntity> page = new PageInfo<>(items);

        return new PageVo<>(page.getPageNum(), page.getPageSize(), page.getPages(), page.getTotal(), page.getList());
    }

    /**
     * 根据类别查询属性分组信息
     *
     * @param categoryId 类别id
     * @return 返回指定类别的属性分组
     */
    @Override
    public List<AttrGroupVo> queryAttrGroupByCategoryId(Long categoryId) {
        List<AttrGroupEntity> attrGroupEntitys = this.list(new QueryWrapper<AttrGroupEntity>().eq("catelog_id", categoryId));

        List<AttrGroupVo> attrGroupVos = new ArrayList<>();
        attrGroupEntitys.forEach(attrGroupEntity -> {
            AttrGroupVo attrGroupVo = new AttrGroupVo();
            BeanUtils.copyProperties(attrGroupEntity, attrGroupVo);
            attrGroupVos.add(attrGroupVo);
        });

        return attrGroupVos;
    }

    /**
     * 获取指定类别下的属性，和分组信息
     *
     * @param categoryId 类别id
     * @return 返回属性分组和属性的结合信息
     */
    @Override
    public List<AttrAndAttrGroupVo>  queryAttrGroupWithAttr(Long categoryId) {
        List<AttrAndAttrGroupVo> items = new ArrayList<>();

        //查询指定类别下的所有分组信息
        List<AttrGroupEntity> attrGroupEntities = this.list(new QueryWrapper<AttrGroupEntity>().eq("catelog_id", categoryId));

        //遍历分组信息，查询分组下的所有属性
        attrGroupEntities.forEach(attrGroupEntity -> {
            AttrAndAttrGroupVo attrAndAttrGroupVo = new AttrAndAttrGroupVo();
            BeanUtils.copyProperties(attrGroupEntity, attrAndAttrGroupVo);

            //查询指定分组和属性的关联关系
            List<AttrAttrgroupRelationEntity> attrAttrgroupRelationEntities = attrAttrgroupRelationService.list(new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_group_id", attrGroupEntity.getAttrGroupId()));

            //根据属性id查询所有的属性信息
            List<AttrAndAttrGroupVo.Attr> attrs = new ArrayList<>();
            attrAttrgroupRelationEntities.forEach(attrAttrgroupRelationEntity -> {
                AttrEntity attrEntity = attrService.getOne(new QueryWrapper<AttrEntity>().eq("attr_id", attrAttrgroupRelationEntity.getAttrId()));
                AttrAndAttrGroupVo.Attr attr = new AttrAndAttrGroupVo.Attr();
                BeanUtils.copyProperties(attrEntity, attr);
                attrs.add(attr);
            });
            attrAndAttrGroupVo.setAttrs(attrs);
            items.add(attrAndAttrGroupVo);
        });
        return items;
    }
}
