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
@Document("cart_test")
@AllArgsConstructor
@NoArgsConstructor
public class CartTest {

    @Id
    private String id;

    private String username;

    private String password;
}
