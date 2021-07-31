package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.vo.SkuInfoVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.SkuInfoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

}
