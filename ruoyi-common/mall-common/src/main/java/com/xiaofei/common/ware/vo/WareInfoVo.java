package com.xiaofei.common.ware.vo;

import com.xiaofei.common.vo.BasePage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 16:14
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("仓库信息")
public class WareInfoVo extends BasePage {

    @ApiModelProperty("仓库id")
    private String id;

    @ApiModelProperty("仓库名称")
    private String name;

    @ApiModelProperty("仓库地址")
    private String address;

    @ApiModelProperty("区域编码")
    private String areacode;

}
