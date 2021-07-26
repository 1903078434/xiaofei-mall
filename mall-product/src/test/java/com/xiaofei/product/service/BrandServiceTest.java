package com.xiaofei.product.service;

import com.xiaofei.common.product.entity.BrandEntity;
import com.xiaofei.common.product.vo.BrandVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * User: 李飞
 * Date: 2021/7/25
 * Time: 14:46
 */
@SpringBootTest
public class BrandServiceTest {

    @Autowired
    private BrandService brandService;

    @Test
    void queryByPage() {
        BrandVo brandVo = new BrandVo();
        brandVo.setPageNo(-567);
        brandVo.setPageSize(24238);
        brandVo.setSearchValue("华为");
        PageVo<BrandEntity> page = brandService.queryByPage(brandVo);
        System.out.println("测试一下");
    }
}
