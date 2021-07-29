package com.xiaofei.common.member.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

/**
 * User: 李飞
 * Date: 2021/7/29
 * Time: 21:04
 */
@EqualsAndHashCode(callSuper = true)
@ApiModel("会员等级")
@Data
public class MemberLevelVo extends BasePage {

    @ApiModelProperty("会员等级id")
    private Long id;

    @ApiModelProperty("等级名称")
    private String name;

    @ApiModelProperty("等级需要的成长值")
    private Integer growthPoint;

    @ApiModelProperty("是否为默认等级[0->不是；1->是]")
    private Integer defaultStatus;

    @ApiModelProperty("免运费标准")
    private BigDecimal freeFreightPoint;

    @ApiModelProperty("每次评价获取的成长值")
    private Integer commentGrowthPoint;

    @ApiModelProperty("是否有免邮特权")
    private Integer priviledgeFreeFreight;

    @ApiModelProperty("是否有会员价格特权")
    private Integer priviledgeMemberPrice;

    @ApiModelProperty("是否有生日特权")
    private Integer priviledgeBirthday;

    @ApiModelProperty("备注")
    private String note;

}
