package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * User: 李飞
 * Date: 2021/7/25
 * Time: 17:11
 */
@Data
@ApiModel("商家信息")
@AllArgsConstructor
@NoArgsConstructor
public class BrandVo {

    @ApiModelProperty("品牌id")
    private Long brandId;

    @ApiModelProperty("品牌名")
    private String name;

    @ApiModelProperty("品牌logo地址")
    private String logo;

    @ApiModelProperty("介绍")
    private String descript;

    @ApiModelProperty("显示状态[0-不显示；1-显示]")
    private int showStatus;

    @ApiModelProperty("检索首字母")
    private String firstLetter;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("当前页码")
    private Integer pageNo = 1;

    @ApiModelProperty("每页显示的数量")
    private Integer pageSize = 10;

    @ApiModelProperty("搜索条件")
    private String searchValue;

    public void setPageSize(Integer pageSize) {
        if (pageSize > 500) {
            this.pageSize = 500;
        } else {
            if (pageSize <= 0) {
                this.pageSize = 1;
            } else {
                this.pageSize = pageSize;
            }
        }
    }

}
