package com.xiaofei.es.repository;

import com.xiaofei.es.entity.SkuInfo;
import org.springframework.data.elasticsearch.annotations.Highlight;
import org.springframework.data.elasticsearch.annotations.HighlightField;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * User: 李飞
 * Date: 2021/8/2
 * Time: 22:43
 */
//@Repository
public interface SkuInfoRepository extends ElasticsearchRepository<SkuInfo, Long> {

    @Highlight(fields = {@HighlightField(name = "skuName")})
    SkuInfo findBySkuName(String skuName);

}
