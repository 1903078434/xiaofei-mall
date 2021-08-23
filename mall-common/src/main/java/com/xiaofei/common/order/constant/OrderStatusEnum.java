package com.xiaofei.common.order.constant;

/**
 * 订单状态
 * User: 李飞
 * Date: 2021/8/23
 * Time: 22:51
 */
public enum OrderStatusEnum {
    PENDING_PAYMENT((byte) 0, "待付款"),
    TO_BE_SHIPPED((byte) 1, "待发货"),
    SHIPPED((byte) 2, "已发货"),
    COMPLETED((byte) 3, "已完成"),
    CLOSE((byte) 4, "已关闭"),
    INVALID_ORDER((byte) 5, "无效订单");


    OrderStatusEnum(Byte statusId, String statusName) {
        this.statusId = statusId;
        this.statusName = statusName;
    }

    private Byte statusId;
    private String statusName;

    public Byte getStatusId() {
        return statusId;
    }
}
