package com.xiaofei.es.repository;

import com.xiaofei.es.entity.Product;
import org.springframework.data.elasticsearch.annotations.HighlightField;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:40
 */
@Repository
public interface ProductRepository extends ElasticsearchRepository<Product, Long> {

    @HighlightField(name = "skuTitle")
    List<Product> queryBySkuTitle(String skuTitle);



}
