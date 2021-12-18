package com.xiaofei.common.member.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * 用户详细信息的查询条件
 * User: 李飞
 * Date: 2021/8/26
 * Time: 19:50
 */
@Data
@ApiModel("查询会员详细信息所需要的条件")
public class MemberDetailQueryVo {

    //订单的详细状态
    private Integer status;
}
