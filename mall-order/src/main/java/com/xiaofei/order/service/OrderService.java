package com.xiaofei.order.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.exception.OrderException;
import com.xiaofei.common.order.entity.OrderEntity;
import com.xiaofei.common.order.vo.*;

import java.util.concurrent.ExecutionException;

/**
 *
 */
public interface OrderService extends IService<OrderEntity> {

    /**
     * 创建订单
     *
     * @param userId   用户id
     * @param username 用户名
     * @param orderVo  订单所需要的信息
     */
    OrderRespVo crateOrder(Long userId, String username, OrderVo orderVo) throws OrderException;


    /**
     * 确认订单信息
     *
     * @param userId 用户id
     * @return 返回所需要的订单信息
     */
    OrderInfoResp queryOrderInfo(Long userId) throws ExecutionException, InterruptedException;

    /**
     * 修改订单信息
     *
     * @param userId        用户id
     * @param username      用户名
     * @param orderUpdateVo 修改的订单信息
     * @return true：修改成功。false：修改失败
     */
    boolean updateOrder(Long userId, String username, OrderUpdateVo orderUpdateVo);

    /**
     * 订单支付
     *
     * @param userId     用户id
     * @param username   用户名
     * @param orderReqVo 订单支付信息
     * @return true:修改成功。false：修改失败
     */
    boolean orderPay(Long userId, String username, OrderReqVo orderReqVo) throws OrderException;

    /**
     * 根据订单id订单编号和用户信息查询订单项信息
     *
     * @param userId      用户id
     * @param username    用户名
     * @param orderRespVo 查询订单项的参数
     */
    OrderItemResp payOrderInfo(Long userId, String username, OrderRespVo orderRespVo) throws OrderException;

}
