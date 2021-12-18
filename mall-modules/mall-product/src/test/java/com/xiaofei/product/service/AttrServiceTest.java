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

    @Test
    public void test1(){
        String str="spring:\n" +
                "  redis:\n" +
                "    host: 127.0.0.1\n" +
                "    port: 6379\n" +
                "    password: \n" +
                "  cloud:\n" +
                "    gateway:\n" +
                "      discovery:\n" +
                "        locator:\n" +
                "          lowerCaseServiceId: true\n" +
                "          enabled: true\n" +
                "      routes:\n" +
                "        # 商品服务\n" +
                "        - id: mall-product\n" +
                "          uri: lb://mall-product\n" +
                "          predicates:\n" +
                "            - Path=/product/**\n" +
                "\n" +
                "        # 订单服务\n" +
                "        - id: mall-order\n" +
                "          uri: lb://mall-order\n" +
                "          predicates:\n" +
                "            - Path=/order/**\n" +
                "\n" +
                "        # 检索服务-转发到elastic search中\n" +
                "        - id: mall-elasticsearch\n" +
                "          uri: lb://mall-elasticsearch\n" +
                "          predicates:\n" +
                "            - Path=/elasticsearch/**\n" +
                "\n" +
                "        # 库存服务\n" +
                "        - id: mall-ware\n" +
                "          uri: lb://mall-ware\n" +
                "          predicates:\n" +
                "            - Path=/ware/**\n" +
                "\n" +
                "        # 会员服务\n" +
                "        - id: mall-member\n" +
                "          uri: lb://mall-member\n" +
                "          predicates:\n" +
                "            - Path=/member/**\n" +
                "\n" +
                "        # 第三方服务：比如，阿里文件上传\n" +
                "        - id: mall-third-part\n" +
                "          uri: lb://mall-third-part\n" +
                "          predicates:\n" +
                "            - Path=/thirdpart/**\n" +
                "            \n" +
                "        # 认证中心\n" +
                "        - id: ruoyi-auth\n" +
                "          uri: lb://ruoyi-auth\n" +
                "          predicates:\n" +
                "            - Path=/auth/**\n" +
                "          filters:\n" +
                "            # 验证码处理\n" +
                "            - CacheRequestFilter\n" +
                "            - ValidateCodeFilter\n" +
                "            - StripPrefix=1\n" +
                "        # 代码生成\n" +
                "        - id: ruoyi-gen\n" +
                "          uri: lb://ruoyi-gen\n" +
                "          predicates:\n" +
                "            - Path=/code/**\n" +
                "          filters:\n" +
                "            - StripPrefix=1\n" +
                "        # 定时任务\n" +
                "        - id: ruoyi-job\n" +
                "          uri: lb://ruoyi-job\n" +
                "          predicates:\n" +
                "            - Path=/schedule/**\n" +
                "          filters:\n" +
                "            - StripPrefix=1\n" +
                "        # 系统模块\n" +
                "        - id: ruoyi-system\n" +
                "          uri: lb://ruoyi-system\n" +
                "          predicates:\n" +
                "            - Path=/system/**\n" +
                "          filters:\n" +
                "            - StripPrefix=1\n" +
                "        # 文件服务\n" +
                "        - id: ruoyi-file\n" +
                "          uri: lb://ruoyi-file\n" +
                "          predicates:\n" +
                "            - Path=/file/**\n" +
                "          filters:\n" +
                "            - StripPrefix=1\n" +
                "\n" +
                "\n" +
                "\n" +
                "\n" +
                "# 不校验白名单\n" +
                "ignore:\n" +
                "  whites:\n" +
                "    - /auth/logout\n" +
                "    - /auth/login\n" +
                "    - /*/v2/api-docs\n" +
                "    - /csrf\n" +
                "    - /thirdpart/**\n" +
                "    - /code\n";
        System.out.println(str);
    }

}
