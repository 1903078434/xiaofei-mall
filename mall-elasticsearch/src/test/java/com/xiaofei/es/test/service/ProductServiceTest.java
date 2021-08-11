package com.xiaofei.es.test.service;

import com.xiaofei.common.es.vo.ProductRespVo;
import com.xiaofei.common.es.vo.SearchVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.es.service.ProductService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * User: 李飞
 * Date: 2021/8/11
 * Time: 11:58
 */
@SpringBootTest
public class ProductServiceTest {
    @Autowired
    private ProductService productService;

    @DisplayName("商品测试功能")
    @Test
    void searchProduct() {
        SearchVo searchVo = new SearchVo();
        searchVo.setSearchValue("HUAWEI");
        PageVo<ProductRespVo> page = productService.searchProduct(searchVo);
        System.out.println(page);
    }

}
