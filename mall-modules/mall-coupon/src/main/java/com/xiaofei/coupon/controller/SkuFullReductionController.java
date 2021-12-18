package com.xiaofei.coupon.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.dto.SkuReductionDto;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.coupon.service.SkuFullReductionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:16
 */
@Api("sku满减接口")
@RestController
@RequestMapping("/coupon/skufullreduction")
public class SkuFullReductionController {

    @Autowired
    private SkuFullReductionService skuFullReductionService;

    @ApiOperation(value = "添加SPU的积分信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/internal")
    public AjaxResult saveSkuReduction(@RequestBody SkuReductionDto skuReductionDto) {
        boolean isAdd = skuFullReductionService.saveSkuReduction(skuReductionDto);
        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据skuId查询商品的所有折扣信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "skuId", value = "商品id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{skuId}")
    public ResponseResult<SkuReductionDto> querySkuDiscountBySkuId(@PathVariable("skuId") Long skuId) {
        SkuReductionDto item = skuFullReductionService.querySkuDiscountBySkuId(skuId);
        return new ResponseResult<SkuReductionDto>().success(item);
    }
}
