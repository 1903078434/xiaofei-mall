package com.xiaofei.es.service.impl;

import com.alibaba.fastjson.JSON;
import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.es.vo.ProductRespVo;
import com.xiaofei.es.vo.SearchVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.es.constant.ESSearchConstant;
import com.xiaofei.es.entity.Product;
import com.xiaofei.es.repository.ProductRepository;
import com.xiaofei.es.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.lucene.search.join.ScoreMode;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.NestedQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.aggregations.Aggregation;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.Aggregations;
import org.elasticsearch.search.aggregations.bucket.MultiBucketsAggregation;
import org.elasticsearch.search.aggregations.bucket.nested.Nested;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    public PageVo<ProductRespVo> searchProduct(SearchVo searchVo) throws IOException {
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

        //判断品牌id——过滤掉品牌id>0的数据
        if (searchVo.getBrandId() != null) {
            List<Long> brandIds = searchVo.getBrandId().stream().filter(item -> item > 0).collect(Collectors.toList());
            searchVo.setBrandId(brandIds);
            if (searchVo.getBrandId().size() > 0) {
                boolQueryBuilder.filter(QueryBuilders.termsQuery("brandId", searchVo.getBrandId()));
            }
        }

        //TODO 判断属性id+属性值，两者都需要判断
        /*if (searchVo.getAttrId() != null && searchVo.getAttrId().size() > 0) {
            boolQueryBuilder.filter(QueryBuilders.nestedQuery("attrs", QueryBuilders.termsQuery("attrs.attrId", searchVo.getAttrId()), ScoreMode.None));
        }*/

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

        // 品牌聚合查询
        request.source().aggregation(
                AggregationBuilders.terms("brandAgg")
                        .field("brandName")
                        .subAggregation(
                                AggregationBuilders.terms("brandIdAgg")
                                        .field("brandId")
                                        .size(1)
                        )
        );

        //类别聚合查询
        request.source().aggregation(
                AggregationBuilders.terms("categoryAgg")
                        .field("categoryName")
                        .subAggregation(
                                AggregationBuilders
                                        .terms("categoryIdAgg")
                                        .field("categoryId")
                                        .size(1)
                        )
        );

        //基本属性聚合
        request.source().aggregation(
                AggregationBuilders.nested("baseAttrAgg", "attrs")
                        //基本属性nested子聚合
                        .subAggregation(
                                AggregationBuilders
                                        .terms("baseAttrNameAgg")
                                        .field("attrs.attrName")
                                        //基本属性值聚合
                                        .subAggregation(
                                                AggregationBuilders
                                                        .terms("baseAttrValueAgg")
                                                        .field("attrs.attrValue")
                                                        .subAggregation(
                                                                AggregationBuilders
                                                                        .terms("attrIdAgg")
                                                                        .field("attrs.attrId")
                                                                        .size(1)
                                                        )
                                        )
                        )

        );

        //TODO 销售属性聚合

        SearchResponse response = restHighLevelClient.search(request, RequestOptions.DEFAULT);

        //所有的聚合结果 聚合名称-聚合值
        Map<String, Object> aggResult = new HashMap<>();

        //获取所有聚合信息
        Aggregations aggregations = response.getAggregations();
        //品牌聚合
        aggResult.put("brandAgg", getTermsAggByAggName(aggregations, "brandAgg", "brandIdAgg"));
        //类别聚合
        aggResult.put("categoryAgg", getTermsAggByAggName(aggregations, "categoryAgg", "categoryIdAgg"));
        //基本属性聚合
        aggResult.put("baseAttrAgg", getNestedAggByAggName(aggregations, "baseAttrAgg", "baseAttrNameAgg", "baseAttrValueAgg", "attrIdAgg"));

        //算总共的页数
        long count = response.getHits().getTotalHits().value;
        Integer pageTotal = Math.toIntExact(count % searchVo.getPageSize() == 0 ?
                count / searchVo.getPageSize() :
                count / searchVo.getPageSize() + 1);


        //拼接聚合信息、商品信息、高亮信息
        ProductRespVo items = new ProductRespVo(getHits(response), aggResult);

        return new PageVo<>(searchVo.getPageNo(), searchVo.getPageSize(), pageTotal, count, items);
    }

    /**
     * 根据聚合名称获取聚合值——Terms聚合
     *
     * @param aggregations 聚合信息
     * @param aggName      聚合名称
     * @return 返回聚合信息
     */
    private Map<String, String> getTermsAggByAggName(Aggregations aggregations, String... aggName) {
        // 1、获取指定的聚合
        Terms terms = aggregations.get(aggName[0]);
        // 2、获取聚合桶
        List<? extends Terms.Bucket> buckets = terms.getBuckets();
        return buckets.stream().collect(Collectors.toMap(MultiBucketsAggregation.Bucket::getKeyAsString, bucket -> {
            Terms terms1 = bucket.getAggregations().get(aggName[1]);
            return terms1.getBuckets().get(0).getKeyAsString();
        }));
    }

    /**
     * 根据聚合名称获取聚合值——Nested聚合
     *
     * @param aggregations  聚合信息
     * @param nestedAggName nested聚合名称
     * @param termsAggName  其他terms聚合名称——从外往里面写
     * @return 返回聚合信息
     */
    private Map<String, Map<String, String>> getNestedAggByAggName(Aggregations aggregations, String nestedAggName, String... termsAggName) {
        //获取基本属性聚合
        Nested baseAttrAgg = aggregations.get(nestedAggName);
        //获取基本属性名称Terms
        Terms baseAttrNameTerms = baseAttrAgg.getAggregations().get(termsAggName[0]);
        //获取基本属性名称桶
        List<? extends Terms.Bucket> baseAttrNameBuckets = baseAttrNameTerms.getBuckets();
        //将基本属性名称和基本属性值组合成Map集合
        return baseAttrNameBuckets.stream().collect(Collectors.toMap(MultiBucketsAggregation.Bucket::getKeyAsString, baseAttrNameBucket ->
                getTermsAggByAggName(baseAttrNameBucket.getAggregations(), termsAggName[1], termsAggName[2])
        ));
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

    /**
     * 获取最新上架的物件商品
     *
     * @return 返回最新上架的五件商品
     */
    @Override
    public List<Product> getNewProduct() throws IOException {

        return getProductByOrder(0, 5, "saleCount", 1);
    }

    /**
     * 获取热度评分最高的物件商品
     *
     * @return 返回销量最高的物件商品
     */
    @Override
    public List<Product> getHotProduct() throws IOException {
        return getProductByOrder(0, 5, "hotScore", 1);
    }

    /**
     * 根据指定字段排序
     *
     * @param pageNo     当前页
     * @param pageSize   每页显示数量
     * @param orderField 排序字段
     * @param sortOrder  0：升序。1：降序
     * @return 返回查询到商品信息
     */
    @Override
    public List<Product> getProductByOrder(Integer pageNo, Integer pageSize, String orderField, int sortOrder) throws IOException {
        // 1.准备Request
        SearchRequest request = new SearchRequest("product");
        // 2.准备DSL
        // 2.1.query
        request.source().query(QueryBuilders.matchAllQuery());
        // 2.2.排序 sort
        request.source().sort(orderField, sortOrder == 0 ? SortOrder.ASC : SortOrder.DESC);
        // 2.3.分页 from、size
        request.source().from(pageNo).size(pageSize);
        // 3.发送请求
        SearchResponse response = restHighLevelClient.search(request, RequestOptions.DEFAULT);
        // 4.解析响应
        return getHits(response);
    }

    /**
     * 滚动加载商品信息
     *
     * @param pageNo     当前页
     * @param pageSize   每页显示大小
     * @param brandId    品牌id
     * @param categoryId 类别id
     * @return 返回指定页面的数据
     */
    @Override
    public List<Product> scrollLoadingProducts(Integer pageNo, Integer pageSize, Long brandId, Long categoryId) throws IOException {
        SearchRequest request = new SearchRequest("product");
        request.source()
                .query(QueryBuilders.matchAllQuery())
                .from((pageNo - 1) * pageSize)
                .size(pageSize)
                .sort("hotScore", SortOrder.DESC);
        SearchResponse response = restHighLevelClient.search(request, RequestOptions.DEFAULT);
        return getHits(response);
    }
}
