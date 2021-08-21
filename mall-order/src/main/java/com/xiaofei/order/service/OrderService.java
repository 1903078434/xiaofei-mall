package com.xiaofei.order.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.order.vo.OrderInfoResp;
import com.xiaofei.order.entity.OrderEntity;

import java.util.concurrent.ExecutionException;

/**
 *
 */
public interface OrderService extends IService<OrderEntity> {

    /**
     * 订单信息
     *
     * @param userId         用户id
     * @return 返回所需要的订单信息
     */
    OrderInfoResp queryOrderInfo( Long userId) throws ExecutionException, InterruptedException;
}
