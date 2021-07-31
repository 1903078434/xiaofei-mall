package com.xiaofei.common.product.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

/**
 * User: 李飞
 * Date: 2021/7/31
 * Time: 19:32
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("sku条件搜索VO")
public class SkuInfoVo extends BasePage {

    @ApiModelProperty("所属分类id")
    private Long catalogId;

    @ApiModelProperty("品牌id")
    private Long brandId;

    @ApiModelProperty("销量-【-1：降序。0：正常排序。1：升序】")
    private Long saleCount = 0L;

    @ApiModelProperty("搜索条件-最小价格")
    private BigDecimal minPrice;

    @ApiModelProperty("搜索条件-最大价格")
    private BigDecimal maxPrice;

}
