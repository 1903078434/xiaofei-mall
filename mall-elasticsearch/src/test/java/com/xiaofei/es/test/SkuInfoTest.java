package com.xiaofei.es.test;

import com.xiaofei.es.enrity.SkuInfo;
import com.xiaofei.es.repository.SkuInfoRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * User: 李飞
 * Date: 2021/8/3
 * Time: 22:48
 */
@SpringBootTest
public class SkuInfoTest {

    @Autowired
    private SkuInfoRepository skuInfoRepository;

    @DisplayName("添加数据")
    @Test
    public void addSkuInfo() {
        SkuInfo skuInfo = new SkuInfo(1L, "Java从入门到放弃222", "https://rjweourw9e.com");
        SkuInfo save = skuInfoRepository.save(skuInfo);
        System.out.println(save);
    }

    @DisplayName("查询全部数据")
    @Test
    public void getAll() {
        skuInfoRepository.findAll().forEach(System.out::println);
    }
}
