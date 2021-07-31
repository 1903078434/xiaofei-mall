package com.xiaofei.common.dto;

import com.xiaofei.common.product.vo.spu.MemberPrice;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:14
 */
@Data
@ApiModel("满减信息和折扣信息")
public class SkuReductionDto {
    private Long skuId;
    private int fullCount;
    private BigDecimal discount;
    private int countStatus;
    private BigDecimal skuPrice;
    private BigDecimal fullPrice;
    private BigDecimal reducePrice;
    private int priceStatus;
    private List<MemberPrice> memberPrice;
}
