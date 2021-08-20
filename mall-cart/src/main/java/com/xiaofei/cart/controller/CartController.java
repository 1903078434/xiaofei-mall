package com.xiaofei.cart.controller;

import com.ruoyi.common.core.constant.CacheConstants;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.cart.service.CartService;
import com.xiaofei.cart.entity.CartEntity;
import com.xiaofei.cart.vo.CartReqVo;
import com.xiaofei.cart.vo.CartRespVo;
import com.xiaofei.common.exception.MallCartException;
import com.xiaofei.common.utils.ResponseResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    public ResponseResult<String> addCart(@RequestBody CartReqVo cartReqVo) throws MallCartException {

        String id = cartService.addCart(cartReqVo);

        return new ResponseResult<String>().success(id);
    }

    @ApiOperation(value = "删除购物车信息", httpMethod = "DELETE", response = ResponseResult.class, produces = "application/json")
    @ApiImplicitParam(name = "id", value = "购物车id", paramType = "path", required = true, dataType = "String")
    @DeleteMapping("/auth")
    public ResponseResult<Boolean> deleteCart(@RequestBody String id) {

        cartService.deleteCart(id);

        return new ResponseResult<Boolean>().success();
    }

    @ApiOperation(value = "修改购物车信息", httpMethod = "PUT", response = ResponseResult.class, produces = "application/json")
    @PutMapping("/auth")
    public ResponseResult<String> updateCart(@RequestBody CartReqVo cartReqVo) throws MallCartException {

        String id = cartService.updateCart(cartReqVo);

        return new ResponseResult<String>().success(id);
    }

    @ApiOperation(value = "全选和全不选", httpMethod = "PUT", response = ResponseResult.class, produces = "application/json")
    @PutMapping("/auth/checkall/{isCheckAll}")
    public ResponseResult<String> checkAll(@PathVariable("isCheckAll") boolean isCheckAll, @RequestHeader(name = CacheConstants.DETAILS_USER_ID) Long userId) {

        boolean isSuccess = cartService.checkAll(isCheckAll, userId);

        return new ResponseResult<String>().success(isSuccess ? "修改成功" : "修改失败");
    }

    @ApiOperation(value = "根据购物车id查询购物车信息数据", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "id", value = "id", paramType = "path", required = true, dataType = "String")
    @GetMapping("/auth/{id}")
    public ResponseResult<CartEntity> queryCartInfoById(@PathVariable("id") String id) {
        CartEntity item = cartService.queryCartInfoById(id);
        return new ResponseResult<CartEntity>().success("查询成功", item);
    }

    @ApiOperation(value = "根据用户id查询购物车信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/auth")
    public ResponseResult<CartRespVo> queryCartByUserId(@RequestHeader(name = CacheConstants.DETAILS_USER_ID) Long userId) {
        CartRespVo item = cartService.queryCartByUserId(userId);
        return new ResponseResult<CartRespVo>().success("查询成功", item);
    }


}
