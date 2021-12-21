package com.xiaofei.es.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/9
 * Time: 19:32
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("搜索条件")
public class SearchVo extends BasePage {
    @ApiModelProperty("三级分类id")
    private Long categoryId;

    @ApiModelProperty("排序条件。0：综合排序，1：价格排序，2：销量排序，3：评论数量排序，4：上架时间。对应的整数为升序，负数为降序")
    private Integer sort = 0;

    @ApiModelProperty("是否有货。0：没有库存，1：有库存")
    private Integer hasStock;

    @ApiModelProperty("最低价格")
    private BigDecimal minPrice = new BigDecimal(0L);

    @ApiModelProperty("最高价格")
    private BigDecimal maxPrice = new BigDecimal(99999999999L);

    @ApiModelProperty("品牌id集合")
    private List<Long> brandId;

    @ApiModelProperty("属性id集合")
    private List<Long> attrId;

}
