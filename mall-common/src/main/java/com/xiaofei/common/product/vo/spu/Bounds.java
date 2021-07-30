
package com.xiaofei.common.product.vo.spu;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

@Data
@ApiModel("购买所得积分")
public class Bounds {

    @ApiModelProperty("购买所得金币，相当于京东的京豆")
    private BigDecimal buyBounds;

    @ApiModelProperty("购买所得成长积分，可以用于升级会员")
    private BigDecimal growBounds;

}
