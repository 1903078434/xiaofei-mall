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

    @ApiModelProperty("收获地址id")
    private Long id;

    @ApiModelProperty("收货人姓名")
    private String name;

    @ApiModelProperty("电话")
    private String phone;

    @ApiModelProperty("地区id")
    private Integer provincesId;

    @ApiModelProperty("详细地址(街道)")
    private String detailAddress;
}
