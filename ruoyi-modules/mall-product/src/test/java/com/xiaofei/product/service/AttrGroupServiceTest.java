package com.xiaofei.product.service;

import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.vo.AttrAndAttrGroupVo;
import com.xiaofei.common.product.vo.AttrGroupVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/26
 * Time: 19:37
 */
@SpringBootTest
public class AttrGroupServiceTest {

    @Autowired
    private AttrGroupService attrGroupService;

    @Test
    void queryByPage() {
        AttrGroupVo attrGroupVo = new AttrGroupVo();
        attrGroupVo.setPageNo(1);
        attrGroupVo.setPageSize(4);
        PageVo<AttrGroupEntity> page = attrGroupService.queryByPage(attrGroupVo);
        System.out.println(page);
    }

    /**
     * 获取指定类别下的属性，和分组信息
     */
    @Test
    void queryAttrGroupWithAttr() {
        List<AttrAndAttrGroupVo> items = attrGroupService.queryAttrGroupWithAttr(225L);
        items.forEach(item -> item.getAttrs().forEach(System.out::println));
    }
}
