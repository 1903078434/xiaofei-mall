package com.xiaofei.common.product.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;

/**
 * User: 李飞
 * Date: 2021/7/31
 * Time: 14:57
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("spu检索信息")
public class SpuInfoVo extends BasePage {

    @ApiModelProperty("商品Id")
    private Long id;

    @ApiModelProperty("商品名称")
    private String spuName;

    @ApiModelProperty("商品描述")
    private String spuDescription;

    @ApiModelProperty("所属分类id")
    private Long catalogId;

    @ApiModelProperty("品牌id")
    private Long brandId;

    @ApiModelProperty("商品重量")
    private BigDecimal weight;

    @ApiModelProperty("上架状态[0 - 下架，1 - 上架]")
    private Integer publishStatus;

    @ApiModelProperty("商品创建时间")
    private Date createTime;

    @ApiModelProperty("商品修改时间")
    private Date updateTime;
}
