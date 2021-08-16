package com.xiaofei.ware.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.common.ware.entity.WareInfoEntity;
import com.xiaofei.common.ware.vo.WareInfoVo;
import com.xiaofei.ware.service.WareInfoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 15:23
 */
@Api(tags = "wareInfo-仓库信息接口")
@RestController
@RequestMapping("/ware/wareinfo")
public class WareInfoController {

    @Autowired
    private WareInfoService wareInfoService;

    @ApiOperation(value = "添加仓库信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/internal")
    public AjaxResult addWareInfo(@RequestBody WareInfoVo wareInfoVo) {

        boolean isAdd = wareInfoService.addWareInfo(wareInfoVo);

        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据仓库id删除仓库", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "wareId", value = "仓库id集合", paramType = "body", required = true, dataType = "String")
    @DeleteMapping("/internal")
    public AjaxResult deleteWareInfoById(@RequestBody String wareId) {
        boolean isDelete = wareInfoService.deleteWareById(wareId);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "根据仓库id修改仓库信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/internal")
    public AjaxResult updateWareInfo(@RequestBody WareInfoVo wareInfoVo) {
        boolean isUpdate = wareInfoService.updateWareInfoById(wareInfoVo);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }

    @ApiOperation(value = "分页和搜索查询仓库信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/internal")
    public AjaxResult queryWareInfoByPage(WareInfoVo wareInfoVo) {
        //分页查询和条件查询
        PageVo<WareInfoEntity> page = wareInfoService.queryByPage(wareInfoVo);
        return AjaxResult.success("查询成功").put("data", page);
    }

    @ApiOperation(value = "根据仓库id查询仓库信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "wareId", value = "仓库id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/internal/{wareId}")
    public AjaxResult queryWareInfoById(@PathVariable("wareId") Long wareId) {
        WareInfoEntity wareInfo = wareInfoService.getById(wareId);
        return AjaxResult.success("查询成功").put("data", wareInfo);
    }
}
