package com.xiaofei.es.test;

import com.xiaofei.es.entity.Product;
import com.xiaofei.es.repository.ProductRepository;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;

import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/8
 * Time: 17:35
 */
@SpringBootTest
public class ProductTest {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ElasticsearchRestTemplate elasticsearchRestTemplate;

    @DisplayName("高亮查询")
    @Test
    void heightLight() {
        String searchValue = "HUAWEI P50 Pro";
        NativeSearchQuery nativeSearchQuery = new NativeSearchQueryBuilder()
                //查询条件
                .withQuery(QueryBuilders.queryStringQuery(searchValue).defaultField("skuTitle"))
                //分页
                .withPageable(PageRequest.of(0, 5))
                //高亮字段显示
                .withHighlightFields(new HighlightBuilder.Field("skuTitle"))
                .build();
        SearchHits<Product> search = elasticsearchRestTemplate.search(nativeSearchQuery, Product.class);
        search.get().collect(Collectors.toList()).forEach(System.out::println);
    }
}
