package com.xiaofei.common.member.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 用户账号密码修改
 * User: 李飞
 * Date: 2021/11/27
 * Time: 22:49
 */
@Data
@ApiModel("用户密码修改所需参数")
public class MemberPasswordVo {
    @ApiModelProperty("旧密码")
    private String oldPassword;
    @ApiModelProperty("新密码")
    private String password;
    @ApiModelProperty("确认密码")
    private String password1;
}
