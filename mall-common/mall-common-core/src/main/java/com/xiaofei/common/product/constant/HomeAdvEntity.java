package com.xiaofei.common.product.constant;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 *
 * @TableName home_adv
 */
@TableName(value ="home_adv")
@Data
public class HomeAdvEntity implements Serializable {
    /**
     * 首页广告、轮播图id
     */
    @TableId(type = IdType.AUTO)
    private Long advId;

    /**
     * 轮播图名字
     */
    private String advName;

    /**
     * 图片地址
     */
    private String advPic;

    /**
     * 状态【0：禁用。1：启用】
     */
    private Byte status;

    /**
     * 备注
     */
    private String note;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 广告类别【0：PC首页轮播图。1：手机首页轮播图。2：PC首页头部广告。3、手机首页广告。4：PC左侧广告】
     */
    private Byte advType;

    /**
     * 开始时间
     */
    private LocalDateTime startTime;

    /**
     * 结束时间
     */
    private LocalDateTime endTime;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
