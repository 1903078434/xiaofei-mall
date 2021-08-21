package com.xiaofei.member.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 会员收货地址
 */
@ApiModel("会员地址")
@Data
public class MemberReceiveAddressVo implements Serializable {

    @ApiModelProperty("id")
    private Long id;

    @ApiModelProperty("会员id")
    private Long memberId;

    @ApiModelProperty("收货人姓名")
    private String name;

    @ApiModelProperty("电话")
    private String phone;

    @ApiModelProperty("地区id")
    private Long provincesId;

    @ApiModelProperty("详细地址(街道)")
    private String detailAddress;

    @ApiModelProperty("是否默认")
    private Boolean defaultStatus;
}
