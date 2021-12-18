
package com.xiaofei.common.product.vo.spu;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@ApiModel("sku信息")
public class Sku {

    @ApiModelProperty("销售属性")
    private List<SaleAttr> attr;

    @ApiModelProperty("商品名称：spuName + descar（所有销售属性的值）")
    private String skuName;

    @ApiModelProperty("价格")
    private BigDecimal price;

    @ApiModelProperty("标题")
    private String skuTitle;

    @ApiModelProperty("副标题")
    private String skuSubtitle;

    @ApiModelProperty("sku图集")
    private List<Image> images;

    @ApiModelProperty("所有销售属性的值")
    private List<String> descar;

    @ApiModelProperty("设置折扣：满几件")
    private int fullCount;

    @ApiModelProperty("设置折扣：满几件，打几折")
    private BigDecimal discount;

    @ApiModelProperty("能否叠加优惠：0，不能叠加")
    private int countStatus;

    @ApiModelProperty("设置优惠：满多少钱")
    private BigDecimal fullPrice;

    @ApiModelProperty("设置优惠：满多少钱，减多少")
    private BigDecimal reducePrice;

    @ApiModelProperty("能否叠加优惠：0，不能叠加")
    private int priceStatus;

    @ApiModelProperty("所有会员价格设置")
    private List<MemberPrice> memberPrice;

}
