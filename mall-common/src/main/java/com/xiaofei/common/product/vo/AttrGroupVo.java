package com.xiaofei.common.product.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 属性分组
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-06-26 23:39:45
 */
@Data
@ApiModel("属性分组")
public class AttrGroupVo {

    @ApiModelProperty("分组id")
    private Long attrGroupId;

    @ApiModelProperty("组名")
    private String attrGroupName;

    @ApiModelProperty("排序")
    private Integer sort;

    @ApiModelProperty("描述")
    private String descript;

    @ApiModelProperty("组图标")
    private String icon;

    @ApiModelProperty("所属分类id")
    private Long catelogId;

    @ApiModelProperty("当前页码")
    private Integer pageNo = 1;

    @ApiModelProperty("每页显示的数量")
    private Integer pageSize = 10;

    @ApiModelProperty("搜索条件")
    private String searchValue;

    @ApiModelProperty("级联选择器路径")
    private Long[] categoryPath;


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
