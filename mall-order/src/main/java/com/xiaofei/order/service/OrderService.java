package com.xiaofei.order.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.exception.OrderException;
import com.xiaofei.common.order.vo.OrderInfoResp;
import com.xiaofei.common.order.vo.OrderVo;
import com.xiaofei.order.entity.OrderEntity;

import java.util.concurrent.ExecutionException;

/**
 *
 */
public interface OrderService extends IService<OrderEntity> {

    /**
     * 确认订单信息
     *
     * @param userId 用户id
     * @return 返回所需要的订单信息
     */
    OrderInfoResp queryOrderInfo(Long userId) throws ExecutionException, InterruptedException;

    /**
     * 创建订单
     *
     * @param userId   用户id
     * @param username 用户名
     * @param orderVo  订单所需要的信息
     */
    void crateOrder(Long userId, String username, OrderVo orderVo) throws OrderException;
}
