package com.xiaofei.member.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.member.entity.MemberLevelEntity;
import com.xiaofei.common.member.vo.MemberLevelVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.member.service.MemberLevelService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/29
 * Time: 20:59
 */
@Api(tags = "会员等级接口")
@RequestMapping("/member/memberlevel")
@RestController
public class MemberLevelController {

    @Autowired
    private MemberLevelService memberLevelService;

    @ApiOperation(value = "添加会员等级信息", httpMethod = "POST", response = AjaxResult.class, produces = "application/json")
    @PostMapping("/internal")
    public AjaxResult addMemberLevel(@RequestBody MemberLevelVo memberLevelVo) {
        boolean isAdd = memberLevelService.addMemberLevel(memberLevelVo);
        return AjaxResult.success(isAdd ? "添加成功" : "添加失败").put("data", isAdd);
    }

    @ApiOperation(value = "根据会员等级id集合删除", httpMethod = "DELETE", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "memberLevelId", value = "会员等级Id", paramType = "body", required = true, dataType = "Long")
    @DeleteMapping("/internal")
    public AjaxResult deleteMemberLevelByIds(@RequestBody List<Long> memberLevelIds) {

        boolean isDelete = memberLevelService.deleteMemberLevelByIds(memberLevelIds);
        return AjaxResult.success(isDelete ? "删除成功" : "删除失败").put("data", isDelete);
    }

    @ApiOperation(value = "修改会员等级信息", httpMethod = "PUT", response = AjaxResult.class, produces = "application/json")
    @PutMapping("/internal")
    public AjaxResult updateMemberLevel(@RequestBody MemberLevelVo memberLevelVo) {
        boolean isUpdate = memberLevelService.updateMemberLevel(memberLevelVo);
        return AjaxResult.success(isUpdate ? "修改成功" : "修改失败").put("data", isUpdate);
    }

    @ApiOperation(value = "根据会员等级id查询会员等级", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @ApiImplicitParam(name = "memberLevelId", value = "会员等级Id", paramType = "path", required = true, dataType = "Long")
    @GetMapping("/internal/{memberLevelId}")
    public AjaxResult queryMemberLevelById(@PathVariable("memberLevelId") Long memberLevelId) {
        MemberLevelEntity item = memberLevelService.getById(memberLevelId);
        return AjaxResult.success("查询成功").put("data", item);
    }

    @ApiOperation(value = "分页查询会员等级接口", httpMethod = "GET", response = AjaxResult.class, produces = "application/json")
    @GetMapping("/internal/list")
    public AjaxResult queryMemberLevelByPage(MemberLevelVo memberLevelVo) {
        //分页查询和条件查询
        PageVo<MemberLevelEntity> page = memberLevelService.queryMemberLevelByPage(memberLevelVo);
        return AjaxResult.success("查询成功").put("data", page);
    }

}
