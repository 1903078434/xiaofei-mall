package com.xiaofei.common.order.constant;

/**
 * 订单删除状态
 * User: 李飞
 * Date: 2021/8/23
 * Time: 23:03
 */
public enum OrderDelStatusEnum {

    NOT_DELETE((byte)0,"未删除"),
    UN_DELETE((byte)1,"已删除");
    OrderDelStatusEnum(Byte delId, String delName) {
        this.delId = delId;
        this.delName = delName;
    };

    private Byte delId;
    private String delName;

    public Byte getDelId() {
        return delId;
    }
}
