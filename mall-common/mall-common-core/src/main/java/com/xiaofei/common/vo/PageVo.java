package com.xiaofei.common.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * 用于接收分页的信息的
 * User: 李飞
 * Date: 2021/7/25
 * Time: 19:39
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("分页信息")
public class PageVo<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty("当前页码")
    private Integer pageNo = 1;

    @ApiModelProperty("每页显示的数量")
    private Integer pageSize = 8;

    @ApiModelProperty("总页码")
    private Integer pageTotal = 1;

    @ApiModelProperty("商品的总数量")
    private Long itemCount = 0L;

    @ApiModelProperty("当前页数据集合")
    private List<T> items;

    @ApiModelProperty("当前页数据")
    private T item;

    /**
     * 没有聚合信息构造函数
     */
    public PageVo(Integer pageNo, Integer pageSize, Integer pageTotal, Long itemCount, List<T> items) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.pageTotal = pageTotal;
        this.itemCount = itemCount;
        this.items = items;
    }

    public PageVo(Integer pageNo, Integer pageSize, Integer pageTotal, Long itemCount, T item) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.pageTotal = pageTotal;
        this.itemCount = itemCount;
        this.item = item;
    }

    public PageVo(Integer pageNo, Integer pageSize, Integer pageTotal, Long itemCount) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.pageTotal = pageTotal;
        this.itemCount = itemCount;
    }

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
