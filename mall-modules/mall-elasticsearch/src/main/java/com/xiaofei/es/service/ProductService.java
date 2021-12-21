package com.xiaofei.es.service;

import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.es.vo.ProductRespVo;
import com.xiaofei.es.vo.SearchVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.es.entity.Product;

import java.io.IOException;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:39
 */
public interface ProductService {
    /**
     * 将商品信息保存到ES中
     *
     * @param skuESDtos 商品信息
     * @return true：保存成功。false：保存失败
     */
    boolean saveProduct(List<SkuESDto> skuESDtos) throws IOException;

    /**
     * 根据skuId删除商品信息
     *
     * @param skuId 商品id
     */
    void deleteProduct(Long skuId) throws IOException;

    /**
     * 根据skuId查询商品信息
     *
     * @param skuId 商品id
     * @return 返回商品信息
     */
    Product getProductById(Long skuId);

    /**
     * 根据商家类别和商品类别查询推荐的相关信息，如果两则都为0，则随机推荐
     *
     * @param brandId    品牌id
     * @param categoryId 类别id
     * @return 返回推荐的数据
     */
    List<Product> getProductRandom(Long brandId, Long categoryId) throws IOException;

    /**
     * 搜索商品数据
     *
     * @param searchVo 搜索条件
     */
    PageVo<ProductRespVo> searchProduct(SearchVo searchVo) throws IOException;

    /**
     * 获取最新上架的物件商品
     *
     * @return 返回最新上架的五件商品
     */
    List<Product> getNewProduct() throws IOException;

    /**
     * 获取销量最高的物件商品
     *
     * @return 返回销量最高的物件商品
     */
    List<Product> getHotProduct() throws IOException;

    /**
     * 根据指定字段排序
     *
     * @param pageNo     当前页
     * @param pageSize   每页显示数量
     * @param orderField 排序字段
     * @param sortOrder  0：升序。1：降序
     * @return 返回查询到商品信息
     */
    List<Product> getProductByOrder(Integer pageNo, Integer pageSize, String orderField, int sortOrder) throws IOException;

    /**
     * 滚动加载商品信息
     *
     * @param pageNo     当前页
     * @param pageSize   每页显示大小
     * @param brandId    品牌id
     * @param categoryId 类别id
     * @return 返回指定页面的数据
     */
    List<Product> scrollLoadingProducts(Integer pageNo, Integer pageSize, Long brandId, Long categoryId) throws IOException;
}
