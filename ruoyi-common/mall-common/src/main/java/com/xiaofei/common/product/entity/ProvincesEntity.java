package com.xiaofei.common.product.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/13
 * Time: 14:10
 */
@Data
@TableName("provinces")
public class ProvincesEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;//id

    private String cityName;//城市名称

    private Integer parentId;//父级id

    private String shortName;//城市缩写名称

    private Integer depth;//城市层级

    private String cityCode;//城市代码

    private String zipCode;//城市邮编

    private String mergerName;//城市组合名称

    private String longitude;//精度

    private String latitude;//维度

    private String pinyin;//城市拼音

    private Integer isUse;//is_use

    /**
     * 将当前菜单的所有子分类都放到这个children属性里面
     */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)//如果该属性的值为空，将不会带上该值
    @TableField(exist = false)
    private List<ProvincesEntity> children;//地区字典的子节点
}
