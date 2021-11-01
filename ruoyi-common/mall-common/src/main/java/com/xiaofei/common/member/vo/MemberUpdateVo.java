package com.xiaofei.common.member.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 会员信息修改所需要的参数
 * User: 李飞
 * Date: 2021/8/26
 * Time: 18:00
 */
@Data
@ApiModel("会员修改所需要的参数")
public class MemberUpdateVo {
    @ApiModelProperty("会员id")
    private Long id;

    @ApiModelProperty("会员等级id")
    private Long levelId;

    @ApiModelProperty("启用状态【1：启用。0：不启用】")
    private Integer status;
}
