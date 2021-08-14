package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.vo.SkuDetailInfoVo;
import com.xiaofei.common.product.vo.SkuInfoVo;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.SkuInfoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.ExecutionException;

/**
 * User: 李飞
 * Date: 2021/7/31
 * Time: 19:31
 */
@Api(tags = "sku接口")
@RestController
@RequestMapping("/product/skuinfo")
public class SkuInfoController {

    @Autowired
    private SkuInfoService skuInfoService;

    @ApiOperation(value = "根据分页信息查询sku信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping
    public AjaxResult queryByPage(SkuInfoVo skuInfoVo) {
        PageVo<SkuInfoEntity> page = skuInfoService.queryByPage(skuInfoVo);
        return AjaxResult.success().put("data", page);
    }

    @ApiOperation(value = "根据skuId查询商品信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "skuId", value = "skuId", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{skuId}")
    public AjaxResult querySkuInfoById(@PathVariable("skuId") Long skuId) {
        SkuInfoEntity item = skuInfoService.getById(skuId);
        return AjaxResult.success(item == null ? "请添加商品，再添加库存" : "查询成功").put("data", item);
    }

    @ApiOperation(value = "根据skuId查询商品详情页面的信息信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "skuId", value = "skuId", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/details/{skuId}")
    public ResponseResult<SkuDetailInfoVo> querySkuDetailsInfo(@PathVariable("skuId") Long skuId) throws ExecutionException, InterruptedException {
        SkuDetailInfoVo item = skuInfoService.querySkuItemInfo(skuId);
        return new ResponseResult<SkuDetailInfoVo>().success("查询成功", item);
    }

}
