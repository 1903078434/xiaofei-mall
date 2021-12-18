package com.xiaofei.coupon.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.coupon.entity.SpuBoundsEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.coupon.service.SpuBoundsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 20:35
 */
@Api("商品spu积分设置")
@RequestMapping("/coupon/spubounds")
@RestController
public class SpuBoundsController {

    @Autowired
    private SpuBoundsService spuBoundsService;

    @ApiOperation(value = "添加SPU的积分信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/internal")
    public AjaxResult addSpuBounds(@RequestBody SpuBoundsEntity spuBoundsEntity) {
        boolean isAdd = spuBoundsService.save(spuBoundsEntity);
        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据spuId积分满减信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "spuId", value = "商品id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/{spuId}")
    public ResponseResult<SpuBoundsEntity> queryBoundInfoById(@PathVariable("spuId") Long spuId) {
        SpuBoundsEntity item = spuBoundsService.getOne(new QueryWrapper<SpuBoundsEntity>().eq("spu_id", spuId));
        return new ResponseResult<SpuBoundsEntity>().success(item);
    }

}
