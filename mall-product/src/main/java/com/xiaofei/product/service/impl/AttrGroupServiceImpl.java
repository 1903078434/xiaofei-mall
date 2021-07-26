package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.utils.StringUtils;
import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.vo.AttrGroupVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.AttrGroupDao;
import com.xiaofei.product.service.AttrGroupService;
import com.xiaofei.product.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        QueryWrapper<AttrGroupEntity> queryWrapper = null;

        //搜索条件不为空，则拼接查询条件
        if (!StringUtils.isEmpty(attrGroupVo.getSearchValue())) {
            queryWrapper = new QueryWrapper<AttrGroupEntity>()
                    .eq("attr_group_id", attrGroupVo.getSearchValue()).or()
                    .eq("attr_group_name", attrGroupVo.getSearchValue()).or()
                    .eq("catelog_id", attrGroupVo.getSearchValue()).or();
        }

        //根据搜索条件查询
        List<AttrGroupEntity> items = this.list(queryWrapper);

        PageInfo<AttrGroupEntity> page = new PageInfo<>(items);

        return new PageVo<>(page.getPageNum(), page.getPageSize(), page.getPages(), page.getTotal(), page.getList());
    }


}
