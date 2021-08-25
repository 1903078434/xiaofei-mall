package com.xiaofei.common.member.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 会员收货地址
 */
@Data
@TableName("ums_member_receive_address")
public class MemberReceiveAddressEntity implements Serializable {
    /**
     * id
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * member_id
     */
    private Long memberId;

    /**
     * 收货人姓名
     */
    private String name;

    /**
     * 电话
     */
    private String phone;

    /**
     * 邮政编码
     */
    private String postCode;

    /**
     * 省份/直辖市
     */
    private String province;

    /**
     * 城市
     */
    private String city;

    /**
     * 区
     */
    private String region;

    /**
     * 详细地址(街道)
     */
    private String detailAddress;

    /**
     * 省市区代码
     */
    private String areacode;

    /**
     * 地区id
     */
    private Integer provincesId;

    /**
     * 是否默认，0不是默认，非0是默认
     */
    private Integer defaultStatus;

    @JsonInclude(JsonInclude.Include.NON_EMPTY)//如果该属性的值为空，将不会带上该值
    @TableField(exist = false)
    private List<Integer> provincesPath;
}
