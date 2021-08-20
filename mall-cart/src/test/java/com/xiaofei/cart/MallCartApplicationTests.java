package com.xiaofei.cart;

import com.xiaofei.cart.service.CartService;
import com.xiaofei.cart.entity.CartTest;
import com.xiaofei.cart.vo.CartRespVo;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

@SpringBootTest
class MallCartApplicationTests {

    @Autowired
    private CartService cartService;

    @Autowired
    private MongoTemplate mongoTemplate;

    @DisplayName("查询购物车信息")
    @Test
    void queryCartInfo(){
        CartRespVo cartRespVo = cartService.queryCartByUserId(2L);
        System.out.println(cartRespVo);
        cartRespVo.getItems().forEach(System.out::println);
    }

    @DisplayName("插入文档")
    @Test
    void contextLoads() {
        CartTest cartTest = new CartTest();
        cartTest.setUsername("1222222222345");
        cartTest.setPassword("62222222227891");
        System.out.println(mongoTemplate.insert(cartTest));
    }

    @DisplayName("修改文档")
    @Test
    public void insertDoc() {
        //Query query = new Query().addCriteria(Criteria.where("id").is("9e596869708741ab957a8ff4367f9522"));
        Query query = new Query();
        Update update = new Update();
        update.set("username", "111");
        update.set("password", "222");
        System.out.println(mongoTemplate.updateMulti(query, update, CartTest.class).getMatchedCount());
    }

}
