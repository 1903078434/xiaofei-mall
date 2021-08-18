package com.xiaofei.cart;

import com.xiaofei.cart.entity.CartTest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.UUID;

@SpringBootTest
class MallCartApplicationTests {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Test
    void contextLoads() {
        CartTest cartTest = new CartTest(UUID.randomUUID().toString().replace("-", "")
        ,"12345","67891");
        System.out.println(mongoTemplate.insert(cartTest));
    }

}
