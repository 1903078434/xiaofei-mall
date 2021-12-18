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
    private Integer fullCount;//满几件
    private BigDecimal discount;//打几折
    private Integer countStatus;//满几件打几折，是否可叠加优惠
    private BigDecimal skuPrice;//商品价格
    private BigDecimal fullPrice;//满多少
    private BigDecimal reducePrice;//减多少
    private Integer priceStatus;//满多少减多少中的是否可叠加优惠
    private List<MemberPrice> memberPrice;//会员价格
}
