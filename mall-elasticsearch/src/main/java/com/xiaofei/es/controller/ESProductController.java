package com.xiaofei.es.controller;

import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.es.service.ESProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:31
 */
@Api(tags = "ElasticSearch保存数据")
@RequestMapping("/elasticsearch/product")
@RestController
public class ESProductController {

    @Autowired
    private ESProductService esProductService;

    @ApiOperation(value = "商品上架", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping
    public ResponseResult<Boolean> addProduct(@RequestBody List<SkuESDto> skuESDtos) {
        boolean isSave = esProductService.saveProduct(skuESDtos);
        return new ResponseResult<Boolean>().success(isSave ? "添加成功" : "添加失败", isSave);
    }
}
