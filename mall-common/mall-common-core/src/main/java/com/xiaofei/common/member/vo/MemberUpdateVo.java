package com.xiaofei.common.member.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDate;

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

    @ApiModelProperty("昵称")
    private String nickname;

    @ApiModelProperty("手机号码")
    private String mobile;

    @ApiModelProperty("头像")
    private String header;

    @ApiModelProperty("性别")
    private Integer gender;

    @ApiModelProperty("生日")
    private LocalDate birth;

    @ApiModelProperty("职业")
    private String job;

    @ApiModelProperty("个性签名")
    private String sign;
}
