
package com.xiaofei.common.product.vo.spu;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("sku图片")
@Data
public class Image {

    @ApiModelProperty("sku图片地址")
    private String imgUrl;

    @ApiModelProperty("是否为默认图片：1，默认图片。0，不是默认图片")
    private int defaultImg;
}
