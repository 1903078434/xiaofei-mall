package com.xiaofei.es.service;

import com.xiaofei.es.entity.Product;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ProductServiceTest {

    @Autowired
    private ProductService productService;

    @Test
    void getProductById() {
        Product product = productService.getProductById(950L);
        System.out.println(product);
    }
}
