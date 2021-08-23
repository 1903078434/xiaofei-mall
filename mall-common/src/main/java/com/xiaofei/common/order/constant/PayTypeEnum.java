package com.xiaofei.common.order.constant;

/**
 * 支付方式
 * User: 李飞
 * Date: 2021/8/23
 * Time: 22:38
 */
public enum PayTypeEnum {
    ALI_PAY((byte) 1,"支付宝"),
    WATCH_PAY((byte)2,"微信"),
    UNION_PAY((byte)3,"银联"),
    FACE_TO_FACE_PAY((byte)4,"货到付款"),
    BANK_PAY((byte)5,"银行卡支付");

    PayTypeEnum(Byte payId, String payName) {
        this.payId = payId;
        this.payName = payName;
    }

    private Byte payId;
    private String payName;

    public Byte getPayId() {
        return payId;
    }
}
