package com.xiaofei.es.service.impl;

import com.alibaba.fastjson.JSON;
import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.common.es.vo.SearchVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.es.constant.ESSearchConstant;
import com.xiaofei.es.entity.Product;
import com.xiaofei.es.repository.ProductRepository;
import com.xiaofei.es.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortBuilders;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

    @Autowired
    private RestHighLevelClient restHighLevelClient;

    /**
     * 根据skuId删除商品信息
     *
     * @param skuId 商品id
     */
    @Override
    public void deleteProduct(Long skuId) throws IOException {
        DeleteRequest request = new DeleteRequest("product", skuId.toString());
        restHighLevelClient.delete(request, RequestOptions.DEFAULT);
    }

    /**
     * 将商品信息保存到ES中
     *
     * @param skuESDtos 商品信息
     * @return true：保存成功。false：保存失败
     */
    @Override
    public boolean saveProduct(List<SkuESDto> skuESDtos) throws IOException {

        BulkRequest bulkRequest = new BulkRequest();
        try {
            /*elasticsearchRestTemplate.save(skuESDtos);*/
            skuESDtos.forEach(skuESDto -> {
                Product product = new Product();
                BeanUtils.copyProperties(skuESDto, product);
                bulkRequest.add(new IndexRequest("product").id(skuESDto.getSkuId().toString())
                        .source(JSON.toJSONString(product), XContentType.JSON));
            });

            restHighLevelClient.bulk(bulkRequest, RequestOptions.DEFAULT);
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
    public List<Product> getProductRandom(Long brandId, Long categoryId) throws IOException {
        SearchRequest request = new SearchRequest("product");
        request.source()
                .query(QueryBuilders.matchAllQuery())
                .from(0)
                .size(60)
                .sort("hotScore", SortOrder.DESC);
        SearchResponse response = restHighLevelClient.search(request, RequestOptions.DEFAULT);
        return getHits(response);
    }

    /**
     * 根据skuId查询商品信息
     *
     * @param skuId 商品id
     * @return 返回商品信息
     */
    @Override
    public Product getProductById(Long skuId) {
        return elasticsearchRestTemplate.get(skuId.toString(), Product.class);
    }

    /**
     * 搜索商品数据
     *
     * @param searchVo 搜索条件
     */
    @Override
    public PageVo<Product> searchProduct(SearchVo searchVo) throws IOException {
        SearchRequest request = new SearchRequest("product");

        // 创建布尔查询的条件
        BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();

        //价格区间判断
        BigDecimal minPrice = searchVo.getMinPrice();
        BigDecimal maxPrice = searchVo.getMaxPrice();
        if (minPrice.compareTo(maxPrice) > 0) {
            BigDecimal t = minPrice;
            minPrice = maxPrice;
            maxPrice = t;
        }

        boolQueryBuilder.filter(QueryBuilders.rangeQuery("skuPrice").gte(minPrice).lte(maxPrice));//价格区间
        //判断搜素条件是否为空
        if (!StringUtils.isEmpty(searchVo.getSearchValue())) {
            boolQueryBuilder.must(QueryBuilders.matchQuery("all", searchVo.getSearchValue()));//匹配查询，需要分词和评分
        }

        //判断类别id
        if (searchVo.getCategoryId() != null && searchVo.getCategoryId() > 0) {
            boolQueryBuilder.filter(QueryBuilders.termQuery("categoryId", searchVo.getCategoryId()));
        }

        //库存判断
        if (searchVo.getHasStock() != null) {
            boolQueryBuilder.filter(QueryBuilders.termQuery("hasStock", searchVo.getHasStock() == 1));
        }

        //判断品牌id
        if (searchVo.getBrandId() != null && searchVo.getBrandId().size() > 0) {
            boolQueryBuilder.filter(QueryBuilders.termsQuery("brandId", searchVo.getBrandId()));
        }

        // 设置排序
        FieldSortBuilder sortBuilder = null;
        if (searchVo.getSort() != null) {
            ESSearchConstant.SortStatus sortStatus = ESSearchConstant.SortStatus.getSortStatus(searchVo.getSort());
            sortBuilder = SortBuilders.fieldSort(sortStatus.getField()).order(sortStatus.getSortOrder());
        } else {
            sortBuilder = SortBuilders.fieldSort("hotScore").order(SortOrder.DESC);
        }


        // 布尔查询
        request.source()
                .query(boolQueryBuilder)
                .from((searchVo.getPageNo() - 1) * searchVo.getPageSize())
                .size(searchVo.getPageSize())
                .highlighter(new HighlightBuilder().field("all").requireFieldMatch(false))
                .sort(sortBuilder);


        SearchResponse response = restHighLevelClient.search(request, RequestOptions.DEFAULT);

        //算总共的页数
        long count = response.getHits().getTotalHits().value;
        Integer pageTotal = Math.toIntExact(count % searchVo.getPageSize() == 0 ?
                count / searchVo.getPageSize() :
                count / searchVo.getPageSize() + 1);


        List<Product> items = getHits(response);

        return new PageVo<>(searchVo.getPageNo(), searchVo.getPageSize(), pageTotal, count, items);
    }

    /**
     * 提取SearchResponse中的hits里面的数据【查询结果，高亮结果】
     */
    private List<Product> getHits(SearchResponse response) {
        List<Product> items = new ArrayList<>();

        for (SearchHit hit : response.getHits()) {
            Product product = JSON.parseObject(hit.getSourceAsString(), Product.class);
            // 设置高亮
            Map<String, HighlightField> highlightFields = hit.getHighlightFields();
            if (CollectionUtils.isEmpty(highlightFields)) {
                HighlightField highlightField = highlightFields.get("all");
                if (highlightField != null) {
                    String all = highlightField.getFragments()[0].string();
                    product.setSkuTitle(all);
                }
            }
            items.add(product);
        }
        return items;
    }
}
