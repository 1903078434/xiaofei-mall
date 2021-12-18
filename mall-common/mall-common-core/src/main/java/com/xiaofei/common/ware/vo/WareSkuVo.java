package com.xiaofei.common.ware.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 19:24
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("库存信息")
public class WareSkuVo extends BasePage {

    @ApiModelProperty("库存id")
    private Long id;

    @ApiModelProperty("skuId")
    private Long skuId;

    @ApiModelProperty("仓库id")
    private Long wareId;

    @ApiModelProperty("库存数")
    private Integer stock;

    @ApiModelProperty("sku名称")
    private String skuName;

    @ApiModelProperty("锁定库存")
    private Integer stockLocked;

}
