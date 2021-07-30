package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.vo.spu.SpuVo;
import com.xiaofei.product.service.SpuInfoService;
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
 * Time: 17:16
 */
@Api(tags = "spu接口")
@RestController
@RequestMapping("/product/spuinfo")
public class SpuInfoController {

    @Autowired
    private SpuInfoService spuInfoService;

    @ApiOperation(value = "添加spu信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping
    public AjaxResult addSpuInfo(@RequestBody SpuVo spuVo) {
        spuInfoService.addSpuInfo(spuVo);
        return AjaxResult.success();
    }
}
