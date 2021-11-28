package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.SpuInfoEntity;
import com.xiaofei.common.product.vo.SpuInfoVo;
import com.xiaofei.common.product.vo.spu.SpuVo;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.SpuInfoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;
import java.util.concurrent.ExecutionException;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 17:16
 */
@Api(tags = "spu接口")
@RestController
@RequestMapping("/product/spuinfo")
public class SpuInfoController {

    @Autowired
    private SpuInfoService spuInfoService;

    @ApiOperation(value = "添加spu信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/internal")
    public AjaxResult addSpuInfo(@RequestBody SpuVo spuVo) {
        spuInfoService.addSpuInfo(spuVo);
        return AjaxResult.success();
    }

    @ApiOperation(value = "商品上架", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "spuId", value = "商品id", paramType = "path", required = true, dataType = "Long")
    @PutMapping("/internal/{spuId}")
    public AjaxResult spuUp(@PathVariable("spuId") Long spuId) {
        Boolean isSuccess = spuInfoService.spuUp(spuId);
        return AjaxResult.success().put("data", isSuccess);
    }

    @ApiOperation(value = "根据分页信息查询商品信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping
    public AjaxResult queryByPage(SpuInfoVo spuInfoVo) {
        PageVo<SpuInfoVo> page = spuInfoService.queryByPage(spuInfoVo);
        return AjaxResult.success().put("data", page);
    }

    @ApiOperation(value = "根据spuId查询spu的全部商品信息【商品图片，优惠信息等】", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "spuId", value = "商品id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/internal/{spuId}")
    public ResponseResult<SpuVo> internalQuerySpuInfoById(@PathVariable("spuId") Long spuId) throws ExecutionException, InterruptedException {
        SpuVo item = spuInfoService.internalQuerySpuInfoById(spuId);
        return new ResponseResult<SpuVo>().success(item);
    }

    @ApiOperation(value = "根据spuId查询spu信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "spuId", value = "商品id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{spuId}")
    public AjaxResult querySpuInfoById(@PathVariable("spuId") Long spuId) {
        PageVo<SpuInfoVo> page = spuInfoService.querySpuInfoById(spuId);
        return AjaxResult.success("查询成功").put("data", page);
    }

    @ApiOperation(value = "根据spuIds查询商品信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/byids")
    public ResponseResult<List<SpuInfoEntity>> querySpuInfoByIds(@RequestParam("skuIds") Set<Long> skuIds) {
        return new ResponseResult<List<SpuInfoEntity>>().success("查询成功", spuInfoService.listByIds(skuIds));
    }

}
