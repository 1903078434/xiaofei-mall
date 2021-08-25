package com.xiaofei.common.order.enums;

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
    CLOSE((byte) 4, "已取消"),
    INVALID_ORDER((byte) 5, "无效订单");


    OrderStatusEnum(Byte statusId, String statusName) {
        this.statusId = statusId;
        this.statusName = statusName;
    }

    private Byte statusId;
    private String statusName;

    public static OrderStatusEnum getStatus(Byte statusId) {
        if (statusId == 0) {
            return PENDING_PAYMENT;
        } else if (statusId == 1) {
            return TO_BE_SHIPPED;
        } else if (statusId == 2) {
            return SHIPPED;
        } else if (statusId == 3) {
            return COMPLETED;
        } else if (statusId == 4) {
            return CLOSE;
        } else if (statusId == 5) {
            return INVALID_ORDER;
        }
        return null;
    }

    public Byte getStatusId() {
        return statusId;
    }
}
