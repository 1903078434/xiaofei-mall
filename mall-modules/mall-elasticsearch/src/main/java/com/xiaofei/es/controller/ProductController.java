package com.xiaofei.es.controller;

import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.common.es.vo.SearchVo;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.es.entity.Product;
import com.xiaofei.es.service.ProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:31
 */
@Api(tags = "ElasticSearch保存数据")
@RequestMapping("/elasticsearch/product")
@RestController
public class ProductController {

    @Autowired
    private ProductService productService;

    @ApiOperation(value = "商品上架", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/internal")
    public ResponseResult<Boolean> addProduct(@RequestBody List<SkuESDto> skuESDtos) throws IOException {
        boolean isSave = productService.saveProduct(skuESDtos);
        return new ResponseResult<Boolean>().success(isSave ? "添加成功" : "添加失败", isSave);
    }

    /**
     * 根据购买的商品类别和品牌信息来推荐商品，如果是首页，则随机推荐
     */
    @ApiOperation(value = "根据商家类别和商品类别查询推荐的相关信息，如果两则都为0，则随机推荐", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/random/product")
    public ResponseResult<List<Product>> getProductRandom(Long brandId, Long categoryId) throws IOException {
        List<Product> items = productService.getProductRandom(brandId, categoryId);
        return new ResponseResult<List<Product>>().success("data", items);
    }

    @ApiOperation(value = "根据搜索条件查询商品信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping
    public ResponseResult<PageVo<Product>> getProductSearchAttr(SearchVo searchVo) throws IOException {
        PageVo<Product> page = productService.searchProduct(searchVo);
        return new ResponseResult<PageVo<Product>>().success("data", page);
    }
}
