package com.xiaofei.coupon.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaofei.common.coupon.entity.SkuLadderEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.coupon.service.SkuLadderService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 20:35
 */
@Api("商品满减折扣设置")
@RequestMapping("/coupon/ladder")
@RestController
public class SkuLadderController {

    @Autowired
    private SkuLadderService skuLadderService;

    @ApiOperation(value = "根据skuId查询商品折扣满减信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "skuId", value = "商品id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{skuId}")
    public ResponseResult<SkuLadderEntity> querySkuLadderBySkuId(@PathVariable("skuId") Long skuId) {
        SkuLadderEntity item = skuLadderService.getOne(new QueryWrapper<SkuLadderEntity>().eq("sku_id", skuId));
        return new ResponseResult<SkuLadderEntity>().success(item);
    }

}
