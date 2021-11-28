package com.xiaofei.product.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaofei.common.product.entity.SkuImagesEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.product.service.SkuImagesService;
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
 * Date: 2021/11/26
 * Time: 14:42
 */
@Api(tags = "sku图片接口")
@RestController
@RequestMapping("/product/skuimage")
public class SkuImageController {

    @Autowired
    private SkuImagesService skuImagesService;

    @ApiOperation(value = "根据skuId查询sku的所有照片", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "skuId", value = "商品id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{skuId}")
    public ResponseResult<List<SkuImagesEntity>> querySpuInfoById(@PathVariable("skuId") Long skuId) {
        List<SkuImagesEntity> items = skuImagesService.list(new QueryWrapper<SkuImagesEntity>().eq("sku_id", skuId));
        return new ResponseResult<List<SkuImagesEntity>>().success(items);
    }

}
