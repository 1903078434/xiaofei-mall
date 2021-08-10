package com.xiaofei.es.test;

import com.alibaba.fastjson.JSON;
import com.xiaofei.common.es.vo.SearchVo;
import com.xiaofei.es.entity.Product;
import com.xiaofei.es.repository.ProductRepository;
import org.apache.commons.lang3.StringUtils;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.bucket.terms.TermsAggregationBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.*;

import java.math.BigDecimal;

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

    @DisplayName("CriteriaQuery查询")
    @Test
    void criteriaQuery() {
        Criteria criteria = new Criteria();
        //构造查询条件
        criteria.and(new Criteria("skuTitle").is("HUAWEI"))//分词查询，相当于MySQL中的like
                .and(new Criteria("skuPrice").greaterThanEqual(6000).lessThanEqual(8000))//区间查询
                .and(new Criteria("skuTitle").contains("pro"));//包含查询,英文的话忽略大小写

        CriteriaQuery criteriaQuery = new CriteriaQuery(criteria)
                .setPageable(PageRequest.of(0, 10))//分页查询
                .addSort(Sort.by(Sort.Direction.ASC, "skuPrice"));//排序

        HighlightBuilder filed = new HighlightBuilder();
        filed.preTags("<span style='color:red;'>");//样式前缀
        filed.postTags("</span>");//样式后缀
        filed.field("skuTitle");//设置需要高亮的属性
        HighlightQuery highlightQuery = new HighlightQuery(filed);//高亮查询构建
        criteriaQuery.setHighlightQuery(highlightQuery);

        SearchHits<Product> search = elasticsearchRestTemplate.search(criteriaQuery, Product.class);
        System.out.println(search);
        search.getSearchHits().forEach(item -> {
            System.out.println(JSON.toJSONString(item));
        });
    }

    @DisplayName("NativeSearchQuery使用方式")
    @Test
    void nativeSearchQuery() {
        SearchVo searchVo = new SearchVo();
        NativeSearchQueryBuilder queryBuilder = new NativeSearchQueryBuilder();

        //价格区间判断
        BigDecimal minPrice = searchVo.getMinPrice();
        BigDecimal maxPrice = searchVo.getMaxPrice();
        if (minPrice.compareTo(maxPrice) > 0) {
            BigDecimal t = minPrice;
            minPrice = maxPrice;
            maxPrice = t;
        }
        queryBuilder.withFilter(QueryBuilders.rangeQuery("skuPrice").gte(minPrice).lte(maxPrice));//价格区间

        //判断搜素条件是否为空
        if (!StringUtils.isEmpty(searchVo.getSearchValue())) {
            queryBuilder.withQuery(QueryBuilders.queryStringQuery(searchVo.getSearchValue()).field("skuTitle"));//匹配查询，需要分词和评分
        }

        //判断类别id
        if (searchVo.getCategoryId() != null && searchVo.getCategoryId() > 0) {
            queryBuilder.withFilter(QueryBuilders.termQuery("categoryId", searchVo.getCategoryId()));
        }

        //库存判断
        if (searchVo.getHasStock() != null) {
            queryBuilder.withFilter(QueryBuilders.termQuery("hasStock", searchVo.getHasStock() == 1));
        }

        //判断品牌id
        if (searchVo.getBrandId() != null && searchVo.getBrandId().size() > 0) {
            queryBuilder.withFilter(QueryBuilders.termsQuery("brandId", searchVo.getBrandId()));
        }

        //queryBuilder.withFields("skuTitle", "skuPrice");//设置只查询哪些属性的值，未设置的属性，查询出来的值为空

        //queryBuilder.withQuery(QueryBuilders.queryStringQuery("HUAWEI").field("skuTitle"));//匹配查询，需要分词和评分

        //queryBuilder.withFilter(QueryBuilders.matchPhraseQuery("brandId", 1));//精确查询，不需要分词

        //queryBuilder.withQuery(QueryBuilders.termQuery("brandId", 1));//term 精确匹配单个值

        //queryBuilder.withFilter(QueryBuilders.termsQuery("brandId", Arrays.asList(1, 2, 3)));//匹配多个值，满足一个即可

        queryBuilder.withSort(new FieldSortBuilder("skuPrice").order(SortOrder.ASC));//排序

        //设置过滤条件 ，这里设置价格大于等于6000小于等于7000的过滤条件
        //queryBuilder.withFilter(QueryBuilders.rangeQuery("skuPrice").gte(6000).lte(7000));//价格区间

        queryBuilder.withPageable(PageRequest.of(searchVo.getPageNo() - 1, searchVo.getPageSize()));//分页查询

        HighlightBuilder highlightBuilder = new HighlightBuilder();//高亮查询构建
        highlightBuilder.preTags("<span style='color:red;'>");//样式前缀
        highlightBuilder.postTags("</span>");//样式后缀
        highlightBuilder.field("skuTitle");//设置需要高亮的属性
        queryBuilder.withHighlightBuilder(highlightBuilder);//设置高亮查询

        //TODO 排序查询

        //聚合品牌信息
        TermsAggregationBuilder brandAgg = AggregationBuilders.terms("brandId");
        brandAgg.field("brandId").size(50);
        brandAgg.subAggregation(AggregationBuilders.terms("brandName").field("brandName.keyword").size(1));
        brandAgg.subAggregation(AggregationBuilders.terms("brandImg").field("brandImg.keyword").size(1));
        queryBuilder.addAggregation(brandAgg);

        //聚合类别信息
        TermsAggregationBuilder categoryAgg = AggregationBuilders.terms("categoryId");
        categoryAgg.field("categoryId").size(50);
        categoryAgg.subAggregation(AggregationBuilders.terms("categoryName").field("categoryName.keyword")).size(50);
        queryBuilder.addAggregation(categoryAgg);

        //属性聚合
        TermsAggregationBuilder attrsAgg = AggregationBuilders.terms("attrId");
        attrsAgg.field("attrs.attrId").size(100);
        attrsAgg.subAggregation(AggregationBuilders.terms("attrName").field("attrs.attrName.keyword"));
        attrsAgg.subAggregation(AggregationBuilders.terms("attrValue").field("attrs.attrValue.keyword"));
        queryBuilder.addAggregation(attrsAgg);

        Query query = queryBuilder.build();

        SearchHits<Product> search = elasticsearchRestTemplate.search(query, Product.class);

        System.out.println(search);
        System.out.println("=======================");
        System.out.println(search.getAggregations());

        search.getSearchHits().forEach(System.out::println);
    }


    @DisplayName("CriteriaQuery使用方式")
    @Test
    void criteriaQueryProduct() {

        SearchVo searchVo = new SearchVo();
        searchVo.setSearchValue("HUAWEI");
        searchVo.setCategoryId(225L);
        //searchVo.setHasStock(0);//库存设置
        // searchVo.setBrandId(Arrays.asList(2L, 3L));//品牌id集合设置


        //构造插叙条件
        Criteria criteria = new Criteria();

        //价格区间判断
        BigDecimal minPrice = searchVo.getMinPrice();
        BigDecimal maxPrice = searchVo.getMaxPrice();
        if (minPrice.compareTo(maxPrice) > 0) {
            BigDecimal t = minPrice;
            minPrice = maxPrice;
            maxPrice = t;
        }
        criteria.and(new Criteria("skuPrice").greaterThanEqual(minPrice).lessThanEqual(maxPrice));

        //判断搜素条件是否为空
        if (!StringUtils.isEmpty(searchVo.getSearchValue())) {
            criteria.and(new Criteria("skuTitle").is(searchVo.getSearchValue()));
        }

        //判断类别id是否为空
        if (searchVo.getCategoryId() != null && searchVo.getCategoryId() > 0) {
            criteria.and(new Criteria("catalogId").is(searchVo.getCategoryId()));
        }

        //库存判断
        if (searchVo.getHasStock() != null) {
            criteria.and(new Criteria("hasStock").is(searchVo.getHasStock() == 1));
        }

        //判断品牌id
        if (searchVo.getBrandId() != null && searchVo.getBrandId().size() > 0) {
            criteria.and(new Criteria("brandId").in(searchVo.getBrandId()));
        }

        CriteriaQuery criteriaQuery = new CriteriaQuery(criteria);

        //分页查询，注意，在ES中页数是从第 0 页开始的
        criteriaQuery.setPageable(PageRequest.of(searchVo.getPageNo() - 1, searchVo.getPageSize()));

        //判断搜索值是否为空，如果不为空，则设置高亮查询
        if (!StringUtils.isEmpty(searchVo.getSearchValue())) {
            HighlightBuilder highlight = new HighlightBuilder();
            highlight.preTags("<b style='color:red'>");//样式前缀
            highlight.postTags("</b>");//样式后缀
            highlight.field("skuTitle");//设置需要高亮的属性
            criteriaQuery.setHighlightQuery(new HighlightQuery(highlight));
        }

        //TODO 设置聚合查询

        SearchHits<Product> search = elasticsearchRestTemplate.search(criteriaQuery, Product.class);
        System.out.println(search);
        search.getSearchHits().forEach(System.out::println);
    }

    @DisplayName("添加和修改操作数据")
    @Test
    void saveAndUpdate() {
        Product product = new Product();
        // 设置数据，如果数据已经存在，则为修改操作，否则为添加操作：................
        productRepository.save(product);
    }

    @DisplayName("删除操作")
    @Test
    void deleteAll() {
        //删除全部
        productRepository.deleteAll();
        //根据id删除
        productRepository.deleteById(1L);
        //等其他条件删除
    }

}
