package com.xiaofei.member.test;

import com.xiaofei.member.service.MemberReceiveAddressService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * User: 李飞
 * Date: 2021/8/22
 * Time: 18:32
 */
@SpringBootTest
public class MemberTest {
    @Autowired
    private MemberReceiveAddressService memberReceiveAddressService;

    @DisplayName("根据收获地址id查询收获地址的详细信息")
    @Test
    void getAddressInfo(){
        System.out.println(memberReceiveAddressService.getReceiveAddressById(1, 2L));
    }
}
