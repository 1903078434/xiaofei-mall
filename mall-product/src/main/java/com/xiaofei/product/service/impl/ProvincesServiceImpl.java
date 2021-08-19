package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.ProvincesEntity;
import com.xiaofei.product.mapper.ProvincesDao;
import com.xiaofei.product.service.ProvincesService;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/13
 * Time: 14:16
 */
@Service
public class ProvincesServiceImpl extends ServiceImpl<ProvincesDao, ProvincesEntity> implements ProvincesService {

    /**
     * 查询全部的地区信息
     *
     * @return 返回查询到的地区信息
     */
    @Cacheable(value = "provinces", key = "'provincesJson'")//开启之后会先去redis中寻找对应的数据，如果没有再从数据库中查询
    @Override
    public List<ProvincesEntity> queryAllProvinces() {
        //1、查出所有分类
        List<ProvincesEntity> provinces = this.list();

        //2、组装成父子的树形结构，2.1、找到一级分类，lambda写法
        return provinces.stream().filter(provincesEntity -> {
            //当父节点为parentId=0时返回节点
            return provincesEntity.getParentId() == 0;
        })
                //获取根集合下的子节点，peek方法将每一项中的children属性中的值修改之后再返回，和stream中的map方法使用差不多
                .peek(provincesEntity -> provincesEntity.setChildren(getChildrens(provincesEntity, provinces)))

                //将查询的结果转换为集合
                .collect(Collectors.toList());//将结果作为一个集合返回
    }

    /**
     * 递归获取获取子节点
     *
     * @param root 根节点
     * @param all  所有阶段的节点
     * @return 返回子节点
     */
    private List<ProvincesEntity> getChildrens(ProvincesEntity root, List<ProvincesEntity> all) {

        return all.stream().filter(provincesEntity -> {
            //Long使用equals比较，long使用 == 来比较
            return provincesEntity.getParentId().equals(root.getId());
        })
                .peek(provincesEntity -> provincesEntity.setChildren(getChildrens(provincesEntity, all)))//设置子节点
                .collect(Collectors.toList());//将结果作为一个集合返回

    }
}
