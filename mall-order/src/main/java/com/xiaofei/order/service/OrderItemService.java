package com.xiaofei.order.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.order.entity.OrderItemEntity;
import com.xiaofei.common.order.vo.OrderItemQueryVo;
import com.xiaofei.common.order.vo.OrderItemResp;
import com.xiaofei.common.vo.PageVo;

import java.util.List;

/**
 *
 */
public interface OrderItemService extends IService<OrderItemEntity> {

    /**
     * 根据查询条件查询订单信息
     *
     * @param userId           用户id
     * @param username         用户名
     * @param orderItemQueryVo 订单项查询条件
     * @return 返回订单项查询结果
     */
    PageVo<OrderItemResp> queryOrderItemInfo(Long userId, String username, OrderItemQueryVo orderItemQueryVo);

    /**
     * 内部系统查询所有订单信息
     *
     * @param orderItemQueryVo 订单项的检索条件
     * @return 返回检索到的信息
     */
    PageVo<OrderItemResp> queryAllByPage(OrderItemQueryVo orderItemQueryVo);
}
