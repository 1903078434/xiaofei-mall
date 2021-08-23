package com.xiaofei.ware.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.exception.OrderException;
import com.xiaofei.common.order.dto.OrderSkuDto;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.common.ware.entity.WareSkuEntity;
import com.xiaofei.common.ware.vo.WareSkuVo;
import com.xiaofei.ware.service.WareSkuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 19:20
 */
@Api(tags = "wareSku-sku库存信息接口")
@RestController
@RequestMapping("/ware/waresku")
public class WareSkuController {

    @Autowired
    private WareSkuService wareSkuService;

    @ApiOperation(value = "添加库存信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/internal")
    public AjaxResult addWareSku(@RequestBody WareSkuVo wareSkuVo) {
        Map<String, Object> response = wareSkuService.addWareSku(wareSkuVo);
        return AjaxResult.success((String) response.get("msg")).put("data", response.get("isSuccess"));
    }

    @ApiOperation(value = "根据库存id删除库存信息", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "skuId", value = "库存id集合", paramType = "body", required = true, dataType = "String")
    @DeleteMapping("/internal")
    public AjaxResult deleteWareSkuById(@RequestBody String skuId) {
        boolean isDelete = wareSkuService.deleteWareSkuById(skuId);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "根据库存id修改库存信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/internal")
    public AjaxResult updateWareSku(@RequestBody WareSkuVo wareSkuVo) {
        boolean isUpdate = wareSkuService.updateWareSkuById(wareSkuVo);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }

    @ApiOperation(value = "分页和搜索查询库存信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/internal")
    public AjaxResult queryWareSkuByPage(WareSkuVo wareSkuVo) {
        //分页查询和条件查询
        PageVo<WareSkuEntity> page = wareSkuService.queryByPage(wareSkuVo);
        return AjaxResult.success("查询成功").put("data", page);
    }

    @ApiOperation(value = "根据库存id查询库存信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "idd", value = "库存id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/internal/{id}")
    public AjaxResult queryWareSkuById(@PathVariable("id") Long id) {
        WareSkuEntity item = wareSkuService.getById(id);
        return AjaxResult.success("查询成功").put("data", item);
    }

    @ApiOperation(value = "判断是否有库存", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/internal/hasStock")
    public ResponseResult<List<SkuHasStockDto>> getSkuStock(@RequestParam("skuIds") List<Long> skuIds) {
        List<SkuHasStockDto> items = wareSkuService.getSkuStock(skuIds);
        return new ResponseResult<List<SkuHasStockDto>>().success("查询成功", items);
    }

    @ApiOperation(value = "判断购买的商品库存是否足够", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/auth/hasStock")
    public ResponseResult<Boolean> updateStock(@RequestBody List<OrderSkuDto> orderSkuDtos)  throws OrderException {
       boolean isUpdate = wareSkuService.updateStock(orderSkuDtos);
        return new ResponseResult<Boolean>().success(isUpdate?"库存充足":"库存不足", isUpdate);
    }

}
