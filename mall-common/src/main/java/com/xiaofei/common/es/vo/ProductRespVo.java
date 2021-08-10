package com.xiaofei.common.es.vo;

import com.xiaofei.common.dto.SkuESDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/10
 * Time: 22:02
 */
@Data
@ApiModel("返回查询出来的商品信息")
public class ProductRespVo {

    @ApiModelProperty("能够搜索的属性信息")
    private Map<String, Object> searchConditions;

    @ApiModelProperty("搜索到的商品信息")
    private List<SkuESDto> items;
}
