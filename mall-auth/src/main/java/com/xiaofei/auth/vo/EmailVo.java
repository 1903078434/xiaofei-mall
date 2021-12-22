package com.xiaofei.auth.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 18:13
 */
@Data
@ApiModel("邮箱注册")
public class EmailVo {

    @ApiModelProperty("需要注册的邮箱")
    private String registerEmail;

}
