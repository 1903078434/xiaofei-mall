package com.xiaofei.product.service;


import com.alibaba.fastjson.JSON;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;
import com.xiaofei.common.product.vo.SkuInfoVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.ExecutionException;

/**
 * User: 李飞
 * Date: 2021/7/31
 * Time: 20:34
 */
@SpringBootTest
public class SkuInfoServiceTest {

    @Autowired
    private SkuInfoService skuInfoService;

    @DisplayName("分页查询sku信息")
    @Test
    void queryByPage() {
        SkuInfoVo skuInfoVo = new SkuInfoVo();
        PageVo<SkuInfoEntity> page = skuInfoService.queryByPage(skuInfoVo);

        System.out.println(page);

        page.getItems().forEach(System.out::println);
    }

    /**
     *
     */
    @DisplayName("根据skuId查询商品详情页面的信息")
    @Test
    void querySkuItemInfo() throws ExecutionException, InterruptedException {
        SkuDetailInfoVo skuDetailInfoVo = skuInfoService.querySkuItemInfo(1L);
        System.out.println(JSON.toJSONString(skuDetailInfoVo));
    }


}
