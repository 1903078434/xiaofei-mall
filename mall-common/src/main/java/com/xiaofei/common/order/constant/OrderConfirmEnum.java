package com.xiaofei.common.order.constant;

/**
 * 订单收货状态
 * User: 李飞
 * Date: 2021/8/23
 * Time: 22:59
 */
public enum OrderConfirmEnum {
    NOT_CONFIRM((byte) 0, "未确认"),
    UN_CONFIRM((byte) 1, "已确认");

    OrderConfirmEnum(Byte confirmId, String confirmName) {
        this.confirmId = confirmId;
        this.confirmName = confirmName;
    }

    private Byte confirmId;
    private String confirmName;

    public Byte getConfirmId() {
        return confirmId;
    }
}
