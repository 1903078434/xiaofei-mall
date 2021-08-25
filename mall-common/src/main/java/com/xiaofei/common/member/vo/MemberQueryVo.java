package com.xiaofei.common.member.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * 查询用户信息需要的参数
 * User: 李飞
 * Date: 2021/8/25
 * Time: 22:11
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("查询会员信息")
public class MemberQueryVo extends BasePage {

    private Long id;

    private Byte levelId;

    private String mobile;

    private String email;

    private Byte gender;

    private LocalDateTime birth;

}
