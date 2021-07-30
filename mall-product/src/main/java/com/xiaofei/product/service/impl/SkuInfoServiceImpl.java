package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.product.mapper.SkuInfoDao;
import com.xiaofei.product.service.SkuInfoService;
import org.springframework.stereotype.Service;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:04
 */
@Service
public class SkuInfoServiceImpl extends ServiceImpl<SkuInfoDao, SkuInfoEntity> implements SkuInfoService {
}
