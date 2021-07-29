package com.xiaofei.product.service;

import com.xiaofei.common.product.vo.AttrVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * User: 李飞
 * Date: 2021/7/28
 * Time: 17:02
 */
@SpringBootTest
public class AttrAttrgroupRelationServiceTest {

    @Autowired
    private AttrAttrgroupRelationService attrAttrgroupRelationService;

    /**
     * 根据属性分组id查询该分组绑定的所有属性信息
     */
    @Test
    void queryRelationByAttrGroupId() {
        attrAttrgroupRelationService.queryRelationByAttrGroupId(1L).forEach(System.out::println);
    }

    /**
     * 根据已关联的信息，查询未关联的属性
     */
    @Test
    void queryNoRelationAttr() {
        AttrVo attrVo = new AttrVo();

        PageVo<AttrVo> pageVo = attrAttrgroupRelationService.queryNoRelationAttr(attrVo);
        System.out.println(pageVo);
        pageVo.getItems().forEach(System.out::println);
    }

}
