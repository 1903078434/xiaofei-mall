package com.xiaofei.common.product.enums;

/**
 * User: 李飞
 * Date: 2021/9/20
 * Time: 15:45
 */
public enum AdvEnum {
    PC_CAROUSEL((byte) 0, "PC端轮播图"),
    APP_CAROUSEL((byte) 1, "手机轮播图"),
    PC_TOP_ADV((byte) 2, "PC顶部广告"),
    APP_TOP_ADV((byte) 3, "手机顶部广告"),
    ;

    AdvEnum(Byte advType, String advTypeName) {
        this.advType = advType;
        this.advTypeName = advTypeName;
    }

    public static AdvEnum getAdv(Byte advType) {
        if (advType == 0) {
            return PC_CAROUSEL;
        } else if (advType == 1) {
            return APP_CAROUSEL;
        } else if (advType == 2) {
            return PC_TOP_ADV;
        } else if (advType == 3) {
            return APP_TOP_ADV;
        } else {
            return null;
        }
    }

    private Byte advType;
    private String advTypeName;

    public Byte getAdvType() {
        return advType;
    }

    public String getAdvTypeName() {
        return advTypeName;
    }
}
