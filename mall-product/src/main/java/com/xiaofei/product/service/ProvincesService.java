package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.entity.ProvincesEntity;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/13
 * Time: 14:16
 */
public interface ProvincesService extends IService<ProvincesEntity> {
    /**
     * 查询全部的地区信息
     *
     * @return 返回查询到的地区信息
     */
    List<ProvincesEntity> queryAllProvinces();
}
