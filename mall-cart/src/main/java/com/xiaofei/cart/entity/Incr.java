package com.xiaofei.cart.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * User: 李飞
 * Date: 2021/8/20
 * Time: 9:10
 */
@Document
@Data
public class Incr {
    @Id
    private String id;
    private String collectionName;
    private Long incrId;

}
