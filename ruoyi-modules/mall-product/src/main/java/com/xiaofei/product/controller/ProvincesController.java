package com.xiaofei.product.controller;

import com.xiaofei.common.product.entity.ProvincesEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.product.service.ProvincesService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/13
 * Time: 14:18
 */
@RestController
@Api(tags = "地区字典")
@RequestMapping("/product/provinces")
public class ProvincesController {

    @Autowired
    private ProvincesService provincesService;

    @ApiOperation(value = "获取全部的地区信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping
    public ResponseResult<List<ProvincesEntity>> queryAllProvinces() {
        List<ProvincesEntity> items = provincesService.queryAllProvinces();
        return new ResponseResult<List<ProvincesEntity>>().success("查询成功", items);
    }

    @ApiOperation(value = "根据id获取信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("{id}")
    public ResponseResult<ProvincesEntity> queryProvincesById(@PathVariable("id") Integer id) {
        ProvincesEntity item = provincesService.getById(id);
        return new ResponseResult<ProvincesEntity>().success("查询成功", item);
    }

    @ApiOperation(value = "根据id获取地区id的全路径", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/provincespath/{id}")
    public ResponseResult<List<Integer>> findProvincesPath(@PathVariable("id") Integer id) {
        List<Integer> items = provincesService.findProvincesPath(id);
        return new ResponseResult<List<Integer>>().success("查询成功", items);
    }
}
