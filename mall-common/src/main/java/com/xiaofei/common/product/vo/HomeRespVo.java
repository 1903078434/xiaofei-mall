package com.xiaofei.common.product.vo;

import com.xiaofei.common.product.constant.HomeAdvEntity;
import com.xiaofei.common.product.entity.CategoryEntity;
import lombok.Data;

import java.util.List;

/**
 * 首页广告和轮播图资源
 * User: 李飞
 * Date: 2021/9/22
 * Time: 9:46
 */
@Data
public class HomeRespVo {
    private List<HomeAdvEntity> carousels;
    private List<HomeAdvEntity> advs;
    private List<CategoryEntity> categorys;
}
