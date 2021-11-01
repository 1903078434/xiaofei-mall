package com.xiaofei.member.controller;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.member.service.MemberReceiveAddressService;
import com.xiaofei.member.vo.MemberReceiveAddressVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

/**
 * User: 李飞
 * Date: 2021/8/21
 * Time: 14:56
 */
@Api(tags = "获取用户收获地址接口")
@RequestMapping("/member/receiveaddress")
@RestController
public class MemberReceiveAddressController {

    @Autowired
    private MemberReceiveAddressService memberReceiveAddressService;

    @ApiOperation(value = "添加收获地址", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/auth")
    public ResponseResult<String> addReceiveAddress(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                    @RequestBody MemberReceiveAddressVo memberReceiveAddressVo) throws ExecutionException, InterruptedException {
        boolean isAdd = memberReceiveAddressService.addReceiveAddress(userId, memberReceiveAddressVo);
        return new ResponseResult<String>().success(isAdd ? "添加成功" : "添加失败");
    }

    @ApiOperation(value = "根据地址id和用户id删除收货地址信息", httpMethod = "DELETE", response = ResponseResult.class, produces = "application/json")
    @DeleteMapping("/auth/{id}")
    public ResponseResult<String> DeleteReceiveAddressById(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                                               @PathVariable("id") Integer id) {
        boolean isDelete = memberReceiveAddressService.deleteReceiveAddressById(id, userId);
        return new ResponseResult<String>().success(isDelete ? "删除成功" : "删除失败");
    }

    @ApiOperation(value = "修改收获地址信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/auth")
    public AjaxResult updateAddress(@RequestBody MemberReceiveAddressVo memberReceiveAddressVo) {
        boolean isUpdate = memberReceiveAddressService.updateAddress(memberReceiveAddressVo);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }


    @ApiOperation(value = "根据用户id查询该用户下面的所有收获地址", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/auth/receiveaddressinfo")
    public ResponseResult<List<MemberReceiveAddressEntity>> getReceiveAddress(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId) {
        List<MemberReceiveAddressEntity> items = memberReceiveAddressService.getReceiveAddress(userId);
        return new ResponseResult<List<MemberReceiveAddressEntity>>().success(items);
    }

    @ApiOperation(value = "根据收获地址id查询收获地址信息", httpMethod = "GET", response = ResponseResult.class, produces = "application/json")
    @GetMapping("/auth/receiveaddressinfo/{id}")
    public ResponseResult<MemberReceiveAddressEntity> getReceiveAddressById(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                                            @PathVariable("id") Integer id) {
        MemberReceiveAddressEntity item = memberReceiveAddressService.getReceiveAddressById(id, userId);
        return new ResponseResult<MemberReceiveAddressEntity>().success(item);
    }

}
