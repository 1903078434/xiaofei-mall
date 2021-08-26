package com.xiaofei.common.member.enums;

/**
 * 会员状态
 * User: 李飞
 * Date: 2021/8/26
 * Time: 18:17
 */
public enum MemberStatusEnum {
    DISABLE( 0, "禁用"),
    ENABLE(1, "启用");

    MemberStatusEnum(Integer status, String name) {
        this.status = status;
        this.name = name;
    }

    public static MemberStatusEnum getStatus(Integer statusId) {
        if (statusId == 0) {
            return DISABLE;
        } else if (statusId == 1) {
            return ENABLE;
        }
        return null;
    }

    private Integer status;
    private String name;

    public Integer getStatus() {
        return status;
    }

    public String getName() {
        return name;
    }
}
