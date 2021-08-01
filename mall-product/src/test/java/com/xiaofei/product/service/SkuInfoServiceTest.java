package com.xiaofei.product.service;


import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.vo.SkuInfoVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * User: 李飞
 * Date: 2021/7/31
 * Time: 20:34
 */
@SpringBootTest
public class SkuInfoServiceTest {

    @Autowired
    private SkuInfoService skuInfoService;

    /**
     * 分页查询sku信息
     */
    @Test
    void queryByPage() {
        SkuInfoVo skuInfoVo = new SkuInfoVo();
        PageVo<SkuInfoEntity> page = skuInfoService.queryByPage(skuInfoVo);

        System.out.println(page);

        page.getItems().forEach(System.out::println);
    }

}
