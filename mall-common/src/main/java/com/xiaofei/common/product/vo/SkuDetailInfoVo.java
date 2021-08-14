package com.xiaofei.common.product.vo;

import com.xiaofei.common.product.entity.BrandEntity;
import com.xiaofei.common.product.entity.SkuImagesEntity;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.entity.SpuInfoDescEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/12
 * Time: 14:52
 */
@Data
@ApiModel("商品详情页面的信息")
public class SkuDetailInfoVo {

    @ApiModelProperty("sku的基本信息")
    private SkuInfoEntity skuInfo;

    @ApiModelProperty("sku的图片信息")
    private List<SkuImagesEntity> skuImages;

    @ApiModelProperty("spu的销售属性组合")
    List<SkuItemSaleAttrVo> saleAttr;

    @ApiModelProperty("spu的描述图片集合")
    private SpuInfoDescEntity spuInfoDesc;

    @ApiModelProperty("spu的每一组基本属性")
    private List<SpuItemBaseAttrGroupVo> groupAttrs;

    @ApiModelProperty("品牌信息")
    private BrandEntity brand;

    @ApiModelProperty("随机获取的数据")
    private List<SkuInfoEntity> randSkuInfos;

    @ApiModelProperty("是否有货")
    private boolean hasStock = true;//如果没有查询默认有货

    @Data
    @ApiModel("所有的销售属性集合，例如版本有：8+128，8+256等")
    public static class SkuItemSaleAttrVo {
        @ApiModelProperty("销售属性集合")
        private Long attrId;
        @ApiModelProperty("销售属性名称")
        private String attrName;
        @ApiModelProperty("销售属性值")
        private List<AttrValueWithSkuIdVo> attrValues;
    }

    @Data
    @ApiModel("商品的基本属性分组和值")
    public static class SpuItemBaseAttrGroupVo {
        @ApiModelProperty("属性分组名称")
        private String groupName;
        @ApiModelProperty("对应属性分组下的属性值")
        private List<SpuBaseAttrVo> attrs;
    }

    @Data
    @ApiModel("商品的基本属性值")
    public static class SpuBaseAttrVo {
        @ApiModelProperty("基本属性名称")
        private String attrName;
        @ApiModelProperty("基本属性值")
        private String attrValue;
    }

    @Data
    @ApiModel("销售属性")
    public static class AttrValueWithSkuIdVo {
        @ApiModelProperty("销售属性的值")
        private String attrValue;
        @ApiModelProperty("哪个sku下有该销售属性")
        private String skuIds;
    }

}
