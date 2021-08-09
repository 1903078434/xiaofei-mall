package com.xiaofei.es.test;

import com.xiaofei.es.entity.SkuInfo;
import com.xiaofei.es.repository.SkuInfoRepository;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.CreateIndexRequest;
import org.elasticsearch.client.indices.CreateIndexResponse;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;

import java.io.IOException;

/**
 * User: 李飞
 * Date: 2021/8/3
 * Time: 22:48
 */
@DisplayName("SkuInfo测试类")
@SpringBootTest
public class SkuInfoTest {

    @Autowired
    private SkuInfoRepository skuInfoRepository;

    @Autowired
    private ElasticsearchRestTemplate template;

    @Autowired
    RestHighLevelClient highLevelClient;

    @DisplayName("创建索引")
    @Test
    void createIndex() throws IOException {
        CreateIndexRequest indexRequest = new CreateIndexRequest("test");

        CreateIndexResponse response = highLevelClient.indices().create(indexRequest, RequestOptions.DEFAULT);

        System.out.println(response);
    }

    @DisplayName("添加数据")
    @Test
    public void addSkuInfo() {
        //一、使用集成ElasticsearchRepository的接口来保存数据
        SkuInfo skuInfo = new SkuInfo(4L, "MySQL从删库到跑路", "https://rjweourw9e.com", System.currentTimeMillis());
        SkuInfo save = skuInfoRepository.save(skuInfo);
        System.out.println(save);

        //二、使用ElasticsearchRestTemplate添加数据
        //System.out.println(template.save(new SkuInfo(1L, "Java从入门到放弃222", "https://rjweourw9e.com")));

    }

    @DisplayName("查询全部数据")
    @Test
    public void getAll() {

        //一、使用集成ElasticsearchRepository的接口来查询
        skuInfoRepository.findAll().forEach(System.out::println);

        //二、使用ElasticsearchRestTemplate查询数据
        System.out.println("返回的数据为：" + template.get("1", SkuInfo.class));

    }

    @DisplayName("通过skuName查询数据")
    @Test
    public void getBySkuName() {

        //一、使用集成ElasticsearchRepository的接口来保存数据
        // skuInfoRepository.findBySkuName("Java").forEach(System.out::println);
        System.out.println(skuInfoRepository.findBySkuName("Java从入门到放弃"));

        //二、使用ElasticsearchRestTemplate添加数据
        //System.out.println("返回的数据为：" + template.get("1", SkuInfo.class));

    }

    @DisplayName("ElasticsearchRestTemplate复杂查询-高亮查询")
    @Test
    public void queryHeightLight() {
    }
}
