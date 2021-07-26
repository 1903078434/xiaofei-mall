package com.xiaofei.product.service;

import com.xiaofei.common.product.entity.AttrGroupEntity;
import com.xiaofei.common.product.vo.AttrGroupVo;
import com.xiaofei.common.vo.PageVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

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
}
