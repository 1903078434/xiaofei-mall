package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.BrandEntity;
import com.xiaofei.common.product.entity.CategoryBrandRelationEntity;
import com.xiaofei.common.product.vo.BrandVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.BrandService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/25
 * Time: 17:24
 */
@Api(tags = "商家接口")
@RestController
@RequestMapping("/product")
public class BrandController {

    @Autowired
    private BrandService brandService;

    @ApiOperation(value = "添加商家信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/brand/add")
    public AjaxResult addBrand(@RequestBody BrandVo brandVo) {

        boolean isAdd = brandService.addBrand(brandVo);

        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据商家id删除", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "brandId", value = "商家id", paramType = "body", required = true, dataType = "Long")
    @DeleteMapping("/brand/delete")
    public AjaxResult deleteBrandById(@RequestBody String brandId) {

        boolean isDelete = brandService.deleteBrandById(brandId);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "根据商家id修改商家信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/brand/update")
    public AjaxResult updateBrand(@RequestBody BrandVo brand) {
        boolean isUpdate = brandService.updateBrandById(brand);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }

    @ApiOperation(value = "根据商家id查询商家信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "brandId", value = "商家id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/brand/{brandId}")
    public AjaxResult queryBrandById(@PathVariable("brandId") Long brandId) {
        BrandEntity brand = brandService.getById(brandId);
        return AjaxResult.success("查询成功").put("data", brand);
    }

    @ApiOperation(value = "根据类别id查询该类别下的所有商家信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "categoryId", value = "类别id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/brand/categoryId/{categoryId}")
    public AjaxResult queryBrandByCategoryId(@PathVariable("categoryId") Long categoryId) {
        List<CategoryBrandRelationEntity> items = brandService.getByCategoryId(categoryId);
        return AjaxResult.success("查询成功").put("data", items);
    }

    @ApiOperation(value = "分页和搜索查询商家信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/brand/list")
    public AjaxResult queryAllCategory(BrandVo brandVo) {
        //分页查询和条件查询
        PageVo<BrandEntity> page = brandService.queryByPage(brandVo);
        return AjaxResult.success("查询成功").put("data", page);
    }
}
