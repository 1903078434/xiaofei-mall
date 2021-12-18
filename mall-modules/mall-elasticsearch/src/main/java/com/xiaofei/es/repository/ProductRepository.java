package com.xiaofei.es.repository;

import com.xiaofei.es.entity.Product;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:40
 */
@Repository
public interface ProductRepository extends ElasticsearchRepository<Product, Long> {



}
