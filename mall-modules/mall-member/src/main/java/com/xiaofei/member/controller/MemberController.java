package com.xiaofei.member.controller;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.member.vo.*;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.member.service.MemberService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @ApiOperation(value = "用户注册", httpMethod = "POST", response = ResponseResult.class, produces = "application/json")
    @PostMapping("/register")
    public ResponseResult<Boolean> registerLogin(@RequestBody MemberEntity memberEntity) {
        Boolean resp = memberService.userRegister(memberEntity);
        return new ResponseResult<Boolean>().success(resp);
    }

    @ApiOperation(value = "根据token获取用户信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/auth")
    public ResponseResult<MemberEntity> queryMemberById(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID, defaultValue = "", required = false) Long userId) {
        //因为在网关处做了处理，所以token的值已经解析了
        MemberEntity item = memberService.getByToken(userId);
        return new ResponseResult<MemberEntity>().success(item);
    }

    @ApiOperation(value = "根据用户名或邮箱获取用户信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/auth/username/email")
    public ResponseResult<MemberEntity> queryMemberByUserNameOrEmail(String username, String email) {
        MemberEntity item = memberService.queryMemberByUserNameOrEmail(username, email);
        return new ResponseResult<MemberEntity>().success(item);
    }

    @ApiOperation(value = "根据用户名获取用户信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/auth/username")
    public ResponseResult<MemberEntity> queryMemberByUserName(String username) {
        MemberEntity item = memberService.queryMemberByUserName(username);
        return new ResponseResult<MemberEntity>().success(item);
    }


    @ApiOperation(value = "修改会员的启用状态", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/internal")
    public ResponseResult<Boolean> updateMemberStatus(@RequestBody MemberUpdateVo memberUpdateVo) {
        boolean isUpdate = memberService.updateMemberStatus(memberUpdateVo);

        return new ResponseResult<Boolean>().success(isUpdate ? "修改成功" : "修改失败", isUpdate);
    }

    @ApiOperation(value = "修改密码", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/auth/update/password")
    public ResponseResult<Boolean> updateMemberPassword(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                        @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                                        @RequestBody MemberPasswordVo memberPasswordVo) {
        boolean isUpdate = memberService.updateMemberPassword(userId, username, memberPasswordVo);

        return new ResponseResult<Boolean>().success(isUpdate ? "修改成功" : "修改失败", isUpdate);
    }

    @ApiOperation(value = "修改用户信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/auth")
    public ResponseResult<Boolean> updateMemberInfo(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                    @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                                    @RequestBody MemberUpdateVo memberUpdateVo) {
        boolean isUpdate = memberService.updateMemberInfo(userId, username, memberUpdateVo);

        return new ResponseResult<Boolean>().success(isUpdate ? "修改成功" : "修改失败", isUpdate);
    }

    @ApiOperation(value = "管理员获取所有的用户列表", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/internal")
    public ResponseResult<PageVo<MemberQueryRespVo>> queryMemberByPage(MemberQueryVo memberQueryVo) {
        PageVo<MemberQueryRespVo> page = memberService.queryMemberByPage(memberQueryVo);
        return new ResponseResult<PageVo<MemberQueryRespVo>>().success(page);
    }

    @ApiOperation(value = "用户查询用户的具体信息和其他的订单、优惠券等信息", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/auth/querymemberdetailinfo")
    public ResponseResult<MemberPageRespVo> queryMemberDetailInfo(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                                  @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username) {
        MemberPageRespVo resp = memberService.queryMemberDetailInfo(userId, username);

        return new ResponseResult<MemberPageRespVo>().success(resp);
    }

}
