package com.xiaofei.cart;

import com.xiaofei.cart.entity.CartTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import java.util.UUID;

@SpringBootTest
class MallCartApplicationTests {

    @Autowired
    private MongoTemplate mongoTemplate;

    @DisplayName("插入文档")
    @Test
    void contextLoads() {
        CartTest cartTest = new CartTest(UUID.randomUUID().toString().replace("-", "")
                , "12345", "67891");
        System.out.println(mongoTemplate.insert(cartTest));
    }

    @DisplayName("修改文档")
    @Test
    public void insertDoc() {
        //Query query = new Query().addCriteria(Criteria.where("id").is("9e596869708741ab957a8ff4367f9522"));
        Query query = new Query();
        Update update = new Update();
        update.set("username","111");
        update.set("password","222");
        System.out.println(mongoTemplate.updateMulti(query, update, CartTest.class).getMatchedCount());
    }

}
