package com.xiaofei.cart.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * User: 李飞
 * Date: 2021/8/18
 * Time: 22:07
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Document("cart_test")
public class CartTest {

    @Id
    private String id;

    private String username;

    private String password;
}
