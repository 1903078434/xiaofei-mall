package com.xiaofei.product.controller;

import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.product.service.SkuSaleAttrValueService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 13:35
 */
@Api(tags = "sku接口")
@RestController
@RequestMapping("/product/saleattr")
public class SkuSaleAttrValueController {

    @Autowired
    private SkuSaleAttrValueService skuSaleAttrValueService;

    @ApiOperation(value = "根据skuId查询商品销售属性", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "skuId", value = "skuId", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{skuId}")
    public ResponseResult<List<SkuSaleAttrValueEntity> > querySkuSaleAttrBySkuId(@PathVariable("skuId") Long skuId) {
        List<SkuSaleAttrValueEntity> items = skuSaleAttrValueService.querySkuSaleAttrBySkuId(skuId);
        return new ResponseResult<List<SkuSaleAttrValueEntity> >().success("查询成功", items);
    }

}
