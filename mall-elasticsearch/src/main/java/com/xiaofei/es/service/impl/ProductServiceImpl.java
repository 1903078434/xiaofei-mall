package com.xiaofei.es.service.impl;

import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.es.entity.Product;
import com.xiaofei.es.repository.ProductRepository;
import com.xiaofei.es.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:40
 */
@Service
@Slf4j
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ElasticsearchRestTemplate elasticsearchRestTemplate;

    /**
     * 将商品信息保存到ES中
     *
     * @param skuESDtos 商品信息
     * @return true：保存成功。false：保存失败
     */
    @Override
    public boolean saveProduct(List<SkuESDto> skuESDtos) {
        try {
            List<Product> products = skuESDtos.stream().map(skuESDto -> {
                Product product = new Product();
                BeanUtils.copyProperties(skuESDto, product);
                return product;
            }).collect(Collectors.toList());
            productRepository.saveAll(products);
        } catch (Exception e) {
            log.error("ES保存商品失败，错误信息为：{}", e);
            return false;
        }
        return true;
    }

    /**
     * 根据商家类别和商品类别查询推荐的相关信息，如果两则都为0，则随机推荐
     *
     * @param brandId    品牌id
     * @param categoryId 类别id
     * @return 返回推荐的数据
     */
    @Override
    public List<Product> getProductRandom(Long brandId, Long categoryId) {
        //构建查询条件
        NativeSearchQuery query = new NativeSearchQueryBuilder().build();

        Pageable pageable = PageRequest.of(0, 100);
        Page<Product> page = productRepository.findAll(pageable);
        return page.getContent();
    }

    /**
     * 高亮查询测试1
     */
    @Override
    public List<Product> test1(String skuTitle) {
        return productRepository.queryBySkuTitle(skuTitle);
    }

    /**
     * 高亮查询测试1
     */
    @Override
    public SearchHits<Product> test2(String searchValue) {
        NativeSearchQuery nativeSearchQuery = new NativeSearchQueryBuilder()
                //查询条件
                .withQuery(QueryBuilders.queryStringQuery(searchValue).defaultField("skuTitle"))
                //分页
                .withPageable(PageRequest.of(0, 5))
                .addAggregation(AggregationBuilders.terms("price"))
                //高亮字段显示
                .withHighlightFields(new HighlightBuilder.Field("skuTitle"))
                .build();
        return elasticsearchRestTemplate.search(nativeSearchQuery, Product.class);
    }


}
