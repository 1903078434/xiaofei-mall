package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.AttrService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * User: 李飞
 * Date: 2021/7/28
 * Time: 14:44
 */
@Api(tags = "基础属性接口")
@RequestMapping("/product")
@RestController
public class AttrController {

    @Autowired
    private AttrService attrService;

    @ApiOperation(value = "添加属性信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/internal/attr")
    public AjaxResult addAttr(@RequestBody AttrVo attrVo) {
        boolean isAdd = attrService.addAttr(attrVo);
        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "修改属性信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/internal/attr")
    public AjaxResult updateAttr(@RequestBody AttrVo attrVo) {
        boolean isUpdate = attrService.updateAttr(attrVo);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }

    @ApiOperation(value = "根据属性id删除", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "attrId", value = "属性Id", paramType = "body", required = true, dataType = "String")
    @DeleteMapping("/internal/attr")
    public AjaxResult deleteAttrById(@RequestBody String attrId) {

        boolean isDelete = attrService.deleteAttrById(attrId);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "根据分页信息查询基础属性信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "attrType", value = "属性类别。1：基本属性。0：销售属性", paramType = "path", required = true, dataType = "int")
    @GetMapping("/attr/list/{attrType}")
    public AjaxResult queryByPage(AttrVo attrVo, @PathVariable("attrType") int attrType) {
        PageVo<AttrVo> item = attrService.queryBaseAttr(attrVo, attrType);
        return AjaxResult.success().put("data", item);
    }

    @ApiOperation(value = "根据属性id查询属性分组信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "attrId", value = "属性id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/attr/{attrId}")
    public AjaxResult queryAttrById(@PathVariable("attrId") Long attrId) {
        AttrVo attrVo = attrService.queryAttrById(attrId);
        return AjaxResult.success("查询成功").put("data", attrVo);
    }

}
