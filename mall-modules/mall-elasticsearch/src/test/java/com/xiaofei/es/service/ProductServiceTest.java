package com.xiaofei.es.service;

import com.xiaofei.es.vo.SearchVo;
import com.xiaofei.es.entity.Product;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

@SpringBootTest
class ProductServiceTest {

    @Autowired
    private ProductService productService;

    @Test
    void getProductById() {
        Product product = productService.getProductById(950L);
        System.out.println(product);
    }

    @Test
    void getNewProduct() throws IOException {
        productService.getNewProduct().forEach(System.out::println);
    }

    @Test
    void getHotProduct() throws IOException {
        productService.getHotProduct().forEach(System.out::print);
    }

    @Test
    @DisplayName("搜索商品")
    void searchProduct() throws IOException {
        SearchVo searchVo = new SearchVo();
        productService.searchProduct(searchVo);
    }
}
