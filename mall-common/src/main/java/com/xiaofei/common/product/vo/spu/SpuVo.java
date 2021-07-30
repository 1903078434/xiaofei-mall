package com.xiaofei.common.product.vo.spu;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@ApiModel("spu保存")
@Data
public class SpuVo {

    @ApiModelProperty("spu名称")
    private String spuName;

    @ApiModelProperty("spu描述信息")
    private String spuDescription;

    @ApiModelProperty("类别id")
    private Long catalogId;

    @ApiModelProperty("品牌id")
    private Long brandId;

    @ApiModelProperty("商品重量")
    private double weight;

    @ApiModelProperty("发布状态")
    private int publishStatus;

    @ApiModelProperty("商品介绍图集地址")
    private List<String> decript;

    @ApiModelProperty("商品图集地址")
    private List<String> images;

    @ApiModelProperty("购买所得积分")
    private Bounds bounds;

    @ApiModelProperty("基本属性")
    private List<BaseAttr> baseAttrs;

    @ApiModelProperty("sku的基本信息")
    private List<Sku> skus;

}
