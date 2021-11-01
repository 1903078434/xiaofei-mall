
package com.xiaofei.common.product.vo.spu;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

@Data
@ApiModel("会员价格信息")
public class MemberPrice {

    @ApiModelProperty("会员等级id")
    private Long id;

    @ApiModelProperty("会员等级名称")
    private String name;

    @ApiModelProperty("指定会员等级价格")
    private BigDecimal price;

}
