package com.xiaofei.common.dto;

import com.xiaofei.common.product.vo.spu.MemberPrice;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/30
 * Time: 21:14
 */
@Data
public class SkuReductionDto {
    private Long skuId;
    private int fullCount;
    private BigDecimal discount;
    private int countStatus;
    private BigDecimal fullPrice;
    private BigDecimal reducePrice;
    private int priceStatus;
    private List<MemberPrice> memberPrice;
}
