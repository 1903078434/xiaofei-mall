package com.xiaofei.product.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaofei.common.product.entity.SpuInfoEntity;
import com.xiaofei.common.product.vo.SpuInfoVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/7/31
 * Time: 15:18
 */
@SpringBootTest
public class SpuInfoServiceTest {

    @Autowired
    private SpuInfoService spuInfoService;

    /**
     * 分页查询商品信息
     */
    @Test
    void queryByPage() {
        SpuInfoVo spuInfoVo = new SpuInfoVo();

        PageVo<SpuInfoVo> page = spuInfoService.queryByPage(spuInfoVo);
        System.out.println(page);
        page.getItems().forEach(System.out::println);
    }

    @Test
    @DisplayName("全部商品上架")
    void spuUpAll() {
        List<Long> spuIds = spuInfoService.list(new QueryWrapper<SpuInfoEntity>().eq("publish_status", 0))
                .stream().map(SpuInfoEntity::getId).collect(Collectors.toList());
        spuIds.forEach(spuId -> spuInfoService.spuUp(spuId));
    }

    @Test
    @DisplayName("上架指定商品")
    void spuUpById() {
        spuInfoService.spuUp(1L);
    }

    @Test
    @DisplayName("查询指定spu的所有信息")
    void internalQuerySpuInfoById() throws ExecutionException, InterruptedException {
        System.out.println(JSON.toJSONString(spuInfoService.internalQuerySpuInfoById(1L)));
    }

}
