package com.xiaofei.member.controller;

import com.ruoyi.common.core.constant.CacheConstants;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.member.service.MemberReceiveAddressService;
import com.xiaofei.member.vo.MemberReceiveAddressVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/21
 * Time: 14:56
 */
@Api("获取用户收获地址接口")
@RequestMapping("/member/receiveaddress")
@RestController
public class MemberReceiveAddressController {

    @Autowired
    private MemberReceiveAddressService memberReceiveAddressService;

    @ApiOperation(value = "添加收获地址", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth")
    public ResponseResult<String> addReceiveAddress(@RequestHeader(name = CacheConstants.DETAILS_USER_ID) Long userId,
                                                    @RequestBody MemberReceiveAddressVo memberReceiveAddressVo) {
        boolean isAdd = memberReceiveAddressService.addReceiveAddress(userId,memberReceiveAddressVo);
        return new ResponseResult<String>().success(isAdd ? "添加成功" : "添加失败");
    }


    @ApiOperation(value = "订单信息填写核对", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/auth/receiveaddressinfo")
    public ResponseResult<List<MemberReceiveAddressEntity>> getReceiveAddress(@RequestHeader(name = CacheConstants.DETAILS_USER_ID) Long userId) {
        List<MemberReceiveAddressEntity> items = memberReceiveAddressService.getReceiveAddress(userId);
        return new ResponseResult<List<MemberReceiveAddressEntity>>().success(items);
    }

}
