package com.xiaofei.es;

import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;

/**
 * User: 李飞
 * Date: 2021/11/24
 * Time: 17:04
 */
public class Test1 {
    @Test
    void test1(){
        System.out.println(LocalDateTime.now().toString().replace("T"," "));
    }
}
