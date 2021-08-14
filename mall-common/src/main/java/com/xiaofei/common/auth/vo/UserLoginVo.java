package com.xiaofei.common.auth.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:22
 */
@Data
@ApiModel("用户登录")
public class UserLoginVo {
    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("密码")
    private String password;

    @ApiModelProperty("验证码")
    private Integer code;
}
