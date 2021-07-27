package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
import com.xiaofei.common.product.vo.CategoryBrandRelationVo;
import com.xiaofei.product.service.CategoryBrandRelationService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/27
 * Time: 12:59
 */
@Api(tags = "商家和类别关联接口")
@RestController
@RequestMapping("/product")
public class CategoryBrandRelationController {

    @Autowired
    private CategoryBrandRelationService categoryBrandRelationService;


    @ApiOperation(value = "添加商家和类别关联信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/categorybrandrelation")
    public AjaxResult addCategoryBrandRelation(@RequestBody CategoryBrandRelationVo categoryBrandRelationVo) {

        boolean isAdd = categoryBrandRelationService.addCategoryAndBrandRelation(categoryBrandRelationVo);

        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据关联id删除", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "id", value = "关联id", paramType = "path", required = true, dataType = "Long")
    @DeleteMapping("/categorybrandrelation/{id}/{brandId}")
    public AjaxResult deleteCategoryBrandRelationById(@PathVariable("id") Long id, @PathVariable("brandId") Long brandId) {

        boolean isDelete = categoryBrandRelationService.deleteCategoryAndBrandRelation(id,brandId);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "根据品牌id删除", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "brandId", value = "品牌id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/categorybrandrelation/{brandId}")
    public AjaxResult queryCategoryBrandRelationByBrandId(@PathVariable("brandId") Long brandId) {
        List<CategoryBrandRelationEntity> items = categoryBrandRelationService.getByBrandId(brandId);
        return AjaxResult.success().put("data", items);
    }

}
