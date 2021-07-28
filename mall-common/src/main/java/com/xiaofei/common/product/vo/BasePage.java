package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * User: 李飞
 * Date: 2021/7/28
 * Time: 14:40
 */
@Data
@ApiModel("分页基本参数和搜索条件")
public class BasePage {

    @ApiModelProperty("当前页码")
    private Integer pageNo = 1;

    @ApiModelProperty("每页显示的数量")
    private Integer pageSize = 8;

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
