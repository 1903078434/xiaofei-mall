package com.xiaofei.es;

import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;

/**
 * User: 李飞
 * Date: 2021/11/24
 * Time: 16:34
 */
@SpringBootTest
public class MallSearchApplicationTest {
    @Autowired
    private RestHighLevelClient restHighLevelClient;

    @Test
    @DisplayName("添加商品信息")
    void add() throws IOException {

        String json = "{\n" +
                "\"addTime\": \"2021-11-24T15:55:52.563\",\n" +
                "\"attrs\": [\n" +
                "{\n" +
                "\"attrId\": 4,\n" +
                "\"attrName\": \"品牌\",\n" +
                "\"attrValue\": \"华为（HUAWEI）\"\n" +
                "},\n" +
                "{\n" +
                "\"attrId\": 14,\n" +
                "\"attrName\": \"机身材质\",\n" +
                "\"attrValue\": \"其他\"\n" +
                "},\n" +
                "{\n" +
                "\"attrId\": 4,\n" +
                "\"attrName\": \"品牌\",\n" +
                "\"attrValue\": \"华为（HUAWEI）\"\n" +
                "},\n" +
                "{\n" +
                "\"attrId\": 54,\n" +
                "\"attrName\": \"系统\",\n" +
                "\"attrValue\": \"HarmonyOS2\"\n" +
                "}\n" +
                "],\n" +
                "\"brandId\": 1,\n" +
                "\"brandName\": \"华为（HUAWEI）\",\n" +
                "\"categoryId\": 126,\n" +
                "\"categoryName\": \"手机\",\n" +
                "\"commentNum\": 67071752,\n" +
                "\"hasStock\": true,\n" +
                "\"hotScore\": 797,\n" +
                "\"saleCount\": 67071752,\n" +
                "\"skuId\": 1,\n" +
                "\"skuImg\": \"https://img14.360buyimg.com/n1/s450x450_jfs/t1/161275/13/9843/137365/60b59f8eEbade8c1d/3c778f0a77663104.jpg\",\n" +
                "\"skuPrice\": 6099,\n" +
                "\"skuTitle\": \"华为Mate40Pro釉白色 8GB+128GB\",\n" +
                "\"spuId\": 1\n" +
                "}";
        // 1.准备Request对象
        IndexRequest request = new IndexRequest("product").id("1");
        // 2.准备Json文档
        request.source(json, XContentType.JSON);
        // 3.发送请求
        restHighLevelClient.index(request, RequestOptions.DEFAULT);
    }


    @AfterEach
    void close() throws IOException {
        restHighLevelClient.close();
    }
}
