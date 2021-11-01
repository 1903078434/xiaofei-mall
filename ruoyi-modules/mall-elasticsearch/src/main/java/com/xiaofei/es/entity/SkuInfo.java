package com.xiaofei.es.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

/**
 * User: 李飞
 * Date: 2021/8/2
 * Time: 22:45
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(indexName = "product")
public class SkuInfo {

    @Id
    private Long skuId;

    @Field(type = FieldType.Text)
    private String skuName;

    @Field(type = FieldType.Text)
    private String imgUrl;

    @Field(type = FieldType.Date , pattern = "dd.MM.uuuu")
    private Long createDate;
}
