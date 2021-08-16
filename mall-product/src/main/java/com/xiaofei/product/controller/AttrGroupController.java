package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.vo.AttrAndAttrGroupVo;
import com.xiaofei.common.product.vo.AttrGroupVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.AttrGroupService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/26
 * Time: 19:27
 */
@Api(tags = "属性分组接口")
@RequestMapping("/product")
@RestController
public class AttrGroupController {
    @Autowired
    private AttrGroupService attrGroupService;

    @ApiOperation(value = "添加属性分组信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/attrgroup/internal/add")
    public AjaxResult addAttrGroup(@RequestBody AttrGroupVo attrGroupVo) {

        boolean isAdd = attrGroupService.addAttrGroup(attrGroupVo);

        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据属性分组id删除", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "attrGroupId", value = "属性分组id集合,多个id，隔开", paramType = "body", required = true, dataType = "Long")
    @DeleteMapping("/attrgroup/internal/delete")
    public AjaxResult deleteAttrGroupById(@RequestBody String attrgroupId) {

        boolean isDelete = attrGroupService.deleteAttrGroupById(attrgroupId);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "根据属性分组id修改属性分组信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/attrgroup/internal/update")
    public AjaxResult updateAttrGroup(@RequestBody AttrGroupVo attrGroupVo) {
        boolean isUpdate = attrGroupService.updateAttrGroupById(attrGroupVo);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }

    @ApiOperation(value = "根据属性分组id查询属性分组信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "attrgroupId", value = "属性分组id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/attrgroup/{attrgroupId}")
    public AjaxResult queryAttrGroupById(@PathVariable("attrgroupId") Long attrgroupId) {
        AttrGroupVo attrGroupVo = attrGroupService.queryAttrGroupById(attrgroupId);
        return AjaxResult.success("查询成功").put("data", attrGroupVo);
    }

    @ApiOperation(value = "根据属性类别id查询属性分组信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "categoryId", value = "类别id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/attrgroup/list/{categoryId}")
    public AjaxResult queryAttrGroupByCategoryId(@PathVariable("categoryId") Long categoryId) {
        List<AttrGroupVo> attrGroupVos = attrGroupService.queryAttrGroupByCategoryId(categoryId);
        return AjaxResult.success("查询成功").put("data", attrGroupVos);
    }

    @ApiOperation(value = "根据分页信息查询属性分组信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/attrgroup/list")
    public AjaxResult queryByPage(AttrGroupVo attrGroupVo) {
        PageVo<AttrGroupEntity> items = attrGroupService.queryByPage(attrGroupVo);
        return AjaxResult.success().put("data", items);
    }

    @ApiOperation(value = "获取指定类别下的属性分组和属性，，每一组属性分组都绑定着属性", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "categoryId", value = "类别id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/attrgroup/list/{categoryId}/withattr")
    public AjaxResult queryByCategoryWithAttr(@PathVariable("categoryId") Long categoryId) {
        List<AttrAndAttrGroupVo> items = attrGroupService.queryAttrGroupWithAttr(categoryId);
        return AjaxResult.success().put("data", items);
    }

}
