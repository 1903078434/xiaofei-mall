package com.xiaofei.coupon.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.dto.SkuReductionDto;
import com.xiaofei.coupon.service.SkuFullReductionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
    @PostMapping
    public AjaxResult saveSkuReduction(@RequestBody SkuReductionDto skuReductionDto) {
        boolean isAdd = skuFullReductionService.saveSkuReduction(skuReductionDto);
        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }
}
