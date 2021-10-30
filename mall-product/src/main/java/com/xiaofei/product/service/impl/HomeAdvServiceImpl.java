package com.xiaofei.product.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.redis.service.RedisService;
import com.xiaofei.common.product.constant.CacheConstant;
import com.xiaofei.common.product.constant.HomeAdvEntity;
import com.xiaofei.common.product.entity.CategoryEntity;
import com.xiaofei.common.product.enums.AdvEnum;
import com.xiaofei.common.product.vo.AdvQueryVo;
import com.xiaofei.common.product.vo.HomeRespVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.mapper.HomeAdvMapper;
import com.xiaofei.product.service.CategoryService;
import com.xiaofei.product.service.HomeAdvService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 *
 */
@Service
public class HomeAdvServiceImpl extends ServiceImpl<HomeAdvMapper, HomeAdvEntity>implements HomeAdvService {
    @Autowired
    private ThreadPoolExecutor thread;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private RedisService redisService;


    /**
     * 根据查询条件
     *
     * @param advQueryVo 查询条件
     * @return 返回查询好的分页信息
     */
    @Override
    public PageVo<HomeAdvEntity> queryByPage(AdvQueryVo advQueryVo) {
        PageHelper.startPage(advQueryVo.getPageNo(), advQueryVo.getPageSize());

        //判断搜索条件是否为空
        QueryWrapper<HomeAdvEntity> queryWrapper = new QueryWrapper<>();

        // 获取指定类别广告
        if (advQueryVo.getAdvType() != null) {
            AdvEnum advEnum = AdvEnum.getAdv(advQueryVo.getAdvType());
            if (advEnum != null && !StringUtils.isEmpty(advEnum.getAdvTypeName())) {
                queryWrapper.eq("adv_type", advEnum.getAdvType());
            }
        }


        //根据搜索条件查询
        List<HomeAdvEntity> advs = this.list(queryWrapper);

        PageInfo<HomeAdvEntity> page = new PageInfo<>(advs);

        return new PageVo<>(page.getPageNum(), page.getPageSize(), page.getPages(), page.getTotal(), page.getList());
    }

    /**
     * 首页广告资源加载
     *
     * @return 返回广告
     */
    @Override
    public HomeRespVo queryAdvInfo() throws ExecutionException, InterruptedException {
        // 异步加载广告资源
        HomeRespVo homeRespVo = new HomeRespVo();

        //首页轮播图获取
        CompletableFuture<Void> carousels = CompletableFuture.runAsync(() -> {
            // 先获取缓存中的数据，如果缓存中没有的话，再去查询数据库
            List<HomeAdvEntity> carouselCache = redisService.getCacheObject(CacheConstant.PC_HOME_ADV);
            if (carouselCache == null || carouselCache.size() < 1) {
                List<HomeAdvEntity> carouselList = this.list(new QueryWrapper<HomeAdvEntity>().eq("adv_type", 1).eq("status", 1));
                redisService.setCacheObject(CacheConstant.PC_HOME_ADV, carouselList, (long) 60 * 60 * 24, TimeUnit.SECONDS);
                homeRespVo.setCarousels(carouselList);
            } else {
                homeRespVo.setCarousels(carouselCache);
            }
        }, thread);

        //首页广告加载
        CompletableFuture<Void> advs = CompletableFuture.runAsync(() -> {
            // 先获取缓存中的数据，如果缓存中没有的话，再去查询数据库
            List<HomeAdvEntity> advCache = redisService.getCacheObject(CacheConstant.PC_HOME_ADV);
            if (advCache == null || advCache.size() < 1) {
                List<HomeAdvEntity> advList = this.list(new QueryWrapper<HomeAdvEntity>().eq("adv_type", 3).eq("status", 1));
                redisService.setCacheObject(CacheConstant.PC_HOME_ADV, advList, (long) 60 * 60 * 24, TimeUnit.SECONDS);
                homeRespVo.setAdvs(advList);
            } else {
                homeRespVo.setAdvs(advCache);
            }
        }, thread);

        //首页热门类别加载
        CompletableFuture<Void> category = CompletableFuture.runAsync(() -> {
            // 先获取缓存中的数据，如果缓存中没有的话，再去查询数据库
            List<CategoryEntity> categoryCache = redisService.getCacheObject(CacheConstant.APP_HOME_CATEGORY);
            if (categoryCache == null || categoryCache.size() < 1) {
                List<CategoryEntity> categoryList = categoryService.queryByParentId(113L);
                redisService.setCacheObject(CacheConstant.APP_HOME_CATEGORY, categoryList, (long) 60 * 60 * 24, TimeUnit.SECONDS);
                homeRespVo.setCategorys(categoryList);
            } else {
                homeRespVo.setCategorys(categoryCache);
            }
        }, thread);

        //等待所有的异步任务都完成之后再返回数据
        CompletableFuture.allOf(carousels, advs, category).get();

        return homeRespVo;
    }
}




