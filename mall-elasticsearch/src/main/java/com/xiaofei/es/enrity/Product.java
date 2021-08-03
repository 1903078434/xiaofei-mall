package com.xiaofei.es.enrity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

/**
 * User: 李飞
 * Date: 2021/8/3
 * Time: 15:24
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(indexName = "product")//指定和es中哪个索引绑定
public class Product {

    @Id
    private Long id;//商品唯一标识

    @Field(type = FieldType.Text)
    private String title;//商品名称

    @Field(type = FieldType.Text)
    private String category;//分类名称

    @Field(type = FieldType.Double)
    private Double price;//商品价格

    @Field(type = FieldType.Keyword)//keyword：该数据为一个单词，不需要分割
    private String images;//图片地址
}
