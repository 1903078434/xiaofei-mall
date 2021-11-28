package com.xiaofei.cart.controller;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.exception.mall.MallCartException;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.cart.service.CartService;
import com.xiaofei.common.cart.entity.CartEntity;
import com.xiaofei.common.cart.vo.CartReqVo;
import com.xiaofei.common.cart.vo.CartRespVo;
import com.xiaofei.common.utils.ResponseResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 10:53
 */

@RestController
@Api(tags = "购物车接口")
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @ApiOperation(value = "添加购物车", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth")
    public ResponseResult<List<Long>> addCart(@RequestHeader(SecurityConstants.DETAILS_USER_ID) Long userId,
                                              @RequestBody List<CartReqVo> cartReqVos) throws MallCartException {

        List<Long> items = cartService.addCart(userId, cartReqVos);

        return new ResponseResult<List<Long>>().success(items);
    }

    @ApiOperation(value = "删除购物车信息", httpMethod = "DELETE", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "id", value = "购物车id", paramType = "path", required = true, dataType = "String")
    @DeleteMapping("/auth")
    public ResponseResult<String> deleteCart(@RequestBody String id) {

        boolean isSuccess = cartService.deleteCart(id);

        return new ResponseResult<String>().success(isSuccess ? "删除成功" : "删除失败");
    }

    @ApiOperation(value = "根据用户id和skuIds删除购物车信息", httpMethod = "DELETE", response = ResponseResult.class, produces = "application/json")
    @DeleteMapping("/auth/byskuids")
    public ResponseResult<String> deleteCartBySkuId(@RequestHeader(SecurityConstants.DETAILS_USER_ID) Long userId,
                                                    @RequestBody List<Long> skuIds) {
        boolean isSuccess = cartService.deleteCartBySkuId(userId, skuIds);

        return new ResponseResult<String>().success(isSuccess ? "删除成功" : "删除失败");
    }

    @ApiOperation(value = "修改购物车信息", httpMethod = "PUT", response = ResponseResult.class, produces = "application/json")
    @PutMapping("/auth")
    public ResponseResult<Long> updateCart(@RequestHeader(SecurityConstants.DETAILS_USER_ID) Long userId,
                                           @RequestBody CartReqVo cartReqVo) throws MallCartException {

        Long id = cartService.updateCart(userId, cartReqVo);

        return new ResponseResult<Long>().success(id);
    }

    @ApiOperation(value = "全选和全不选", httpMethod = "PUT", response = ResponseResult.class, produces = "application/json")
    @PutMapping("/auth/checkall/{isCheckAll}")
    public ResponseResult<String> checkAll(@PathVariable("isCheckAll") boolean isCheckAll, @RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId) {

        boolean isSuccess = cartService.checkAll(isCheckAll, userId);

        return new ResponseResult<String>().success(isSuccess ? "修改成功" : "修改失败");
    }

    @ApiOperation(value = "根据购物车id查询购物车信息数据", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "id", value = "id", paramType = "path", required = true, dataType = "String")
    @GetMapping("/auth/{id}")
    public ResponseResult<List<CartEntity>> queryCartInfoById(@PathVariable("id") String id) {
        List<CartEntity> items = cartService.queryCartInfoById(id);
        return new ResponseResult<List<CartEntity>>().success("查询成功", items);
    }

    @ApiOperation(value = "根据用户id查询购物车信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/auth")
    public ResponseResult<CartRespVo> queryCartByUserId(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId) {
        CartRespVo item = cartService.queryCartByUserId(userId);
        return new ResponseResult<CartRespVo>().success("查询成功", item);
    }

    @ApiOperation(value = "根据购物车id查询购物车信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/auth/querybyids")
    public ResponseResult<List<CartEntity>> queryCartByUserIds(@RequestBody String ids) {
        List<CartEntity> items = cartService.queryCartsByIds(ids);
        return new ResponseResult<List<CartEntity>>().success("查询成功", items);
    }

    @ApiOperation(value = "查询指定用户所有选中的商品信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/auth/querycheckcart")
    public ResponseResult<List<CartEntity>> queryCheckCart(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId) {
        List<CartEntity> items = cartService.queryCheckCart(userId);
        return new ResponseResult<List<CartEntity>>().success("查询成功", items);
    }
}
