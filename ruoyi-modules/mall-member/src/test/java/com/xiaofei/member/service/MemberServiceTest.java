package com.xiaofei.member.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaofei.common.member.entity.MemberEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootTest
class MemberServiceTest {

    @Autowired
    private MemberService memberService;

    @Test
    void queryMemberDetailInfo() {
        memberService.queryMemberDetailInfo(2L, "1903078434");
    }

    @Test
    void test1() {
        MemberEntity memberEntity = memberService.getOne(new QueryWrapper<MemberEntity>()
                .eq("id", 2).eq("username", 1903078434));
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        System.out.println(passwordEncoder.matches("1903078434", memberEntity.getPassword()));
    }
}
