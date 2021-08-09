package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.CategoryEntity;
import com.xiaofei.common.product.vo.CategoryVo;
import com.xiaofei.product.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/23
 * Time: 21:40
 */
@Api(tags = "商品类别接口")
@RestController
@RequestMapping("/product")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @ApiOperation(value = "添加商品类别", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/category/add")
    public AjaxResult addCategory(@RequestBody CategoryVo categoryVo) {
        boolean isAdd = categoryService.addCategory(categoryVo);
        return AjaxResult.success().put("data", isAdd);
    }

    @ApiOperation(value = "根据类别id删除商品类别", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "categoryId", value = "类别id", paramType = "path", required = true, dataType = "Long")
    @DeleteMapping("/category/{categoryId}")
    public AjaxResult deleteCategoryById(@PathVariable("categoryId") Long categoryId) {
        boolean isDelete = categoryService.deleteCategoryById(categoryId);
        return AjaxResult.success().put("data", isDelete);
    }

    @ApiOperation(value = "修改商品类别", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/category/update")
    public AjaxResult updateCategory(@RequestBody CategoryVo categoryVo) {
        boolean isAdd = categoryService.updateCategory(categoryVo);
        return AjaxResult.success(isAdd ? "修改成功" : "修改失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据类别id查询商品类别", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "categoryId", value = "类别id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/category/{categoryId}")
    public AjaxResult queryCategoryById(@PathVariable("categoryId") Long categoryId) {
        CategoryEntity category = categoryService.getById(categoryId);
        return AjaxResult.success("查询成功").put("data", category);
    }

    @ApiOperation(value = "查询所有类别", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/category/list")
    public AjaxResult queryAllCategory() {
        return AjaxResult.success("查询成功").put("data", categoryService.queryAllCategory());
    }

    @ApiOperation(value = "获取缓存中的商品类别信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/category/cache/list")
    public AjaxResult queryCacheCategory() {
        return AjaxResult.success("查询成功").put("data", categoryService.queryCacheCategory());
    }

    /**
     * 查询所有分类及其子分类，以树形结构组装起来
     */
    @ApiOperation(value = "查询所有分类及其子分类，以树形结构组装起来", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/category/list/tree")
    public AjaxResult listTree() {
        List<CategoryEntity> categoryEntities = categoryService.listWithTree();
        return AjaxResult.success().put("data", categoryEntities);
    }

}
