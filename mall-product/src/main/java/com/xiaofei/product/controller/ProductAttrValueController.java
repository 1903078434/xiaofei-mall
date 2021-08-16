package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.ProductAttrValueEntity;
import com.xiaofei.common.product.vo.ProductAttrValueVo;
import com.xiaofei.product.service.ProductAttrValueService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/2
 * Time: 12:43
 */
@Api(tags = "spu属性管理接口")
@RestController
@RequestMapping("/product/productattrvalue")
public class ProductAttrValueController {
    @Autowired
    private ProductAttrValueService productAttrValueService;

    @ApiOperation(value = "批量修改产品的基本属性", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "spuId", value = "spuId", paramType = "path", required = true, dataType = "Long")
    @PutMapping("/internal/{spuId}")
    public AjaxResult updateCategory(@RequestBody List<ProductAttrValueVo> items, @PathVariable("spuId") Long spuId) {
        boolean isUpdate = productAttrValueService.updateProductAttrValue(items,spuId);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }

    @ApiOperation(value = "根据spuId查询spu属性", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "spuId", value = "spuId", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{spuId}")
    public AjaxResult queryCategoryById(@PathVariable("spuId") Long spuId) {
        List<ProductAttrValueEntity> items = productAttrValueService.getBySpuId(spuId);
        return AjaxResult.success("查询成功").put("data", items);
    }

}
