package com.xiaofei.coupon.service;

import com.alibaba.fastjson.JSON;
import com.xiaofei.common.dto.SkuReductionDto;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class SkuFullReductionServiceTest {

    @Autowired
    private SkuFullReductionService skuFullReductionService;

    @Test
    @DisplayName("查询指定商品的所有优惠信息")
    void querySkuDiscountBySkuId() {
        SkuReductionDto skuReductionDto = skuFullReductionService.querySkuDiscountBySkuId(1L);
        System.out.println(JSON.toJSONString(skuReductionDto));
    }
}
