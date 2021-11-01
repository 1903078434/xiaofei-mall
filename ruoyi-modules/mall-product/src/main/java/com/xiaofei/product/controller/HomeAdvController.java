package com.xiaofei.product.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.product.constant.HomeAdvEntity;
import com.xiaofei.common.product.vo.AdvQueryVo;
import com.xiaofei.common.product.vo.HomeRespVo;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.product.service.HomeAdvService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.ExecutionException;

/**
 * User: 李飞
 */
@Api(tags = "广告接口")
@RestController
@RequestMapping("/product/adv")
public class HomeAdvController {

    @Autowired
    private HomeAdvService homeAdvService;

    @ApiOperation(value = "根据分页信息查询广告信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping
    public AjaxResult queryByPage(AdvQueryVo advQueryVo) {
        PageVo<HomeAdvEntity> page = homeAdvService.queryByPage(advQueryVo);
        return AjaxResult.success().put("data", page);
    }

    @ApiOperation(value = "首页广告资源加载", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/advinfo")
    public ResponseResult<HomeRespVo> queryAdvInfo() throws ExecutionException, InterruptedException {
        HomeRespVo item = homeAdvService.queryAdvInfo();
        return new ResponseResult<HomeRespVo>().success(item);
    }

}
