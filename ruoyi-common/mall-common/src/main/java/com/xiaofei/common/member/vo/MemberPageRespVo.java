package com.xiaofei.common.member.vo;

import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.order.entity.OrderItemEntity;
import lombok.Data;

import java.util.List;

/**
 * 用户信息页面所需信息
 * User: 李飞
 * Date: 2021/11/27
 * Time: 15:44
 */
@Data
public class MemberPageRespVo {
    private List<OrderItemEntity> orderItems;
    private MemberEntity memberEntity;
}
