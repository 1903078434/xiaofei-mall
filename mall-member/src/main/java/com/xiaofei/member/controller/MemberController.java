package com.xiaofei.member.controller;

import com.ruoyi.common.core.constant.CacheConstants;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.member.service.MemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * User: 李飞
 * Date: 2021/8/16
 * Time: 15:57
 */
@Api(tags = "会员接口")
@RequestMapping("/member/member")
@RestController
public class MemberController {

    @Autowired
    private MemberService memberService;

    @ApiOperation(value = "根据token获取用户信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/auth")
    public ResponseResult<MemberEntity> queryMemberById(@RequestHeader(name = CacheConstants.DETAILS_USER_ID, defaultValue = "", required = false) Long userId) {
        //因为在网关处做了处理，所以token的值已经解析了
        MemberEntity item = memberService.getByToken(userId);
        return new ResponseResult<MemberEntity>().success(item);
    }

}
