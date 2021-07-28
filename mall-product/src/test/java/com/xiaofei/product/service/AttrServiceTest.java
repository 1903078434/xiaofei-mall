package com.xiaofei.product.service;

import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * 商品类别
 * User: 李飞
 * Date: 2021/7/23
 * Time:
 */
@SpringBootTest
public class AttrServiceTest {

    @Autowired
    private AttrService attrService;

    @Test
    void queryBaseAttr() {
        AttrVo attrVo = new AttrVo();
        attrVo.setPageNo(1);
        attrVo.setPageSize(8);
        PageVo<AttrVo> pageVo = attrService.queryBaseAttr(attrVo, 1);
        System.out.println(pageVo);
    }

    @Test
    void queryAttrGroupById() {
        AttrVo attrVo = attrService.queryAttrById(1L);
        System.out.println(attrVo);
    }

}
