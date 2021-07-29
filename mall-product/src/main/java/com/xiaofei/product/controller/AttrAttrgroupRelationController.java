package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.vo.AttrAttrGroupRelationVo;
import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.AttrAttrgroupRelationService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/29
 * Time: 10:11
 */
@Api(tags = "属性和属性分组关联接口")
@RequestMapping("/product")
@RestController
public class AttrAttrgroupRelationController {
    @Autowired

    private AttrAttrgroupRelationService attrAttrgroupRelationService;

    @ApiOperation(value = "添加属性和属性分组的信息信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/attrattrgrouprelation")
    public AjaxResult addAttr(@RequestBody List<AttrAttrGroupRelationVo> relationVos) {
        boolean isAdd = attrAttrgroupRelationService.addRelation(relationVos);
        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "单个或批量删除属性和属性分组", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "relationId", value = "关联Id数组字符串", paramType = "body", required = true, dataType = "String")
    @DeleteMapping("/attrattrgrouprelation")
    public AjaxResult deleteAttrAttrGroupRelation(@RequestBody List<AttrAttrGroupRelationVo> relationVos) {
        boolean isDelete = attrAttrgroupRelationService.deleteByRelation(relationVos);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "根据属性分组id查询关联关系", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "attrGroupId", value = "属性分组id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/attrattrgrouprelation/{attrGroupId}")
    public AjaxResult queryRelationByAttrGroupId(@PathVariable("attrGroupId") Long attrGroupId) {
        List<AttrAttrGroupRelationVo> items = attrAttrgroupRelationService.queryRelationByAttrGroupId(attrGroupId);
        return AjaxResult.success("查询成功").put("data", items);
    }

    @ApiOperation(value = "根据分页信息查询未关联的属性信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/attrattrgrouprelation")
    public AjaxResult queryNotRelationByAttrGroupId(AttrVo attrVo) {
        PageVo<AttrVo> items = attrAttrgroupRelationService.queryNoRelationAttr(attrVo);
        return AjaxResult.success("查询成功").put("data", items);
    }

}
