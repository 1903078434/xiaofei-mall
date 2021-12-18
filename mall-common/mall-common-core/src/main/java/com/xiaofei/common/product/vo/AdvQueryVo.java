package com.xiaofei.common.product.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * User: 李飞
 * Date: 2021/9/20
 * Time: 14:26
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("广告查询需要的信息")
public class AdvQueryVo extends BasePage {

    @ApiModelProperty("广告类别")
    private Byte advType;

}
