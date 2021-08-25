package com.xiaofei.common.member.vo;

import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/25
 * Time: 22:15
 */
@Data
@ApiModel("查询出来的会员信息")
public class MemberQueryRespVo {

    @ApiModelProperty("会员基本信息")
    private MemberEntity memberEntity;

    @ApiModelProperty("会员的收获地址")
    private List<MemberReceiveAddressEntity> memberReceiveAddressEntitys;
}
