package com.xiaofei.product.service;

import com.xiaofei.common.product.vo.SpuInfoVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

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

}
