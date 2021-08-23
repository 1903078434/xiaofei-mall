package com.xiaofei.common.order.constant;

/**
 * 订单来源
 * User: 李飞
 * Date: 2021/8/23
 * Time: 22:46
 */
public enum OrderSourceEnum {
    PC_SOURCE((byte)0, "PC订单"),
    APP_SOURCE((byte)1, "app订单");

    OrderSourceEnum(Byte sourceId, String sourceName) {
        this.sourceId = sourceId;
        this.sourceName = sourceName;
    }

    private Byte sourceId;
    private String sourceName;

    public Byte getSourceId() {
        return sourceId;
    }
}
