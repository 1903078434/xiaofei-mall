package com.xiaofei.order.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.order.entity.OrderEntity;
import com.xiaofei.common.order.entity.OrderItemEntity;
import com.xiaofei.common.order.enums.OrderStatusEnum;
import com.xiaofei.common.order.vo.OrderItemQueryVo;
import com.xiaofei.common.order.vo.OrderItemResp;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.order.mapper.OrderItemMapper;
import com.xiaofei.order.service.OrderItemService;
import com.xiaofei.order.service.OrderService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 *
 */
@Service
public class OrderItemServiceImpl extends ServiceImpl<OrderItemMapper, OrderItemEntity> implements OrderItemService {

    @Autowired
    private OrderService orderService;

    /**
     * 根据查询条件查询订单信息【查询订单===>查询订单项】
     *
     * @param userId           用户id
     * @param username         用户名
     * @param orderItemQueryVo 订单项查询条件
     * @return 返回订单项查询结果
     */
    @Override
    public PageVo<OrderItemResp> queryOrderItemInfo(Long userId, String username, OrderItemQueryVo orderItemQueryVo) {

        QueryWrapper<OrderEntity> orderQuery = new QueryWrapper<>();

        orderQuery.eq("member_id", userId).eq("member_username", username).orderByDesc("id");

        return orderBaseQuery(orderQuery, orderItemQueryVo);
    }

    /**
     * 内部系统查询所有订单信息
     *
     * @param orderItemQueryVo 订单项的检索条件
     * @return 返回检索到的信息
     */
    @Override
    public PageVo<OrderItemResp> queryAllByPage(OrderItemQueryVo orderItemQueryVo) {

        return orderBaseQuery(new QueryWrapper<>(), orderItemQueryVo);

    }

    /**
     * 内部订单查询条件和外部订单查询的公共部分
     *
     * @param orderQuery       各自不同的查询条件
     * @param orderItemQueryVo 订单项查询条件
     * @return 返回订单项目的查询条件
     */
    private PageVo<OrderItemResp> orderBaseQuery(QueryWrapper<OrderEntity> orderQuery, OrderItemQueryVo orderItemQueryVo) {

        PageHelper.startPage(orderItemQueryVo.getPageNo(), orderItemQueryVo.getPageSize());

        if (!StringUtils.isEmpty(orderItemQueryVo.getOrderSn())) {
            orderQuery.eq("order_sn", orderItemQueryVo.getOrderSn());
        }

        if (orderItemQueryVo.getOrderStatus() != null) {
            OrderStatusEnum status = OrderStatusEnum.getStatus(orderItemQueryVo.getOrderStatus());
            if (status != null) {
                Byte statusId = status.getStatusId();
                orderQuery.eq("status", statusId);
            }
        }

        if (orderItemQueryVo.getAddTime() != null) {
            orderQuery.le("create_time", orderItemQueryVo.getAddTime());
        }


        List<OrderEntity> orderEntitys = orderService.list(orderQuery);//分页查询订单项
        PageInfo<OrderEntity> pageInfo = new PageInfo<>(orderEntitys);

        List<OrderItemResp> items = pageInfo.getList().stream().map(orderEntity -> {
            OrderItemResp orderItemResp = new OrderItemResp();

            Long orderId = orderEntity.getId();
            String orderSn = orderEntity.getOrderSn();
            List<OrderItemEntity> orderItems = this.list(new QueryWrapper<OrderItemEntity>()
                    .eq("order_id", orderId).eq("order_sn", orderSn));

            orderItemResp.setOrderEntity(orderEntity);
            orderItemResp.setOrderItemEntitys(orderItems);
            return orderItemResp;

        }).collect(Collectors.toList());

        return new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal(), items);

    }
}




