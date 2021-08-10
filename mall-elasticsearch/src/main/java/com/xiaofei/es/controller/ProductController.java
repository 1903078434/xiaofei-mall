package com.xiaofei.es.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.common.es.vo.SearchVo;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.es.entity.Product;
import com.xiaofei.es.service.ProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.web.bind.annotation.*;

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
    @PostMapping
    public ResponseResult<Boolean> addProduct(@RequestBody List<SkuESDto> skuESDtos) {
        boolean isSave = productService.saveProduct(skuESDtos);
        return new ResponseResult<Boolean>().success(isSave ? "添加成功" : "添加失败", isSave);
    }

    /**
     * 根据购买的商品类别和品牌信息来推荐商品，如果是首页，则随机推荐
     */
    @ApiOperation(value = "根据商家类别和商品类别查询推荐的相关信息，如果两则都为0，则随机推荐", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/random/product")
    public AjaxResult getProductRandom(Long brandId, Long categoryId) {
        List<Product> items = productService.getProductRandom(brandId, categoryId);
        return AjaxResult.success().put("data", items);
    }

    @ApiOperation(value = "根据搜索条件查询商品信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping
    public AjaxResult getProductSearchAttr(SearchVo searchVo) {
        PageVo<SearchHits<Product>> page = productService.searchProduct(searchVo);
        return AjaxResult.success().put("data", page);
    }
}
