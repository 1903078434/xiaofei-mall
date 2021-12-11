/*
 Navicat Premium Data Transfer

 Source Server         : MySQL80
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : mall-pms

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 11/12/2021 10:10:24
*/

CREATE DATABASE IF NOT EXISTS `mall-pms` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE `mall-pms`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`
(
    `table_id`          bigint                                                         NOT NULL AUTO_INCREMENT COMMENT '编号',
    `table_name`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT '' COMMENT '表名称',
    `table_comment`     varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT '' COMMENT '表描述',
    `sub_table_name`    varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT NULL COMMENT '关联子表的表名',
    `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT NULL COMMENT '子表关联的外键名',
    `class_name`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT '' COMMENT '实体类名称',
    `tpl_category`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
    `package_name`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT NULL COMMENT '生成包路径',
    `module_name`       varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT NULL COMMENT '生成模块名',
    `business_name`     varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT NULL COMMENT '生成业务名',
    `function_name`     varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT NULL COMMENT '生成功能名',
    `function_author`   varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT NULL COMMENT '生成功能作者',
    `gen_type`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci       NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
    `gen_path`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
    `options`           varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
    `create_by`         varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT '' COMMENT '创建者',
    `create_time`       datetime                                                       NULL DEFAULT NULL COMMENT '创建时间',
    `update_by`         varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci   NULL DEFAULT '' COMMENT '更新者',
    `update_time`       datetime                                                       NULL DEFAULT NULL COMMENT '更新时间',
    `remark`            varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`
(
    `column_id`      bigint                                                        NOT NULL AUTO_INCREMENT COMMENT '编号',
    `table_id`       varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT NULL COMMENT '归属表编号',
    `column_name`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
    `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
    `column_type`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
    `java_type`      varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
    `java_field`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
    `is_pk`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      NULL DEFAULT NULL COMMENT '是否主键（1是）',
    `is_increment`   char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      NULL DEFAULT NULL COMMENT '是否自增（1是）',
    `is_required`    char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      NULL DEFAULT NULL COMMENT '是否必填（1是）',
    `is_insert`      char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
    `is_edit`        char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
    `is_list`        char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
    `is_query`       char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
    `query_type`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
    `html_type`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
    `dict_type`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
    `sort`           int                                                           NULL DEFAULT NULL COMMENT '排序',
    `create_by`      varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT '' COMMENT '创建者',
    `create_time`    datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    `update_by`      varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NULL DEFAULT '' COMMENT '更新者',
    `update_time`    datetime                                                      NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for home_adv
-- ----------------------------
DROP TABLE IF EXISTS `home_adv`;
CREATE TABLE `home_adv`
(
    `adv_id`     bigint                                                        NOT NULL AUTO_INCREMENT COMMENT '首页广告、轮播图id',
    `adv_name`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '轮播图名字',
    `adv_pic`    varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
    `status`     tinyint                                                       NULL DEFAULT NULL COMMENT '状态【0：禁用。1：启用】',
    `note`       varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
    `sort`       int                                                           NULL DEFAULT NULL COMMENT '排序',
    `adv_type`   tinyint                                                       NULL DEFAULT NULL COMMENT '广告类别【0：PC首页轮播图。1：手机首页轮播图。2：PC首页头部广告。3、手机首页广告。4：PC左侧广告大。5、PC右侧小轮播图。6、PC左侧广告小】',
    `start_time` datetime                                                      NULL DEFAULT NULL COMMENT '开始时间',
    `end_time`   datetime                                                      NULL DEFAULT NULL COMMENT '结束时间',
    PRIMARY KEY (`adv_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 14
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of home_adv
-- ----------------------------
INSERT INTO `home_adv`
VALUES (1, '轮播图1', '	http://localhost:90/static/img/76a6d92783a116ee.jpg.0b2e4f34.webp', 1, '323243242', 1, 0,
        '2021-10-13 23:04:10', '2021-12-31 23:04:12');
INSERT INTO `home_adv`
VALUES (2, '轮播图2', 'http://localhost:90/static/img/3.bd84a2f3.jpg', 1, NULL, 1, 0, '2021-10-14 15:04:10',
        '2021-10-14 15:04:10');
INSERT INTO `home_adv`
VALUES (4, '轮播图4', 'http://localhost:90/static/img/4.7665006c.jpg', 1, NULL, 1, 0, '2021-10-14 15:04:10',
        '2021-10-14 15:04:10');
INSERT INTO `home_adv`
VALUES (5, '轮播图',
        'https://img13.360buyimg.com/da/s380x300_jfs/t1/105973/3/18524/40685/5e9705e4E79886837/b77d319a5cb8b646.png.webp',
        1, '', 1, 5, '2021-10-14 15:29:49', '2021-10-14 15:29:49');
INSERT INTO `home_adv`
VALUES (6, '轮播图',
        'https://img11.360buyimg.com/babel/s380x300_jfs/t1/156373/29/12285/68780/603f2b75E4fd09458/a6aa23f1163ff561.jpg.webp',
        1, '', 1, 5, '2021-10-14 15:29:49', '2021-10-14 15:29:49');
INSERT INTO `home_adv`
VALUES (7, '轮播图',
        'https://img11.360buyimg.com/babel/s380x300_jfs/t1/124193/7/20235/50643/5fc1b453Ede1ff346/4cfd67de0ee4869a.jpg.webp',
        1, '', 1, 5, '2021-10-14 15:29:49', '2021-10-14 15:29:49');
INSERT INTO `home_adv`
VALUES (8, '轮播图',
        'https://img11.360buyimg.com/babel/s380x300_jfs/t1/156373/29/12285/68780/603f2b75E4fd09458/a6aa23f1163ff561.jpg.webp',
        1, '', 1, 5, '2021-10-14 15:29:49', '2021-10-14 15:29:49');
INSERT INTO `home_adv`
VALUES (9, '轮播图',
        'https://img12.360buyimg.com/babel/s380x300_jfs/t1/152314/13/19839/57522/603e118dE941f0ce9/fdff58457adbef3e.jpg.webp',
        1, '', 1, 5, '2021-10-14 15:29:49', '2021-10-14 15:29:49');
INSERT INTO `home_adv`
VALUES (10, '轮播图',
        'https://img12.360buyimg.com/pop/s380x300_jfs/t1/112552/1/1487/44200/5e985affEdbef2113/8d0d7a187b89d426.png.webp',
        1, '', 1, 5, '2021-10-14 15:29:49', '2021-10-14 15:29:49');
INSERT INTO `home_adv`
VALUES (11, '轮播图',
        'https://img20.360buyimg.com/pop/s380x300_jfs/t1/166909/7/17418/87085/6073e5deE5159a884/76a2ff2bc18551bb.jpg.webp',
        1, '', 1, 5, '2021-10-14 15:29:49', '2021-10-14 15:29:49');
INSERT INTO `home_adv`
VALUES (12, 'PC左侧广告',
        'https://img11.360buyimg.com/babel/jfs/t1/197320/13/12060/164917/61610a78Eb73e3327/9940336b9e24e8d0.jpg.webp',
        1, NULL, 1, 4, NULL, NULL);
INSERT INTO `home_adv`
VALUES (13, 'PC右侧广告',
        'https://img12.360buyimg.com/babel/jfs/t1/152334/17/21941/100002/61610a6cEdc34190a/42a0df6d77275c36.png.webp',
        1, NULL, 1, 6, NULL, NULL);

-- ----------------------------
-- Table structure for pms_attr
-- ----------------------------
DROP TABLE IF EXISTS `pms_attr`;
CREATE TABLE `pms_attr`
(
    `attr_id`      bigint                                                        NOT NULL AUTO_INCREMENT COMMENT '属性id',
    `attr_name`    char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci     NULL DEFAULT NULL COMMENT '属性名',
    `search_type`  tinyint                                                       NULL DEFAULT NULL COMMENT '是否需要检索[0-不需要，1-需要]',
    `value_type`   tinyint                                                       NULL DEFAULT NULL COMMENT '值类型。【1：多选。0：单选】',
    `icon`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性图标',
    `value_select` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci    NULL DEFAULT NULL COMMENT '可选值列表[用逗号分隔]',
    `attr_type`    tinyint                                                       NULL DEFAULT NULL COMMENT '属性类型[0-销售属性，1-基本属性]',
    `enable`       bigint                                                        NULL DEFAULT NULL COMMENT '启用状态[0 - 禁用，1 - 启用]',
    `catelog_id`   bigint                                                        NULL DEFAULT NULL COMMENT '所属分类',
    `show_desc`    tinyint                                                       NULL DEFAULT NULL COMMENT '快速展示【是否展示在介绍上；0-否 1-是】，在sku中仍然可以调整',
    PRIMARY KEY (`attr_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '商品属性'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_attr_attrgroup_relation
-- ----------------------------
DROP TABLE IF EXISTS `pms_attr_attrgroup_relation`;
CREATE TABLE `pms_attr_attrgroup_relation`
(
    `id`            bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
    `attr_id`       bigint NULL DEFAULT NULL COMMENT '属性id',
    `attr_group_id` bigint NULL DEFAULT NULL COMMENT '属性分组id',
    `attr_sort`     int    NULL DEFAULT NULL COMMENT '属性组内排序',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `attr_id` (`attr_id`) USING BTREE COMMENT '每个属性只能绑定一个属性分组，但是一个属性分组可以有多个属性'
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '属性&属性分组关联'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_attr_group
-- ----------------------------
DROP TABLE IF EXISTS `pms_attr_group`;
CREATE TABLE `pms_attr_group`
(
    `attr_group_id`   bigint                                                        NOT NULL AUTO_INCREMENT COMMENT '分组id',
    `attr_group_name` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci     NULL DEFAULT NULL COMMENT '组名',
    `sort`            int                                                           NULL DEFAULT NULL COMMENT '排序',
    `descript`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
    `icon`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组图标',
    `catelog_id`      bigint                                                        NULL DEFAULT NULL COMMENT '所属分类id',
    PRIMARY KEY (`attr_group_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '属性分组'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_brand
-- ----------------------------
DROP TABLE IF EXISTS `pms_brand`;
CREATE TABLE `pms_brand`
(
    `brand_id`     bigint                                                         NOT NULL AUTO_INCREMENT COMMENT '品牌id',
    `name`         char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci      NULL DEFAULT NULL COMMENT '品牌名',
    `logo`         varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '品牌logo地址',
    `descript`     longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci      NULL COMMENT '介绍',
    `show_status`  tinyint                                                        NULL DEFAULT NULL COMMENT '显示状态[0-不显示；1-显示]',
    `first_letter` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci       NULL DEFAULT NULL COMMENT '检索首字母',
    `sort`         int                                                            NULL DEFAULT NULL COMMENT '排序',
    PRIMARY KEY (`brand_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '品牌'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_category
-- ----------------------------
DROP TABLE IF EXISTS `pms_category`;
CREATE TABLE `pms_category`
(
    `cat_id`        bigint                                                     NOT NULL AUTO_INCREMENT COMMENT '分类id',
    `name`          char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '分类名称',
    `parent_cid`    bigint                                                     NULL DEFAULT NULL COMMENT '父分类id',
    `cat_level`     int                                                        NULL DEFAULT NULL COMMENT '层级',
    `show_status`   tinyint                                                    NULL DEFAULT NULL COMMENT '是否显示[0-不显示，1显示]',
    `sort`          int                                                        NULL DEFAULT NULL COMMENT '排序',
    `icon`          char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标地址',
    `product_unit`  char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '计量单位',
    `product_count` int                                                        NULL DEFAULT NULL COMMENT '商品数量',
    PRIMARY KEY (`cat_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品三级分类'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_category_brand_relation
-- ----------------------------
DROP TABLE IF EXISTS `pms_category_brand_relation`;
CREATE TABLE `pms_category_brand_relation`
(
    `id`           bigint                                                        NOT NULL AUTO_INCREMENT,
    `brand_id`     bigint                                                        NULL DEFAULT NULL COMMENT '品牌id',
    `catelog_id`   bigint                                                        NULL DEFAULT NULL COMMENT '分类id',
    `brand_name`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `catelog_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '品牌分类关联'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_comment_replay
-- ----------------------------
DROP TABLE IF EXISTS `pms_comment_replay`;
CREATE TABLE `pms_comment_replay`
(
    `id`         bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
    `comment_id` bigint NULL DEFAULT NULL COMMENT '评论id',
    `reply_id`   bigint NULL DEFAULT NULL COMMENT '回复id',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '商品评价回复关系'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_product_attr_value
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_attr_value`;
CREATE TABLE `pms_product_attr_value`
(
    `id`         bigint                                                        NOT NULL AUTO_INCREMENT COMMENT 'id',
    `spu_id`     bigint                                                        NULL DEFAULT NULL COMMENT '商品id',
    `attr_id`    bigint                                                        NULL DEFAULT NULL COMMENT '属性id',
    `attr_name`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性名',
    `attr_value` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性值',
    `attr_sort`  int                                                           NULL DEFAULT NULL COMMENT '顺序',
    `quick_show` tinyint                                                       NULL DEFAULT NULL COMMENT '快速展示【是否展示在介绍上；0-否 1-是】',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = 'spu属性值'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_sku_images
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_images`;
CREATE TABLE `pms_sku_images`
(
    `id`          bigint                                                        NOT NULL AUTO_INCREMENT COMMENT 'id',
    `sku_id`      bigint                                                        NULL DEFAULT NULL COMMENT 'sku_id',
    `img_url`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
    `img_sort`    int                                                           NULL DEFAULT NULL COMMENT '排序',
    `default_img` int                                                           NULL DEFAULT NULL COMMENT '默认图[0 - 不是默认图，1 - 是默认图]',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = 'sku图片'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_sku_info
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_info`;
CREATE TABLE `pms_sku_info`
(
    `sku_id`          bigint                                                         NOT NULL AUTO_INCREMENT COMMENT 'skuId',
    `spu_id`          bigint                                                         NULL DEFAULT NULL COMMENT 'spuId',
    `sku_name`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT 'sku名称',
    `sku_desc`        varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku介绍描述',
    `catalog_id`      bigint                                                         NULL DEFAULT NULL COMMENT '所属分类id',
    `brand_id`        bigint                                                         NULL DEFAULT NULL COMMENT '品牌id',
    `sku_default_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '默认图片',
    `sku_title`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '标题',
    `sku_subtitle`    varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '副标题',
    `price`           decimal(18, 4)                                                 NULL DEFAULT NULL COMMENT '价格',
    `sale_count`      bigint                                                         NULL DEFAULT NULL COMMENT '销量',
    PRIMARY KEY (`sku_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = 'sku信息'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_sku_sale_attr_value
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_sale_attr_value`;
CREATE TABLE `pms_sku_sale_attr_value`
(
    `id`         bigint                                                        NOT NULL AUTO_INCREMENT COMMENT 'id',
    `sku_id`     bigint                                                        NULL DEFAULT NULL COMMENT 'sku_id',
    `attr_id`    bigint                                                        NULL DEFAULT NULL COMMENT 'attr_id',
    `attr_name`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '销售属性名',
    `attr_value` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '销售属性值',
    `attr_sort`  int                                                           NULL DEFAULT NULL COMMENT '顺序',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = 'sku销售属性&值'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_spu_comment
-- ----------------------------
DROP TABLE IF EXISTS `pms_spu_comment`;
CREATE TABLE `pms_spu_comment`
(
    `id`               bigint                                                         NOT NULL AUTO_INCREMENT COMMENT 'id',
    `sku_id`           bigint                                                         NULL DEFAULT NULL COMMENT 'sku_id',
    `spu_id`           bigint                                                         NULL DEFAULT NULL COMMENT 'spu_id',
    `spu_name`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '商品名字',
    `member_nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '会员昵称',
    `star`             tinyint(1)                                                     NULL DEFAULT NULL COMMENT '星级',
    `member_ip`        varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL DEFAULT NULL COMMENT '会员ip',
    `create_time`      datetime                                                       NULL DEFAULT NULL COMMENT '创建时间',
    `show_status`      tinyint(1)                                                     NULL DEFAULT NULL COMMENT '显示状态[0-不显示，1-显示]',
    `spu_attributes`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '购买时属性组合',
    `likes_count`      int                                                            NULL DEFAULT NULL COMMENT '点赞数',
    `reply_count`      int                                                            NULL DEFAULT NULL COMMENT '回复数',
    `resources`        varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论图片/视频[json数据；[{type:文件类型,url:资源路径}]]',
    `content`          text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci          NULL COMMENT '内容',
    `member_icon`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '用户头像',
    `comment_type`     tinyint                                                        NULL DEFAULT NULL COMMENT '评论类型[0 - 对商品的直接评论，1 - 对评论的回复]',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '商品评价'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_spu_images
-- ----------------------------
DROP TABLE IF EXISTS `pms_spu_images`;
CREATE TABLE `pms_spu_images`
(
    `id`          bigint                                                        NOT NULL AUTO_INCREMENT COMMENT 'id',
    `spu_id`      bigint                                                        NULL DEFAULT NULL COMMENT 'spu_id',
    `img_name`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片名',
    `img_url`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
    `img_sort`    int                                                           NULL DEFAULT NULL COMMENT '顺序',
    `default_img` tinyint                                                       NULL DEFAULT NULL COMMENT '是否默认图',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = 'spu图片'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_spu_info
-- ----------------------------
DROP TABLE IF EXISTS `pms_spu_info`;
CREATE TABLE `pms_spu_info`
(
    `id`              bigint                                                         NOT NULL AUTO_INCREMENT COMMENT '商品id',
    `spu_name`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '商品名称',
    `spu_description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品描述',
    `catalog_id`      bigint                                                         NULL DEFAULT NULL COMMENT '所属分类id',
    `brand_id`        bigint                                                         NULL DEFAULT NULL COMMENT '品牌id',
    `weight`          decimal(18, 4)                                                 NULL DEFAULT NULL COMMENT '商品重量，单位kg',
    `publish_status`  tinyint                                                        NULL DEFAULT NULL COMMENT '上架状态[0 - 下架，1 - 上架]',
    `create_time`     datetime                                                       NULL DEFAULT NULL,
    `update_time`     datetime                                                       NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = 'spu信息'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pms_spu_info_desc
-- ----------------------------
DROP TABLE IF EXISTS `pms_spu_info_desc`;
CREATE TABLE `pms_spu_info_desc`
(
    `spu_id`  bigint                                                    NOT NULL COMMENT '商品id',
    `decript` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品介绍',
    PRIMARY KEY (`spu_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = 'spu信息介绍'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for provinces
-- ----------------------------

DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces`
(
    `id`          int                                                    NOT NULL,
    `city_name`   varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市名称',
    `parent_id`   int                                                    NOT NULL COMMENT '父级id',
    `short_name`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市缩写名称',
    `depth`       int                                                    NOT NULL COMMENT '城市层级',
    `city_code`   varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '城市代码',
    `zip_code`    varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '城市邮编',
    `merger_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市组合名称',
    `longitude`   varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '精度',
    `latitude`    varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '维度',
    `pinyin`      varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市拼音',
    `is_use`      int(1) UNSIGNED ZEROFILL                               NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `depth` (`depth`) USING BTREE,
    INDEX `id` (`id`, `parent_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '区县行政编码字典表'
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of provinces
-- ----------------------------
INSERT INTO `provinces`
VALUES (100000, '中国', 0, '中国', 0, '', '', '中国', '116.3683244', '39.915085', 'China', 1);
INSERT INTO `provinces`
VALUES (110000, '北京', 100000, '北京', 1, '', '', '中国,北京', '116.405285', '39.904989', 'Beijing', 1);
INSERT INTO `provinces`
VALUES (110100, '北京市', 110000, '北京', 2, '010', '100000', '中国,北京,北京市', '116.405285', '39.904989', 'Beijing', 1);
INSERT INTO `provinces`
VALUES (110101, '东城区', 110100, '东城', 3, '010', '100010', '中国,北京,北京市,东城区', '116.41005', '39.93157', 'Dongcheng', 1);
INSERT INTO `provinces`
VALUES (110102, '西城区', 110100, '西城', 3, '010', '100032', '中国,北京,北京市,西城区', '116.36003', '39.9305', 'Xicheng', 1);
INSERT INTO `provinces`
VALUES (110105, '朝阳区', 110100, '朝阳', 3, '010', '100020', '中国,北京,北京市,朝阳区', '116.48548', '39.9484', 'Chaoyang', 1);
INSERT INTO `provinces`
VALUES (110106, '丰台区', 110100, '丰台', 3, '010', '100071', '中国,北京,北京市,丰台区', '116.28625', '39.8585', 'Fengtai', 1);
INSERT INTO `provinces`
VALUES (110107, '石景山区', 110100, '石景山', 3, '010', '100043', '中国,北京,北京市,石景山区', '116.2229', '39.90564', 'Shijingshan', 1);
INSERT INTO `provinces`
VALUES (110108, '海淀区', 110100, '海淀', 3, '010', '100089', '中国,北京,北京市,海淀区', '116.29812', '39.95931', 'Haidian', 1);
INSERT INTO `provinces`
VALUES (110109, '门头沟区', 110100, '门头沟', 3, '010', '102300', '中国,北京,北京市,门头沟区', '116.10137', '39.94043', 'Mentougou', 1);
INSERT INTO `provinces`
VALUES (110111, '房山区', 110100, '房山', 3, '010', '102488', '中国,北京,北京市,房山区', '116.14257', '39.74786', 'Fangshan', 1);
INSERT INTO `provinces`
VALUES (110112, '通州区', 110100, '通州', 3, '010', '101149', '中国,北京,北京市,通州区', '116.65716', '39.90966', 'Tongzhou', 1);
INSERT INTO `provinces`
VALUES (110113, '顺义区', 110100, '顺义', 3, '010', '101300', '中国,北京,北京市,顺义区', '116.65417', '40.1302', 'Shunyi', 1);
INSERT INTO `provinces`
VALUES (110114, '昌平区', 110100, '昌平', 3, '010', '102200', '中国,北京,北京市,昌平区', '116.2312', '40.22072', 'Changping', 1);
INSERT INTO `provinces`
VALUES (110115, '大兴区', 110100, '大兴', 3, '010', '102600', '中国,北京,北京市,大兴区', '116.34149', '39.72668', 'Daxing', 1);
INSERT INTO `provinces`
VALUES (110116, '怀柔区', 110100, '怀柔', 3, '010', '101400', '中国,北京,北京市,怀柔区', '116.63168', '40.31602', 'Huairou', 1);
INSERT INTO `provinces`
VALUES (110117, '平谷区', 110100, '平谷', 3, '010', '101200', '中国,北京,北京市,平谷区', '117.12133', '40.14056', 'Pinggu', 1);
INSERT INTO `provinces`
VALUES (110228, '密云县', 110100, '密云', 3, '010', '101500', '中国,北京,北京市,密云县', '116.84295', '40.37618', 'Miyun', 1);
INSERT INTO `provinces`
VALUES (110229, '延庆县', 110100, '延庆', 3, '010', '102100', '中国,北京,北京市,延庆县', '115.97494', '40.45672', 'Yanqing', 1);
INSERT INTO `provinces`
VALUES (120000, '天津', 100000, '天津', 1, '', '', '中国,天津', '117.190182', '39.125596', 'Tianjin', 1);
INSERT INTO `provinces`
VALUES (120100, '天津市', 120000, '天津', 2, '022', '300000', '中国,天津,天津市', '117.190182', '39.125596', 'Tianjin', 1);
INSERT INTO `provinces`
VALUES (120101, '和平区', 120100, '和平', 3, '022', '300041', '中国,天津,天津市,和平区', '117.21456', '39.11718', 'Heping', 1);
INSERT INTO `provinces`
VALUES (120102, '河东区', 120100, '河东', 3, '022', '300171', '中国,天津,天津市,河东区', '117.12662', '39.12318', 'Hedong', 1);
INSERT INTO `provinces`
VALUES (120103, '河西区', 120100, '河西', 3, '022', '300202', '中国,天津,天津市,河西区', '117.22327', '39.10959', 'Hexi', 1);
INSERT INTO `provinces`
VALUES (120104, '南开区', 120100, '南开', 3, '022', '300110', '中国,天津,天津市,南开区', '117.15074', '39.13821', 'Nankai', 1);
INSERT INTO `provinces`
VALUES (120105, '河北区', 120100, '河北', 3, '022', '300143', '中国,天津,天津市,河北区', '117.19697', '39.14816', 'Hebei', 1);
INSERT INTO `provinces`
VALUES (120106, '红桥区', 120100, '红桥', 3, '022', '300131', '中国,天津,天津市,红桥区', '117.15145', '39.16715', 'Hongqiao', 1);
INSERT INTO `provinces`
VALUES (120110, '东丽区', 120100, '东丽', 3, '022', '300300', '中国,天津,天津市,东丽区', '117.31436', '39.0863', 'Dongli', 1);
INSERT INTO `provinces`
VALUES (120111, '西青区', 120100, '西青', 3, '022', '300380', '中国,天津,天津市,西青区', '117.00927', '39.14123', 'Xiqing', 1);
INSERT INTO `provinces`
VALUES (120112, '津南区', 120100, '津南', 3, '022', '300350', '中国,天津,天津市,津南区', '117.38537', '38.99139', 'Jinnan', 1);
INSERT INTO `provinces`
VALUES (120113, '北辰区', 120100, '北辰', 3, '022', '300400', '中国,天津,天津市,北辰区', '117.13217', '39.22131', 'Beichen', 1);
INSERT INTO `provinces`
VALUES (120114, '武清区', 120100, '武清', 3, '022', '301700', '中国,天津,天津市,武清区', '117.04443', '39.38415', 'Wuqing', 1);
INSERT INTO `provinces`
VALUES (120115, '宝坻区', 120100, '宝坻', 3, '022', '301800', '中国,天津,天津市,宝坻区', '117.3103', '39.71761', 'Baodi', 1);
INSERT INTO `provinces`
VALUES (120116, '滨海新区', 120100, '滨海新区', 3, '022', '300451', '中国,天津,天津市,滨海新区', '117.70162', '39.02668', 'Binhaixinqu',
        1);
INSERT INTO `provinces`
VALUES (120126, '蓟县', 120100, '蓟县', 3, '022', '301900', '中国,天津,天津市,蓟县', '117.40799', '40.04567', 'Jixian', 1);
INSERT INTO `provinces`
VALUES (120221, '宁河县', 120100, '宁河', 3, '022', '301500', '中国,天津,天津市,宁河县', '117.8255', '39.33048', 'Ninghe', 1);
INSERT INTO `provinces`
VALUES (120223, '静海县', 120100, '静海', 3, '022', '301600', '中国,天津,天津市,静海县', '116.97436', '38.94582', 'Jinghai', 1);
INSERT INTO `provinces`
VALUES (130000, '河北省', 100000, '河北', 1, '', '', '中国,河北省', '114.502461', '38.045474', 'Hebei', 1);
INSERT INTO `provinces`
VALUES (130100, '石家庄市', 130000, '石家庄', 2, '0311', '050011', '中国,河北省,石家庄市', '114.502461', '38.045474', 'Shijiazhuang',
        1);
INSERT INTO `provinces`
VALUES (130102, '长安区', 130100, '长安', 3, '0311', '050011', '中国,河北省,石家庄市,长安区', '114.53906', '38.03665', 'Chang\'an', 1);
INSERT INTO `provinces`
VALUES (130104, '桥西区', 130100, '桥西', 3, '0311', '050091', '中国,河北省,石家庄市,桥西区', '114.46977', '38.03221', 'Qiaoxi', 1);
INSERT INTO `provinces`
VALUES (130105, '新华区', 130100, '新华', 3, '0311', '050051', '中国,河北省,石家庄市,新华区', '114.46326', '38.05088', 'Xinhua', 1);
INSERT INTO `provinces`
VALUES (130107, '井陉矿区', 130100, '井陉矿区', 3, '0311', '050100', '中国,河北省,石家庄市,井陉矿区', '114.06518', '38.06705',
        'Jingxingkuangqu', 1);
INSERT INTO `provinces`
VALUES (130108, '裕华区', 130100, '裕华', 3, '0311', '050031', '中国,河北省,石家庄市,裕华区', '114.53115', '38.00604', 'Yuhua', 1);
INSERT INTO `provinces`
VALUES (130109, '藁城区', 130100, '藁城', 3, '0311', '052160', '中国,河北省,石家庄市,藁城区', '114.84671', '38.02162', 'Gaocheng', 1);
INSERT INTO `provinces`
VALUES (130110, '鹿泉区', 130100, '鹿泉', 3, '0311', '050200', '中国,河北省,石家庄市,鹿泉区', '114.31347', '38.08782', 'Luquan', 1);
INSERT INTO `provinces`
VALUES (130111, '栾城区', 130100, '栾城', 3, '0311', '051430', '中国,河北省,石家庄市,栾城区', '114.64834', '37.90022', 'Luancheng', 1);
INSERT INTO `provinces`
VALUES (130121, '井陉县', 130100, '井陉', 3, '0311', '050300', '中国,河北省,石家庄市,井陉县', '114.14257', '38.03688', 'Jingxing', 1);
INSERT INTO `provinces`
VALUES (130123, '正定县', 130100, '正定', 3, '0311', '050800', '中国,河北省,石家庄市,正定县', '114.57296', '38.14445', 'Zhengding', 1);
INSERT INTO `provinces`
VALUES (130125, '行唐县', 130100, '行唐', 3, '0311', '050600', '中国,河北省,石家庄市,行唐县', '114.55316', '38.43654', 'Xingtang', 1);
INSERT INTO `provinces`
VALUES (130126, '灵寿县', 130100, '灵寿', 3, '0311', '050500', '中国,河北省,石家庄市,灵寿县', '114.38259', '38.30845', 'Lingshou', 1);
INSERT INTO `provinces`
VALUES (130127, '高邑县', 130100, '高邑', 3, '0311', '051330', '中国,河北省,石家庄市,高邑县', '114.61142', '37.61556', 'Gaoyi', 1);
INSERT INTO `provinces`
VALUES (130128, '深泽县', 130100, '深泽', 3, '0311', '052560', '中国,河北省,石家庄市,深泽县', '115.20358', '38.18353', 'Shenze', 1);
INSERT INTO `provinces`
VALUES (130129, '赞皇县', 130100, '赞皇', 3, '0311', '051230', '中国,河北省,石家庄市,赞皇县', '114.38775', '37.66135', 'Zanhuang', 1);
INSERT INTO `provinces`
VALUES (130130, '无极县', 130100, '无极', 3, '0311', '052460', '中国,河北省,石家庄市,无极县', '114.97509', '38.17653', 'Wuji', 1);
INSERT INTO `provinces`
VALUES (130131, '平山县', 130100, '平山', 3, '0311', '050400', '中国,河北省,石家庄市,平山县', '114.186', '38.25994', 'Pingshan', 1);
INSERT INTO `provinces`
VALUES (130132, '元氏县', 130100, '元氏', 3, '0311', '051130', '中国,河北省,石家庄市,元氏县', '114.52539', '37.76668', 'Yuanshi', 1);
INSERT INTO `provinces`
VALUES (130133, '赵县', 130100, '赵县', 3, '0311', '051530', '中国,河北省,石家庄市,赵县', '114.77612', '37.75628', 'Zhaoxian', 1);
INSERT INTO `provinces`
VALUES (130181, '辛集市', 130100, '辛集', 3, '0311', '052360', '中国,河北省,石家庄市,辛集市', '115.20626', '37.94079', 'Xinji', 1);
INSERT INTO `provinces`
VALUES (130183, '晋州市', 130100, '晋州', 3, '0311', '052260', '中国,河北省,石家庄市,晋州市', '115.04348', '38.03135', 'Jinzhou', 1);
INSERT INTO `provinces`
VALUES (130184, '新乐市', 130100, '新乐', 3, '0311', '050700', '中国,河北省,石家庄市,新乐市', '114.68985', '38.34417', 'Xinle', 1);
INSERT INTO `provinces`
VALUES (130200, '唐山市', 130000, '唐山', 2, '0315', '063000', '中国,河北省,唐山市', '118.175393', '39.635113', 'Tangshan', 1);
INSERT INTO `provinces`
VALUES (130202, '路南区', 130200, '路南', 3, '0315', '063000', '中国,河北省,唐山市,路南区', '118.15431', '39.62505', 'Lunan', 1);
INSERT INTO `provinces`
VALUES (130203, '路北区', 130200, '路北', 3, '0315', '063000', '中国,河北省,唐山市,路北区', '118.20079', '39.62436', 'Lubei', 1);
INSERT INTO `provinces`
VALUES (130204, '古冶区', 130200, '古冶', 3, '0315', '063100', '中国,河北省,唐山市,古冶区', '118.45803', '39.71993', 'Guye', 1);
INSERT INTO `provinces`
VALUES (130205, '开平区', 130200, '开平', 3, '0315', '063021', '中国,河北省,唐山市,开平区', '118.26171', '39.67128', 'Kaiping', 1);
INSERT INTO `provinces`
VALUES (130207, '丰南区', 130200, '丰南', 3, '0315', '063300', '中国,河北省,唐山市,丰南区', '118.11282', '39.56483', 'Fengnan', 1);
INSERT INTO `provinces`
VALUES (130208, '丰润区', 130200, '丰润', 3, '0315', '064000', '中国,河北省,唐山市,丰润区', '118.12976', '39.8244', 'Fengrun', 1);
INSERT INTO `provinces`
VALUES (130209, '曹妃甸区', 130200, '曹妃甸', 3, '0315', '063200', '中国,河北省,唐山市,曹妃甸区', '118.460379', '39.273070', 'Caofeidian',
        1);
INSERT INTO `provinces`
VALUES (130223, '滦县', 130200, '滦县', 3, '0315', '063700', '中国,河北省,唐山市,滦县', '118.70346', '39.74056', 'Luanxian', 1);
INSERT INTO `provinces`
VALUES (130224, '滦南县', 130200, '滦南', 3, '0315', '063500', '中国,河北省,唐山市,滦南县', '118.6741', '39.5039', 'Luannan', 1);
INSERT INTO `provinces`
VALUES (130283, '迁安市', 130200, '迁安', 3, '0315', '064400', '中国,河北省,唐山市,迁安市', '118.70068', '39.99833', 'Qian\'an', 1);
INSERT INTO `provinces`
VALUES (130300, '秦皇岛市', 130000, '秦皇岛', 2, '0335', '066000', '中国,河北省,秦皇岛市', '119.586579', '39.942531', 'Qinhuangdao', 1);
INSERT INTO `provinces`
VALUES (130302, '海港区', 130300, '海港', 3, '0335', '066000', '中国,河北省,秦皇岛市,海港区', '119.61046', '39.9345', 'Haigang', 1);
INSERT INTO `provinces`
VALUES (130303, '山海关区', 130300, '山海关', 3, '0335', '066200', '中国,河北省,秦皇岛市,山海关区', '119.77563', '39.97869', 'Shanhaiguan',
        1);
INSERT INTO `provinces`
VALUES (130304, '北戴河区', 130300, '北戴河', 3, '0335', '066100', '中国,河北省,秦皇岛市,北戴河区', '119.48388', '39.83408', 'Beidaihe', 1);
INSERT INTO `provinces`
VALUES (130321, '青龙满族自治县', 130300, '青龙', 3, '0335', '066500', '中国,河北省,秦皇岛市,青龙满族自治县', '118.95242', '40.40743',
        'Qinglong', 1);
INSERT INTO `provinces`
VALUES (130322, '昌黎县', 130300, '昌黎', 3, '0335', '066600', '中国,河北省,秦皇岛市,昌黎县', '119.16595', '39.70884', 'Changli', 1);
INSERT INTO `provinces`
VALUES (130323, '抚宁县', 130300, '抚宁', 3, '0335', '066300', '中国,河北省,秦皇岛市,抚宁县', '119.24487', '39.87538', 'Funing', 1);
INSERT INTO `provinces`
VALUES (130324, '卢龙县', 130300, '卢龙', 3, '0335', '066400', '中国,河北省,秦皇岛市,卢龙县', '118.89288', '39.89176', 'Lulong', 1);
INSERT INTO `provinces`
VALUES (130400, '邯郸市', 130000, '邯郸', 2, '0310', '056002', '中国,河北省,邯郸市', '114.490686', '36.612273', 'Handan', 1);
INSERT INTO `provinces`
VALUES (130402, '邯山区', 130400, '邯山', 3, '0310', '056001', '中国,河北省,邯郸市,邯山区', '114.48375', '36.60006', 'Hanshan', 1);
INSERT INTO `provinces`
VALUES (130403, '丛台区', 130400, '丛台', 3, '0310', '056002', '中国,河北省,邯郸市,丛台区', '114.49343', '36.61847', 'Congtai', 1);
INSERT INTO `provinces`
VALUES (130404, '复兴区', 130400, '复兴', 3, '0310', '056003', '中国,河北省,邯郸市,复兴区', '114.45928', '36.61134', 'Fuxing', 1);
INSERT INTO `provinces`
VALUES (130406, '峰峰矿区', 130400, '峰峰矿区', 3, '0310', '056200', '中国,河北省,邯郸市,峰峰矿区', '114.21148', '36.41937',
        'Fengfengkuangqu', 1);
INSERT INTO `provinces`
VALUES (130421, '邯郸县', 130400, '邯郸', 3, '0310', '056101', '中国,河北省,邯郸市,邯郸县', '114.53103', '36.59385', 'Handan', 1);
INSERT INTO `provinces`
VALUES (130423, '临漳县', 130400, '临漳', 3, '0310', '056600', '中国,河北省,邯郸市,临漳县', '114.6195', '36.33461', 'Linzhang', 1);
INSERT INTO `provinces`
VALUES (130424, '成安县', 130400, '成安', 3, '0310', '056700', '中国,河北省,邯郸市,成安县', '114.66995', '36.44411', 'Cheng\'an', 1);
INSERT INTO `provinces`
VALUES (130425, '大名县', 130400, '大名', 3, '0310', '056900', '中国,河北省,邯郸市,大名县', '115.15362', '36.27994', 'Daming', 1);
INSERT INTO `provinces`
VALUES (130426, '涉县', 130400, '涉县', 3, '0310', '056400', '中国,河北省,邯郸市,涉县', '113.69183', '36.58072', 'Shexian', 1);
INSERT INTO `provinces`
VALUES (130427, '磁县', 130400, '磁县', 3, '0310', '056500', '中国,河北省,邯郸市,磁县', '114.37387', '36.37392', 'Cixian', 1);
INSERT INTO `provinces`
VALUES (130428, '肥乡县', 130400, '肥乡', 3, '0310', '057550', '中国,河北省,邯郸市,肥乡县', '114.79998', '36.54807', 'Feixiang', 1);
INSERT INTO `provinces`
VALUES (130429, '永年县', 130400, '永年', 3, '0310', '057150', '中国,河北省,邯郸市,永年县', '114.48925', '36.78356', 'Yongnian', 1);
INSERT INTO `provinces`
VALUES (130430, '邱县', 130400, '邱县', 3, '0310', '057450', '中国,河北省,邯郸市,邱县', '115.17407', '36.82082', 'Qiuxian', 1);
INSERT INTO `provinces`
VALUES (130431, '鸡泽县', 130400, '鸡泽', 3, '0310', '057350', '中国,河北省,邯郸市,鸡泽县', '114.8742', '36.92374', 'Jize', 1);
INSERT INTO `provinces`
VALUES (130432, '广平县', 130400, '广平', 3, '0310', '057650', '中国,河北省,邯郸市,广平县', '114.94653', '36.48046', 'Guangping', 1);
INSERT INTO `provinces`
VALUES (130433, '馆陶县', 130400, '馆陶', 3, '0310', '057750', '中国,河北省,邯郸市,馆陶县', '115.29913', '36.53719', 'Guantao', 1);
INSERT INTO `provinces`
VALUES (130434, '魏县', 130400, '魏县', 3, '0310', '056800', '中国,河北省,邯郸市,魏县', '114.93518', '36.36171', 'Weixian', 1);
INSERT INTO `provinces`
VALUES (130435, '曲周县', 130400, '曲周', 3, '0310', '057250', '中国,河北省,邯郸市,曲周县', '114.95196', '36.77671', 'Quzhou', 1);
INSERT INTO `provinces`
VALUES (130481, '武安市', 130400, '武安', 3, '0310', '056300', '中国,河北省,邯郸市,武安市', '114.20153', '36.69281', 'Wu\'an', 1);
INSERT INTO `provinces`
VALUES (130500, '邢台市', 130000, '邢台', 2, '0319', '054001', '中国,河北省,邢台市', '114.508851', '37.0682', 'Xingtai', 1);
INSERT INTO `provinces`
VALUES (130502, '桥东区', 130500, '桥东', 3, '0319', '054001', '中国,河北省,邢台市,桥东区', '114.50725', '37.06801', 'Qiaodong', 1);
INSERT INTO `provinces`
VALUES (130503, '桥西区', 130500, '桥西', 3, '0319', '054000', '中国,河北省,邢台市,桥西区', '114.46803', '37.05984', 'Qiaoxi', 1);
INSERT INTO `provinces`
VALUES (130521, '邢台县', 130500, '邢台', 3, '0319', '054001', '中国,河北省,邢台市,邢台县', '114.56575', '37.0456', 'Xingtai', 1);
INSERT INTO `provinces`
VALUES (130522, '临城县', 130500, '临城', 3, '0319', '054300', '中国,河北省,邢台市,临城县', '114.50387', '37.43977', 'Lincheng', 1);
INSERT INTO `provinces`
VALUES (130523, '内丘县', 130500, '内丘', 3, '0319', '054200', '中国,河北省,邢台市,内丘县', '114.51212', '37.28671', 'Neiqiu', 1);
INSERT INTO `provinces`
VALUES (130524, '柏乡县', 130500, '柏乡', 3, '0319', '055450', '中国,河北省,邢台市,柏乡县', '114.69332', '37.48242', 'Baixiang', 1);
INSERT INTO `provinces`
VALUES (130525, '隆尧县', 130500, '隆尧', 3, '0319', '055350', '中国,河北省,邢台市,隆尧县', '114.77615', '37.35351', 'Longyao', 1);
INSERT INTO `provinces`
VALUES (130526, '任县', 130500, '任县', 3, '0319', '055150', '中国,河北省,邢台市,任县', '114.6842', '37.12575', 'Renxian', 1);
INSERT INTO `provinces`
VALUES (130527, '南和县', 130500, '南和', 3, '0319', '054400', '中国,河北省,邢台市,南和县', '114.68371', '37.00488', 'Nanhe', 1);
INSERT INTO `provinces`
VALUES (130528, '宁晋县', 130500, '宁晋', 3, '0319', '055550', '中国,河北省,邢台市,宁晋县', '114.92117', '37.61696', 'Ningjin', 1);
INSERT INTO `provinces`
VALUES (130529, '巨鹿县', 130500, '巨鹿', 3, '0319', '055250', '中国,河北省,邢台市,巨鹿县', '115.03524', '37.21801', 'Julu', 1);
INSERT INTO `provinces`
VALUES (130530, '新河县', 130500, '新河', 3, '0319', '055650', '中国,河北省,邢台市,新河县', '115.24987', '37.52718', 'Xinhe', 1);
INSERT INTO `provinces`
VALUES (130531, '广宗县', 130500, '广宗', 3, '0319', '054600', '中国,河北省,邢台市,广宗县', '115.14254', '37.0746', 'Guangzong', 1);
INSERT INTO `provinces`
VALUES (130532, '平乡县', 130500, '平乡', 3, '0319', '054500', '中国,河北省,邢台市,平乡县', '115.03002', '37.06317', 'Pingxiang', 1);
INSERT INTO `provinces`
VALUES (130533, '威县', 130500, '威县', 3, '0319', '054700', '中国,河北省,邢台市,威县', '115.2637', '36.9768', 'Weixian', 1);
INSERT INTO `provinces`
VALUES (130534, '清河县', 130500, '清河', 3, '0319', '054800', '中国,河北省,邢台市,清河县', '115.66479', '37.07122', 'Qinghe', 1);
INSERT INTO `provinces`
VALUES (130535, '临西县', 130500, '临西', 3, '0319', '054900', '中国,河北省,邢台市,临西县', '115.50097', '36.87078', 'Linxi', 1);
INSERT INTO `provinces`
VALUES (130581, '南宫市', 130500, '南宫', 3, '0319', '055750', '中国,河北省,邢台市,南宫市', '115.39068', '37.35799', 'Nangong', 1);
INSERT INTO `provinces`
VALUES (130582, '沙河市', 130500, '沙河', 3, '0319', '054100', '中国,河北省,邢台市,沙河市', '114.4981', '36.8577', 'Shahe', 1);
INSERT INTO `provinces`
VALUES (130600, '保定市', 130000, '保定', 2, '0312', '071052', '中国,河北省,保定市', '115.482331', '38.867657', 'Baoding', 1);
INSERT INTO `provinces`
VALUES (130602, '新市区', 130600, '新市', 3, '0312', '071051', '中国,河北省,保定市,新市区', '115.4587', '38.87751', 'Xinshi', 1);
INSERT INTO `provinces`
VALUES (130603, '北市区', 130600, '北市', 3, '0312', '071000', '中国,河北省,保定市,北市区', '115.49715', '38.88322', 'Beishi', 1);
INSERT INTO `provinces`
VALUES (130604, '南市区', 130600, '南市', 3, '0312', '071001', '中国,河北省,保定市,南市区', '115.52859', '38.85455', 'Nanshi', 1);
INSERT INTO `provinces`
VALUES (130621, '满城县', 130600, '满城', 3, '0312', '072150', '中国,河北省,保定市,满城县', '115.32296', '38.94972', 'Mancheng', 1);
INSERT INTO `provinces`
VALUES (130622, '清苑县', 130600, '清苑', 3, '0312', '071100', '中国,河北省,保定市,清苑县', '115.49267', '38.76709', 'Qingyuan', 1);
INSERT INTO `provinces`
VALUES (130623, '涞水县', 130600, '涞水', 3, '0312', '074100', '中国,河北省,保定市,涞水县', '115.71517', '39.39404', 'Laishui', 1);
INSERT INTO `provinces`
VALUES (130624, '阜平县', 130600, '阜平', 3, '0312', '073200', '中国,河北省,保定市,阜平县', '114.19683', '38.84763', 'Fuping', 1);
INSERT INTO `provinces`
VALUES (130625, '徐水县', 130600, '徐水', 3, '0312', '072550', '中国,河北省,保定市,徐水县', '115.65829', '39.02099', 'Xushui', 1);
INSERT INTO `provinces`
VALUES (130626, '定兴县', 130600, '定兴', 3, '0312', '072650', '中国,河北省,保定市,定兴县', '115.80786', '39.26312', 'Dingxing', 1);
INSERT INTO `provinces`
VALUES (130627, '唐县', 130600, '唐县', 3, '0312', '072350', '中国,河北省,保定市,唐县', '114.98516', '38.74513', 'Tangxian', 1);
INSERT INTO `provinces`
VALUES (130628, '高阳县', 130600, '高阳', 3, '0312', '071500', '中国,河北省,保定市,高阳县', '115.7788', '38.70003', 'Gaoyang', 1);
INSERT INTO `provinces`
VALUES (130629, '容城县', 130600, '容城', 3, '0312', '071700', '中国,河北省,保定市,容城县', '115.87158', '39.0535', 'Rongcheng', 1);
INSERT INTO `provinces`
VALUES (130630, '涞源县', 130600, '涞源', 3, '0312', '074300', '中国,河北省,保定市,涞源县', '114.69128', '39.35388', 'Laiyuan', 1);
INSERT INTO `provinces`
VALUES (130631, '望都县', 130600, '望都', 3, '0312', '072450', '中国,河北省,保定市,望都县', '115.1567', '38.70996', 'Wangdu', 1);
INSERT INTO `provinces`
VALUES (130632, '安新县', 130600, '安新', 3, '0312', '071600', '中国,河北省,保定市,安新县', '115.93557', '38.93532', 'Anxin', 1);
INSERT INTO `provinces`
VALUES (130633, '易县', 130600, '易县', 3, '0312', '074200', '中国,河北省,保定市,易县', '115.4981', '39.34885', 'Yixian', 1);
INSERT INTO `provinces`
VALUES (130634, '曲阳县', 130600, '曲阳', 3, '0312', '073100', '中国,河北省,保定市,曲阳县', '114.70123', '38.62154', 'Quyang', 1);
INSERT INTO `provinces`
VALUES (130635, '蠡县', 130600, '蠡县', 3, '0312', '071400', '中国,河北省,保定市,蠡县', '115.57717', '38.48974', 'Lixian', 1);
INSERT INTO `provinces`
VALUES (130636, '顺平县', 130600, '顺平', 3, '0312', '071260', '中国,河北省,保定市,顺平县', '115.1347', '38.83854', 'Shunping', 1);
INSERT INTO `provinces`
VALUES (130637, '博野县', 130600, '博野', 3, '0312', '071300', '中国,河北省,保定市,博野县', '115.47033', '38.4564', 'Boye', 1);
INSERT INTO `provinces`
VALUES (130638, '雄县', 130600, '雄县', 3, '0312', '071800', '中国,河北省,保定市,雄县', '116.10873', '38.99442', 'Xiongxian', 1);
INSERT INTO `provinces`
VALUES (130681, '涿州市', 130600, '涿州', 3, '0312', '072750', '中国,河北省,保定市,涿州市', '115.98062', '39.48622', 'Zhuozhou', 1);
INSERT INTO `provinces`
VALUES (130682, '定州市', 130600, '定州', 3, '0312', '073000', '中国,河北省,保定市,定州市', '114.9902', '38.51623', 'Dingzhou', 1);
INSERT INTO `provinces`
VALUES (130683, '安国市', 130600, '安国', 3, '0312', '071200', '中国,河北省,保定市,安国市', '115.32321', '38.41391', 'Anguo', 1);
INSERT INTO `provinces`
VALUES (130684, '高碑店市', 130600, '高碑店', 3, '0312', '074000', '中国,河北省,保定市,高碑店市', '115.87368', '39.32655', 'Gaobeidian',
        1);
INSERT INTO `provinces`
VALUES (130700, '张家口市', 130000, '张家口', 2, '0313', '075000', '中国,河北省,张家口市', '114.884091', '40.811901', 'Zhangjiakou', 1);
INSERT INTO `provinces`
VALUES (130702, '桥东区', 130700, '桥东', 3, '0313', '075000', '中国,河北省,张家口市,桥东区', '114.8943', '40.78844', 'Qiaodong', 1);
INSERT INTO `provinces`
VALUES (130703, '桥西区', 130700, '桥西', 3, '0313', '075061', '中国,河北省,张家口市,桥西区', '114.86962', '40.81945', 'Qiaoxi', 1);
INSERT INTO `provinces`
VALUES (130705, '宣化区', 130700, '宣化', 3, '0313', '075100', '中国,河北省,张家口市,宣化区', '115.06543', '40.60957', 'Xuanhua', 1);
INSERT INTO `provinces`
VALUES (130706, '下花园区', 130700, '下花园', 3, '0313', '075300', '中国,河北省,张家口市,下花园区', '115.28744', '40.50236', 'Xiahuayuan',
        1);
INSERT INTO `provinces`
VALUES (130721, '宣化县', 130700, '宣化', 3, '0313', '075100', '中国,河北省,张家口市,宣化县', '115.15497', '40.56618', 'Xuanhua', 1);
INSERT INTO `provinces`
VALUES (130722, '张北县', 130700, '张北', 3, '0313', '076450', '中国,河北省,张家口市,张北县', '114.71432', '41.15977', 'Zhangbei', 1);
INSERT INTO `provinces`
VALUES (130723, '康保县', 130700, '康保', 3, '0313', '076650', '中国,河北省,张家口市,康保县', '114.60031', '41.85126', 'Kangbao', 1);
INSERT INTO `provinces`
VALUES (130724, '沽源县', 130700, '沽源', 3, '0313', '076550', '中国,河北省,张家口市,沽源县', '115.68859', '41.66959', 'Guyuan', 1);
INSERT INTO `provinces`
VALUES (130725, '尚义县', 130700, '尚义', 3, '0313', '076750', '中国,河北省,张家口市,尚义县', '113.97134', '41.07782', 'Shangyi', 1);
INSERT INTO `provinces`
VALUES (130726, '蔚县', 130700, '蔚县', 3, '0313', '075700', '中国,河北省,张家口市,蔚县', '114.58892', '39.84067', 'Yuxian', 1);
INSERT INTO `provinces`
VALUES (130727, '阳原县', 130700, '阳原', 3, '0313', '075800', '中国,河北省,张家口市,阳原县', '114.15051', '40.10361', 'Yangyuan', 1);
INSERT INTO `provinces`
VALUES (130728, '怀安县', 130700, '怀安', 3, '0313', '076150', '中国,河北省,张家口市,怀安县', '114.38559', '40.67425', 'Huai\'an', 1);
INSERT INTO `provinces`
VALUES (130729, '万全县', 130700, '万全', 3, '0313', '076250', '中国,河北省,张家口市,万全县', '114.7405', '40.76694', 'Wanquan', 1);
INSERT INTO `provinces`
VALUES (130730, '怀来县', 130700, '怀来', 3, '0313', '075400', '中国,河北省,张家口市,怀来县', '115.51773', '40.41536', 'Huailai', 1);
INSERT INTO `provinces`
VALUES (130731, '涿鹿县', 130700, '涿鹿', 3, '0313', '075600', '中国,河北省,张家口市,涿鹿县', '115.22403', '40.37636', 'Zhuolu', 1);
INSERT INTO `provinces`
VALUES (130732, '赤城县', 130700, '赤城', 3, '0313', '075500', '中国,河北省,张家口市,赤城县', '115.83187', '40.91438', 'Chicheng', 1);
INSERT INTO `provinces`
VALUES (130733, '崇礼县', 130700, '崇礼', 3, '0313', '076350', '中国,河北省,张家口市,崇礼县', '115.27993', '40.97519', 'Chongli', 1);
INSERT INTO `provinces`
VALUES (130800, '承德市', 130000, '承德', 2, '0314', '067000', '中国,河北省,承德市', '117.939152', '40.976204', 'Chengde', 1);
INSERT INTO `provinces`
VALUES (130802, '双桥区', 130800, '双桥', 3, '0314', '067000', '中国,河北省,承德市,双桥区', '117.9432', '40.97466', 'Shuangqiao', 1);
INSERT INTO `provinces`
VALUES (130803, '双滦区', 130800, '双滦', 3, '0314', '067001', '中国,河北省,承德市,双滦区', '117.74487', '40.95375', 'Shuangluan', 1);
INSERT INTO `provinces`
VALUES (130804, '鹰手营子矿区', 130800, '鹰手营子矿区', 3, '0314', '067200', '中国,河北省,承德市,鹰手营子矿区', '117.65985', '40.54744',
        'Yingshouyingzikuangqu', 1);
INSERT INTO `provinces`
VALUES (130821, '承德县', 130800, '承德', 3, '0314', '067400', '中国,河北省,承德市,承德县', '118.17639', '40.76985', 'Chengde', 1);
INSERT INTO `provinces`
VALUES (130822, '兴隆县', 130800, '兴隆', 3, '0314', '067300', '中国,河北省,承德市,兴隆县', '117.50073', '40.41709', 'Xinglong', 1);
INSERT INTO `provinces`
VALUES (130823, '平泉县', 130800, '平泉', 3, '0314', '067500', '中国,河北省,承德市,平泉县', '118.70196', '41.01839', 'Pingquan', 1);
INSERT INTO `provinces`
VALUES (130824, '滦平县', 130800, '滦平', 3, '0314', '068250', '中国,河北省,承德市,滦平县', '117.33276', '40.94148', 'Luanping', 1);
INSERT INTO `provinces`
VALUES (130825, '隆化县', 130800, '隆化', 3, '0314', '068150', '中国,河北省,承德市,隆化县', '117.7297', '41.31412', 'Longhua', 1);
INSERT INTO `provinces`
VALUES (130826, '丰宁满族自治县', 130800, '丰宁', 3, '0314', '068350', '中国,河北省,承德市,丰宁满族自治县', '116.6492', '41.20481', 'Fengning',
        1);
INSERT INTO `provinces`
VALUES (130827, '宽城满族自治县', 130800, '宽城', 3, '0314', '067600', '中国,河北省,承德市,宽城满族自治县', '118.49176', '40.60829',
        'Kuancheng', 1);
INSERT INTO `provinces`
VALUES (130828, '围场满族蒙古族自治县', 130800, '围场', 3, '0314', '068450', '中国,河北省,承德市,围场满族蒙古族自治县', '117.7601', '41.94368',
        'Weichang', 1);
INSERT INTO `provinces`
VALUES (130900, '沧州市', 130000, '沧州', 2, '0317', '061001', '中国,河北省,沧州市', '116.857461', '38.310582', 'Cangzhou', 1);
INSERT INTO `provinces`
VALUES (130902, '新华区', 130900, '新华', 3, '0317', '061000', '中国,河北省,沧州市,新华区', '116.86643', '38.31438', 'Xinhua', 1);
INSERT INTO `provinces`
VALUES (130903, '运河区', 130900, '运河', 3, '0317', '061001', '中国,河北省,沧州市,运河区', '116.85706', '38.31352', 'Yunhe', 1);
INSERT INTO `provinces`
VALUES (130921, '沧县', 130900, '沧县', 3, '0317', '061000', '中国,河北省,沧州市,沧县', '116.87817', '38.29361', 'Cangxian', 1);
INSERT INTO `provinces`
VALUES (130922, '青县', 130900, '青县', 3, '0317', '062650', '中国,河北省,沧州市,青县', '116.80316', '38.58345', 'Qingxian', 1);
INSERT INTO `provinces`
VALUES (130923, '东光县', 130900, '东光', 3, '0317', '061600', '中国,河北省,沧州市,东光县', '116.53668', '37.8857', 'Dongguang', 1);
INSERT INTO `provinces`
VALUES (130924, '海兴县', 130900, '海兴', 3, '0317', '061200', '中国,河北省,沧州市,海兴县', '117.49758', '38.13958', 'Haixing', 1);
INSERT INTO `provinces`
VALUES (130925, '盐山县', 130900, '盐山', 3, '0317', '061300', '中国,河北省,沧州市,盐山县', '117.23092', '38.05647', 'Yanshan', 1);
INSERT INTO `provinces`
VALUES (130926, '肃宁县', 130900, '肃宁', 3, '0317', '062350', '中国,河北省,沧州市,肃宁县', '115.82971', '38.42272', 'Suning', 1);
INSERT INTO `provinces`
VALUES (130927, '南皮县', 130900, '南皮', 3, '0317', '061500', '中国,河北省,沧州市,南皮县', '116.70224', '38.04109', 'Nanpi', 1);
INSERT INTO `provinces`
VALUES (130928, '吴桥县', 130900, '吴桥', 3, '0317', '061800', '中国,河北省,沧州市,吴桥县', '116.3847', '37.62546', 'Wuqiao', 1);
INSERT INTO `provinces`
VALUES (130929, '献县', 130900, '献县', 3, '0317', '061260', '中国,河北省,沧州市,献县', '116.12695', '38.19228', 'Xianxian', 1);
INSERT INTO `provinces`
VALUES (130930, '孟村回族自治县', 130900, '孟村', 3, '0317', '061400', '中国,河北省,沧州市,孟村回族自治县', '117.10412', '38.05338', 'Mengcun',
        1);
INSERT INTO `provinces`
VALUES (130981, '泊头市', 130900, '泊头', 3, '0317', '062150', '中国,河北省,沧州市,泊头市', '116.57824', '38.08359', 'Botou', 1);
INSERT INTO `provinces`
VALUES (130982, '任丘市', 130900, '任丘', 3, '0317', '062550', '中国,河北省,沧州市,任丘市', '116.1033', '38.71124', 'Renqiu', 1);
INSERT INTO `provinces`
VALUES (130983, '黄骅市', 130900, '黄骅', 3, '0317', '061100', '中国,河北省,沧州市,黄骅市', '117.33883', '38.3706', 'Huanghua', 1);
INSERT INTO `provinces`
VALUES (130984, '河间市', 130900, '河间', 3, '0317', '062450', '中国,河北省,沧州市,河间市', '116.0993', '38.44549', 'Hejian', 1);
INSERT INTO `provinces`
VALUES (131000, '廊坊市', 130000, '廊坊', 2, '0316', '065000', '中国,河北省,廊坊市', '116.713873', '39.529244', 'Langfang', 1);
INSERT INTO `provinces`
VALUES (131002, '安次区', 131000, '安次', 3, '0316', '065000', '中国,河北省,廊坊市,安次区', '116.70308', '39.52057', 'Anci', 1);
INSERT INTO `provinces`
VALUES (131003, '广阳区', 131000, '广阳', 3, '0316', '065000', '中国,河北省,廊坊市,广阳区', '116.71069', '39.52278', 'Guangyang', 1);
INSERT INTO `provinces`
VALUES (131022, '固安县', 131000, '固安', 3, '0316', '065500', '中国,河北省,廊坊市,固安县', '116.29916', '39.43833', 'Gu\'an', 1);
INSERT INTO `provinces`
VALUES (131023, '永清县', 131000, '永清', 3, '0316', '065600', '中国,河北省,廊坊市,永清县', '116.50091', '39.32069', 'Yongqing', 1);
INSERT INTO `provinces`
VALUES (131024, '香河县', 131000, '香河', 3, '0316', '065400', '中国,河北省,廊坊市,香河县', '117.00634', '39.76133', 'Xianghe', 1);
INSERT INTO `provinces`
VALUES (131025, '大城县', 131000, '大城', 3, '0316', '065900', '中国,河北省,廊坊市,大城县', '116.65353', '38.70534', 'Daicheng', 1);
INSERT INTO `provinces`
VALUES (131026, '文安县', 131000, '文安', 3, '0316', '065800', '中国,河北省,廊坊市,文安县', '116.45846', '38.87325', 'Wen\'an', 1);
INSERT INTO `provinces`
VALUES (131028, '大厂回族自治县', 131000, '大厂', 3, '0316', '065300', '中国,河北省,廊坊市,大厂回族自治县', '116.98916', '39.88649', 'Dachang',
        1);
INSERT INTO `provinces`
VALUES (131081, '霸州市', 131000, '霸州', 3, '0316', '065700', '中国,河北省,廊坊市,霸州市', '116.39154', '39.12569', 'Bazhou', 1);
INSERT INTO `provinces`
VALUES (131082, '三河市', 131000, '三河', 3, '0316', '065200', '中国,河北省,廊坊市,三河市', '117.07229', '39.98358', 'Sanhe', 1);
INSERT INTO `provinces`
VALUES (131100, '衡水市', 130000, '衡水', 2, '0318', '053000', '中国,河北省,衡水市', '115.665993', '37.735097', 'Hengshui', 1);
INSERT INTO `provinces`
VALUES (131102, '桃城区', 131100, '桃城', 3, '0318', '053000', '中国,河北省,衡水市,桃城区', '115.67529', '37.73499', 'Taocheng', 1);
INSERT INTO `provinces`
VALUES (131121, '枣强县', 131100, '枣强', 3, '0318', '053100', '中国,河北省,衡水市,枣强县', '115.72576', '37.51027', 'Zaoqiang', 1);
INSERT INTO `provinces`
VALUES (131122, '武邑县', 131100, '武邑', 3, '0318', '053400', '中国,河北省,衡水市,武邑县', '115.88748', '37.80181', 'Wuyi', 1);
INSERT INTO `provinces`
VALUES (131123, '武强县', 131100, '武强', 3, '0318', '053300', '中国,河北省,衡水市,武强县', '115.98226', '38.04138', 'Wuqiang', 1);
INSERT INTO `provinces`
VALUES (131124, '饶阳县', 131100, '饶阳', 3, '0318', '053900', '中国,河北省,衡水市,饶阳县', '115.72558', '38.23529', 'Raoyang', 1);
INSERT INTO `provinces`
VALUES (131125, '安平县', 131100, '安平', 3, '0318', '053600', '中国,河北省,衡水市,安平县', '115.51876', '38.23388', 'Anping', 1);
INSERT INTO `provinces`
VALUES (131126, '故城县', 131100, '故城', 3, '0318', '053800', '中国,河北省,衡水市,故城县', '115.97076', '37.34773', 'Gucheng', 1);
INSERT INTO `provinces`
VALUES (131127, '景县', 131100, '景县', 3, '0318', '053500', '中国,河北省,衡水市,景县', '116.26904', '37.6926', 'Jingxian', 1);
INSERT INTO `provinces`
VALUES (131128, '阜城县', 131100, '阜城', 3, '0318', '053700', '中国,河北省,衡水市,阜城县', '116.14431', '37.86881', 'Fucheng', 1);
INSERT INTO `provinces`
VALUES (131181, '冀州市', 131100, '冀州', 3, '0318', '053200', '中国,河北省,衡水市,冀州市', '115.57934', '37.55082', 'Jizhou', 1);
INSERT INTO `provinces`
VALUES (131182, '深州市', 131100, '深州', 3, '0318', '053800', '中国,河北省,衡水市,深州市', '115.55993', '38.00109', 'Shenzhou', 1);
INSERT INTO `provinces`
VALUES (140000, '山西省', 100000, '山西', 1, '', '', '中国,山西省', '112.549248', '37.857014', 'Shanxi', 1);
INSERT INTO `provinces`
VALUES (140100, '太原市', 140000, '太原', 2, '0351', '030082', '中国,山西省,太原市', '112.549248', '37.857014', 'Taiyuan', 1);
INSERT INTO `provinces`
VALUES (140105, '小店区', 140100, '小店', 3, '0351', '030032', '中国,山西省,太原市,小店区', '112.56878', '37.73565', 'Xiaodian', 1);
INSERT INTO `provinces`
VALUES (140106, '迎泽区', 140100, '迎泽', 3, '0351', '030002', '中国,山西省,太原市,迎泽区', '112.56338', '37.86326', 'Yingze', 1);
INSERT INTO `provinces`
VALUES (140107, '杏花岭区', 140100, '杏花岭', 3, '0351', '030009', '中国,山西省,太原市,杏花岭区', '112.56237', '37.88429', 'Xinghualing',
        1);
INSERT INTO `provinces`
VALUES (140108, '尖草坪区', 140100, '尖草坪', 3, '0351', '030023', '中国,山西省,太原市,尖草坪区', '112.48709', '37.94193', 'Jiancaoping',
        1);
INSERT INTO `provinces`
VALUES (140109, '万柏林区', 140100, '万柏林', 3, '0351', '030024', '中国,山西省,太原市,万柏林区', '112.51553', '37.85923', 'Wanbailin', 1);
INSERT INTO `provinces`
VALUES (140110, '晋源区', 140100, '晋源', 3, '0351', '030025', '中国,山西省,太原市,晋源区', '112.47985', '37.72479', 'Jinyuan', 1);
INSERT INTO `provinces`
VALUES (140121, '清徐县', 140100, '清徐', 3, '0351', '030400', '中国,山西省,太原市,清徐县', '112.35888', '37.60758', 'Qingxu', 1);
INSERT INTO `provinces`
VALUES (140122, '阳曲县', 140100, '阳曲', 3, '0351', '030100', '中国,山西省,太原市,阳曲县', '112.67861', '38.05989', 'Yangqu', 1);
INSERT INTO `provinces`
VALUES (140123, '娄烦县', 140100, '娄烦', 3, '0351', '030300', '中国,山西省,太原市,娄烦县', '111.79473', '38.06689', 'Loufan', 1);
INSERT INTO `provinces`
VALUES (140126, '浑源县', 140200, '浑源', 3, '0352', '037400', '中国,山西省,大同市,浑源县', '113.69552', '39.69962', 'Hunyuan', 1);
INSERT INTO `provinces`
VALUES (140181, '古交市', 140100, '古交', 3, '0351', '030200', '中国,山西省,太原市,古交市', '112.16918', '37.90983', 'Gujiao', 1);
INSERT INTO `provinces`
VALUES (140200, '大同市', 140000, '大同', 2, '0352', '037008', '中国,山西省,大同市', '113.295259', '40.09031', 'Datong', 1);
INSERT INTO `provinces`
VALUES (140202, '城区', 140200, '城区', 3, '0352', '037008', '中国,山西省,大同市,城区', '113.298', '40.07566', 'Chengqu', 1);
INSERT INTO `provinces`
VALUES (140203, '矿区', 140200, '矿区', 3, '0352', '037003', '中国,山西省,大同市,矿区', '113.1772', '40.03685', 'Kuangqu', 1);
INSERT INTO `provinces`
VALUES (140211, '南郊区', 140200, '南郊', 3, '0352', '037001', '中国,山西省,大同市,南郊区', '113.14947', '40.00539', 'Nanjiao', 1);
INSERT INTO `provinces`
VALUES (140212, '新荣区', 140200, '新荣', 3, '0352', '037002', '中国,山西省,大同市,新荣区', '113.13504', '40.25618', 'Xinrong', 1);
INSERT INTO `provinces`
VALUES (140221, '阳高县', 140200, '阳高', 3, '0352', '038100', '中国,山西省,大同市,阳高县', '113.75012', '40.36256', 'Yanggao', 1);
INSERT INTO `provinces`
VALUES (140222, '天镇县', 140200, '天镇', 3, '0352', '038200', '中国,山西省,大同市,天镇县', '114.0931', '40.42299', 'Tianzhen', 1);
INSERT INTO `provinces`
VALUES (140223, '广灵县', 140200, '广灵', 3, '0352', '037500', '中国,山西省,大同市,广灵县', '114.28204', '39.76082', 'Guangling', 1);
INSERT INTO `provinces`
VALUES (140224, '灵丘县', 140200, '灵丘', 3, '0352', '034400', '中国,山西省,大同市,灵丘县', '114.23672', '39.44043', 'Lingqiu', 1);
INSERT INTO `provinces`
VALUES (140226, '左云县', 140200, '左云', 3, '0352', '037100', '中国,山西省,大同市,左云县', '112.70266', '40.01336', 'Zuoyun', 1);
INSERT INTO `provinces`
VALUES (140227, '大同县', 140200, '大同', 3, '0352', '037300', '中国,山西省,大同市,大同县', '113.61212', '40.04012', 'Datong', 1);
INSERT INTO `provinces`
VALUES (140300, '阳泉市', 140000, '阳泉', 2, '0353', '045000', '中国,山西省,阳泉市', '113.583285', '37.861188', 'Yangquan', 1);
INSERT INTO `provinces`
VALUES (140302, '城区', 140300, '城区', 3, '0353', '045000', '中国,山西省,阳泉市,城区', '113.60069', '37.8474', 'Chengqu', 1);
INSERT INTO `provinces`
VALUES (140303, '矿区', 140300, '矿区', 3, '0353', '045000', '中国,山西省,阳泉市,矿区', '113.55677', '37.86895', 'Kuangqu', 1);
INSERT INTO `provinces`
VALUES (140311, '郊区', 140300, '郊区', 3, '0353', '045011', '中国,山西省,阳泉市,郊区', '113.58539', '37.94139', 'Jiaoqu', 1);
INSERT INTO `provinces`
VALUES (140321, '平定县', 140300, '平定', 3, '0353', '045200', '中国,山西省,阳泉市,平定县', '113.65789', '37.78601', 'Pingding', 1);
INSERT INTO `provinces`
VALUES (140322, '盂县', 140300, '盂县', 3, '0353', '045100', '中国,山西省,阳泉市,盂县', '113.41235', '38.08579', 'Yuxian', 1);
INSERT INTO `provinces`
VALUES (140400, '长治市', 140000, '长治', 2, '0355', '046000', '中国,山西省,长治市', '113.113556', '36.191112', 'Changzhi', 1);
INSERT INTO `provinces`
VALUES (140402, '城区', 140400, '城区', 3, '0355', '046011', '中国,山西省,长治市,城区', '113.12308', '36.20351', 'Chengqu', 1);
INSERT INTO `provinces`
VALUES (140411, '郊区', 140400, '郊区', 3, '0355', '046011', '中国,山西省,长治市,郊区', '113.12653', '36.19918', 'Jiaoqu', 1);
INSERT INTO `provinces`
VALUES (140421, '长治县', 140400, '长治', 3, '0355', '047100', '中国,山西省,长治市,长治县', '113.04791', '36.04722', 'Changzhi', 1);
INSERT INTO `provinces`
VALUES (140423, '襄垣县', 140400, '襄垣', 3, '0355', '046200', '中国,山西省,长治市,襄垣县', '113.05157', '36.53527', 'Xiangyuan', 1);
INSERT INTO `provinces`
VALUES (140424, '屯留县', 140400, '屯留', 3, '0355', '046100', '中国,山西省,长治市,屯留县', '112.89196', '36.31579', 'Tunliu', 1);
INSERT INTO `provinces`
VALUES (140425, '平顺县', 140400, '平顺', 3, '0355', '047400', '中国,山西省,长治市,平顺县', '113.43603', '36.20005', 'Pingshun', 1);
INSERT INTO `provinces`
VALUES (140426, '黎城县', 140400, '黎城', 3, '0355', '047600', '中国,山西省,长治市,黎城县', '113.38766', '36.50301', 'Licheng', 1);
INSERT INTO `provinces`
VALUES (140427, '壶关县', 140400, '壶关', 3, '0355', '047300', '中国,山西省,长治市,壶关县', '113.207', '36.11301', 'Huguan', 1);
INSERT INTO `provinces`
VALUES (140428, '长子县', 140400, '长子', 3, '0355', '046600', '中国,山西省,长治市,长子县', '112.87731', '36.12125', 'Zhangzi', 1);
INSERT INTO `provinces`
VALUES (140429, '武乡县', 140400, '武乡', 3, '0355', '046300', '中国,山西省,长治市,武乡县', '112.86343', '36.83687', 'Wuxiang', 1);
INSERT INTO `provinces`
VALUES (140430, '沁县', 140400, '沁县', 3, '0355', '046400', '中国,山西省,长治市,沁县', '112.69863', '36.75628', 'Qinxian', 1);
INSERT INTO `provinces`
VALUES (140431, '沁源县', 140400, '沁源', 3, '0355', '046500', '中国,山西省,长治市,沁源县', '112.33758', '36.50008', 'Qinyuan', 1);
INSERT INTO `provinces`
VALUES (140481, '潞城市', 140400, '潞城', 3, '0355', '047500', '中国,山西省,长治市,潞城市', '113.22888', '36.33414', 'Lucheng', 1);
INSERT INTO `provinces`
VALUES (140500, '晋城市', 140000, '晋城', 2, '0356', '048000', '中国,山西省,晋城市', '112.851274', '35.497553', 'Jincheng', 1);
INSERT INTO `provinces`
VALUES (140502, '城区', 140500, '城区', 3, '0356', '048000', '中国,山西省,晋城市,城区', '112.85319', '35.50175', 'Chengqu', 1);
INSERT INTO `provinces`
VALUES (140521, '沁水县', 140500, '沁水', 3, '0356', '048200', '中国,山西省,晋城市,沁水县', '112.1871', '35.69102', 'Qinshui', 1);
INSERT INTO `provinces`
VALUES (140522, '阳城县', 140500, '阳城', 3, '0356', '048100', '中国,山西省,晋城市,阳城县', '112.41485', '35.48614', 'Yangcheng', 1);
INSERT INTO `provinces`
VALUES (140524, '陵川县', 140500, '陵川', 3, '0356', '048300', '中国,山西省,晋城市,陵川县', '113.2806', '35.77532', 'Lingchuan', 1);
INSERT INTO `provinces`
VALUES (140525, '泽州县', 140500, '泽州', 3, '0356', '048012', '中国,山西省,晋城市,泽州县', '112.83947', '35.50789', 'Zezhou', 1);
INSERT INTO `provinces`
VALUES (140581, '高平市', 140500, '高平', 3, '0356', '048400', '中国,山西省,晋城市,高平市', '112.92288', '35.79705', 'Gaoping', 1);
INSERT INTO `provinces`
VALUES (140600, '朔州市', 140000, '朔州', 2, '0349', '038500', '中国,山西省,朔州市', '112.433387', '39.331261', 'Shuozhou', 1);
INSERT INTO `provinces`
VALUES (140602, '朔城区', 140600, '朔城', 3, '0349', '036000', '中国,山西省,朔州市,朔城区', '112.43189', '39.31982', 'Shuocheng', 1);
INSERT INTO `provinces`
VALUES (140603, '平鲁区', 140600, '平鲁', 3, '0349', '038600', '中国,山西省,朔州市,平鲁区', '112.28833', '39.51155', 'Pinglu', 1);
INSERT INTO `provinces`
VALUES (140621, '山阴县', 140600, '山阴', 3, '0349', '036900', '中国,山西省,朔州市,山阴县', '112.81662', '39.52697', 'Shanyin', 1);
INSERT INTO `provinces`
VALUES (140622, '应县', 140600, '应县', 3, '0349', '037600', '中国,山西省,朔州市,应县', '113.19052', '39.55279', 'Yingxian', 1);
INSERT INTO `provinces`
VALUES (140623, '右玉县', 140600, '右玉', 3, '0349', '037200', '中国,山西省,朔州市,右玉县', '112.46902', '39.99011', 'Youyu', 1);
INSERT INTO `provinces`
VALUES (140624, '怀仁县', 140600, '怀仁', 3, '0349', '038300', '中国,山西省,朔州市,怀仁县', '113.10009', '39.82806', 'Huairen', 1);
INSERT INTO `provinces`
VALUES (140700, '晋中市', 140000, '晋中', 2, '0354', '030600', '中国,山西省,晋中市', '112.736465', '37.696495', 'Jinzhong', 1);
INSERT INTO `provinces`
VALUES (140702, '榆次区', 140700, '榆次', 3, '0354', '030600', '中国,山西省,晋中市,榆次区', '112.70788', '37.6978', 'Yuci', 1);
INSERT INTO `provinces`
VALUES (140721, '榆社县', 140700, '榆社', 3, '0354', '031800', '中国,山西省,晋中市,榆社县', '112.97558', '37.0721', 'Yushe', 1);
INSERT INTO `provinces`
VALUES (140722, '左权县', 140700, '左权', 3, '0354', '032600', '中国,山西省,晋中市,左权县', '113.37918', '37.08235', 'Zuoquan', 1);
INSERT INTO `provinces`
VALUES (140723, '和顺县', 140700, '和顺', 3, '0354', '032700', '中国,山西省,晋中市,和顺县', '113.56988', '37.32963', 'Heshun', 1);
INSERT INTO `provinces`
VALUES (140724, '昔阳县', 140700, '昔阳', 3, '0354', '045300', '中国,山西省,晋中市,昔阳县', '113.70517', '37.61863', 'Xiyang', 1);
INSERT INTO `provinces`
VALUES (140725, '寿阳县', 140700, '寿阳', 3, '0354', '045400', '中国,山西省,晋中市,寿阳县', '113.17495', '37.88899', 'Shouyang', 1);
INSERT INTO `provinces`
VALUES (140726, '太谷县', 140700, '太谷', 3, '0354', '030800', '中国,山西省,晋中市,太谷县', '112.55246', '37.42161', 'Taigu', 1);
INSERT INTO `provinces`
VALUES (140727, '祁县', 140700, '祁县', 3, '0354', '030900', '中国,山西省,晋中市,祁县', '112.33358', '37.3579', 'Qixian', 1);
INSERT INTO `provinces`
VALUES (140728, '平遥县', 140700, '平遥', 3, '0354', '031100', '中国,山西省,晋中市,平遥县', '112.17553', '37.1892', 'Pingyao', 1);
INSERT INTO `provinces`
VALUES (140729, '灵石县', 140700, '灵石', 3, '0354', '031300', '中国,山西省,晋中市,灵石县', '111.7774', '36.84814', 'Lingshi', 1);
INSERT INTO `provinces`
VALUES (140781, '介休市', 140700, '介休', 3, '0354', '032000', '中国,山西省,晋中市,介休市', '111.91824', '37.02771', 'Jiexiu', 1);
INSERT INTO `provinces`
VALUES (140800, '运城市', 140000, '运城', 2, '0359', '044000', '中国,山西省,运城市', '111.003957', '35.022778', 'Yuncheng', 1);
INSERT INTO `provinces`
VALUES (140802, '盐湖区', 140800, '盐湖', 3, '0359', '044000', '中国,山西省,运城市,盐湖区', '110.99827', '35.0151', 'Yanhu', 1);
INSERT INTO `provinces`
VALUES (140821, '临猗县', 140800, '临猗', 3, '0359', '044100', '中国,山西省,运城市,临猗县', '110.77432', '35.14455', 'Linyi', 1);
INSERT INTO `provinces`
VALUES (140822, '万荣县', 140800, '万荣', 3, '0359', '044200', '中国,山西省,运城市,万荣县', '110.83657', '35.41556', 'Wanrong', 1);
INSERT INTO `provinces`
VALUES (140823, '闻喜县', 140800, '闻喜', 3, '0359', '043800', '中国,山西省,运城市,闻喜县', '111.22265', '35.35553', 'Wenxi', 1);
INSERT INTO `provinces`
VALUES (140824, '稷山县', 140800, '稷山', 3, '0359', '043200', '中国,山西省,运城市,稷山县', '110.97924', '35.59993', 'Jishan', 1);
INSERT INTO `provinces`
VALUES (140825, '新绛县', 140800, '新绛', 3, '0359', '043100', '中国,山西省,运城市,新绛县', '111.12609', '35.61566', 'Xinjiang', 1);
INSERT INTO `provinces`
VALUES (140826, '绛县', 140800, '绛县', 3, '0359', '043600', '中国,山西省,运城市,绛县', '111.56668', '35.49096', 'Jiangxian', 1);
INSERT INTO `provinces`
VALUES (140827, '垣曲县', 140800, '垣曲', 3, '0359', '043700', '中国,山西省,运城市,垣曲县', '111.67166', '35.29923', 'Yuanqu', 1);
INSERT INTO `provinces`
VALUES (140828, '夏县', 140800, '夏县', 3, '0359', '044400', '中国,山西省,运城市,夏县', '111.21966', '35.14121', 'Xiaxian', 1);
INSERT INTO `provinces`
VALUES (140829, '平陆县', 140800, '平陆', 3, '0359', '044300', '中国,山西省,运城市,平陆县', '111.21704', '34.83772', 'Pinglu', 1);
INSERT INTO `provinces`
VALUES (140830, '芮城县', 140800, '芮城', 3, '0359', '044600', '中国,山西省,运城市,芮城县', '110.69455', '34.69384', 'Ruicheng', 1);
INSERT INTO `provinces`
VALUES (140881, '永济市', 140800, '永济', 3, '0359', '044500', '中国,山西省,运城市,永济市', '110.44537', '34.86556', 'Yongji', 1);
INSERT INTO `provinces`
VALUES (140882, '河津市', 140800, '河津', 3, '0359', '043300', '中国,山西省,运城市,河津市', '110.7116', '35.59478', 'Hejin', 1);
INSERT INTO `provinces`
VALUES (140900, '忻州市', 140000, '忻州', 2, '0350', '034000', '中国,山西省,忻州市', '112.733538', '38.41769', 'Xinzhou', 1);
INSERT INTO `provinces`
VALUES (140902, '忻府区', 140900, '忻府', 3, '0350', '034000', '中国,山西省,忻州市,忻府区', '112.74603', '38.40414', 'Xinfu', 1);
INSERT INTO `provinces`
VALUES (140921, '定襄县', 140900, '定襄', 3, '0350', '035400', '中国,山西省,忻州市,定襄县', '112.95733', '38.47387', 'Dingxiang', 1);
INSERT INTO `provinces`
VALUES (140922, '五台县', 140900, '五台', 3, '0350', '035500', '中国,山西省,忻州市,五台县', '113.25256', '38.72774', 'Wutai', 1);
INSERT INTO `provinces`
VALUES (140923, '代县', 140900, '代县', 3, '0350', '034200', '中国,山西省,忻州市,代县', '112.95913', '39.06717', 'Daixian', 1);
INSERT INTO `provinces`
VALUES (140924, '繁峙县', 140900, '繁峙', 3, '0350', '034300', '中国,山西省,忻州市,繁峙县', '113.26303', '39.18886', 'Fanshi', 1);
INSERT INTO `provinces`
VALUES (140925, '宁武县', 140900, '宁武', 3, '0350', '036700', '中国,山西省,忻州市,宁武县', '112.30423', '39.00211', 'Ningwu', 1);
INSERT INTO `provinces`
VALUES (140926, '静乐县', 140900, '静乐', 3, '0350', '035100', '中国,山西省,忻州市,静乐县', '111.94158', '38.3602', 'Jingle', 1);
INSERT INTO `provinces`
VALUES (140927, '神池县', 140900, '神池', 3, '0350', '036100', '中国,山西省,忻州市,神池县', '112.20541', '39.09', 'Shenchi', 1);
INSERT INTO `provinces`
VALUES (140928, '五寨县', 140900, '五寨', 3, '0350', '036200', '中国,山西省,忻州市,五寨县', '111.8489', '38.90757', 'Wuzhai', 1);
INSERT INTO `provinces`
VALUES (140929, '岢岚县', 140900, '岢岚', 3, '0350', '036300', '中国,山西省,忻州市,岢岚县', '111.57388', '38.70452', 'Kelan', 1);
INSERT INTO `provinces`
VALUES (140930, '河曲县', 140900, '河曲', 3, '0350', '036500', '中国,山西省,忻州市,河曲县', '111.13821', '39.38439', 'Hequ', 1);
INSERT INTO `provinces`
VALUES (140931, '保德县', 140900, '保德', 3, '0350', '036600', '中国,山西省,忻州市,保德县', '111.08656', '39.02248', 'Baode', 1);
INSERT INTO `provinces`
VALUES (140932, '偏关县', 140900, '偏关', 3, '0350', '036400', '中国,山西省,忻州市,偏关县', '111.50863', '39.43609', 'Pianguan', 1);
INSERT INTO `provinces`
VALUES (140981, '原平市', 140900, '原平', 3, '0350', '034100', '中国,山西省,忻州市,原平市', '112.70584', '38.73181', 'Yuanping', 1);
INSERT INTO `provinces`
VALUES (141000, '临汾市', 140000, '临汾', 2, '0357', '041000', '中国,山西省,临汾市', '111.517973', '36.08415', 'Linfen', 1);
INSERT INTO `provinces`
VALUES (141002, '尧都区', 141000, '尧都', 3, '0357', '041000', '中国,山西省,临汾市,尧都区', '111.5787', '36.08298', 'Yaodu', 1);
INSERT INTO `provinces`
VALUES (141021, '曲沃县', 141000, '曲沃', 3, '0357', '043400', '中国,山西省,临汾市,曲沃县', '111.47525', '35.64119', 'Quwo', 1);
INSERT INTO `provinces`
VALUES (141022, '翼城县', 141000, '翼城', 3, '0357', '043500', '中国,山西省,临汾市,翼城县', '111.7181', '35.73881', 'Yicheng', 1);
INSERT INTO `provinces`
VALUES (141023, '襄汾县', 141000, '襄汾', 3, '0357', '041500', '中国,山西省,临汾市,襄汾县', '111.44204', '35.87711', 'Xiangfen', 1);
INSERT INTO `provinces`
VALUES (141024, '洪洞县', 141000, '洪洞', 3, '0357', '041600', '中国,山西省,临汾市,洪洞县', '111.67501', '36.25425', 'Hongtong', 1);
INSERT INTO `provinces`
VALUES (141025, '古县', 141000, '古县', 3, '0357', '042400', '中国,山西省,临汾市,古县', '111.92041', '36.26688', 'Guxian', 1);
INSERT INTO `provinces`
VALUES (141026, '安泽县', 141000, '安泽', 3, '0357', '042500', '中国,山西省,临汾市,安泽县', '112.24981', '36.14803', 'Anze', 1);
INSERT INTO `provinces`
VALUES (141027, '浮山县', 141000, '浮山', 3, '0357', '042600', '中国,山西省,临汾市,浮山县', '111.84744', '35.96854', 'Fushan', 1);
INSERT INTO `provinces`
VALUES (141028, '吉县', 141000, '吉县', 3, '0357', '042200', '中国,山西省,临汾市,吉县', '110.68148', '36.09873', 'Jixian', 1);
INSERT INTO `provinces`
VALUES (141029, '乡宁县', 141000, '乡宁', 3, '0357', '042100', '中国,山西省,临汾市,乡宁县', '110.84652', '35.97072', 'Xiangning', 1);
INSERT INTO `provinces`
VALUES (141030, '大宁县', 141000, '大宁', 3, '0357', '042300', '中国,山西省,临汾市,大宁县', '110.75216', '36.46624', 'Daning', 1);
INSERT INTO `provinces`
VALUES (141031, '隰县', 141000, '隰县', 3, '0357', '041300', '中国,山西省,临汾市,隰县', '110.93881', '36.69258', 'Xixian', 1);
INSERT INTO `provinces`
VALUES (141032, '永和县', 141000, '永和', 3, '0357', '041400', '中国,山西省,临汾市,永和县', '110.63168', '36.7584', 'Yonghe', 1);
INSERT INTO `provinces`
VALUES (141033, '蒲县', 141000, '蒲县', 3, '0357', '041200', '中国,山西省,临汾市,蒲县', '111.09674', '36.41243', 'Puxian', 1);
INSERT INTO `provinces`
VALUES (141034, '汾西县', 141000, '汾西', 3, '0357', '031500', '中国,山西省,临汾市,汾西县', '111.56811', '36.65063', 'Fenxi', 1);
INSERT INTO `provinces`
VALUES (141081, '侯马市', 141000, '侯马', 3, '0357', '043000', '中国,山西省,临汾市,侯马市', '111.37207', '35.61903', 'Houma', 1);
INSERT INTO `provinces`
VALUES (141082, '霍州市', 141000, '霍州', 3, '0357', '031400', '中国,山西省,临汾市,霍州市', '111.755', '36.5638', 'Huozhou', 1);
INSERT INTO `provinces`
VALUES (141100, '吕梁市', 140000, '吕梁', 2, '0358', '033000', '中国,山西省,吕梁市', '111.134335', '37.524366', 'Lvliang', 1);
INSERT INTO `provinces`
VALUES (141102, '离石区', 141100, '离石', 3, '0358', '033000', '中国,山西省,吕梁市,离石区', '111.15059', '37.5177', 'Lishi', 1);
INSERT INTO `provinces`
VALUES (141121, '文水县', 141100, '文水', 3, '0358', '032100', '中国,山西省,吕梁市,文水县', '112.02829', '37.43841', 'Wenshui', 1);
INSERT INTO `provinces`
VALUES (141122, '交城县', 141100, '交城', 3, '0358', '030500', '中国,山西省,吕梁市,交城县', '112.1585', '37.5512', 'Jiaocheng', 1);
INSERT INTO `provinces`
VALUES (141123, '兴县', 141100, '兴县', 3, '0358', '033600', '中国,山西省,吕梁市,兴县', '111.12692', '38.46321', 'Xingxian', 1);
INSERT INTO `provinces`
VALUES (141124, '临县', 141100, '临县', 3, '0358', '033200', '中国,山西省,吕梁市,临县', '110.99282', '37.95271', 'Linxian', 1);
INSERT INTO `provinces`
VALUES (141125, '柳林县', 141100, '柳林', 3, '0358', '033300', '中国,山西省,吕梁市,柳林县', '110.88922', '37.42932', 'Liulin', 1);
INSERT INTO `provinces`
VALUES (141126, '石楼县', 141100, '石楼', 3, '0358', '032500', '中国,山西省,吕梁市,石楼县', '110.8352', '36.99731', 'Shilou', 1);
INSERT INTO `provinces`
VALUES (141127, '岚县', 141100, '岚县', 3, '0358', '033500', '中国,山西省,吕梁市,岚县', '111.67627', '38.27874', 'Lanxian', 1);
INSERT INTO `provinces`
VALUES (141128, '方山县', 141100, '方山', 3, '0358', '033100', '中国,山西省,吕梁市,方山县', '111.24011', '37.88979', 'Fangshan', 1);
INSERT INTO `provinces`
VALUES (141129, '中阳县', 141100, '中阳', 3, '0358', '033400', '中国,山西省,吕梁市,中阳县', '111.1795', '37.35715', 'Zhongyang', 1);
INSERT INTO `provinces`
VALUES (141130, '交口县', 141100, '交口', 3, '0358', '032400', '中国,山西省,吕梁市,交口县', '111.18103', '36.98213', 'Jiaokou', 1);
INSERT INTO `provinces`
VALUES (141181, '孝义市', 141100, '孝义', 3, '0358', '032300', '中国,山西省,吕梁市,孝义市', '111.77362', '37.14414', 'Xiaoyi', 1);
INSERT INTO `provinces`
VALUES (141182, '汾阳市', 141100, '汾阳', 3, '0358', '032200', '中国,山西省,吕梁市,汾阳市', '111.7882', '37.26605', 'Fenyang', 1);
INSERT INTO `provinces`
VALUES (150000, '内蒙古自治区', 100000, '内蒙古', 1, '', '', '中国,内蒙古自治区', '111.670801', '40.818311', 'Inner Mongolia', 1);
INSERT INTO `provinces`
VALUES (150100, '呼和浩特市', 150000, '呼和浩特', 2, '0471', '010000', '中国,内蒙古自治区,呼和浩特市', '111.670801', '40.818311', 'Hohhot',
        1);
INSERT INTO `provinces`
VALUES (150102, '新城区', 150100, '新城', 3, '0471', '010050', '中国,内蒙古自治区,呼和浩特市,新城区', '111.66554', '40.85828', 'Xincheng',
        1);
INSERT INTO `provinces`
VALUES (150103, '回民区', 150100, '回民', 3, '0471', '010030', '中国,内蒙古自治区,呼和浩特市,回民区', '111.62402', '40.80827', 'Huimin', 1);
INSERT INTO `provinces`
VALUES (150104, '玉泉区', 150100, '玉泉', 3, '0471', '010020', '中国,内蒙古自治区,呼和浩特市,玉泉区', '111.67456', '40.75227', 'Yuquan', 1);
INSERT INTO `provinces`
VALUES (150105, '赛罕区', 150100, '赛罕', 3, '0471', '010020', '中国,内蒙古自治区,呼和浩特市,赛罕区', '111.70224', '40.79207', 'Saihan', 1);
INSERT INTO `provinces`
VALUES (150121, '土默特左旗', 150100, '土默特左旗', 3, '0471', '010100', '中国,内蒙古自治区,呼和浩特市,土默特左旗', '111.14898', '40.72229',
        'Tumotezuoqi', 1);
INSERT INTO `provinces`
VALUES (150122, '托克托县', 150100, '托克托', 3, '0471', '010200', '中国,内蒙古自治区,呼和浩特市,托克托县', '111.19101', '40.27492', 'Tuoketuo',
        1);
INSERT INTO `provinces`
VALUES (150123, '和林格尔县', 150100, '和林格尔', 3, '0471', '011500', '中国,内蒙古自治区,呼和浩特市,和林格尔县', '111.82205', '40.37892',
        'Helingeer', 1);
INSERT INTO `provinces`
VALUES (150124, '清水河县', 150100, '清水河', 3, '0471', '011600', '中国,内蒙古自治区,呼和浩特市,清水河县', '111.68316', '39.9097',
        'Qingshuihe', 1);
INSERT INTO `provinces`
VALUES (150125, '武川县', 150100, '武川', 3, '0471', '011700', '中国,内蒙古自治区,呼和浩特市,武川县', '111.45785', '41.09289', 'Wuchuan', 1);
INSERT INTO `provinces`
VALUES (150200, '包头市', 150000, '包头', 2, '0472', '014025', '中国,内蒙古自治区,包头市', '109.840405', '40.658168', 'Baotou', 1);
INSERT INTO `provinces`
VALUES (150202, '东河区', 150200, '东河', 3, '0472', '014040', '中国,内蒙古自治区,包头市,东河区', '110.0462', '40.58237', 'Donghe', 1);
INSERT INTO `provinces`
VALUES (150203, '昆都仑区', 150200, '昆都仑', 3, '0472', '014010', '中国,内蒙古自治区,包头市,昆都仑区', '109.83862', '40.64175', 'Kundulun',
        1);
INSERT INTO `provinces`
VALUES (150204, '青山区', 150200, '青山', 3, '0472', '014030', '中国,内蒙古自治区,包头市,青山区', '109.90131', '40.64329', 'Qingshan', 1);
INSERT INTO `provinces`
VALUES (150205, '石拐区', 150200, '石拐', 3, '0472', '014070', '中国,内蒙古自治区,包头市,石拐区', '110.27322', '40.67297', 'Shiguai', 1);
INSERT INTO `provinces`
VALUES (150206, '白云鄂博矿区', 150200, '白云鄂博矿区', 3, '0472', '014080', '中国,内蒙古自治区,包头市,白云鄂博矿区', '109.97367', '41.76968',
        'Baiyunebokuangqu', 1);
INSERT INTO `provinces`
VALUES (150207, '九原区', 150200, '九原', 3, '0472', '014060', '中国,内蒙古自治区,包头市,九原区', '109.96496', '40.60554', 'Jiuyuan', 1);
INSERT INTO `provinces`
VALUES (150221, '土默特右旗', 150200, '土默特右旗', 3, '0472', '014100', '中国,内蒙古自治区,包头市,土默特右旗', '110.52417', '40.5688',
        'Tumoteyouqi', 1);
INSERT INTO `provinces`
VALUES (150222, '固阳县', 150200, '固阳', 3, '0472', '014200', '中国,内蒙古自治区,包头市,固阳县', '110.06372', '41.01851', 'Guyang', 1);
INSERT INTO `provinces`
VALUES (150223, '达尔罕茂明安联合旗', 150200, '达茂旗', 3, '0472', '014500', '中国,内蒙古自治区,包头市,达尔罕茂明安联合旗', '110.43258', '41.69875',
        'Damaoqi', 1);
INSERT INTO `provinces`
VALUES (150300, '乌海市', 150000, '乌海', 2, '0473', '016000', '中国,内蒙古自治区,乌海市', '106.825563', '39.673734', 'Wuhai', 1);
INSERT INTO `provinces`
VALUES (150302, '海勃湾区', 150300, '海勃湾', 3, '0473', '016000', '中国,内蒙古自治区,乌海市,海勃湾区', '106.8222', '39.66955', 'Haibowan',
        1);
INSERT INTO `provinces`
VALUES (150303, '海南区', 150300, '海南', 3, '0473', '016030', '中国,内蒙古自治区,乌海市,海南区', '106.88656', '39.44128', 'Hainan', 1);
INSERT INTO `provinces`
VALUES (150304, '乌达区', 150300, '乌达', 3, '0473', '016040', '中国,内蒙古自治区,乌海市,乌达区', '106.72723', '39.505', 'Wuda', 1);
INSERT INTO `provinces`
VALUES (150400, '赤峰市', 150000, '赤峰', 2, '0476', '024000', '中国,内蒙古自治区,赤峰市', '118.956806', '42.275317', 'Chifeng', 1);
INSERT INTO `provinces`
VALUES (150402, '红山区', 150400, '红山', 3, '0476', '024020', '中国,内蒙古自治区,赤峰市,红山区', '118.95755', '42.24312', 'Hongshan', 1);
INSERT INTO `provinces`
VALUES (150403, '元宝山区', 150400, '元宝山', 3, '0476', '024076', '中国,内蒙古自治区,赤峰市,元宝山区', '119.28921', '42.04005',
        'Yuanbaoshan', 1);
INSERT INTO `provinces`
VALUES (150404, '松山区', 150400, '松山', 3, '0476', '024005', '中国,内蒙古自治区,赤峰市,松山区', '118.9328', '42.28613', 'Songshan', 1);
INSERT INTO `provinces`
VALUES (150421, '阿鲁科尔沁旗', 150400, '阿鲁科尔沁旗', 3, '0476', '025550', '中国,内蒙古自治区,赤峰市,阿鲁科尔沁旗', '120.06527', '43.87988',
        'Alukeerqinqi', 1);
INSERT INTO `provinces`
VALUES (150422, '巴林左旗', 150400, '巴林左旗', 3, '0476', '025450', '中国,内蒙古自治区,赤峰市,巴林左旗', '119.38012', '43.97031',
        'Balinzuoqi', 1);
INSERT INTO `provinces`
VALUES (150423, '巴林右旗', 150400, '巴林右旗', 3, '0476', '025150', '中国,内蒙古自治区,赤峰市,巴林右旗', '118.66461', '43.53387',
        'Balinyouqi', 1);
INSERT INTO `provinces`
VALUES (150424, '林西县', 150400, '林西', 3, '0476', '025250', '中国,内蒙古自治区,赤峰市,林西县', '118.04733', '43.61165', 'Linxi', 1);
INSERT INTO `provinces`
VALUES (150425, '克什克腾旗', 150400, '克什克腾旗', 3, '0476', '025350', '中国,内蒙古自治区,赤峰市,克什克腾旗', '117.54562', '43.26501',
        'Keshiketengqi', 1);
INSERT INTO `provinces`
VALUES (150426, '翁牛特旗', 150400, '翁牛特旗', 3, '0476', '024500', '中国,内蒙古自治区,赤峰市,翁牛特旗', '119.03042', '42.93147',
        'Wengniuteqi', 1);
INSERT INTO `provinces`
VALUES (150428, '喀喇沁旗', 150400, '喀喇沁旗', 3, '0476', '024400', '中国,内蒙古自治区,赤峰市,喀喇沁旗', '118.70144', '41.92917', 'Kalaqinqi',
        1);
INSERT INTO `provinces`
VALUES (150429, '宁城县', 150400, '宁城', 3, '0476', '024200', '中国,内蒙古自治区,赤峰市,宁城县', '119.34375', '41.59661', 'Ningcheng', 1);
INSERT INTO `provinces`
VALUES (150430, '敖汉旗', 150400, '敖汉旗', 3, '0476', '024300', '中国,内蒙古自治区,赤峰市,敖汉旗', '119.92163', '42.29071', 'Aohanqi', 1);
INSERT INTO `provinces`
VALUES (150500, '通辽市', 150000, '通辽', 2, '0475', '028000', '中国,内蒙古自治区,通辽市', '122.263119', '43.617429', 'Tongliao', 1);
INSERT INTO `provinces`
VALUES (150502, '科尔沁区', 150500, '科尔沁', 3, '0475', '028000', '中国,内蒙古自治区,通辽市,科尔沁区', '122.25573', '43.61267', 'Keerqin',
        1);
INSERT INTO `provinces`
VALUES (150521, '科尔沁左翼中旗', 150500, '科尔沁左翼中旗', 3, '0475', '029300', '中国,内蒙古自治区,通辽市,科尔沁左翼中旗', '123.31912', '44.13014',
        'Keerqinzuoyizhongqi', 1);
INSERT INTO `provinces`
VALUES (150522, '科尔沁左翼后旗', 150500, '科尔沁左翼后旗', 3, '0475', '028100', '中国,内蒙古自治区,通辽市,科尔沁左翼后旗', '122.35745', '42.94897',
        'Keerqinzuoyihouqi', 1);
INSERT INTO `provinces`
VALUES (150523, '开鲁县', 150500, '开鲁', 3, '0475', '028400', '中国,内蒙古自治区,通辽市,开鲁县', '121.31884', '43.60003', 'Kailu', 1);
INSERT INTO `provinces`
VALUES (150524, '库伦旗', 150500, '库伦旗', 3, '0475', '028200', '中国,内蒙古自治区,通辽市,库伦旗', '121.776', '42.72998', 'Kulunqi', 1);
INSERT INTO `provinces`
VALUES (150525, '奈曼旗', 150500, '奈曼旗', 3, '0475', '028300', '中国,内蒙古自治区,通辽市,奈曼旗', '120.66348', '42.84527', 'Naimanqi', 1);
INSERT INTO `provinces`
VALUES (150526, '扎鲁特旗', 150500, '扎鲁特旗', 3, '0475', '029100', '中国,内蒙古自治区,通辽市,扎鲁特旗', '120.91507', '44.55592', 'Zhaluteqi',
        1);
INSERT INTO `provinces`
VALUES (150581, '霍林郭勒市', 150500, '霍林郭勒', 3, '0475', '029200', '中国,内蒙古自治区,通辽市,霍林郭勒市', '119.65429', '45.53454',
        'Huolinguole', 1);
INSERT INTO `provinces`
VALUES (150600, '鄂尔多斯市', 150000, '鄂尔多斯', 2, '0477', '017004', '中国,内蒙古自治区,鄂尔多斯市', '109.99029', '39.817179', 'Ordos', 1);
INSERT INTO `provinces`
VALUES (150602, '东胜区', 150600, '东胜', 3, '0477', '017000', '中国,内蒙古自治区,鄂尔多斯市,东胜区', '109.96289', '39.82236', 'Dongsheng',
        1);
INSERT INTO `provinces`
VALUES (150621, '达拉特旗', 150600, '达拉特旗', 3, '0477', '014300', '中国,内蒙古自治区,鄂尔多斯市,达拉特旗', '110.03317', '40.4001', 'Dalateqi',
        1);
INSERT INTO `provinces`
VALUES (150622, '准格尔旗', 150600, '准格尔旗', 3, '0477', '017100', '中国,内蒙古自治区,鄂尔多斯市,准格尔旗', '111.23645', '39.86783',
        'Zhungeerqi', 1);
INSERT INTO `provinces`
VALUES (150623, '鄂托克前旗', 150600, '鄂托克前旗', 3, '0477', '016200', '中国,内蒙古自治区,鄂尔多斯市,鄂托克前旗', '107.48403', '38.18396',
        'Etuokeqianqi', 1);
INSERT INTO `provinces`
VALUES (150624, '鄂托克旗', 150600, '鄂托克旗', 3, '0477', '016100', '中国,内蒙古自治区,鄂尔多斯市,鄂托克旗', '107.98226', '39.09456',
        'Etuokeqi', 1);
INSERT INTO `provinces`
VALUES (150625, '杭锦旗', 150600, '杭锦旗', 3, '0477', '017400', '中国,内蒙古自治区,鄂尔多斯市,杭锦旗', '108.72934', '39.84023', 'Hangjinqi',
        1);
INSERT INTO `provinces`
VALUES (150626, '乌审旗', 150600, '乌审旗', 3, '0477', '017300', '中国,内蒙古自治区,鄂尔多斯市,乌审旗', '108.8461', '38.59092', 'Wushenqi',
        1);
INSERT INTO `provinces`
VALUES (150627, '伊金霍洛旗', 150600, '伊金霍洛旗', 3, '0477', '017200', '中国,内蒙古自治区,鄂尔多斯市,伊金霍洛旗', '109.74908', '39.57393',
        'Yijinhuoluoqi', 1);
INSERT INTO `provinces`
VALUES (150700, '呼伦贝尔市', 150000, '呼伦贝尔', 2, '0470', '021008', '中国,内蒙古自治区,呼伦贝尔市', '119.758168', '49.215333', 'Hulunber',
        1);
INSERT INTO `provinces`
VALUES (150702, '海拉尔区', 150700, '海拉尔', 3, '0470', '021000', '中国,内蒙古自治区,呼伦贝尔市,海拉尔区', '119.7364', '49.2122', 'Hailaer',
        1);
INSERT INTO `provinces`
VALUES (150703, '扎赉诺尔区', 150700, '扎赉诺尔', 3, '0470', '021410', '中国,内蒙古自治区,呼伦贝尔市,扎赉诺尔区', '117.792702', '49.486943',
        'Zhalainuoer', 1);
INSERT INTO `provinces`
VALUES (150721, '阿荣旗', 150700, '阿荣旗', 3, '0470', '162750', '中国,内蒙古自治区,呼伦贝尔市,阿荣旗', '123.45941', '48.12581', 'Arongqi',
        1);
INSERT INTO `provinces`
VALUES (150722, '莫力达瓦达斡尔族自治旗', 150700, '莫旗', 3, '0470', '162850', '中国,内蒙古自治区,呼伦贝尔市,莫力达瓦达斡尔族自治旗', '124.51498',
        '48.48055', 'Moqi', 1);
INSERT INTO `provinces`
VALUES (150723, '鄂伦春自治旗', 150700, '鄂伦春', 3, '0470', '165450', '中国,内蒙古自治区,呼伦贝尔市,鄂伦春自治旗', '123.72604', '50.59777',
        'Elunchun', 1);
INSERT INTO `provinces`
VALUES (150724, '鄂温克族自治旗', 150700, '鄂温', 3, '0470', '021100', '中国,内蒙古自治区,呼伦贝尔市,鄂温克族自治旗', '119.7565', '49.14284', 'Ewen',
        1);
INSERT INTO `provinces`
VALUES (150725, '陈巴尔虎旗', 150700, '陈巴尔虎旗', 3, '0470', '021500', '中国,内蒙古自治区,呼伦贝尔市,陈巴尔虎旗', '119.42434', '49.32684',
        'Chenbaerhuqi', 1);
INSERT INTO `provinces`
VALUES (150726, '新巴尔虎左旗', 150700, '新巴尔虎左旗', 3, '0470', '021200', '中国,内蒙古自治区,呼伦贝尔市,新巴尔虎左旗', '118.26989', '48.21842',
        'Xinbaerhuzuoqi', 1);
INSERT INTO `provinces`
VALUES (150727, '新巴尔虎右旗', 150700, '新巴尔虎右旗', 3, '0470', '021300', '中国,内蒙古自治区,呼伦贝尔市,新巴尔虎右旗', '116.82366', '48.66473',
        'Xinbaerhuyouqi', 1);
INSERT INTO `provinces`
VALUES (150781, '满洲里市', 150700, '满洲里', 3, '0470', '021400', '中国,内蒙古自治区,呼伦贝尔市,满洲里市', '117.47946', '49.58272',
        'Manzhouli', 1);
INSERT INTO `provinces`
VALUES (150782, '牙克石市', 150700, '牙克石', 3, '0470', '022150', '中国,内蒙古自治区,呼伦贝尔市,牙克石市', '120.7117', '49.2856', 'Yakeshi',
        1);
INSERT INTO `provinces`
VALUES (150783, '扎兰屯市', 150700, '扎兰屯', 3, '0470', '162650', '中国,内蒙古自治区,呼伦贝尔市,扎兰屯市', '122.73757', '48.01363',
        'Zhalantun', 1);
INSERT INTO `provinces`
VALUES (150784, '额尔古纳市', 150700, '额尔古纳', 3, '0470', '021260', '中国,内蒙古自治区,呼伦贝尔市,额尔古纳市', '120.19094', '50.24249',
        'Eerguna', 1);
INSERT INTO `provinces`
VALUES (150785, '根河市', 150700, '根河', 3, '0470', '022350', '中国,内蒙古自治区,呼伦贝尔市,根河市', '121.52197', '50.77996', 'Genhe', 1);
INSERT INTO `provinces`
VALUES (150800, '巴彦淖尔市', 150000, '巴彦淖尔', 2, '0478', '015001', '中国,内蒙古自治区,巴彦淖尔市', '107.416959', '40.757402', 'Bayan Nur',
        1);
INSERT INTO `provinces`
VALUES (150802, '临河区', 150800, '临河', 3, '0478', '015001', '中国,内蒙古自治区,巴彦淖尔市,临河区', '107.42668', '40.75827', 'Linhe', 1);
INSERT INTO `provinces`
VALUES (150821, '五原县', 150800, '五原', 3, '0478', '015100', '中国,内蒙古自治区,巴彦淖尔市,五原县', '108.26916', '41.09631', 'Wuyuan', 1);
INSERT INTO `provinces`
VALUES (150822, '磴口县', 150800, '磴口', 3, '0478', '015200', '中国,内蒙古自治区,巴彦淖尔市,磴口县', '107.00936', '40.33062', 'Dengkou', 1);
INSERT INTO `provinces`
VALUES (150823, '乌拉特前旗', 150800, '乌拉特前旗', 3, '0478', '014400', '中国,内蒙古自治区,巴彦淖尔市,乌拉特前旗', '108.65219', '40.73649',
        'Wulateqianqi', 1);
INSERT INTO `provinces`
VALUES (150824, '乌拉特中旗', 150800, '乌拉特中旗', 3, '0478', '015300', '中国,内蒙古自治区,巴彦淖尔市,乌拉特中旗', '108.52587', '41.56789',
        'Wulatezhongqi', 1);
INSERT INTO `provinces`
VALUES (150825, '乌拉特后旗', 150800, '乌拉特后旗', 3, '0478', '015500', '中国,内蒙古自治区,巴彦淖尔市,乌拉特后旗', '106.98971', '41.43151',
        'Wulatehouqi', 1);
INSERT INTO `provinces`
VALUES (150826, '杭锦后旗', 150800, '杭锦后旗', 3, '0478', '015400', '中国,内蒙古自治区,巴彦淖尔市,杭锦后旗', '107.15133', '40.88627',
        'Hangjinhouqi', 1);
INSERT INTO `provinces`
VALUES (150900, '乌兰察布市', 150000, '乌兰察布', 2, '0474', '012000', '中国,内蒙古自治区,乌兰察布市', '113.114543', '41.034126', 'Ulanqab',
        1);
INSERT INTO `provinces`
VALUES (150902, '集宁区', 150900, '集宁', 3, '0474', '012000', '中国,内蒙古自治区,乌兰察布市,集宁区', '113.11452', '41.0353', 'Jining', 1);
INSERT INTO `provinces`
VALUES (150921, '卓资县', 150900, '卓资', 3, '0474', '012300', '中国,内蒙古自治区,乌兰察布市,卓资县', '112.57757', '40.89414', 'Zhuozi', 1);
INSERT INTO `provinces`
VALUES (150922, '化德县', 150900, '化德', 3, '0474', '013350', '中国,内蒙古自治区,乌兰察布市,化德县', '114.01071', '41.90433', 'Huade', 1);
INSERT INTO `provinces`
VALUES (150923, '商都县', 150900, '商都', 3, '0474', '013450', '中国,内蒙古自治区,乌兰察布市,商都县', '113.57772', '41.56213', 'Shangdu', 1);
INSERT INTO `provinces`
VALUES (150924, '兴和县', 150900, '兴和', 3, '0474', '013650', '中国,内蒙古自治区,乌兰察布市,兴和县', '113.83395', '40.87186', 'Xinghe', 1);
INSERT INTO `provinces`
VALUES (150925, '凉城县', 150900, '凉城', 3, '0474', '013750', '中国,内蒙古自治区,乌兰察布市,凉城县', '112.49569', '40.53346', 'Liangcheng',
        1);
INSERT INTO `provinces`
VALUES (150926, '察哈尔右翼前旗', 150900, '察右前旗', 3, '0474', '012200', '中国,内蒙古自治区,乌兰察布市,察哈尔右翼前旗', '113.22131', '40.7788',
        'Chayouqianqi', 1);
INSERT INTO `provinces`
VALUES (150927, '察哈尔右翼中旗', 150900, '察右中旗', 3, '0474', '013550', '中国,内蒙古自治区,乌兰察布市,察哈尔右翼中旗', '112.63537', '41.27742',
        'Chayouzhongqi', 1);
INSERT INTO `provinces`
VALUES (150928, '察哈尔右翼后旗', 150900, '察右后旗', 3, '0474', '012400', '中国,内蒙古自治区,乌兰察布市,察哈尔右翼后旗', '113.19216', '41.43554',
        'Chayouhouqi', 1);
INSERT INTO `provinces`
VALUES (150929, '四子王旗', 150900, '四子王旗', 3, '0474', '011800', '中国,内蒙古自治区,乌兰察布市,四子王旗', '111.70654', '41.53312',
        'Siziwangqi', 1);
INSERT INTO `provinces`
VALUES (150981, '丰镇市', 150900, '丰镇', 3, '0474', '012100', '中国,内蒙古自治区,乌兰察布市,丰镇市', '113.10983', '40.4369', 'Fengzhen', 1);
INSERT INTO `provinces`
VALUES (152200, '兴安盟', 150000, '兴安盟', 2, '0482', '137401', '中国,内蒙古自治区,兴安盟', '122.070317', '46.076268', 'Hinggan', 1);
INSERT INTO `provinces`
VALUES (152201, '乌兰浩特市', 152200, '乌兰浩特', 3, '0482', '137401', '中国,内蒙古自治区,兴安盟,乌兰浩特市', '122.06378', '46.06235',
        'Wulanhaote', 1);
INSERT INTO `provinces`
VALUES (152202, '阿尔山市', 152200, '阿尔山', 3, '0482', '137800', '中国,内蒙古自治区,兴安盟,阿尔山市', '119.94317', '47.17716', 'Aershan',
        1);
INSERT INTO `provinces`
VALUES (152221, '科尔沁右翼前旗', 152200, '科右前旗', 3, '0482', '137423', '中国,内蒙古自治区,兴安盟,科尔沁右翼前旗', '121.95269', '46.0795',
        'Keyouqianqi', 1);
INSERT INTO `provinces`
VALUES (152222, '科尔沁右翼中旗', 152200, '科右中旗', 3, '0482', '029400', '中国,内蒙古自治区,兴安盟,科尔沁右翼中旗', '121.46807', '45.05605',
        'Keyouzhongqi', 1);
INSERT INTO `provinces`
VALUES (152223, '扎赉特旗', 152200, '扎赉特旗', 3, '0482', '137600', '中国,内蒙古自治区,兴安盟,扎赉特旗', '122.91229', '46.7267', 'Zhalaiteqi',
        1);
INSERT INTO `provinces`
VALUES (152224, '突泉县', 152200, '突泉', 3, '0482', '137500', '中国,内蒙古自治区,兴安盟,突泉县', '121.59396', '45.38187', 'Tuquan', 1);
INSERT INTO `provinces`
VALUES (152500, '锡林郭勒盟', 150000, '锡林郭勒盟', 2, '0479', '026000', '中国,内蒙古自治区,锡林郭勒盟', '116.090996', '43.944018',
        'Xilin Gol', 1);
INSERT INTO `provinces`
VALUES (152501, '二连浩特市', 152500, '二连浩特', 3, '0479', '011100', '中国,内蒙古自治区,锡林郭勒盟,二连浩特市', '111.98297', '43.65303',
        'Erlianhaote', 1);
INSERT INTO `provinces`
VALUES (152502, '锡林浩特市', 152500, '锡林浩特', 3, '0479', '026021', '中国,内蒙古自治区,锡林郭勒盟,锡林浩特市', '116.08603', '43.93341',
        'Xilinhaote', 1);
INSERT INTO `provinces`
VALUES (152522, '阿巴嘎旗', 152500, '阿巴嘎旗', 3, '0479', '011400', '中国,内蒙古自治区,锡林郭勒盟,阿巴嘎旗', '114.96826', '44.02174', 'Abagaqi',
        1);
INSERT INTO `provinces`
VALUES (152523, '苏尼特左旗', 152500, '苏尼特左旗', 3, '0479', '011300', '中国,内蒙古自治区,锡林郭勒盟,苏尼特左旗', '113.6506', '43.85687',
        'Sunitezuoqi', 1);
INSERT INTO `provinces`
VALUES (152524, '苏尼特右旗', 152500, '苏尼特右旗', 3, '0479', '011200', '中国,内蒙古自治区,锡林郭勒盟,苏尼特右旗', '112.65741', '42.7469',
        'Suniteyouqi', 1);
INSERT INTO `provinces`
VALUES (152525, '东乌珠穆沁旗', 152500, '东乌旗', 3, '0479', '026300', '中国,内蒙古自治区,锡林郭勒盟,东乌珠穆沁旗', '116.97293', '45.51108',
        'Dongwuqi', 1);
INSERT INTO `provinces`
VALUES (152526, '西乌珠穆沁旗', 152500, '西乌旗', 3, '0479', '026200', '中国,内蒙古自治区,锡林郭勒盟,西乌珠穆沁旗', '117.60983', '44.59623',
        'Xiwuqi', 1);
INSERT INTO `provinces`
VALUES (152527, '太仆寺旗', 152500, '太仆寺旗', 3, '0479', '027000', '中国,内蒙古自治区,锡林郭勒盟,太仆寺旗', '115.28302', '41.87727',
        'Taipusiqi', 1);
INSERT INTO `provinces`
VALUES (152528, '镶黄旗', 152500, '镶黄旗', 3, '0479', '013250', '中国,内蒙古自治区,锡林郭勒盟,镶黄旗', '113.84472', '42.23927',
        'Xianghuangqi', 1);
INSERT INTO `provinces`
VALUES (152529, '正镶白旗', 152500, '正镶白旗', 3, '0479', '013800', '中国,内蒙古自治区,锡林郭勒盟,正镶白旗', '115.00067', '42.30712',
        'Zhengxiangbaiqi', 1);
INSERT INTO `provinces`
VALUES (152530, '正蓝旗', 152500, '正蓝旗', 3, '0479', '027200', '中国,内蒙古自治区,锡林郭勒盟,正蓝旗', '116.00363', '42.25229', 'Zhenglanqi',
        1);
INSERT INTO `provinces`
VALUES (152531, '多伦县', 152500, '多伦', 3, '0479', '027300', '中国,内蒙古自治区,锡林郭勒盟,多伦县', '116.48565', '42.203', 'Duolun', 1);
INSERT INTO `provinces`
VALUES (152900, '阿拉善盟', 150000, '阿拉善盟', 2, '0483', '750306', '中国,内蒙古自治区,阿拉善盟', '105.706422', '38.844814', 'Alxa', 1);
INSERT INTO `provinces`
VALUES (152921, '阿拉善左旗', 152900, '阿拉善左旗', 3, '0483', '750306', '中国,内蒙古自治区,阿拉善盟,阿拉善左旗', '105.67532', '38.8293',
        'Alashanzuoqi', 1);
INSERT INTO `provinces`
VALUES (152922, '阿拉善右旗', 152900, '阿拉善右旗', 3, '0483', '737300', '中国,内蒙古自治区,阿拉善盟,阿拉善右旗', '101.66705', '39.21533',
        'Alashanyouqi', 1);
INSERT INTO `provinces`
VALUES (152923, '额济纳旗', 152900, '额济纳旗', 3, '0483', '735400', '中国,内蒙古自治区,阿拉善盟,额济纳旗', '101.06887', '41.96755', 'Ejinaqi',
        1);
INSERT INTO `provinces`
VALUES (210000, '辽宁省', 100000, '辽宁', 1, '', '', '中国,辽宁省', '123.429096', '41.796767', 'Liaoning', 1);
INSERT INTO `provinces`
VALUES (210100, '沈阳市', 210000, '沈阳', 2, '024', '110013', '中国,辽宁省,沈阳市', '123.429096', '41.796767', 'Shenyang', 1);
INSERT INTO `provinces`
VALUES (210102, '和平区', 210100, '和平', 3, '024', '110001', '中国,辽宁省,沈阳市,和平区', '123.4204', '41.78997', 'Heping', 1);
INSERT INTO `provinces`
VALUES (210103, '沈河区', 210100, '沈河', 3, '024', '110011', '中国,辽宁省,沈阳市,沈河区', '123.45871', '41.79625', 'Shenhe', 1);
INSERT INTO `provinces`
VALUES (210104, '大东区', 210100, '大东', 3, '024', '110041', '中国,辽宁省,沈阳市,大东区', '123.46997', '41.80539', 'Dadong', 1);
INSERT INTO `provinces`
VALUES (210105, '皇姑区', 210100, '皇姑', 3, '024', '110031', '中国,辽宁省,沈阳市,皇姑区', '123.42527', '41.82035', 'Huanggu', 1);
INSERT INTO `provinces`
VALUES (210106, '铁西区', 210100, '铁西', 3, '024', '110021', '中国,辽宁省,沈阳市,铁西区', '123.37675', '41.80269', 'Tiexi', 1);
INSERT INTO `provinces`
VALUES (210111, '苏家屯区', 210100, '苏家屯', 3, '024', '110101', '中国,辽宁省,沈阳市,苏家屯区', '123.34405', '41.66475', 'Sujiatun', 1);
INSERT INTO `provinces`
VALUES (210112, '浑南区', 210100, '浑南', 3, '024', '110015', '中国,辽宁省,沈阳市,浑南区', '123.457707', '41.719450', 'Hunnan', 1);
INSERT INTO `provinces`
VALUES (210113, '沈北新区', 210100, '沈北新区', 3, '024', '110121', '中国,辽宁省,沈阳市,沈北新区', '123.52658', '42.05297', 'Shenbeixinqu',
        1);
INSERT INTO `provinces`
VALUES (210114, '于洪区', 210100, '于洪', 3, '024', '110141', '中国,辽宁省,沈阳市,于洪区', '123.30807', '41.794', 'Yuhong', 1);
INSERT INTO `provinces`
VALUES (210122, '辽中县', 210100, '辽中', 3, '024', '110200', '中国,辽宁省,沈阳市,辽中县', '122.72659', '41.51302', 'Liaozhong', 1);
INSERT INTO `provinces`
VALUES (210123, '康平县', 210100, '康平', 3, '024', '110500', '中国,辽宁省,沈阳市,康平县', '123.35446', '42.75081', 'Kangping', 1);
INSERT INTO `provinces`
VALUES (210124, '法库县', 210100, '法库', 3, '024', '110400', '中国,辽宁省,沈阳市,法库县', '123.41214', '42.50608', 'Faku', 1);
INSERT INTO `provinces`
VALUES (210181, '新民市', 210100, '新民', 3, '024', '110300', '中国,辽宁省,沈阳市,新民市', '122.82867', '41.99847', 'Xinmin', 1);
INSERT INTO `provinces`
VALUES (210200, '大连市', 210000, '大连', 2, '0411', '116011', '中国,辽宁省,大连市', '121.618622', '38.91459', 'Dalian', 1);
INSERT INTO `provinces`
VALUES (210202, '中山区', 210200, '中山', 3, '0411', '116001', '中国,辽宁省,大连市,中山区', '121.64465', '38.91859', 'Zhongshan', 1);
INSERT INTO `provinces`
VALUES (210203, '西岗区', 210200, '西岗', 3, '0411', '116011', '中国,辽宁省,大连市,西岗区', '121.61238', '38.91469', 'Xigang', 1);
INSERT INTO `provinces`
VALUES (210204, '沙河口区', 210200, '沙河口', 3, '0411', '116021', '中国,辽宁省,大连市,沙河口区', '121.58017', '38.90536', 'Shahekou', 1);
INSERT INTO `provinces`
VALUES (210211, '甘井子区', 210200, '甘井子', 3, '0411', '116033', '中国,辽宁省,大连市,甘井子区', '121.56567', '38.95017', 'Ganjingzi', 1);
INSERT INTO `provinces`
VALUES (210212, '旅顺口区', 210200, '旅顺口', 3, '0411', '116041', '中国,辽宁省,大连市,旅顺口区', '121.26202', '38.85125', 'Lvshunkou', 1);
INSERT INTO `provinces`
VALUES (210213, '金州区', 210200, '金州', 3, '0411', '116100', '中国,辽宁省,大连市,金州区', '121.71893', '39.1004', 'Jinzhou', 1);
INSERT INTO `provinces`
VALUES (210224, '长海县', 210200, '长海', 3, '0411', '116500', '中国,辽宁省,大连市,长海县', '122.58859', '39.27274', 'Changhai', 1);
INSERT INTO `provinces`
VALUES (210281, '瓦房店市', 210200, '瓦房店', 3, '0411', '116300', '中国,辽宁省,大连市,瓦房店市', '121.98104', '39.62843', 'Wafangdian',
        1);
INSERT INTO `provinces`
VALUES (210282, '普兰店市', 210200, '普兰店', 3, '0411', '116200', '中国,辽宁省,大连市,普兰店市', '121.96316', '39.39465', 'Pulandian', 1);
INSERT INTO `provinces`
VALUES (210283, '庄河市', 210200, '庄河', 3, '0411', '116400', '中国,辽宁省,大连市,庄河市', '122.96725', '39.68815', 'Zhuanghe', 1);
INSERT INTO `provinces`
VALUES (210300, '鞍山市', 210000, '鞍山', 2, '0412', '114001', '中国,辽宁省,鞍山市', '122.995632', '41.110626', 'Anshan', 1);
INSERT INTO `provinces`
VALUES (210302, '铁东区', 210300, '铁东', 3, '0412', '114001', '中国,辽宁省,鞍山市,铁东区', '122.99085', '41.08975', 'Tiedong', 1);
INSERT INTO `provinces`
VALUES (210303, '铁西区', 210300, '铁西', 3, '0413', '114013', '中国,辽宁省,鞍山市,铁西区', '122.96967', '41.11977', 'Tiexi', 1);
INSERT INTO `provinces`
VALUES (210304, '立山区', 210300, '立山', 3, '0414', '114031', '中国,辽宁省,鞍山市,立山区', '123.02948', '41.15008', 'Lishan', 1);
INSERT INTO `provinces`
VALUES (210311, '千山区', 210300, '千山', 3, '0415', '114041', '中国,辽宁省,鞍山市,千山区', '122.96048', '41.07507', 'Qianshan', 1);
INSERT INTO `provinces`
VALUES (210321, '台安县', 210300, '台安', 3, '0417', '114100', '中国,辽宁省,鞍山市,台安县', '122.43585', '41.41265', 'Tai\'an', 1);
INSERT INTO `provinces`
VALUES (210323, '岫岩满族自治县', 210300, '岫岩', 3, '0418', '114300', '中国,辽宁省,鞍山市,岫岩满族自治县', '123.28875', '40.27996', 'Xiuyan',
        1);
INSERT INTO `provinces`
VALUES (210381, '海城市', 210300, '海城', 3, '0416', '114200', '中国,辽宁省,鞍山市,海城市', '122.68457', '40.88142', 'Haicheng', 1);
INSERT INTO `provinces`
VALUES (210400, '抚顺市', 210000, '抚顺', 2, '024', '113008', '中国,辽宁省,抚顺市', '123.921109', '41.875956', 'Fushun', 1);
INSERT INTO `provinces`
VALUES (210402, '新抚区', 210400, '新抚', 3, '024', '113008', '中国,辽宁省,抚顺市,新抚区', '123.91264', '41.86205', 'Xinfu', 1);
INSERT INTO `provinces`
VALUES (210403, '东洲区', 210400, '东洲', 3, '024', '113003', '中国,辽宁省,抚顺市,东洲区', '124.03759', '41.8519', 'Dongzhou', 1);
INSERT INTO `provinces`
VALUES (210404, '望花区', 210400, '望花', 3, '024', '113001', '中国,辽宁省,抚顺市,望花区', '123.78283', '41.85532', 'Wanghua', 1);
INSERT INTO `provinces`
VALUES (210411, '顺城区', 210400, '顺城', 3, '024', '113006', '中国,辽宁省,抚顺市,顺城区', '123.94506', '41.88321', 'Shuncheng', 1);
INSERT INTO `provinces`
VALUES (210421, '抚顺县', 210400, '抚顺', 3, '024', '113006', '中国,辽宁省,抚顺市,抚顺县', '124.17755', '41.71217', 'Fushun', 1);
INSERT INTO `provinces`
VALUES (210422, '新宾满族自治县', 210400, '新宾', 3, '024', '113200', '中国,辽宁省,抚顺市,新宾满族自治县', '125.04049', '41.73409', 'Xinbin',
        1);
INSERT INTO `provinces`
VALUES (210423, '清原满族自治县', 210400, '清原', 3, '024', '113300', '中国,辽宁省,抚顺市,清原满族自治县', '124.92807', '42.10221', 'Qingyuan',
        1);
INSERT INTO `provinces`
VALUES (210500, '本溪市', 210000, '本溪', 2, '0414', '117000', '中国,辽宁省,本溪市', '123.770519', '41.297909', 'Benxi', 1);
INSERT INTO `provinces`
VALUES (210502, '平山区', 210500, '平山', 3, '0414', '117000', '中国,辽宁省,本溪市,平山区', '123.76892', '41.2997', 'Pingshan', 1);
INSERT INTO `provinces`
VALUES (210503, '溪湖区', 210500, '溪湖', 3, '0414', '117002', '中国,辽宁省,本溪市,溪湖区', '123.76764', '41.32921', 'Xihu', 1);
INSERT INTO `provinces`
VALUES (210504, '明山区', 210500, '明山', 3, '0414', '117021', '中国,辽宁省,本溪市,明山区', '123.81746', '41.30827', 'Mingshan', 1);
INSERT INTO `provinces`
VALUES (210505, '南芬区', 210500, '南芬', 3, '0414', '117014', '中国,辽宁省,本溪市,南芬区', '123.74523', '41.1006', 'Nanfen', 1);
INSERT INTO `provinces`
VALUES (210521, '本溪满族自治县', 210500, '本溪', 3, '0414', '117100', '中国,辽宁省,本溪市,本溪满族自治县', '124.12741', '41.30059', 'Benxi',
        1);
INSERT INTO `provinces`
VALUES (210522, '桓仁满族自治县', 210500, '桓仁', 3, '0414', '117200', '中国,辽宁省,本溪市,桓仁满族自治县', '125.36062', '41.26798', 'Huanren',
        1);
INSERT INTO `provinces`
VALUES (210600, '丹东市', 210000, '丹东', 2, '0415', '118000', '中国,辽宁省,丹东市', '124.383044', '40.124296', 'Dandong', 1);
INSERT INTO `provinces`
VALUES (210602, '元宝区', 210600, '元宝', 3, '0415', '118000', '中国,辽宁省,丹东市,元宝区', '124.39575', '40.13651', 'Yuanbao', 1);
INSERT INTO `provinces`
VALUES (210603, '振兴区', 210600, '振兴', 3, '0415', '118002', '中国,辽宁省,丹东市,振兴区', '124.36035', '40.10489', 'Zhenxing', 1);
INSERT INTO `provinces`
VALUES (210604, '振安区', 210600, '振安', 3, '0415', '118001', '中国,辽宁省,丹东市,振安区', '124.42816', '40.15826', 'Zhen\'an', 1);
INSERT INTO `provinces`
VALUES (210624, '宽甸满族自治县', 210600, '宽甸', 3, '0415', '118200', '中国,辽宁省,丹东市,宽甸满族自治县', '124.78247', '40.73187', 'Kuandian',
        1);
INSERT INTO `provinces`
VALUES (210681, '东港市', 210600, '东港', 3, '0415', '118300', '中国,辽宁省,丹东市,东港市', '124.16287', '39.86256', 'Donggang', 1);
INSERT INTO `provinces`
VALUES (210682, '凤城市', 210600, '凤城', 3, '0415', '118100', '中国,辽宁省,丹东市,凤城市', '124.06671', '40.45302', 'Fengcheng', 1);
INSERT INTO `provinces`
VALUES (210700, '锦州市', 210000, '锦州', 2, '0416', '121000', '中国,辽宁省,锦州市', '121.135742', '41.119269', 'Jinzhou', 1);
INSERT INTO `provinces`
VALUES (210702, '古塔区', 210700, '古塔', 3, '0416', '121001', '中国,辽宁省,锦州市,古塔区', '121.12832', '41.11725', 'Guta', 1);
INSERT INTO `provinces`
VALUES (210703, '凌河区', 210700, '凌河', 3, '0416', '121000', '中国,辽宁省,锦州市,凌河区', '121.15089', '41.11496', 'Linghe', 1);
INSERT INTO `provinces`
VALUES (210711, '太和区', 210700, '太和', 3, '0416', '121011', '中国,辽宁省,锦州市,太和区', '121.10354', '41.10929', 'Taihe', 1);
INSERT INTO `provinces`
VALUES (210726, '黑山县', 210700, '黑山', 3, '0416', '121400', '中国,辽宁省,锦州市,黑山县', '122.12081', '41.69417', 'Heishan', 1);
INSERT INTO `provinces`
VALUES (210727, '义县', 210700, '义县', 3, '0416', '121100', '中国,辽宁省,锦州市,义县', '121.24035', '41.53458', 'Yixian', 1);
INSERT INTO `provinces`
VALUES (210781, '凌海市', 210700, '凌海', 3, '0416', '121200', '中国,辽宁省,锦州市,凌海市', '121.35705', '41.1737', 'Linghai', 1);
INSERT INTO `provinces`
VALUES (210782, '北镇市', 210700, '北镇', 3, '0416', '121300', '中国,辽宁省,锦州市,北镇市', '121.79858', '41.59537', 'Beizhen', 1);
INSERT INTO `provinces`
VALUES (210800, '营口市', 210000, '营口', 2, '0417', '115003', '中国,辽宁省,营口市', '122.235151', '40.667432', 'Yingkou', 1);
INSERT INTO `provinces`
VALUES (210802, '站前区', 210800, '站前', 3, '0417', '115002', '中国,辽宁省,营口市,站前区', '122.25896', '40.67266', 'Zhanqian', 1);
INSERT INTO `provinces`
VALUES (210803, '西市区', 210800, '西市', 3, '0417', '115004', '中国,辽宁省,营口市,西市区', '122.20641', '40.6664', 'Xishi', 1);
INSERT INTO `provinces`
VALUES (210804, '鲅鱼圈区', 210800, '鲅鱼圈', 3, '0417', '115007', '中国,辽宁省,营口市,鲅鱼圈区', '122.13266', '40.26865', 'Bayuquan', 1);
INSERT INTO `provinces`
VALUES (210811, '老边区', 210800, '老边', 3, '0417', '115005', '中国,辽宁省,营口市,老边区', '122.37996', '40.6803', 'Laobian', 1);
INSERT INTO `provinces`
VALUES (210881, '盖州市', 210800, '盖州', 3, '0417', '115200', '中国,辽宁省,营口市,盖州市', '122.35464', '40.40446', 'Gaizhou', 1);
INSERT INTO `provinces`
VALUES (210882, '大石桥市', 210800, '大石桥', 3, '0417', '115100', '中国,辽宁省,营口市,大石桥市', '122.50927', '40.64567', 'Dashiqiao', 1);
INSERT INTO `provinces`
VALUES (210900, '阜新市', 210000, '阜新', 2, '0418', '123000', '中国,辽宁省,阜新市', '121.648962', '42.011796', 'Fuxin', 1);
INSERT INTO `provinces`
VALUES (210902, '海州区', 210900, '海州', 3, '0418', '123000', '中国,辽宁省,阜新市,海州区', '121.65626', '42.01336', 'Haizhou', 1);
INSERT INTO `provinces`
VALUES (210903, '新邱区', 210900, '新邱', 3, '0418', '123005', '中国,辽宁省,阜新市,新邱区', '121.79251', '42.09181', 'Xinqiu', 1);
INSERT INTO `provinces`
VALUES (210904, '太平区', 210900, '太平', 3, '0418', '123003', '中国,辽宁省,阜新市,太平区', '121.67865', '42.01065', 'Taiping', 1);
INSERT INTO `provinces`
VALUES (210905, '清河门区', 210900, '清河门', 3, '0418', '123006', '中国,辽宁省,阜新市,清河门区', '121.4161', '41.78309', 'Qinghemen', 1);
INSERT INTO `provinces`
VALUES (210911, '细河区', 210900, '细河', 3, '0418', '123000', '中国,辽宁省,阜新市,细河区', '121.68013', '42.02533', 'Xihe', 1);
INSERT INTO `provinces`
VALUES (210921, '阜新蒙古族自治县', 210900, '阜新', 3, '0418', '123100', '中国,辽宁省,阜新市,阜新蒙古族自治县', '121.75787', '42.0651', 'Fuxin',
        1);
INSERT INTO `provinces`
VALUES (210922, '彰武县', 210900, '彰武', 3, '0418', '123200', '中国,辽宁省,阜新市,彰武县', '122.54022', '42.38625', 'Zhangwu', 1);
INSERT INTO `provinces`
VALUES (211000, '辽阳市', 210000, '辽阳', 2, '0419', '111000', '中国,辽宁省,辽阳市', '123.18152', '41.269402', 'Liaoyang', 1);
INSERT INTO `provinces`
VALUES (211002, '白塔区', 211000, '白塔', 3, '0419', '111000', '中国,辽宁省,辽阳市,白塔区', '123.1747', '41.27025', 'Baita', 1);
INSERT INTO `provinces`
VALUES (211003, '文圣区', 211000, '文圣', 3, '0419', '111000', '中国,辽宁省,辽阳市,文圣区', '123.18521', '41.26267', 'Wensheng', 1);
INSERT INTO `provinces`
VALUES (211004, '宏伟区', 211000, '宏伟', 3, '0419', '111003', '中国,辽宁省,辽阳市,宏伟区', '123.1929', '41.21852', 'Hongwei', 1);
INSERT INTO `provinces`
VALUES (211005, '弓长岭区', 211000, '弓长岭', 3, '0419', '111008', '中国,辽宁省,辽阳市,弓长岭区', '123.41963', '41.15181', 'Gongchangling',
        1);
INSERT INTO `provinces`
VALUES (211011, '太子河区', 211000, '太子河', 3, '0419', '111000', '中国,辽宁省,辽阳市,太子河区', '123.18182', '41.25337', 'Taizihe', 1);
INSERT INTO `provinces`
VALUES (211021, '辽阳县', 211000, '辽阳', 3, '0419', '111200', '中国,辽宁省,辽阳市,辽阳县', '123.10574', '41.20542', 'Liaoyang', 1);
INSERT INTO `provinces`
VALUES (211081, '灯塔市', 211000, '灯塔', 3, '0419', '111300', '中国,辽宁省,辽阳市,灯塔市', '123.33926', '41.42612', 'Dengta', 1);
INSERT INTO `provinces`
VALUES (211100, '盘锦市', 210000, '盘锦', 2, '0427', '124010', '中国,辽宁省,盘锦市', '122.06957', '41.124484', 'Panjin', 1);
INSERT INTO `provinces`
VALUES (211102, '双台子区', 211100, '双台子', 3, '0427', '124000', '中国,辽宁省,盘锦市,双台子区', '122.06011', '41.1906', 'Shuangtaizi',
        1);
INSERT INTO `provinces`
VALUES (211103, '兴隆台区', 211100, '兴隆台', 3, '0427', '124010', '中国,辽宁省,盘锦市,兴隆台区', '122.07529', '41.12402', 'Xinglongtai',
        1);
INSERT INTO `provinces`
VALUES (211121, '大洼县', 211100, '大洼', 3, '0427', '124200', '中国,辽宁省,盘锦市,大洼县', '122.08239', '41.00244', 'Dawa', 1);
INSERT INTO `provinces`
VALUES (211122, '盘山县', 211100, '盘山', 3, '0427', '124000', '中国,辽宁省,盘锦市,盘山县', '121.99777', '41.23805', 'Panshan', 1);
INSERT INTO `provinces`
VALUES (211200, '铁岭市', 210000, '铁岭', 2, '024', '112000', '中国,辽宁省,铁岭市', '123.844279', '42.290585', 'Tieling', 1);
INSERT INTO `provinces`
VALUES (211202, '银州区', 211200, '银州', 3, '024', '112000', '中国,辽宁省,铁岭市,银州区', '123.8573', '42.29507', 'Yinzhou', 1);
INSERT INTO `provinces`
VALUES (211204, '清河区', 211200, '清河', 3, '024', '112003', '中国,辽宁省,铁岭市,清河区', '124.15911', '42.54679', 'Qinghe', 1);
INSERT INTO `provinces`
VALUES (211221, '铁岭县', 211200, '铁岭', 3, '024', '112000', '中国,辽宁省,铁岭市,铁岭县', '123.77325', '42.22498', 'Tieling', 1);
INSERT INTO `provinces`
VALUES (211223, '西丰县', 211200, '西丰', 3, '024', '112400', '中国,辽宁省,铁岭市,西丰县', '124.7304', '42.73756', 'Xifeng', 1);
INSERT INTO `provinces`
VALUES (211224, '昌图县', 211200, '昌图', 3, '024', '112500', '中国,辽宁省,铁岭市,昌图县', '124.11206', '42.78428', 'Changtu', 1);
INSERT INTO `provinces`
VALUES (211281, '调兵山市', 211200, '调兵山', 3, '024', '112700', '中国,辽宁省,铁岭市,调兵山市', '123.56689', '42.4675', 'Diaobingshan',
        1);
INSERT INTO `provinces`
VALUES (211282, '开原市', 211200, '开原', 3, '024', '112300', '中国,辽宁省,铁岭市,开原市', '124.03945', '42.54585', 'Kaiyuan', 1);
INSERT INTO `provinces`
VALUES (211300, '朝阳市', 210000, '朝阳', 2, '0421', '122000', '中国,辽宁省,朝阳市', '120.451176', '41.576758', 'Chaoyang', 1);
INSERT INTO `provinces`
VALUES (211302, '双塔区', 211300, '双塔', 3, '0421', '122000', '中国,辽宁省,朝阳市,双塔区', '120.45385', '41.566', 'Shuangta', 1);
INSERT INTO `provinces`
VALUES (211303, '龙城区', 211300, '龙城', 3, '0421', '122000', '中国,辽宁省,朝阳市,龙城区', '120.43719', '41.59264', 'Longcheng', 1);
INSERT INTO `provinces`
VALUES (211321, '朝阳县', 211300, '朝阳', 3, '0421', '122000', '中国,辽宁省,朝阳市,朝阳县', '120.17401', '41.4324', 'Chaoyang', 1);
INSERT INTO `provinces`
VALUES (211322, '建平县', 211300, '建平', 3, '0421', '122400', '中国,辽宁省,朝阳市,建平县', '119.64392', '41.40315', 'Jianping', 1);
INSERT INTO `provinces`
VALUES (211324, '喀喇沁左翼蒙古族自治县', 211300, '喀喇沁左翼', 3, '0421', '122300', '中国,辽宁省,朝阳市,喀喇沁左翼蒙古族自治县', '119.74185', '41.12801',
        'Kalaqinzuoyi', 1);
INSERT INTO `provinces`
VALUES (211381, '北票市', 211300, '北票', 3, '0421', '122100', '中国,辽宁省,朝阳市,北票市', '120.76977', '41.80196', 'Beipiao', 1);
INSERT INTO `provinces`
VALUES (211382, '凌源市', 211300, '凌源', 3, '0421', '112600', '中国,辽宁省,朝阳市,凌源市', '119.40148', '41.24558', 'Lingyuan', 1);
INSERT INTO `provinces`
VALUES (211400, '葫芦岛市', 210000, '葫芦岛', 2, '0429', '125000', '中国,辽宁省,葫芦岛市', '120.856394', '40.755572', 'Huludao', 1);
INSERT INTO `provinces`
VALUES (211402, '连山区', 211400, '连山', 3, '0429', '125001', '中国,辽宁省,葫芦岛市,连山区', '120.86393', '40.75554', 'Lianshan', 1);
INSERT INTO `provinces`
VALUES (211403, '龙港区', 211400, '龙港', 3, '0429', '125003', '中国,辽宁省,葫芦岛市,龙港区', '120.94866', '40.71919', 'Longgang', 1);
INSERT INTO `provinces`
VALUES (211404, '南票区', 211400, '南票', 3, '0429', '125027', '中国,辽宁省,葫芦岛市,南票区', '120.74978', '41.10707', 'Nanpiao', 1);
INSERT INTO `provinces`
VALUES (211421, '绥中县', 211400, '绥中', 3, '0429', '125200', '中国,辽宁省,葫芦岛市,绥中县', '120.34451', '40.32552', 'Suizhong', 1);
INSERT INTO `provinces`
VALUES (211422, '建昌县', 211400, '建昌', 3, '0429', '125300', '中国,辽宁省,葫芦岛市,建昌县', '119.8377', '40.82448', 'Jianchang', 1);
INSERT INTO `provinces`
VALUES (211481, '兴城市', 211400, '兴城', 3, '0429', '125100', '中国,辽宁省,葫芦岛市,兴城市', '120.72537', '40.61492', 'Xingcheng', 1);
INSERT INTO `provinces`
VALUES (211500, '金普新区', 210000, '金普新区', 2, '0411', '116100', '中国,辽宁省,金普新区', '121.789627', '39.055451', 'Jinpuxinqu', 1);
INSERT INTO `provinces`
VALUES (211501, '金州新区', 211500, '金州新区', 3, '0411', '116100', '中国,辽宁省,金普新区,金州新区', '121.784821', '39.051262',
        'Jinzhouxinqu', 1);
INSERT INTO `provinces`
VALUES (211502, '普湾新区', 211500, '普湾新区', 3, '0411', '116200', '中国,辽宁省,金普新区,普湾新区', '121.812812', '39.330093',
        'Puwanxinqu', 1);
INSERT INTO `provinces`
VALUES (211503, '保税区', 211500, '保税区', 3, '0411', '116100', '中国,辽宁省,金普新区,保税区', '121.94289', '39.224614', 'Baoshuiqu', 1);
INSERT INTO `provinces`
VALUES (220000, '吉林省', 100000, '吉林', 1, '', '', '中国,吉林省', '125.3245', '43.886841', 'Jilin', 1);
INSERT INTO `provinces`
VALUES (220100, '长春市', 220000, '长春', 2, '0431', '130022', '中国,吉林省,长春市', '125.3245', '43.886841', 'Changchun', 1);
INSERT INTO `provinces`
VALUES (220102, '南关区', 220100, '南关', 3, '0431', '130022', '中国,吉林省,长春市,南关区', '125.35035', '43.86401', 'Nanguan', 1);
INSERT INTO `provinces`
VALUES (220103, '宽城区', 220100, '宽城', 3, '0431', '130051', '中国,吉林省,长春市,宽城区', '125.32635', '43.90182', 'Kuancheng', 1);
INSERT INTO `provinces`
VALUES (220104, '朝阳区', 220100, '朝阳', 3, '0431', '130012', '中国,吉林省,长春市,朝阳区', '125.2883', '43.83339', 'Chaoyang', 1);
INSERT INTO `provinces`
VALUES (220105, '二道区', 220100, '二道', 3, '0431', '130031', '中国,吉林省,长春市,二道区', '125.37429', '43.86501', 'Erdao', 1);
INSERT INTO `provinces`
VALUES (220106, '绿园区', 220100, '绿园', 3, '0431', '130062', '中国,吉林省,长春市,绿园区', '125.25582', '43.88045', 'Lvyuan', 1);
INSERT INTO `provinces`
VALUES (220112, '双阳区', 220100, '双阳', 3, '0431', '130600', '中国,吉林省,长春市,双阳区', '125.65631', '43.52803', 'Shuangyang', 1);
INSERT INTO `provinces`
VALUES (220113, '九台区', 220100, '九台', 3, '0431', '130500', '中国,吉林省,长春市,九台区', '125.8395', '44.15163', 'Jiutai', 1);
INSERT INTO `provinces`
VALUES (220122, '农安县', 220100, '农安', 3, '0431', '130200', '中国,吉林省,长春市,农安县', '125.18481', '44.43265', 'Nong\'an', 1);
INSERT INTO `provinces`
VALUES (220182, '榆树市', 220100, '榆树', 3, '0431', '130400', '中国,吉林省,长春市,榆树市', '126.55688', '44.82523', 'Yushu', 1);
INSERT INTO `provinces`
VALUES (220183, '德惠市', 220100, '德惠', 3, '0431', '130300', '中国,吉林省,长春市,德惠市', '125.70538', '44.53719', 'Dehui', 1);
INSERT INTO `provinces`
VALUES (220200, '吉林市', 220000, '吉林', 2, '0432', '132011', '中国,吉林省,吉林市', '126.55302', '43.843577', 'Jilin', 1);
INSERT INTO `provinces`
VALUES (220202, '昌邑区', 220200, '昌邑', 3, '0432', '132002', '中国,吉林省,吉林市,昌邑区', '126.57424', '43.88183', 'Changyi', 1);
INSERT INTO `provinces`
VALUES (220203, '龙潭区', 220200, '龙潭', 3, '0432', '132021', '中国,吉林省,吉林市,龙潭区', '126.56213', '43.91054', 'Longtan', 1);
INSERT INTO `provinces`
VALUES (220204, '船营区', 220200, '船营', 3, '0432', '132011', '中国,吉林省,吉林市,船营区', '126.54096', '43.83344', 'Chuanying', 1);
INSERT INTO `provinces`
VALUES (220211, '丰满区', 220200, '丰满', 3, '0432', '132013', '中国,吉林省,吉林市,丰满区', '126.56237', '43.82236', 'Fengman', 1);
INSERT INTO `provinces`
VALUES (220221, '永吉县', 220200, '永吉', 3, '0432', '132200', '中国,吉林省,吉林市,永吉县', '126.4963', '43.67197', 'Yongji', 1);
INSERT INTO `provinces`
VALUES (220281, '蛟河市', 220200, '蛟河', 3, '0432', '132500', '中国,吉林省,吉林市,蛟河市', '127.34426', '43.72696', 'Jiaohe', 1);
INSERT INTO `provinces`
VALUES (220282, '桦甸市', 220200, '桦甸', 3, '0432', '132400', '中国,吉林省,吉林市,桦甸市', '126.74624', '42.97206', 'Huadian', 1);
INSERT INTO `provinces`
VALUES (220283, '舒兰市', 220200, '舒兰', 3, '0432', '132600', '中国,吉林省,吉林市,舒兰市', '126.9653', '44.40582', 'Shulan', 1);
INSERT INTO `provinces`
VALUES (220284, '磐石市', 220200, '磐石', 3, '0432', '132300', '中国,吉林省,吉林市,磐石市', '126.0625', '42.94628', 'Panshi', 1);
INSERT INTO `provinces`
VALUES (220300, '四平市', 220000, '四平', 2, '0434', '136000', '中国,吉林省,四平市', '124.370785', '43.170344', 'Siping', 1);
INSERT INTO `provinces`
VALUES (220302, '铁西区', 220300, '铁西', 3, '0434', '136000', '中国,吉林省,四平市,铁西区', '124.37369', '43.17456', 'Tiexi', 1);
INSERT INTO `provinces`
VALUES (220303, '铁东区', 220300, '铁东', 3, '0434', '136001', '中国,吉林省,四平市,铁东区', '124.40976', '43.16241', 'Tiedong', 1);
INSERT INTO `provinces`
VALUES (220322, '梨树县', 220300, '梨树', 3, '0434', '136500', '中国,吉林省,四平市,梨树县', '124.33563', '43.30717', 'Lishu', 1);
INSERT INTO `provinces`
VALUES (220323, '伊通满族自治县', 220300, '伊通', 3, '0434', '130700', '中国,吉林省,四平市,伊通满族自治县', '125.30596', '43.34434', 'Yitong',
        1);
INSERT INTO `provinces`
VALUES (220381, '公主岭市', 220300, '公主岭', 3, '0434', '136100', '中国,吉林省,四平市,公主岭市', '124.82266', '43.50453', 'Gongzhuling',
        1);
INSERT INTO `provinces`
VALUES (220382, '双辽市', 220300, '双辽', 3, '0434', '136400', '中国,吉林省,四平市,双辽市', '123.50106', '43.52099', 'Shuangliao', 1);
INSERT INTO `provinces`
VALUES (220400, '辽源市', 220000, '辽源', 2, '0437', '136200', '中国,吉林省,辽源市', '125.145349', '42.902692', 'Liaoyuan', 1);
INSERT INTO `provinces`
VALUES (220402, '龙山区', 220400, '龙山', 3, '0437', '136200', '中国,吉林省,辽源市,龙山区', '125.13641', '42.89714', 'Longshan', 1);
INSERT INTO `provinces`
VALUES (220403, '西安区', 220400, '西安', 3, '0437', '136201', '中国,吉林省,辽源市,西安区', '125.14904', '42.927', 'Xi\'an', 1);
INSERT INTO `provinces`
VALUES (220421, '东丰县', 220400, '东丰', 3, '0437', '136300', '中国,吉林省,辽源市,东丰县', '125.53244', '42.6783', 'Dongfeng', 1);
INSERT INTO `provinces`
VALUES (220422, '东辽县', 220400, '东辽', 3, '0437', '136600', '中国,吉林省,辽源市,东辽县', '124.98596', '42.92492', 'Dongliao', 1);
INSERT INTO `provinces`
VALUES (220500, '通化市', 220000, '通化', 2, '0435', '134001', '中国,吉林省,通化市', '125.936501', '41.721177', 'Tonghua', 1);
INSERT INTO `provinces`
VALUES (220502, '东昌区', 220500, '东昌', 3, '0435', '134001', '中国,吉林省,通化市,东昌区', '125.9551', '41.72849', 'Dongchang', 1);
INSERT INTO `provinces`
VALUES (220503, '二道江区', 220500, '二道江', 3, '0435', '134003', '中国,吉林省,通化市,二道江区', '126.04257', '41.7741', 'Erdaojiang', 1);
INSERT INTO `provinces`
VALUES (220521, '通化县', 220500, '通化', 3, '0435', '134100', '中国,吉林省,通化市,通化县', '125.75936', '41.67928', 'Tonghua', 1);
INSERT INTO `provinces`
VALUES (220523, '辉南县', 220500, '辉南', 3, '0435', '135100', '中国,吉林省,通化市,辉南县', '126.04684', '42.68497', 'Huinan', 1);
INSERT INTO `provinces`
VALUES (220524, '柳河县', 220500, '柳河', 3, '0435', '135300', '中国,吉林省,通化市,柳河县', '125.74475', '42.28468', 'Liuhe', 1);
INSERT INTO `provinces`
VALUES (220581, '梅河口市', 220500, '梅河口', 3, '0435', '135000', '中国,吉林省,通化市,梅河口市', '125.71041', '42.53828', 'Meihekou', 1);
INSERT INTO `provinces`
VALUES (220582, '集安市', 220500, '集安', 3, '0435', '134200', '中国,吉林省,通化市,集安市', '126.18829', '41.12268', 'Ji\'an', 1);
INSERT INTO `provinces`
VALUES (220600, '白山市', 220000, '白山', 2, '0439', '134300', '中国,吉林省,白山市', '126.427839', '41.942505', 'Baishan', 1);
INSERT INTO `provinces`
VALUES (220602, '浑江区', 220600, '浑江', 3, '0439', '134300', '中国,吉林省,白山市,浑江区', '126.422342', '41.945656', 'Hunjiang', 1);
INSERT INTO `provinces`
VALUES (220605, '江源区', 220600, '江源', 3, '0439', '134700', '中国,吉林省,白山市,江源区', '126.59079', '42.05664', 'Jiangyuan', 1);
INSERT INTO `provinces`
VALUES (220621, '抚松县', 220600, '抚松', 3, '0439', '134500', '中国,吉林省,白山市,抚松县', '127.2803', '42.34198', 'Fusong', 1);
INSERT INTO `provinces`
VALUES (220622, '靖宇县', 220600, '靖宇', 3, '0439', '135200', '中国,吉林省,白山市,靖宇县', '126.81308', '42.38863', 'Jingyu', 1);
INSERT INTO `provinces`
VALUES (220623, '长白朝鲜族自治县', 220600, '长白', 3, '0439', '134400', '中国,吉林省,白山市,长白朝鲜族自治县', '128.20047', '41.41996',
        'Changbai', 1);
INSERT INTO `provinces`
VALUES (220681, '临江市', 220600, '临江', 3, '0439', '134600', '中国,吉林省,白山市,临江市', '126.91751', '41.81142', 'Linjiang', 1);
INSERT INTO `provinces`
VALUES (220700, '松原市', 220000, '松原', 2, '0438', '138000', '中国,吉林省,松原市', '124.823608', '45.118243', 'Songyuan', 1);
INSERT INTO `provinces`
VALUES (220702, '宁江区', 220700, '宁江', 3, '0438', '138000', '中国,吉林省,松原市,宁江区', '124.81689', '45.17175', 'Ningjiang', 1);
INSERT INTO `provinces`
VALUES (220721, '前郭尔罗斯蒙古族自治县', 220700, '前郭尔罗斯', 3, '0438', '138000', '中国,吉林省,松原市,前郭尔罗斯蒙古族自治县', '124.82351', '45.11726',
        'Qianguoerluosi', 1);
INSERT INTO `provinces`
VALUES (220722, '长岭县', 220700, '长岭', 3, '0438', '131500', '中国,吉林省,松原市,长岭县', '123.96725', '44.27581', 'Changling', 1);
INSERT INTO `provinces`
VALUES (220723, '乾安县', 220700, '乾安', 3, '0438', '131400', '中国,吉林省,松原市,乾安县', '124.02737', '45.01068', 'Qian\'an', 1);
INSERT INTO `provinces`
VALUES (220781, '扶余市', 220700, '扶余', 3, '0438', '131200', '中国,吉林省,松原市,扶余市', '126.042758', '44.986199', 'Fuyu', 1);
INSERT INTO `provinces`
VALUES (220800, '白城市', 220000, '白城', 2, '0436', '137000', '中国,吉林省,白城市', '122.841114', '45.619026', 'Baicheng', 1);
INSERT INTO `provinces`
VALUES (220802, '洮北区', 220800, '洮北', 3, '0436', '137000', '中国,吉林省,白城市,洮北区', '122.85104', '45.62167', 'Taobei', 1);
INSERT INTO `provinces`
VALUES (220821, '镇赉县', 220800, '镇赉', 3, '0436', '137300', '中国,吉林省,白城市,镇赉县', '123.19924', '45.84779', 'Zhenlai', 1);
INSERT INTO `provinces`
VALUES (220822, '通榆县', 220800, '通榆', 3, '0436', '137200', '中国,吉林省,白城市,通榆县', '123.08761', '44.81388', 'Tongyu', 1);
INSERT INTO `provinces`
VALUES (220881, '洮南市', 220800, '洮南', 3, '0436', '137100', '中国,吉林省,白城市,洮南市', '122.78772', '45.33502', 'Taonan', 1);
INSERT INTO `provinces`
VALUES (220882, '大安市', 220800, '大安', 3, '0436', '131300', '中国,吉林省,白城市,大安市', '124.29519', '45.50846', 'Da\'an', 1);
INSERT INTO `provinces`
VALUES (222400, '延边朝鲜族自治州', 220000, '延边', 2, '0433', '133000', '中国,吉林省,延边朝鲜族自治州', '129.513228', '42.904823', 'Yanbian',
        1);
INSERT INTO `provinces`
VALUES (222401, '延吉市', 222400, '延吉', 3, '0433', '133000', '中国,吉林省,延边朝鲜族自治州,延吉市', '129.51357', '42.90682', 'Yanji', 1);
INSERT INTO `provinces`
VALUES (222402, '图们市', 222400, '图们', 3, '0433', '133100', '中国,吉林省,延边朝鲜族自治州,图们市', '129.84381', '42.96801', 'Tumen', 1);
INSERT INTO `provinces`
VALUES (222403, '敦化市', 222400, '敦化', 3, '0433', '133700', '中国,吉林省,延边朝鲜族自治州,敦化市', '128.23242', '43.37304', 'Dunhua', 1);
INSERT INTO `provinces`
VALUES (222404, '珲春市', 222400, '珲春', 3, '0433', '133300', '中国,吉林省,延边朝鲜族自治州,珲春市', '130.36572', '42.86242', 'Hunchun', 1);
INSERT INTO `provinces`
VALUES (222405, '龙井市', 222400, '龙井', 3, '0433', '133400', '中国,吉林省,延边朝鲜族自治州,龙井市', '129.42584', '42.76804', 'Longjing',
        1);
INSERT INTO `provinces`
VALUES (222406, '和龙市', 222400, '和龙', 3, '0433', '133500', '中国,吉林省,延边朝鲜族自治州,和龙市', '129.01077', '42.5464', 'Helong', 1);
INSERT INTO `provinces`
VALUES (222424, '汪清县', 222400, '汪清', 3, '0433', '133200', '中国,吉林省,延边朝鲜族自治州,汪清县', '129.77121', '43.31278', 'Wangqing',
        1);
INSERT INTO `provinces`
VALUES (222426, '安图县', 222400, '安图', 3, '0433', '133600', '中国,吉林省,延边朝鲜族自治州,安图县', '128.90625', '43.11533', 'Antu', 1);
INSERT INTO `provinces`
VALUES (230000, '黑龙江省', 100000, '黑龙江', 1, '', '', '中国,黑龙江省', '126.642464', '45.756967', 'Heilongjiang', 1);
INSERT INTO `provinces`
VALUES (230100, '哈尔滨市', 230000, '哈尔滨', 2, '0451', '150010', '中国,黑龙江省,哈尔滨市', '126.642464', '45.756967', 'Harbin', 1);
INSERT INTO `provinces`
VALUES (230102, '道里区', 230100, '道里', 3, '0451', '150010', '中国,黑龙江省,哈尔滨市,道里区', '126.61705', '45.75586', 'Daoli', 1);
INSERT INTO `provinces`
VALUES (230103, '南岗区', 230100, '南岗', 3, '0451', '150006', '中国,黑龙江省,哈尔滨市,南岗区', '126.66854', '45.75996', 'Nangang', 1);
INSERT INTO `provinces`
VALUES (230104, '道外区', 230100, '道外', 3, '0451', '150020', '中国,黑龙江省,哈尔滨市,道外区', '126.64938', '45.79187', 'Daowai', 1);
INSERT INTO `provinces`
VALUES (230108, '平房区', 230100, '平房', 3, '0451', '150060', '中国,黑龙江省,哈尔滨市,平房区', '126.63729', '45.59777', 'Pingfang', 1);
INSERT INTO `provinces`
VALUES (230109, '松北区', 230100, '松北', 3, '0451', '150028', '中国,黑龙江省,哈尔滨市,松北区', '126.56276', '45.80831', 'Songbei', 1);
INSERT INTO `provinces`
VALUES (230110, '香坊区', 230100, '香坊', 3, '0451', '150036', '中国,黑龙江省,哈尔滨市,香坊区', '126.67968', '45.72383', 'Xiangfang', 1);
INSERT INTO `provinces`
VALUES (230111, '呼兰区', 230100, '呼兰', 3, '0451', '150500', '中国,黑龙江省,哈尔滨市,呼兰区', '126.58792', '45.88895', 'Hulan', 1);
INSERT INTO `provinces`
VALUES (230112, '阿城区', 230100, '阿城', 3, '0451', '150300', '中国,黑龙江省,哈尔滨市,阿城区', '126.97525', '45.54144', 'A\'cheng', 1);
INSERT INTO `provinces`
VALUES (230113, '双城区', 230100, '双城', 3, '0451', '150100', '中国,黑龙江省,哈尔滨市,双城区', '126.308784', '45.377942', 'Shuangcheng',
        1);
INSERT INTO `provinces`
VALUES (230123, '依兰县', 230100, '依兰', 3, '0451', '154800', '中国,黑龙江省,哈尔滨市,依兰县', '129.56817', '46.3247', 'Yilan', 1);
INSERT INTO `provinces`
VALUES (230124, '方正县', 230100, '方正', 3, '0451', '150800', '中国,黑龙江省,哈尔滨市,方正县', '128.82952', '45.85162', 'Fangzheng', 1);
INSERT INTO `provinces`
VALUES (230125, '宾县', 230100, '宾县', 3, '0451', '150400', '中国,黑龙江省,哈尔滨市,宾县', '127.48675', '45.75504', 'Binxian', 1);
INSERT INTO `provinces`
VALUES (230126, '巴彦县', 230100, '巴彦', 3, '0451', '151800', '中国,黑龙江省,哈尔滨市,巴彦县', '127.40799', '46.08148', 'Bayan', 1);
INSERT INTO `provinces`
VALUES (230127, '木兰县', 230100, '木兰', 3, '0451', '151900', '中国,黑龙江省,哈尔滨市,木兰县', '128.0448', '45.94944', 'Mulan', 1);
INSERT INTO `provinces`
VALUES (230128, '通河县', 230100, '通河', 3, '0451', '150900', '中国,黑龙江省,哈尔滨市,通河县', '128.74603', '45.99007', 'Tonghe', 1);
INSERT INTO `provinces`
VALUES (230129, '延寿县', 230100, '延寿', 3, '0451', '150700', '中国,黑龙江省,哈尔滨市,延寿县', '128.33419', '45.4554', 'Yanshou', 1);
INSERT INTO `provinces`
VALUES (230183, '尚志市', 230100, '尚志', 3, '0451', '150600', '中国,黑龙江省,哈尔滨市,尚志市', '127.96191', '45.21736', 'Shangzhi', 1);
INSERT INTO `provinces`
VALUES (230184, '五常市', 230100, '五常', 3, '0451', '150200', '中国,黑龙江省,哈尔滨市,五常市', '127.16751', '44.93184', 'Wuchang', 1);
INSERT INTO `provinces`
VALUES (230200, '齐齐哈尔市', 230000, '齐齐哈尔', 2, '0452', '161005', '中国,黑龙江省,齐齐哈尔市', '123.953486', '47.348079', 'Qiqihar', 1);
INSERT INTO `provinces`
VALUES (230202, '龙沙区', 230200, '龙沙', 3, '0452', '161000', '中国,黑龙江省,齐齐哈尔市,龙沙区', '123.95752', '47.31776', 'Longsha', 1);
INSERT INTO `provinces`
VALUES (230203, '建华区', 230200, '建华', 3, '0452', '161006', '中国,黑龙江省,齐齐哈尔市,建华区', '124.0133', '47.36718', 'Jianhua', 1);
INSERT INTO `provinces`
VALUES (230204, '铁锋区', 230200, '铁锋', 3, '0452', '161000', '中国,黑龙江省,齐齐哈尔市,铁锋区', '123.97821', '47.34075', 'Tiefeng', 1);
INSERT INTO `provinces`
VALUES (230205, '昂昂溪区', 230200, '昂昂溪', 3, '0452', '161031', '中国,黑龙江省,齐齐哈尔市,昂昂溪区', '123.82229', '47.15513', 'Angangxi',
        1);
INSERT INTO `provinces`
VALUES (230206, '富拉尔基区', 230200, '富拉尔基', 3, '0452', '161041', '中国,黑龙江省,齐齐哈尔市,富拉尔基区', '123.62918', '47.20884',
        'Fulaerji', 1);
INSERT INTO `provinces`
VALUES (230207, '碾子山区', 230200, '碾子山', 3, '0452', '161046', '中国,黑龙江省,齐齐哈尔市,碾子山区', '122.88183', '47.51662', 'Nianzishan',
        1);
INSERT INTO `provinces`
VALUES (230208, '梅里斯达斡尔族区', 230200, '梅里斯', 3, '0452', '161021', '中国,黑龙江省,齐齐哈尔市,梅里斯达斡尔族区', '123.75274', '47.30946',
        'Meilisi', 1);
INSERT INTO `provinces`
VALUES (230221, '龙江县', 230200, '龙江', 3, '0452', '161100', '中国,黑龙江省,齐齐哈尔市,龙江县', '123.20532', '47.33868', 'Longjiang', 1);
INSERT INTO `provinces`
VALUES (230223, '依安县', 230200, '依安', 3, '0452', '161500', '中国,黑龙江省,齐齐哈尔市,依安县', '125.30896', '47.8931', 'Yi\'an', 1);
INSERT INTO `provinces`
VALUES (230224, '泰来县', 230200, '泰来', 3, '0452', '162400', '中国,黑龙江省,齐齐哈尔市,泰来县', '123.42285', '46.39386', 'Tailai', 1);
INSERT INTO `provinces`
VALUES (310110, '杨浦区', 310100, '杨浦', 3, '021', '200082', '中国,上海,上海市,杨浦区', '121.526', '31.2595', 'Yangpu', 1);
INSERT INTO `provinces`
VALUES (310112, '闵行区', 310100, '闵行', 3, '021', '201100', '中国,上海,上海市,闵行区', '121.38162', '31.11246', 'Minhang', 1);
INSERT INTO `provinces`
VALUES (310113, '宝山区', 310100, '宝山', 3, '021', '201900', '中国,上海,上海市,宝山区', '121.4891', '31.4045', 'Baoshan', 1);
INSERT INTO `provinces`
VALUES (310114, '嘉定区', 310100, '嘉定', 3, '021', '201800', '中国,上海,上海市,嘉定区', '121.2655', '31.37473', 'Jiading', 1);
INSERT INTO `provinces`
VALUES (310115, '浦东新区', 310100, '浦东', 3, '021', '200135', '中国,上海,上海市,浦东新区', '121.5447', '31.22249', 'Pudong', 1);
INSERT INTO `provinces`
VALUES (310116, '金山区', 310100, '金山', 3, '021', '200540', '中国,上海,上海市,金山区', '121.34164', '30.74163', 'Jinshan', 1);
INSERT INTO `provinces`
VALUES (310117, '松江区', 310100, '松江', 3, '021', '201600', '中国,上海,上海市,松江区', '121.22879', '31.03222', 'Songjiang', 1);
INSERT INTO `provinces`
VALUES (310118, '青浦区', 310100, '青浦', 3, '021', '201700', '中国,上海,上海市,青浦区', '121.12417', '31.14974', 'Qingpu', 1);
INSERT INTO `provinces`
VALUES (310120, '奉贤区', 310100, '奉贤', 3, '021', '201400', '中国,上海,上海市,奉贤区', '121.47412', '30.9179', 'Fengxian', 1);
INSERT INTO `provinces`
VALUES (310230, '崇明县', 310100, '崇明', 3, '021', '202150', '中国,上海,上海市,崇明县', '121.39758', '31.62278', 'Chongming', 1);
INSERT INTO `provinces`
VALUES (320000, '江苏省', 100000, '江苏', 1, '', '', '中国,江苏省', '118.767413', '32.041544', 'Jiangsu', 1);
INSERT INTO `provinces`
VALUES (320100, '南京市', 320000, '南京', 2, '025', '210008', '中国,江苏省,南京市', '118.767413', '32.041544', 'Nanjing', 1);
INSERT INTO `provinces`
VALUES (320102, '玄武区', 320100, '玄武', 3, '025', '210018', '中国,江苏省,南京市,玄武区', '118.79772', '32.04856', 'Xuanwu', 1);
INSERT INTO `provinces`
VALUES (320104, '秦淮区', 320100, '秦淮', 3, '025', '210001', '中国,江苏省,南京市,秦淮区', '118.79815', '32.01112', 'Qinhuai', 1);
INSERT INTO `provinces`
VALUES (320105, '建邺区', 320100, '建邺', 3, '025', '210004', '中国,江苏省,南京市,建邺区', '118.76641', '32.03096', 'Jianye', 1);
INSERT INTO `provinces`
VALUES (320106, '鼓楼区', 320100, '鼓楼', 3, '025', '210009', '中国,江苏省,南京市,鼓楼区', '118.76974', '32.06632', 'Gulou', 1);
INSERT INTO `provinces`
VALUES (320111, '浦口区', 320100, '浦口', 3, '025', '211800', '中国,江苏省,南京市,浦口区', '118.62802', '32.05881', 'Pukou', 1);
INSERT INTO `provinces`
VALUES (320113, '栖霞区', 320100, '栖霞', 3, '025', '210046', '中国,江苏省,南京市,栖霞区', '118.88064', '32.11352', 'Qixia', 1);
INSERT INTO `provinces`
VALUES (320114, '雨花台区', 320100, '雨花台', 3, '025', '210012', '中国,江苏省,南京市,雨花台区', '118.7799', '31.99202', 'Yuhuatai', 1);
INSERT INTO `provinces`
VALUES (320115, '江宁区', 320100, '江宁', 3, '025', '211100', '中国,江苏省,南京市,江宁区', '118.8399', '31.95263', 'Jiangning', 1);
INSERT INTO `provinces`
VALUES (320116, '六合区', 320100, '六合', 3, '025', '211500', '中国,江苏省,南京市,六合区', '118.8413', '32.34222', 'Luhe', 1);
INSERT INTO `provinces`
VALUES (320117, '溧水区', 320100, '溧水', 3, '025', '211200', '中国,江苏省,南京市,溧水区', '119.028732', '31.653061', 'Lishui', 1);
INSERT INTO `provinces`
VALUES (320118, '高淳区', 320100, '高淳', 3, '025', '211300', '中国,江苏省,南京市,高淳区', '118.87589', '31.327132', 'Gaochun', 1);
INSERT INTO `provinces`
VALUES (320200, '无锡市', 320000, '无锡', 2, '0510', '214000', '中国,江苏省,无锡市', '120.301663', '31.574729', 'Wuxi', 1);
INSERT INTO `provinces`
VALUES (320202, '崇安区', 320200, '崇安', 3, '0510', '214001', '中国,江苏省,无锡市,崇安区', '120.29975', '31.58002', 'Chong\'an', 1);
INSERT INTO `provinces`
VALUES (320203, '南长区', 320200, '南长', 3, '0510', '214021', '中国,江苏省,无锡市,南长区', '120.30873', '31.56359', 'Nanchang', 1);
INSERT INTO `provinces`
VALUES (320204, '北塘区', 320200, '北塘', 3, '0510', '214044', '中国,江苏省,无锡市,北塘区', '120.29405', '31.60592', 'Beitang', 1);
INSERT INTO `provinces`
VALUES (320205, '锡山区', 320200, '锡山', 3, '0510', '214101', '中国,江苏省,无锡市,锡山区', '120.35699', '31.5886', 'Xishan', 1);
INSERT INTO `provinces`
VALUES (320206, '惠山区', 320200, '惠山', 3, '0510', '214174', '中国,江苏省,无锡市,惠山区', '120.29849', '31.68088', 'Huishan', 1);
INSERT INTO `provinces`
VALUES (320211, '滨湖区', 320200, '滨湖', 3, '0510', '214123', '中国,江苏省,无锡市,滨湖区', '120.29461', '31.52162', 'Binhu', 1);
INSERT INTO `provinces`
VALUES (320281, '江阴市', 320200, '江阴', 3, '0510', '214431', '中国,江苏省,无锡市,江阴市', '120.2853', '31.91996', 'Jiangyin', 1);
INSERT INTO `provinces`
VALUES (320282, '宜兴市', 320200, '宜兴', 3, '0510', '214200', '中国,江苏省,无锡市,宜兴市', '119.82357', '31.33978', 'Yixing', 1);
INSERT INTO `provinces`
VALUES (320300, '徐州市', 320000, '徐州', 2, '0516', '221003', '中国,江苏省,徐州市', '117.184811', '34.261792', 'Xuzhou', 1);
INSERT INTO `provinces`
VALUES (320302, '鼓楼区', 320300, '鼓楼', 3, '0516', '221005', '中国,江苏省,徐州市,鼓楼区', '117.18559', '34.28851', 'Gulou', 1);
INSERT INTO `provinces`
VALUES (320303, '云龙区', 320300, '云龙', 3, '0516', '221007', '中国,江苏省,徐州市,云龙区', '117.23053', '34.24895', 'Yunlong', 1);
INSERT INTO `provinces`
VALUES (320305, '贾汪区', 320300, '贾汪', 3, '0516', '221003', '中国,江苏省,徐州市,贾汪区', '117.45346', '34.44264', 'Jiawang', 1);
INSERT INTO `provinces`
VALUES (320311, '泉山区', 320300, '泉山', 3, '0516', '221006', '中国,江苏省,徐州市,泉山区', '117.19378', '34.24418', 'Quanshan', 1);
INSERT INTO `provinces`
VALUES (320312, '铜山区', 320300, '铜山', 3, '0516', '221106', '中国,江苏省,徐州市,铜山区', '117.183894', '34.19288', 'Tongshan', 1);
INSERT INTO `provinces`
VALUES (320321, '丰县', 320300, '丰县', 3, '0516', '221700', '中国,江苏省,徐州市,丰县', '116.59957', '34.69972', 'Fengxian', 1);
INSERT INTO `provinces`
VALUES (320322, '沛县', 320300, '沛县', 3, '0516', '221600', '中国,江苏省,徐州市,沛县', '116.93743', '34.72163', 'Peixian', 1);
INSERT INTO `provinces`
VALUES (320324, '睢宁县', 320300, '睢宁', 3, '0516', '221200', '中国,江苏省,徐州市,睢宁县', '117.94104', '33.91269', 'Suining', 1);
INSERT INTO `provinces`
VALUES (320381, '新沂市', 320300, '新沂', 3, '0516', '221400', '中国,江苏省,徐州市,新沂市', '118.35452', '34.36942', 'Xinyi', 1);
INSERT INTO `provinces`
VALUES (320382, '邳州市', 320300, '邳州', 3, '0516', '221300', '中国,江苏省,徐州市,邳州市', '117.95858', '34.33329', 'Pizhou', 1);
INSERT INTO `provinces`
VALUES (320400, '常州市', 320000, '常州', 2, '0519', '213000', '中国,江苏省,常州市', '119.946973', '31.772752', 'Changzhou', 1);
INSERT INTO `provinces`
VALUES (320402, '天宁区', 320400, '天宁', 3, '0519', '213000', '中国,江苏省,常州市,天宁区', '119.95132', '31.75211', 'Tianning', 1);
INSERT INTO `provinces`
VALUES (320404, '钟楼区', 320400, '钟楼', 3, '0519', '213023', '中国,江苏省,常州市,钟楼区', '119.90178', '31.80221', 'Zhonglou', 1);
INSERT INTO `provinces`
VALUES (320405, '戚墅堰区', 320400, '戚墅堰', 3, '0519', '213025', '中国,江苏省,常州市,戚墅堰区', '120.06106', '31.71956', 'Qishuyan', 1);
INSERT INTO `provinces`
VALUES (320411, '新北区', 320400, '新北', 3, '0519', '213022', '中国,江苏省,常州市,新北区', '119.97131', '31.83046', 'Xinbei', 1);
INSERT INTO `provinces`
VALUES (320412, '武进区', 320400, '武进', 3, '0519', '213100', '中国,江苏省,常州市,武进区', '119.94244', '31.70086', 'Wujin', 1);
INSERT INTO `provinces`
VALUES (320481, '溧阳市', 320400, '溧阳', 3, '0519', '213300', '中国,江苏省,常州市,溧阳市', '119.4837', '31.41538', 'Liyang', 1);
INSERT INTO `provinces`
VALUES (320482, '金坛市', 320400, '金坛', 3, '0519', '213200', '中国,江苏省,常州市,金坛市', '119.57757', '31.74043', 'Jintan', 1);
INSERT INTO `provinces`
VALUES (320500, '苏州市', 320000, '苏州', 2, '0512', '215002', '中国,江苏省,苏州市', '120.619585', '31.299379', 'Suzhou', 1);
INSERT INTO `provinces`
VALUES (320505, '虎丘区', 320500, '虎丘', 3, '0512', '215004', '中国,江苏省,苏州市,虎丘区', '120.57345', '31.2953', 'Huqiu', 1);
INSERT INTO `provinces`
VALUES (320506, '吴中区', 320500, '吴中', 3, '0512', '215128', '中国,江苏省,苏州市,吴中区', '120.63211', '31.26226', 'Wuzhong', 1);
INSERT INTO `provinces`
VALUES (320507, '相城区', 320500, '相城', 3, '0512', '215131', '中国,江苏省,苏州市,相城区', '120.64239', '31.36889', 'Xiangcheng', 1);
INSERT INTO `provinces`
VALUES (320508, '姑苏区', 320500, '姑苏', 3, '0512', '215031', '中国,江苏省,苏州市,姑苏区', '120.619585', '31.299379', 'Gusu', 1);
INSERT INTO `provinces`
VALUES (320509, '吴江区', 320500, '吴江', 3, '0512', '215200', '中国,江苏省,苏州市,吴江区', '120.638317', '31.159815', 'Wujiang', 1);
INSERT INTO `provinces`
VALUES (320581, '常熟市', 320500, '常熟', 3, '0512', '215500', '中国,江苏省,苏州市,常熟市', '120.75126', '31.65374', 'Changshu', 1);
INSERT INTO `provinces`
VALUES (320582, '张家港市', 320500, '张家港', 3, '0512', '215600', '中国,江苏省,苏州市,张家港市', '120.55538', '31.87532', 'Zhangjiagang',
        1);
INSERT INTO `provinces`
VALUES (320583, '昆山市', 320500, '昆山', 3, '0512', '215300', '中国,江苏省,苏州市,昆山市', '120.98074', '31.38464', 'Kunshan', 1);
INSERT INTO `provinces`
VALUES (320585, '太仓市', 320500, '太仓', 3, '0512', '215400', '中国,江苏省,苏州市,太仓市', '121.10891', '31.4497', 'Taicang', 1);
INSERT INTO `provinces`
VALUES (320600, '南通市', 320000, '南通', 2, '0513', '226001', '中国,江苏省,南通市', '120.864608', '32.016212', 'Nantong', 1);
INSERT INTO `provinces`
VALUES (320602, '崇川区', 320600, '崇川', 3, '0513', '226001', '中国,江苏省,南通市,崇川区', '120.8573', '32.0098', 'Chongchuan', 1);
INSERT INTO `provinces`
VALUES (320611, '港闸区', 320600, '港闸', 3, '0513', '226001', '中国,江苏省,南通市,港闸区', '120.81778', '32.03163', 'Gangzha', 1);
INSERT INTO `provinces`
VALUES (320612, '通州区', 320600, '通州', 3, '0513', '226300', '中国,江苏省,南通市,通州区', '121.07293', '32.0676', 'Tongzhou', 1);
INSERT INTO `provinces`
VALUES (320621, '海安县', 320600, '海安', 3, '0513', '226600', '中国,江苏省,南通市,海安县', '120.45852', '32.54514', 'Hai\'an', 1);
INSERT INTO `provinces`
VALUES (320623, '如东县', 320600, '如东', 3, '0513', '226400', '中国,江苏省,南通市,如东县', '121.18942', '32.31439', 'Rudong', 1);
INSERT INTO `provinces`
VALUES (320681, '启东市', 320600, '启东', 3, '0513', '226200', '中国,江苏省,南通市,启东市', '121.65985', '31.81083', 'Qidong', 1);
INSERT INTO `provinces`
VALUES (320682, '如皋市', 320600, '如皋', 3, '0513', '226500', '中国,江苏省,南通市,如皋市', '120.55969', '32.37597', 'Rugao', 1);
INSERT INTO `provinces`
VALUES (320684, '海门市', 320600, '海门', 3, '0513', '226100', '中国,江苏省,南通市,海门市', '121.16995', '31.89422', 'Haimen', 1);
INSERT INTO `provinces`
VALUES (320700, '连云港市', 320000, '连云港', 2, '0518', '222002', '中国,江苏省,连云港市', '119.178821', '34.600018', 'Lianyungang', 1);
INSERT INTO `provinces`
VALUES (320703, '连云区', 320700, '连云', 3, '0518', '222042', '中国,江苏省,连云港市,连云区', '119.37304', '34.75293', 'Lianyun', 1);
INSERT INTO `provinces`
VALUES (320706, '海州区', 320700, '海州', 3, '0518', '222003', '中国,江苏省,连云港市,海州区', '119.13128', '34.56986', 'Haizhou', 1);
INSERT INTO `provinces`
VALUES (320707, '赣榆区', 320700, '赣榆', 3, '0518', '222100', '中国,江苏省,连云港市,赣榆区', '119.128774', '34.839154', 'Ganyu', 1);
INSERT INTO `provinces`
VALUES (320722, '东海县', 320700, '东海', 3, '0518', '222300', '中国,江苏省,连云港市,东海县', '118.77145', '34.54215', 'Donghai', 1);
INSERT INTO `provinces`
VALUES (320723, '灌云县', 320700, '灌云', 3, '0518', '222200', '中国,江苏省,连云港市,灌云县', '119.23925', '34.28391', 'Guanyun', 1);
INSERT INTO `provinces`
VALUES (320724, '灌南县', 320700, '灌南', 3, '0518', '212600', '中国,江苏省,连云港市,灌南县', '119.35632', '34.09', 'Guannan', 1);
INSERT INTO `provinces`
VALUES (320800, '淮安市', 320000, '淮安', 2, '0517', '223001', '中国,江苏省,淮安市', '119.021265', '33.597506', 'Huai\'an', 1);
INSERT INTO `provinces`
VALUES (320802, '清河区', 320800, '清河', 3, '0517', '223001', '中国,江苏省,淮安市,清河区', '119.00778', '33.59949', 'Qinghe', 1);
INSERT INTO `provinces`
VALUES (320803, '淮安区', 320800, '淮安', 3, '0517', '223200', '中国,江苏省,淮安市,淮安区', '119.021265', '33.597506', 'Huai\'an', 1);
INSERT INTO `provinces`
VALUES (320804, '淮阴区', 320800, '淮阴', 3, '0517', '223300', '中国,江苏省,淮安市,淮阴区', '119.03485', '33.63171', 'Huaiyin', 1);
INSERT INTO `provinces`
VALUES (320811, '清浦区', 320800, '清浦', 3, '0517', '223002', '中国,江苏省,淮安市,清浦区', '119.02648', '33.55232', 'Qingpu', 1);
INSERT INTO `provinces`
VALUES (320826, '涟水县', 320800, '涟水', 3, '0517', '223400', '中国,江苏省,淮安市,涟水县', '119.26083', '33.78094', 'Lianshui', 1);
INSERT INTO `provinces`
VALUES (320829, '洪泽县', 320800, '洪泽', 3, '0517', '223100', '中国,江苏省,淮安市,洪泽县', '118.87344', '33.29429', 'Hongze', 1);
INSERT INTO `provinces`
VALUES (320830, '盱眙县', 320800, '盱眙', 3, '0517', '211700', '中国,江苏省,淮安市,盱眙县', '118.54495', '33.01086', 'Xuyi', 1);
INSERT INTO `provinces`
VALUES (320831, '金湖县', 320800, '金湖', 3, '0517', '211600', '中国,江苏省,淮安市,金湖县', '119.02307', '33.02219', 'Jinhu', 1);
INSERT INTO `provinces`
VALUES (320900, '盐城市', 320000, '盐城', 2, '0515', '224005', '中国,江苏省,盐城市', '120.139998', '33.377631', 'Yancheng', 1);
INSERT INTO `provinces`
VALUES (320902, '亭湖区', 320900, '亭湖', 3, '0515', '224005', '中国,江苏省,盐城市,亭湖区', '120.16583', '33.37825', 'Tinghu', 1);
INSERT INTO `provinces`
VALUES (320903, '盐都区', 320900, '盐都', 3, '0515', '224055', '中国,江苏省,盐城市,盐都区', '120.15441', '33.3373', 'Yandu', 1);
INSERT INTO `provinces`
VALUES (320921, '响水县', 320900, '响水', 3, '0515', '224600', '中国,江苏省,盐城市,响水县', '119.56985', '34.20513', 'Xiangshui', 1);
INSERT INTO `provinces`
VALUES (320922, '滨海县', 320900, '滨海', 3, '0515', '224500', '中国,江苏省,盐城市,滨海县', '119.82058', '33.98972', 'Binhai', 1);
INSERT INTO `provinces`
VALUES (320923, '阜宁县', 320900, '阜宁', 3, '0515', '224400', '中国,江苏省,盐城市,阜宁县', '119.80175', '33.78228', 'Funing', 1);
INSERT INTO `provinces`
VALUES (320924, '射阳县', 320900, '射阳', 3, '0515', '224300', '中国,江苏省,盐城市,射阳县', '120.26043', '33.77636', 'Sheyang', 1);
INSERT INTO `provinces`
VALUES (320925, '建湖县', 320900, '建湖', 3, '0515', '224700', '中国,江苏省,盐城市,建湖县', '119.79852', '33.47241', 'Jianhu', 1);
INSERT INTO `provinces`
VALUES (320981, '东台市', 320900, '东台', 3, '0515', '224200', '中国,江苏省,盐城市,东台市', '120.32376', '32.85078', 'Dongtai', 1);
INSERT INTO `provinces`
VALUES (320982, '大丰市', 320900, '大丰', 3, '0515', '224100', '中国,江苏省,盐城市,大丰市', '120.46594', '33.19893', 'Dafeng', 1);
INSERT INTO `provinces`
VALUES (321000, '扬州市', 320000, '扬州', 2, '0514', '126002', '中国,江苏省,扬州市', '119.421003', '32.393159', 'Yangzhou', 1);
INSERT INTO `provinces`
VALUES (321002, '广陵区', 321000, '广陵', 3, '0514', '126002', '中国,江苏省,扬州市,广陵区', '119.43186', '32.39472', 'Guangling', 1);
INSERT INTO `provinces`
VALUES (321003, '邗江区', 321000, '邗江', 3, '0514', '126002', '中国,江苏省,扬州市,邗江区', '119.39816', '32.3765', 'Hanjiang', 1);
INSERT INTO `provinces`
VALUES (321012, '江都区', 321000, '江都', 3, '0514', '126200', '中国,江苏省,扬州市,江都区', '119.567481', '32.426564', 'Jiangdu', 1);
INSERT INTO `provinces`
VALUES (321023, '宝应县', 321000, '宝应', 3, '0514', '126800', '中国,江苏省,扬州市,宝应县', '119.31213', '33.23549', 'Baoying', 1);
INSERT INTO `provinces`
VALUES (321081, '仪征市', 321000, '仪征', 3, '0514', '211400', '中国,江苏省,扬州市,仪征市', '119.18432', '32.27197', 'Yizheng', 1);
INSERT INTO `provinces`
VALUES (321084, '高邮市', 321000, '高邮', 3, '0514', '126600', '中国,江苏省,扬州市,高邮市', '119.45965', '32.78135', 'Gaoyou', 1);
INSERT INTO `provinces`
VALUES (321100, '镇江市', 320000, '镇江', 2, '0511', '212004', '中国,江苏省,镇江市', '119.452753', '32.204402', 'Zhenjiang', 1);
INSERT INTO `provinces`
VALUES (321102, '京口区', 321100, '京口', 3, '0511', '212003', '中国,江苏省,镇江市,京口区', '119.46947', '32.19809', 'Jingkou', 1);
INSERT INTO `provinces`
VALUES (321111, '润州区', 321100, '润州', 3, '0511', '212005', '中国,江苏省,镇江市,润州区', '119.41134', '32.19523', 'Runzhou', 1);
INSERT INTO `provinces`
VALUES (321112, '丹徒区', 321100, '丹徒', 3, '0511', '212028', '中国,江苏省,镇江市,丹徒区', '119.43383', '32.13183', 'Dantu', 1);
INSERT INTO `provinces`
VALUES (321181, '丹阳市', 321100, '丹阳', 3, '0511', '212300', '中国,江苏省,镇江市,丹阳市', '119.57525', '31.99121', 'Danyang', 1);
INSERT INTO `provinces`
VALUES (321182, '扬中市', 321100, '扬中', 3, '0511', '212200', '中国,江苏省,镇江市,扬中市', '119.79718', '32.2363', 'Yangzhong', 1);
INSERT INTO `provinces`
VALUES (321183, '句容市', 321100, '句容', 3, '0511', '212400', '中国,江苏省,镇江市,句容市', '119.16482', '31.95591', 'Jurong', 1);
INSERT INTO `provinces`
VALUES (321200, '泰州市', 320000, '泰州', 2, '0523', '126300', '中国,江苏省,泰州市', '119.915176', '32.484882', 'Taizhou', 1);
INSERT INTO `provinces`
VALUES (321202, '海陵区', 321200, '海陵', 3, '0523', '126300', '中国,江苏省,泰州市,海陵区', '119.91942', '32.49101', 'Hailing', 1);
INSERT INTO `provinces`
VALUES (321203, '高港区', 321200, '高港', 3, '0523', '126321', '中国,江苏省,泰州市,高港区', '119.88089', '32.31833', 'Gaogang', 1);
INSERT INTO `provinces`
VALUES (321204, '姜堰区', 321200, '姜堰', 3, '0523', '126500', '中国,江苏省,泰州市,姜堰区', '120.148208', '32.508483', 'Jiangyan', 1);
INSERT INTO `provinces`
VALUES (321281, '兴化市', 321200, '兴化', 3, '0523', '126700', '中国,江苏省,泰州市,兴化市', '119.85238', '32.90944', 'Xinghua', 1);
INSERT INTO `provinces`
VALUES (321282, '靖江市', 321200, '靖江', 3, '0523', '214500', '中国,江苏省,泰州市,靖江市', '120.27291', '32.01595', 'Jingjiang', 1);
INSERT INTO `provinces`
VALUES (321283, '泰兴市', 321200, '泰兴', 3, '0523', '126400', '中国,江苏省,泰州市,泰兴市', '120.05194', '32.17187', 'Taixing', 1);
INSERT INTO `provinces`
VALUES (321300, '宿迁市', 320000, '宿迁', 2, '0527', '223800', '中国,江苏省,宿迁市', '118.293328', '33.945154', 'Suqian', 1);
INSERT INTO `provinces`
VALUES (321302, '宿城区', 321300, '宿城', 3, '0527', '223800', '中国,江苏省,宿迁市,宿城区', '118.29141', '33.94219', 'Sucheng', 1);
INSERT INTO `provinces`
VALUES (321311, '宿豫区', 321300, '宿豫', 3, '0527', '223800', '中国,江苏省,宿迁市,宿豫区', '118.32922', '33.94673', 'Suyu', 1);
INSERT INTO `provinces`
VALUES (321322, '沭阳县', 321300, '沭阳', 3, '0527', '223600', '中国,江苏省,宿迁市,沭阳县', '118.76873', '34.11446', 'Shuyang', 1);
INSERT INTO `provinces`
VALUES (321323, '泗阳县', 321300, '泗阳', 3, '0527', '223700', '中国,江苏省,宿迁市,泗阳县', '118.7033', '33.72096', 'Siyang', 1);
INSERT INTO `provinces`
VALUES (321324, '泗洪县', 321300, '泗洪', 3, '0527', '223900', '中国,江苏省,宿迁市,泗洪县', '118.21716', '33.45996', 'Sihong', 1);
INSERT INTO `provinces`
VALUES (330000, '浙江省', 100000, '浙江', 1, '', '', '中国,浙江省', '120.153576', '30.287459', 'Zhejiang', 1);
INSERT INTO `provinces`
VALUES (330100, '杭州市', 330000, '杭州', 2, '0571', '310026', '中国,浙江省,杭州市', '120.153576', '30.287459', 'Hangzhou', 1);
INSERT INTO `provinces`
VALUES (330102, '上城区', 330100, '上城', 3, '0571', '310002', '中国,浙江省,杭州市,上城区', '120.16922', '30.24255', 'Shangcheng', 1);
INSERT INTO `provinces`
VALUES (330103, '下城区', 330100, '下城', 3, '0571', '310006', '中国,浙江省,杭州市,下城区', '120.18096', '30.28153', 'Xiacheng', 1);
INSERT INTO `provinces`
VALUES (330104, '江干区', 330100, '江干', 3, '0571', '310016', '中国,浙江省,杭州市,江干区', '120.20517', '30.2572', 'Jianggan', 1);
INSERT INTO `provinces`
VALUES (330105, '拱墅区', 330100, '拱墅', 3, '0571', '310011', '中国,浙江省,杭州市,拱墅区', '120.14209', '30.31968', 'Gongshu', 1);
INSERT INTO `provinces`
VALUES (330106, '西湖区', 330100, '西湖', 3, '0571', '310013', '中国,浙江省,杭州市,西湖区', '120.12979', '30.25949', 'Xihu', 1);
INSERT INTO `provinces`
VALUES (330108, '滨江区', 330100, '滨江', 3, '0571', '310051', '中国,浙江省,杭州市,滨江区', '120.21194', '30.20835', 'Binjiang', 1);
INSERT INTO `provinces`
VALUES (330109, '萧山区', 330100, '萧山', 3, '0571', '311200', '中国,浙江省,杭州市,萧山区', '120.26452', '30.18505', 'Xiaoshan', 1);
INSERT INTO `provinces`
VALUES (330110, '余杭区', 330100, '余杭', 3, '0571', '311100', '中国,浙江省,杭州市,余杭区', '120.29986', '30.41829', 'Yuhang', 1);
INSERT INTO `provinces`
VALUES (330122, '桐庐县', 330100, '桐庐', 3, '0571', '311500', '中国,浙江省,杭州市,桐庐县', '119.68853', '29.79779', 'Tonglu', 1);
INSERT INTO `provinces`
VALUES (330126, '象山县', 330200, '象山', 3, '0574', '315700', '中国,浙江省,宁波市,象山县', '121.86917', '29.47758', 'Xiangshan', 1);
INSERT INTO `provinces`
VALUES (330127, '淳安县', 330100, '淳安', 3, '0571', '311700', '中国,浙江省,杭州市,淳安县', '119.04257', '29.60988', 'Chun\'an', 1);
INSERT INTO `provinces`
VALUES (330182, '建德市', 330100, '建德', 3, '0571', '311600', '中国,浙江省,杭州市,建德市', '119.28158', '29.47603', 'Jiande', 1);
INSERT INTO `provinces`
VALUES (330183, '富阳区', 330100, '富阳', 3, '0571', '311400', '中国,浙江省,杭州市,富阳区', '119.96041', '30.04878', 'Fuyang', 1);
INSERT INTO `provinces`
VALUES (330185, '临安市', 330100, '临安', 3, '0571', '311300', '中国,浙江省,杭州市,临安市', '119.72473', '30.23447', 'Lin\'an', 1);
INSERT INTO `provinces`
VALUES (330200, '宁波市', 330000, '宁波', 2, '0574', '315000', '中国,浙江省,宁波市', '121.549792', '29.868388', 'Ningbo', 1);
INSERT INTO `provinces`
VALUES (330203, '海曙区', 330200, '海曙', 3, '0574', '315000', '中国,浙江省,宁波市,海曙区', '121.55106', '29.85977', 'Haishu', 1);
INSERT INTO `provinces`
VALUES (330204, '江东区', 330200, '江东', 3, '0574', '315040', '中国,浙江省,宁波市,江东区', '121.57028', '29.86701', 'Jiangdong', 1);
INSERT INTO `provinces`
VALUES (330205, '江北区', 330200, '江北', 3, '0574', '315020', '中国,浙江省,宁波市,江北区', '121.55681', '29.88776', 'Jiangbei', 1);
INSERT INTO `provinces`
VALUES (330206, '北仑区', 330200, '北仑', 3, '0574', '315800', '中国,浙江省,宁波市,北仑区', '121.84408', '29.90069', 'Beilun', 1);
INSERT INTO `provinces`
VALUES (330211, '镇海区', 330200, '镇海', 3, '0574', '315200', '中国,浙江省,宁波市,镇海区', '121.71615', '29.94893', 'Zhenhai', 1);
INSERT INTO `provinces`
VALUES (330212, '鄞州区', 330200, '鄞州', 3, '0574', '315100', '中国,浙江省,宁波市,鄞州区', '121.54754', '29.81614', 'Yinzhou', 1);
INSERT INTO `provinces`
VALUES (330226, '宁海县', 330200, '宁海', 3, '0574', '315600', '中国,浙江省,宁波市,宁海县', '121.43072', '29.2889', 'Ninghai', 1);
INSERT INTO `provinces`
VALUES (330281, '余姚市', 330200, '余姚', 3, '0574', '315400', '中国,浙江省,宁波市,余姚市', '121.15341', '30.03867', 'Yuyao', 1);
INSERT INTO `provinces`
VALUES (330282, '慈溪市', 330200, '慈溪', 3, '0574', '315300', '中国,浙江省,宁波市,慈溪市', '121.26641', '30.16959', 'Cixi', 1);
INSERT INTO `provinces`
VALUES (330283, '奉化市', 330200, '奉化', 3, '0574', '315500', '中国,浙江省,宁波市,奉化市', '121.41003', '29.65537', 'Fenghua', 1);
INSERT INTO `provinces`
VALUES (330300, '温州市', 330000, '温州', 2, '0577', '325000', '中国,浙江省,温州市', '120.672111', '28.000575', 'Wenzhou', 1);
INSERT INTO `provinces`
VALUES (330302, '鹿城区', 330300, '鹿城', 3, '0577', '325000', '中国,浙江省,温州市,鹿城区', '120.65505', '28.01489', 'Lucheng', 1);
INSERT INTO `provinces`
VALUES (330303, '龙湾区', 330300, '龙湾', 3, '0577', '325013', '中国,浙江省,温州市,龙湾区', '120.83053', '27.91284', 'Longwan', 1);
INSERT INTO `provinces`
VALUES (330304, '瓯海区', 330300, '瓯海', 3, '0577', '325005', '中国,浙江省,温州市,瓯海区', '120.63751', '28.00714', 'Ouhai', 1);
INSERT INTO `provinces`
VALUES (330322, '洞头县', 330300, '洞头', 3, '0577', '325700', '中国,浙江省,温州市,洞头县', '121.15606', '27.83634', 'Dongtou', 1);
INSERT INTO `provinces`
VALUES (330324, '永嘉县', 330300, '永嘉', 3, '0577', '325100', '中国,浙江省,温州市,永嘉县', '120.69317', '28.15456', 'Yongjia', 1);
INSERT INTO `provinces`
VALUES (330326, '平阳县', 330300, '平阳', 3, '0577', '325400', '中国,浙江省,温州市,平阳县', '120.56506', '27.66245', 'Pingyang', 1);
INSERT INTO `provinces`
VALUES (330327, '苍南县', 330300, '苍南', 3, '0577', '325800', '中国,浙江省,温州市,苍南县', '120.42608', '27.51739', 'Cangnan', 1);
INSERT INTO `provinces`
VALUES (330328, '文成县', 330300, '文成', 3, '0577', '325300', '中国,浙江省,温州市,文成县', '120.09063', '27.78678', 'Wencheng', 1);
INSERT INTO `provinces`
VALUES (330329, '泰顺县', 330300, '泰顺', 3, '0577', '325500', '中国,浙江省,温州市,泰顺县', '119.7182', '27.55694', 'Taishun', 1);
INSERT INTO `provinces`
VALUES (330381, '瑞安市', 330300, '瑞安', 3, '0577', '325200', '中国,浙江省,温州市,瑞安市', '120.65466', '27.78041', 'Rui\'an', 1);
INSERT INTO `provinces`
VALUES (330382, '乐清市', 330300, '乐清', 3, '0577', '325600', '中国,浙江省,温州市,乐清市', '120.9617', '28.12404', 'Yueqing', 1);
INSERT INTO `provinces`
VALUES (330400, '嘉兴市', 330000, '嘉兴', 2, '0573', '314000', '中国,浙江省,嘉兴市', '120.750865', '30.762653', 'Jiaxing', 1);
INSERT INTO `provinces`
VALUES (330402, '南湖区', 330400, '南湖', 3, '0573', '314051', '中国,浙江省,嘉兴市,南湖区', '120.78524', '30.74865', 'Nanhu', 1);
INSERT INTO `provinces`
VALUES (330411, '秀洲区', 330400, '秀洲', 3, '0573', '314031', '中国,浙江省,嘉兴市,秀洲区', '120.70867', '30.76454', 'Xiuzhou', 1);
INSERT INTO `provinces`
VALUES (330421, '嘉善县', 330400, '嘉善', 3, '0573', '314100', '中国,浙江省,嘉兴市,嘉善县', '120.92559', '30.82993', 'Jiashan', 1);
INSERT INTO `provinces`
VALUES (330424, '海盐县', 330400, '海盐', 3, '0573', '314300', '中国,浙江省,嘉兴市,海盐县', '120.9457', '30.52547', 'Haiyan', 1);
INSERT INTO `provinces`
VALUES (330481, '海宁市', 330400, '海宁', 3, '0573', '314400', '中国,浙江省,嘉兴市,海宁市', '120.6813', '30.5097', 'Haining', 1);
INSERT INTO `provinces`
VALUES (330482, '平湖市', 330400, '平湖', 3, '0573', '314200', '中国,浙江省,嘉兴市,平湖市', '121.02166', '30.69618', 'Pinghu', 1);
INSERT INTO `provinces`
VALUES (330483, '桐乡市', 330400, '桐乡', 3, '0573', '314500', '中国,浙江省,嘉兴市,桐乡市', '120.56485', '30.6302', 'Tongxiang', 1);
INSERT INTO `provinces`
VALUES (330500, '湖州市', 330000, '湖州', 2, '0572', '313000', '中国,浙江省,湖州市', '120.102398', '30.867198', 'Huzhou', 1);
INSERT INTO `provinces`
VALUES (330502, '吴兴区', 330500, '吴兴', 3, '0572', '313000', '中国,浙江省,湖州市,吴兴区', '120.12548', '30.85752', 'Wuxing', 1);
INSERT INTO `provinces`
VALUES (330503, '南浔区', 330500, '南浔', 3, '0572', '313009', '中国,浙江省,湖州市,南浔区', '120.42038', '30.86686', 'Nanxun', 1);
INSERT INTO `provinces`
VALUES (330521, '德清县', 330500, '德清', 3, '0572', '313200', '中国,浙江省,湖州市,德清县', '119.97836', '30.53369', 'Deqing', 1);
INSERT INTO `provinces`
VALUES (330522, '长兴县', 330500, '长兴', 3, '0572', '313100', '中国,浙江省,湖州市,长兴县', '119.90783', '31.00606', 'Changxing', 1);
INSERT INTO `provinces`
VALUES (330523, '安吉县', 330500, '安吉', 3, '0572', '313300', '中国,浙江省,湖州市,安吉县', '119.68158', '30.63798', 'Anji', 1);
INSERT INTO `provinces`
VALUES (330600, '绍兴市', 330000, '绍兴', 2, '0575', '312000', '中国,浙江省,绍兴市', '120.582112', '29.997117', 'Shaoxing', 1);
INSERT INTO `provinces`
VALUES (330602, '越城区', 330600, '越城', 3, '0575', '312000', '中国,浙江省,绍兴市,越城区', '120.5819', '29.98895', 'Yuecheng', 1);
INSERT INTO `provinces`
VALUES (330603, '柯桥区', 330600, '柯桥', 3, '0575', '312030', '中国,浙江省,绍兴市,柯桥区', '120.492736', '30.08763', 'Keqiao ', 1);
INSERT INTO `provinces`
VALUES (330604, '上虞区', 330600, '上虞', 3, '0575', '312300', '中国,浙江省,绍兴市,上虞区', '120.476075', '30.078038', 'Shangyu', 1);
INSERT INTO `provinces`
VALUES (330624, '新昌县', 330600, '新昌', 3, '0575', '312500', '中国,浙江省,绍兴市,新昌县', '120.90435', '29.49991', 'Xinchang', 1);
INSERT INTO `provinces`
VALUES (330681, '诸暨市', 330600, '诸暨', 3, '0575', '311800', '中国,浙江省,绍兴市,诸暨市', '120.23629', '29.71358', 'Zhuji', 1);
INSERT INTO `provinces`
VALUES (330683, '嵊州市', 330600, '嵊州', 3, '0575', '312400', '中国,浙江省,绍兴市,嵊州市', '120.82174', '29.58854', 'Shengzhou', 1);
INSERT INTO `provinces`
VALUES (330700, '金华市', 330000, '金华', 2, '0579', '321000', '中国,浙江省,金华市', '119.649506', '29.089524', 'Jinhua', 1);
INSERT INTO `provinces`
VALUES (330702, '婺城区', 330700, '婺城', 3, '0579', '321000', '中国,浙江省,金华市,婺城区', '119.57135', '29.09521', 'Wucheng', 1);
INSERT INTO `provinces`
VALUES (330703, '金东区', 330700, '金东', 3, '0579', '321000', '中国,浙江省,金华市,金东区', '119.69302', '29.0991', 'Jindong', 1);
INSERT INTO `provinces`
VALUES (330723, '武义县', 330700, '武义', 3, '0579', '321200', '中国,浙江省,金华市,武义县', '119.8164', '28.89331', 'Wuyi', 1);
INSERT INTO `provinces`
VALUES (330726, '浦江县', 330700, '浦江', 3, '0579', '322200', '中国,浙江省,金华市,浦江县', '119.89181', '29.45353', 'Pujiang', 1);
INSERT INTO `provinces`
VALUES (330727, '磐安县', 330700, '磐安', 3, '0579', '322300', '中国,浙江省,金华市,磐安县', '120.45022', '29.05733', 'Pan\'an', 1);
INSERT INTO `provinces`
VALUES (330781, '兰溪市', 330700, '兰溪', 3, '0579', '321100', '中国,浙江省,金华市,兰溪市', '119.45965', '29.20841', 'Lanxi', 1);
INSERT INTO `provinces`
VALUES (330782, '义乌市', 330700, '义乌', 3, '0579', '322000', '中国,浙江省,金华市,义乌市', '120.0744', '29.30558', 'Yiwu', 1);
INSERT INTO `provinces`
VALUES (330783, '东阳市', 330700, '东阳', 3, '0579', '322100', '中国,浙江省,金华市,东阳市', '120.24185', '29.28942', 'Dongyang', 1);
INSERT INTO `provinces`
VALUES (330784, '永康市', 330700, '永康', 3, '0579', '321300', '中国,浙江省,金华市,永康市', '120.04727', '28.88844', 'Yongkang', 1);
INSERT INTO `provinces`
VALUES (330800, '衢州市', 330000, '衢州', 2, '0570', '324002', '中国,浙江省,衢州市', '118.87263', '28.941708', 'Quzhou', 1);
INSERT INTO `provinces`
VALUES (330802, '柯城区', 330800, '柯城', 3, '0570', '324100', '中国,浙江省,衢州市,柯城区', '118.87109', '28.96858', 'Kecheng', 1);
INSERT INTO `provinces`
VALUES (330803, '衢江区', 330800, '衢江', 3, '0570', '324022', '中国,浙江省,衢州市,衢江区', '118.9598', '28.97977', 'Qujiang', 1);
INSERT INTO `provinces`
VALUES (330822, '常山县', 330800, '常山', 3, '0570', '324200', '中国,浙江省,衢州市,常山县', '118.51025', '28.90191', 'Changshan', 1);
INSERT INTO `provinces`
VALUES (330824, '开化县', 330800, '开化', 3, '0570', '324300', '中国,浙江省,衢州市,开化县', '118.41616', '29.13785', 'Kaihua', 1);
INSERT INTO `provinces`
VALUES (330825, '龙游县', 330800, '龙游', 3, '0570', '324400', '中国,浙江省,衢州市,龙游县', '119.17221', '29.02823', 'Longyou', 1);
INSERT INTO `provinces`
VALUES (330881, '江山市', 330800, '江山', 3, '0570', '324100', '中国,浙江省,衢州市,江山市', '118.62674', '28.7386', 'Jiangshan', 1);
INSERT INTO `provinces`
VALUES (330900, '舟山市', 330000, '舟山', 2, '0580', '316000', '中国,浙江省,舟山市', '122.106863', '30.016028', 'Zhoushan', 1);
INSERT INTO `provinces`
VALUES (330902, '定海区', 330900, '定海', 3, '0580', '316000', '中国,浙江省,舟山市,定海区', '122.10677', '30.01985', 'Dinghai', 1);
INSERT INTO `provinces`
VALUES (330903, '普陀区', 330900, '普陀', 3, '0580', '316100', '中国,浙江省,舟山市,普陀区', '122.30278', '29.94908', 'Putuo', 1);
INSERT INTO `provinces`
VALUES (330921, '岱山县', 330900, '岱山', 3, '0580', '316200', '中国,浙江省,舟山市,岱山县', '122.20486', '30.24385', 'Daishan', 1);
INSERT INTO `provinces`
VALUES (330922, '嵊泗县', 330900, '嵊泗', 3, '0580', '202450', '中国,浙江省,舟山市,嵊泗县', '122.45129', '30.72678', 'Shengsi', 1);
INSERT INTO `provinces`
VALUES (331000, '台州市', 330000, '台州', 2, '0576', '318000', '中国,浙江省,台州市', '121.428599', '28.661378', 'Taizhou', 1);
INSERT INTO `provinces`
VALUES (331002, '椒江区', 331000, '椒江', 3, '0576', '318000', '中国,浙江省,台州市,椒江区', '121.44287', '28.67301', 'Jiaojiang', 1);
INSERT INTO `provinces`
VALUES (331003, '黄岩区', 331000, '黄岩', 3, '0576', '318020', '中国,浙江省,台州市,黄岩区', '121.25891', '28.65077', 'Huangyan', 1);
INSERT INTO `provinces`
VALUES (331004, '路桥区', 331000, '路桥', 3, '0576', '318050', '中国,浙江省,台州市,路桥区', '121.37381', '28.58016', 'Luqiao', 1);
INSERT INTO `provinces`
VALUES (331021, '玉环县', 331000, '玉环', 3, '0576', '317600', '中国,浙江省,台州市,玉环县', '121.23242', '28.13637', 'Yuhuan', 1);
INSERT INTO `provinces`
VALUES (331022, '三门县', 331000, '三门', 3, '0576', '317100', '中国,浙江省,台州市,三门县', '121.3937', '29.1051', 'Sanmen', 1);
INSERT INTO `provinces`
VALUES (331023, '天台县', 331000, '天台', 3, '0576', '317200', '中国,浙江省,台州市,天台县', '121.00848', '29.218', 'Tiantai', 1);
INSERT INTO `provinces`
VALUES (331024, '仙居县', 331000, '仙居', 3, '0576', '317300', '中国,浙江省,台州市,仙居县', '120.72872', '28.84672', 'Xianju', 1);
INSERT INTO `provinces`
VALUES (331081, '温岭市', 331000, '温岭', 3, '0576', '317500', '中国,浙江省,台州市,温岭市', '121.38595', '28.37176', 'Wenling', 1);
INSERT INTO `provinces`
VALUES (331082, '临海市', 331000, '临海', 3, '0576', '317000', '中国,浙江省,台州市,临海市', '121.13885', '28.85603', 'Linhai', 1);
INSERT INTO `provinces`
VALUES (331100, '丽水市', 330000, '丽水', 2, '0578', '323000', '中国,浙江省,丽水市', '119.921786', '28.451993', 'Lishui', 1);
INSERT INTO `provinces`
VALUES (331102, '莲都区', 331100, '莲都', 3, '0578', '323000', '中国,浙江省,丽水市,莲都区', '119.9127', '28.44583', 'Liandu', 1);
INSERT INTO `provinces`
VALUES (331121, '青田县', 331100, '青田', 3, '0578', '323900', '中国,浙江省,丽水市,青田县', '120.29028', '28.13897', 'Qingtian', 1);
INSERT INTO `provinces`
VALUES (331122, '缙云县', 331100, '缙云', 3, '0578', '321400', '中国,浙江省,丽水市,缙云县', '120.09036', '28.65944', 'Jinyun', 1);
INSERT INTO `provinces`
VALUES (331123, '遂昌县', 331100, '遂昌', 3, '0578', '323300', '中国,浙江省,丽水市,遂昌县', '119.27606', '28.59291', 'Suichang', 1);
INSERT INTO `provinces`
VALUES (331124, '松阳县', 331100, '松阳', 3, '0578', '323400', '中国,浙江省,丽水市,松阳县', '119.48199', '28.4494', 'Songyang', 1);
INSERT INTO `provinces`
VALUES (331125, '云和县', 331100, '云和', 3, '0578', '323600', '中国,浙江省,丽水市,云和县', '119.57287', '28.11643', 'Yunhe', 1);
INSERT INTO `provinces`
VALUES (331126, '庆元县', 331100, '庆元', 3, '0578', '323800', '中国,浙江省,丽水市,庆元县', '119.06256', '27.61842', 'Qingyuan', 1);
INSERT INTO `provinces`
VALUES (331127, '景宁畲族自治县', 331100, '景宁', 3, '0578', '323500', '中国,浙江省,丽水市,景宁畲族自治县', '119.63839', '27.97393', 'Jingning',
        1);
INSERT INTO `provinces`
VALUES (331181, '龙泉市', 331100, '龙泉', 3, '0578', '323700', '中国,浙江省,丽水市,龙泉市', '119.14163', '28.0743', 'Longquan', 1);
INSERT INTO `provinces`
VALUES (331200, '舟山群岛新区', 330000, '舟山新区', 2, '0580', '316000', '中国,浙江省,舟山群岛新区', '122.317657', '29.813242', 'Zhoushan',
        1);
INSERT INTO `provinces`
VALUES (331201, '金塘岛', 331200, '金塘', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,金塘岛', '121.893373', '30.040641', 'Jintang', 1);
INSERT INTO `provinces`
VALUES (331202, '六横岛', 331200, '六横', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,六横岛', '122.14265', '29.662938', 'Liuheng', 1);
INSERT INTO `provinces`
VALUES (331203, '衢山岛', 331200, '衢山', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,衢山岛', '122.358425', '30.442642', 'Qushan', 1);
INSERT INTO `provinces`
VALUES (331204, '舟山本岛西北部', 331200, '舟山', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,舟山本岛西北部', '122.03064', '30.140377',
        'Zhoushan', 1);
INSERT INTO `provinces`
VALUES (331205, '岱山岛西南部', 331200, '岱山', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,岱山岛西南部', '122.180123', '30.277269',
        'Daishan', 1);
INSERT INTO `provinces`
VALUES (331206, '泗礁岛', 331200, '泗礁', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,泗礁岛', '122.45803', '30.725112', 'Sijiao', 1);
INSERT INTO `provinces`
VALUES (331207, '朱家尖岛', 331200, '朱家尖', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,朱家尖岛', '122.390636', '29.916303',
        'Zhujiajian', 1);
INSERT INTO `provinces`
VALUES (331208, '洋山岛', 331200, '洋山', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,洋山岛', '121.995891', '30.094637', 'Yangshan',
        1);
INSERT INTO `provinces`
VALUES (331209, '长涂岛', 331200, '长涂', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,长涂岛', '122.284681', '30.24888', 'Changtu', 1);
INSERT INTO `provinces`
VALUES (331210, '虾峙岛', 331200, '虾峙', 3, '0580', '316000', '中国,浙江省,舟山群岛新区,虾峙岛', '122.244686', '29.752941', 'Xiazhi', 1);
INSERT INTO `provinces`
VALUES (340000, '安徽省', 100000, '安徽', 1, '', '', '中国,安徽省', '117.283042', '31.86119', 'Anhui', 1);
INSERT INTO `provinces`
VALUES (340100, '合肥市', 340000, '合肥', 2, '0551', '230001', '中国,安徽省,合肥市', '117.283042', '31.86119', 'Hefei', 1);
INSERT INTO `provinces`
VALUES (340102, '瑶海区', 340100, '瑶海', 3, '0551', '230011', '中国,安徽省,合肥市,瑶海区', '117.30947', '31.85809', 'Yaohai', 1);
INSERT INTO `provinces`
VALUES (340103, '庐阳区', 340100, '庐阳', 3, '0551', '230001', '中国,安徽省,合肥市,庐阳区', '117.26452', '31.87874', 'Luyang', 1);
INSERT INTO `provinces`
VALUES (340104, '蜀山区', 340100, '蜀山', 3, '0551', '230031', '中国,安徽省,合肥市,蜀山区', '117.26104', '31.85117', 'Shushan', 1);
INSERT INTO `provinces`
VALUES (340111, '包河区', 340100, '包河', 3, '0551', '230041', '中国,安徽省,合肥市,包河区', '117.30984', '31.79502', 'Baohe', 1);
INSERT INTO `provinces`
VALUES (340121, '长丰县', 340100, '长丰', 3, '0551', '231100', '中国,安徽省,合肥市,长丰县', '117.16549', '32.47959', 'Changfeng', 1);
INSERT INTO `provinces`
VALUES (340122, '肥东县', 340100, '肥东', 3, '0551', '231600', '中国,安徽省,合肥市,肥东县', '117.47128', '31.88525', 'Feidong', 1);
INSERT INTO `provinces`
VALUES (340123, '肥西县', 340100, '肥西', 3, '0551', '231200', '中国,安徽省,合肥市,肥西县', '117.16845', '31.72143', 'Feixi', 1);
INSERT INTO `provinces`
VALUES (340124, '庐江县', 340100, '庐江', 3, '0565', '231500', '中国,安徽省,合肥市,庐江县', '117.289844', '31.251488', 'Lujiang', 1);
INSERT INTO `provinces`
VALUES (340126, '无为县', 340200, '无为', 3, '0565', '238300', '中国,安徽省,芜湖市,无为县', '117.911432', '31.303075', 'Wuwei', 1);
INSERT INTO `provinces`
VALUES (340181, '巢湖市', 340100, '巢湖', 3, '0565', '238000', '中国,安徽省,合肥市,巢湖市', '117.874155', '31.600518', 'Chaohu', 1);
INSERT INTO `provinces`
VALUES (340200, '芜湖市', 340000, '芜湖', 2, '0551', '241000', '中国,安徽省,芜湖市', '118.376451', '31.326319', 'Wuhu', 1);
INSERT INTO `provinces`
VALUES (340202, '镜湖区', 340200, '镜湖', 3, '0553', '241000', '中国,安徽省,芜湖市,镜湖区', '118.38525', '31.34038', 'Jinghu', 1);
INSERT INTO `provinces`
VALUES (340203, '弋江区', 340200, '弋江', 3, '0553', '241000', '中国,安徽省,芜湖市,弋江区', '118.37265', '31.31178', 'Yijiang', 1);
INSERT INTO `provinces`
VALUES (340207, '鸠江区', 340200, '鸠江', 3, '0553', '241000', '中国,安徽省,芜湖市,鸠江区', '118.39215', '31.36928', 'Jiujiang', 1);
INSERT INTO `provinces`
VALUES (340208, '三山区', 340200, '三山', 3, '0553', '241000', '中国,安徽省,芜湖市,三山区', '118.12609', '31.20703', 'Sanshan', 1);
INSERT INTO `provinces`
VALUES (340221, '芜湖县', 340200, '芜湖', 3, '0553', '241100', '中国,安徽省,芜湖市,芜湖县', '118.57525', '31.13476', 'Wuhu', 1);
INSERT INTO `provinces`
VALUES (340222, '繁昌县', 340200, '繁昌', 3, '0553', '241200', '中国,安徽省,芜湖市,繁昌县', '118.19982', '31.08319', 'Fanchang', 1);
INSERT INTO `provinces`
VALUES (340223, '南陵县', 340200, '南陵', 3, '0553', '242400', '中国,安徽省,芜湖市,南陵县', '118.33688', '30.91969', 'Nanling', 1);
INSERT INTO `provinces`
VALUES (340300, '蚌埠市', 340000, '蚌埠', 2, '0552', '233000', '中国,安徽省,蚌埠市', '117.36237', '32.934037', 'Bengbu', 1);
INSERT INTO `provinces`
VALUES (340302, '龙子湖区', 340300, '龙子湖', 3, '0552', '233000', '中国,安徽省,蚌埠市,龙子湖区', '117.39379', '32.94301', 'Longzihu', 1);
INSERT INTO `provinces`
VALUES (340303, '蚌山区', 340300, '蚌山', 3, '0552', '233000', '中国,安徽省,蚌埠市,蚌山区', '117.36767', '32.94411', 'Bengshan', 1);
INSERT INTO `provinces`
VALUES (340304, '禹会区', 340300, '禹会', 3, '0552', '233010', '中国,安徽省,蚌埠市,禹会区', '117.35315', '32.93336', 'Yuhui', 1);
INSERT INTO `provinces`
VALUES (340311, '淮上区', 340300, '淮上', 3, '0552', '233002', '中国,安徽省,蚌埠市,淮上区', '117.35983', '32.96423', 'Huaishang', 1);
INSERT INTO `provinces`
VALUES (340321, '怀远县', 340300, '怀远', 3, '0552', '233400', '中国,安徽省,蚌埠市,怀远县', '117.20507', '32.97007', 'Huaiyuan', 1);
INSERT INTO `provinces`
VALUES (340322, '五河县', 340300, '五河', 3, '0552', '233300', '中国,安徽省,蚌埠市,五河县', '117.89144', '33.14457', 'Wuhe', 1);
INSERT INTO `provinces`
VALUES (340323, '固镇县', 340300, '固镇', 3, '0552', '233700', '中国,安徽省,蚌埠市,固镇县', '117.31558', '33.31803', 'Guzhen', 1);
INSERT INTO `provinces`
VALUES (340400, '淮南市', 340000, '淮南', 2, '0554', '232001', '中国,安徽省,淮南市', '117.025449', '32.645947', 'Huainan', 1);
INSERT INTO `provinces`
VALUES (340402, '大通区', 340400, '大通', 3, '0554', '232033', '中国,安徽省,淮南市,大通区', '117.05255', '32.63265', 'Datong', 1);
INSERT INTO `provinces`
VALUES (340403, '田家庵区', 340400, '田家庵', 3, '0554', '232000', '中国,安徽省,淮南市,田家庵区', '117.01739', '32.64697', 'Tianjiaan', 1);
INSERT INTO `provinces`
VALUES (340404, '谢家集区', 340400, '谢家集', 3, '0554', '232052', '中国,安徽省,淮南市,谢家集区', '116.86377', '32.59818', 'Xiejiaji', 1);
INSERT INTO `provinces`
VALUES (340405, '八公山区', 340400, '八公山', 3, '0554', '232072', '中国,安徽省,淮南市,八公山区', '116.83694', '32.62941', 'Bagongshan',
        1);
INSERT INTO `provinces`
VALUES (340406, '潘集区', 340400, '潘集', 3, '0554', '232082', '中国,安徽省,淮南市,潘集区', '116.81622', '32.78287', 'Panji', 1);
INSERT INTO `provinces`
VALUES (340421, '凤台县', 340400, '凤台', 3, '0554', '232100', '中国,安徽省,淮南市,凤台县', '116.71569', '32.70752', 'Fengtai', 1);
INSERT INTO `provinces`
VALUES (340500, '马鞍山市', 340000, '马鞍山', 2, '0555', '243001', '中国,安徽省,马鞍山市', '118.507906', '31.689362', 'Ma\'anshan', 1);
INSERT INTO `provinces`
VALUES (340503, '花山区', 340500, '花山', 3, '0555', '243000', '中国,安徽省,马鞍山市,花山区', '118.51231', '31.7001', 'Huashan', 1);
INSERT INTO `provinces`
VALUES (340504, '雨山区', 340500, '雨山', 3, '0555', '243071', '中国,安徽省,马鞍山市,雨山区', '118.49869', '31.68219', 'Yushan', 1);
INSERT INTO `provinces`
VALUES (340506, '博望区', 340500, '博望', 3, '0555', '243131', '中国,安徽省,马鞍山市,博望区', '118.844387', '31.561871', 'Bowang', 1);
INSERT INTO `provinces`
VALUES (340521, '当涂县', 340500, '当涂', 3, '0555', '243100', '中国,安徽省,马鞍山市,当涂县', '118.49786', '31.57098', 'Dangtu', 1);
INSERT INTO `provinces`
VALUES (340522, '含山县', 340500, '含山', 3, '0555', '238100', '中国,安徽省,马鞍山市,含山县', '118.105545', '31.727758', 'Hanshan ', 1);
INSERT INTO `provinces`
VALUES (340523, '和县', 340500, '和县', 3, '0555', '238200', '中国,安徽省,马鞍山市,和县', '118.351405', '31.741794', 'Hexian', 1);
INSERT INTO `provinces`
VALUES (340600, '淮北市', 340000, '淮北', 2, '0561', '235000', '中国,安徽省,淮北市', '116.794664', '33.971707', 'Huaibei', 1);
INSERT INTO `provinces`
VALUES (340602, '杜集区', 340600, '杜集', 3, '0561', '235000', '中国,安徽省,淮北市,杜集区', '116.82998', '33.99363', 'Duji', 1);
INSERT INTO `provinces`
VALUES (340603, '相山区', 340600, '相山', 3, '0561', '235000', '中国,安徽省,淮北市,相山区', '116.79464', '33.95979', 'Xiangshan', 1);
INSERT INTO `provinces`
VALUES (340604, '烈山区', 340600, '烈山', 3, '0561', '235000', '中国,安徽省,淮北市,烈山区', '116.81448', '33.89355', 'Lieshan', 1);
INSERT INTO `provinces`
VALUES (340621, '濉溪县', 340600, '濉溪', 3, '0561', '235100', '中国,安徽省,淮北市,濉溪县', '116.76785', '33.91455', 'Suixi', 1);
INSERT INTO `provinces`
VALUES (340700, '铜陵市', 340000, '铜陵', 2, '0562', '244000', '中国,安徽省,铜陵市', '117.816576', '30.929935', 'Tongling', 1);
INSERT INTO `provinces`
VALUES (340702, '铜官山区', 340700, '铜官山', 3, '0562', '244000', '中国,安徽省,铜陵市,铜官山区', '117.81525', '30.93423', 'Tongguanshan',
        1);
INSERT INTO `provinces`
VALUES (340703, '狮子山区', 340700, '狮子山', 3, '0562', '244000', '中国,安徽省,铜陵市,狮子山区', '117.89178', '30.92631', 'Shizishan', 1);
INSERT INTO `provinces`
VALUES (340711, '郊区', 340700, '郊区', 3, '0562', '244000', '中国,安徽省,铜陵市,郊区', '117.80868', '30.91976', 'Jiaoqu', 1);
INSERT INTO `provinces`
VALUES (340721, '铜陵县', 340700, '铜陵', 3, '0562', '244100', '中国,安徽省,铜陵市,铜陵县', '117.79113', '30.95365', 'Tongling', 1);
INSERT INTO `provinces`
VALUES (340800, '安庆市', 340000, '安庆', 2, '0556', '246001', '中国,安徽省,安庆市', '117.053571', '30.524816', 'Anqing', 1);
INSERT INTO `provinces`
VALUES (340802, '迎江区', 340800, '迎江', 3, '0556', '246001', '中国,安徽省,安庆市,迎江区', '117.0493', '30.50421', 'Yingjiang', 1);
INSERT INTO `provinces`
VALUES (340803, '大观区', 340800, '大观', 3, '0556', '246002', '中国,安徽省,安庆市,大观区', '117.03426', '30.51216', 'Daguan', 1);
INSERT INTO `provinces`
VALUES (340811, '宜秀区', 340800, '宜秀', 3, '0556', '246003', '中国,安徽省,安庆市,宜秀区', '117.06127', '30.50783', 'Yixiu', 1);
INSERT INTO `provinces`
VALUES (340822, '怀宁县', 340800, '怀宁', 3, '0556', '246100', '中国,安徽省,安庆市,怀宁县', '116.82968', '30.73376', 'Huaining', 1);
INSERT INTO `provinces`
VALUES (340823, '枞阳县', 340800, '枞阳', 3, '0556', '246700', '中国,安徽省,安庆市,枞阳县', '117.22015', '30.69956', 'Zongyang', 1);
INSERT INTO `provinces`
VALUES (340824, '潜山县', 340800, '潜山', 3, '0556', '246300', '中国,安徽省,安庆市,潜山县', '116.57574', '30.63037', 'Qianshan', 1);
INSERT INTO `provinces`
VALUES (340825, '太湖县', 340800, '太湖', 3, '0556', '246400', '中国,安徽省,安庆市,太湖县', '116.3088', '30.4541', 'Taihu', 1);
INSERT INTO `provinces`
VALUES (340826, '宿松县', 340800, '宿松', 3, '0556', '246500', '中国,安徽省,安庆市,宿松县', '116.12915', '30.1536', 'Susong', 1);
INSERT INTO `provinces`
VALUES (340827, '望江县', 340800, '望江', 3, '0556', '246200', '中国,安徽省,安庆市,望江县', '116.68814', '30.12585', 'Wangjiang', 1);
INSERT INTO `provinces`
VALUES (340828, '岳西县', 340800, '岳西', 3, '0556', '246600', '中国,安徽省,安庆市,岳西县', '116.35995', '30.84983', 'Yuexi', 1);
INSERT INTO `provinces`
VALUES (340881, '桐城市', 340800, '桐城', 3, '0556', '231400', '中国,安徽省,安庆市,桐城市', '116.95071', '31.05216', 'Tongcheng', 1);
INSERT INTO `provinces`
VALUES (341000, '黄山市', 340000, '黄山', 2, '0559', '245000', '中国,安徽省,黄山市', '118.317325', '29.709239', 'Huangshan', 1);
INSERT INTO `provinces`
VALUES (341002, '屯溪区', 341000, '屯溪', 3, '0559', '245000', '中国,安徽省,黄山市,屯溪区', '118.33368', '29.71138', 'Tunxi', 1);
INSERT INTO `provinces`
VALUES (341003, '黄山区', 341000, '黄山', 3, '0559', '242700', '中国,安徽省,黄山市,黄山区', '118.1416', '30.2729', 'Huangshan', 1);
INSERT INTO `provinces`
VALUES (341004, '徽州区', 341000, '徽州', 3, '0559', '245061', '中国,安徽省,黄山市,徽州区', '118.33654', '29.82784', 'Huizhou', 1);
INSERT INTO `provinces`
VALUES (341021, '歙县', 341000, '歙县', 3, '0559', '245200', '中国,安徽省,黄山市,歙县', '118.43676', '29.86745', 'Shexian', 1);
INSERT INTO `provinces`
VALUES (341022, '休宁县', 341000, '休宁', 3, '0559', '245400', '中国,安徽省,黄山市,休宁县', '118.18136', '29.78607', 'Xiuning', 1);
INSERT INTO `provinces`
VALUES (341023, '黟县', 341000, '黟县', 3, '0559', '245500', '中国,安徽省,黄山市,黟县', '117.94137', '29.92588', 'Yixian', 1);
INSERT INTO `provinces`
VALUES (341024, '祁门县', 341000, '祁门', 3, '0559', '245600', '中国,安徽省,黄山市,祁门县', '117.71847', '29.85723', 'Qimen', 1);
INSERT INTO `provinces`
VALUES (341100, '滁州市', 340000, '滁州', 2, '0550', '239000', '中国,安徽省,滁州市', '118.316264', '32.303627', 'Chuzhou', 1);
INSERT INTO `provinces`
VALUES (341102, '琅琊区', 341100, '琅琊', 3, '0550', '239000', '中国,安徽省,滁州市,琅琊区', '118.30538', '32.29521', 'Langya', 1);
INSERT INTO `provinces`
VALUES (341103, '南谯区', 341100, '南谯', 3, '0550', '239000', '中国,安徽省,滁州市,南谯区', '118.31222', '32.31861', 'Nanqiao', 1);
INSERT INTO `provinces`
VALUES (341122, '来安县', 341100, '来安', 3, '0550', '239200', '中国,安徽省,滁州市,来安县', '118.43438', '32.45176', 'Lai\'an', 1);
INSERT INTO `provinces`
VALUES (341124, '全椒县', 341100, '全椒', 3, '0550', '239500', '中国,安徽省,滁州市,全椒县', '118.27291', '32.08524', 'Quanjiao', 1);
INSERT INTO `provinces`
VALUES (341125, '定远县', 341100, '定远', 3, '0550', '233200', '中国,安徽省,滁州市,定远县', '117.68035', '32.52488', 'Dingyuan', 1);
INSERT INTO `provinces`
VALUES (341126, '凤阳县', 341100, '凤阳', 3, '0550', '233100', '中国,安徽省,滁州市,凤阳县', '117.56454', '32.86507', 'Fengyang', 1);
INSERT INTO `provinces`
VALUES (341181, '天长市', 341100, '天长', 3, '0550', '239300', '中国,安徽省,滁州市,天长市', '118.99868', '32.69124', 'Tianchang', 1);
INSERT INTO `provinces`
VALUES (341182, '明光市', 341100, '明光', 3, '0550', '239400', '中国,安徽省,滁州市,明光市', '117.99093', '32.77819', 'Mingguang', 1);
INSERT INTO `provinces`
VALUES (341200, '阜阳市', 340000, '阜阳', 2, '0558', '236033', '中国,安徽省,阜阳市', '115.819729', '32.896969', 'Fuyang', 1);
INSERT INTO `provinces`
VALUES (341202, '颍州区', 341200, '颍州', 3, '0558', '236001', '中国,安徽省,阜阳市,颍州区', '115.80694', '32.88346', 'Yingzhou', 1);
INSERT INTO `provinces`
VALUES (341203, '颍东区', 341200, '颍东', 3, '0558', '236058', '中国,安徽省,阜阳市,颍东区', '115.85659', '32.91296', 'Yingdong', 1);
INSERT INTO `provinces`
VALUES (341204, '颍泉区', 341200, '颍泉', 3, '0558', '236045', '中国,安徽省,阜阳市,颍泉区', '115.80712', '32.9249', 'Yingquan', 1);
INSERT INTO `provinces`
VALUES (341221, '临泉县', 341200, '临泉', 3, '0558', '236400', '中国,安徽省,阜阳市,临泉县', '115.26232', '33.06758', 'Linquan', 1);
INSERT INTO `provinces`
VALUES (341222, '太和县', 341200, '太和', 3, '0558', '236600', '中国,安徽省,阜阳市,太和县', '115.62191', '33.16025', 'Taihe', 1);
INSERT INTO `provinces`
VALUES (350300, '莆田市', 350000, '莆田', 2, '0594', '351100', '中国,福建省,莆田市', '119.007558', '25.431011', 'Putian', 1);
INSERT INTO `provinces`
VALUES (350302, '城厢区', 350300, '城厢', 3, '0594', '351100', '中国,福建省,莆田市,城厢区', '118.99462', '25.41872', 'Chengxiang', 1);
INSERT INTO `provinces`
VALUES (350303, '涵江区', 350300, '涵江', 3, '0594', '351111', '中国,福建省,莆田市,涵江区', '119.11621', '25.45876', 'Hanjiang', 1);
INSERT INTO `provinces`
VALUES (350304, '荔城区', 350300, '荔城', 3, '0594', '351100', '中国,福建省,莆田市,荔城区', '119.01339', '25.43369', 'Licheng', 1);
INSERT INTO `provinces`
VALUES (350305, '秀屿区', 350300, '秀屿', 3, '0594', '351152', '中国,福建省,莆田市,秀屿区', '119.10553', '25.31831', 'Xiuyu', 1);
INSERT INTO `provinces`
VALUES (350322, '仙游县', 350300, '仙游', 3, '0594', '351200', '中国,福建省,莆田市,仙游县', '118.69177', '25.36214', 'Xianyou', 1);
INSERT INTO `provinces`
VALUES (350400, '三明市', 350000, '三明', 2, '0598', '365000', '中国,福建省,三明市', '117.635001', '26.265444', 'Sanming', 1);
INSERT INTO `provinces`
VALUES (350402, '梅列区', 350400, '梅列', 3, '0598', '365000', '中国,福建省,三明市,梅列区', '117.64585', '26.27171', 'Meilie', 1);
INSERT INTO `provinces`
VALUES (350403, '三元区', 350400, '三元', 3, '0598', '365001', '中国,福建省,三明市,三元区', '117.60788', '26.23372', 'Sanyuan', 1);
INSERT INTO `provinces`
VALUES (350421, '明溪县', 350400, '明溪', 3, '0598', '365200', '中国,福建省,三明市,明溪县', '117.20498', '26.35294', 'Mingxi', 1);
INSERT INTO `provinces`
VALUES (350423, '清流县', 350400, '清流', 3, '0598', '365300', '中国,福建省,三明市,清流县', '116.8146', '26.17144', 'Qingliu', 1);
INSERT INTO `provinces`
VALUES (350424, '宁化县', 350400, '宁化', 3, '0598', '365400', '中国,福建省,三明市,宁化县', '116.66101', '26.25874', 'Ninghua', 1);
INSERT INTO `provinces`
VALUES (350425, '大田县', 350400, '大田', 3, '0598', '366100', '中国,福建省,三明市,大田县', '117.8471', '25.6926', 'Datian', 1);
INSERT INTO `provinces`
VALUES (350426, '尤溪县', 350400, '尤溪', 3, '0598', '365100', '中国,福建省,三明市,尤溪县', '118.19049', '26.17002', 'Youxi', 1);
INSERT INTO `provinces`
VALUES (350427, '沙县', 350400, '沙县', 3, '0598', '365500', '中国,福建省,三明市,沙县', '117.79266', '26.39615', 'Shaxian', 1);
INSERT INTO `provinces`
VALUES (350428, '将乐县', 350400, '将乐', 3, '0598', '353300', '中国,福建省,三明市,将乐县', '117.47317', '26.72837', 'Jiangle', 1);
INSERT INTO `provinces`
VALUES (350429, '泰宁县', 350400, '泰宁', 3, '0598', '354400', '中国,福建省,三明市,泰宁县', '117.17578', '26.9001', 'Taining', 1);
INSERT INTO `provinces`
VALUES (350430, '建宁县', 350400, '建宁', 3, '0598', '354500', '中国,福建省,三明市,建宁县', '116.84603', '26.83091', 'Jianning', 1);
INSERT INTO `provinces`
VALUES (350481, '永安市', 350400, '永安', 3, '0598', '366000', '中国,福建省,三明市,永安市', '117.36517', '25.94136', 'Yong\'an', 1);
INSERT INTO `provinces`
VALUES (350500, '泉州市', 350000, '泉州', 2, '0595', '362000', '中国,福建省,泉州市', '118.589421', '24.908853', 'Quanzhou', 1);
INSERT INTO `provinces`
VALUES (350502, '鲤城区', 350500, '鲤城', 3, '0595', '362000', '中国,福建省,泉州市,鲤城区', '118.56591', '24.88741', 'Licheng', 1);
INSERT INTO `provinces`
VALUES (350503, '丰泽区', 350500, '丰泽', 3, '0595', '362000', '中国,福建省,泉州市,丰泽区', '118.61328', '24.89119', 'Fengze', 1);
INSERT INTO `provinces`
VALUES (350504, '洛江区', 350500, '洛江', 3, '0595', '362011', '中国,福建省,泉州市,洛江区', '118.67111', '24.93984', 'Luojiang', 1);
INSERT INTO `provinces`
VALUES (350505, '泉港区', 350500, '泉港', 3, '0595', '362114', '中国,福建省,泉州市,泉港区', '118.91586', '25.12005', 'Quangang', 1);
INSERT INTO `provinces`
VALUES (350521, '惠安县', 350500, '惠安', 3, '0595', '362100', '中国,福建省,泉州市,惠安县', '118.79687', '25.03059', 'Hui\'an', 1);
INSERT INTO `provinces`
VALUES (350524, '安溪县', 350500, '安溪', 3, '0595', '362400', '中国,福建省,泉州市,安溪县', '118.18719', '25.05627', 'Anxi', 1);
INSERT INTO `provinces`
VALUES (350525, '永春县', 350500, '永春', 3, '0595', '362600', '中国,福建省,泉州市,永春县', '118.29437', '25.32183', 'Yongchun', 1);
INSERT INTO `provinces`
VALUES (350526, '德化县', 350500, '德化', 3, '0595', '362500', '中国,福建省,泉州市,德化县', '118.24176', '25.49224', 'Dehua', 1);
INSERT INTO `provinces`
VALUES (350527, '金门县', 350500, '金门', 3, '', '', '中国,福建省,泉州市,金门县', '118.32263', '24.42922', 'Jinmen', 1);
INSERT INTO `provinces`
VALUES (350581, '石狮市', 350500, '石狮', 3, '0595', '362700', '中国,福建省,泉州市,石狮市', '118.64779', '24.73242', 'Shishi', 1);
INSERT INTO `provinces`
VALUES (350582, '晋江市', 350500, '晋江', 3, '0595', '362200', '中国,福建省,泉州市,晋江市', '118.55194', '24.78141', 'Jinjiang', 1);
INSERT INTO `provinces`
VALUES (350583, '南安市', 350500, '南安', 3, '0595', '362300', '中国,福建省,泉州市,南安市', '118.38589', '24.96055', 'Nan\'an', 1);
INSERT INTO `provinces`
VALUES (350600, '漳州市', 350000, '漳州', 2, '0596', '363005', '中国,福建省,漳州市', '117.661801', '24.510897', 'Zhangzhou', 1);
INSERT INTO `provinces`
VALUES (350602, '芗城区', 350600, '芗城', 3, '0596', '363000', '中国,福建省,漳州市,芗城区', '117.65402', '24.51081', 'Xiangcheng', 1);
INSERT INTO `provinces`
VALUES (350603, '龙文区', 350600, '龙文', 3, '0596', '363005', '中国,福建省,漳州市,龙文区', '117.70971', '24.50323', 'Longwen', 1);
INSERT INTO `provinces`
VALUES (350622, '云霄县', 350600, '云霄', 3, '0596', '363300', '中国,福建省,漳州市,云霄县', '117.34051', '23.95534', 'Yunxiao', 1);
INSERT INTO `provinces`
VALUES (350623, '漳浦县', 350600, '漳浦', 3, '0596', '363200', '中国,福建省,漳州市,漳浦县', '117.61367', '24.11706', 'Zhangpu', 1);
INSERT INTO `provinces`
VALUES (350624, '诏安县', 350600, '诏安', 3, '0596', '363500', '中国,福建省,漳州市,诏安县', '117.17501', '23.71148', 'Zhao\'an', 1);
INSERT INTO `provinces`
VALUES (350625, '长泰县', 350600, '长泰', 3, '0596', '363900', '中国,福建省,漳州市,长泰县', '117.75924', '24.62526', 'Changtai', 1);
INSERT INTO `provinces`
VALUES (350626, '东山县', 350600, '东山', 3, '0596', '363400', '中国,福建省,漳州市,东山县', '117.42822', '23.70109', 'Dongshan', 1);
INSERT INTO `provinces`
VALUES (350627, '南靖县', 350600, '南靖', 3, '0596', '363600', '中国,福建省,漳州市,南靖县', '117.35736', '24.51448', 'Nanjing', 1);
INSERT INTO `provinces`
VALUES (350628, '平和县', 350600, '平和', 3, '0596', '363700', '中国,福建省,漳州市,平和县', '117.3124', '24.36395', 'Pinghe', 1);
INSERT INTO `provinces`
VALUES (350629, '华安县', 350600, '华安', 3, '0596', '363800', '中国,福建省,漳州市,华安县', '117.54077', '25.00563', 'Hua\'an', 1);
INSERT INTO `provinces`
VALUES (350681, '龙海市', 350600, '龙海', 3, '0596', '363100', '中国,福建省,漳州市,龙海市', '117.81802', '24.44655', 'Longhai', 1);
INSERT INTO `provinces`
VALUES (350700, '南平市', 350000, '南平', 2, '0599', '353000', '中国,福建省,南平市', '118.178459', '26.635627', 'Nanping', 1);
INSERT INTO `provinces`
VALUES (350702, '延平区', 350700, '延平', 3, '0600', '353000', '中国,福建省,南平市,延平区', '118.18189', '26.63745', 'Yanping', 1);
INSERT INTO `provinces`
VALUES (350703, '建阳区', 350700, '建阳', 3, '0599', '354200', '中国,福建省,南平市,建阳区', '118.12267', '27.332067', 'Jianyang', 1);
INSERT INTO `provinces`
VALUES (350721, '顺昌县', 350700, '顺昌', 3, '0605', '353200', '中国,福建省,南平市,顺昌县', '117.8103', '26.79298', 'Shunchang', 1);
INSERT INTO `provinces`
VALUES (350722, '浦城县', 350700, '浦城', 3, '0606', '353400', '中国,福建省,南平市,浦城县', '118.54007', '27.91888', 'Pucheng', 1);
INSERT INTO `provinces`
VALUES (350723, '光泽县', 350700, '光泽', 3, '0607', '354100', '中国,福建省,南平市,光泽县', '117.33346', '27.54231', 'Guangze', 1);
INSERT INTO `provinces`
VALUES (350724, '松溪县', 350700, '松溪', 3, '0608', '353500', '中国,福建省,南平市,松溪县', '118.78533', '27.52624', 'Songxi', 1);
INSERT INTO `provinces`
VALUES (350725, '政和县', 350700, '政和', 3, '0609', '353600', '中国,福建省,南平市,政和县', '118.85571', '27.36769', 'Zhenghe', 1);
INSERT INTO `provinces`
VALUES (350781, '邵武市', 350700, '邵武', 3, '0601', '354000', '中国,福建省,南平市,邵武市', '117.4924', '27.34033', 'Shaowu', 1);
INSERT INTO `provinces`
VALUES (350782, '武夷山市', 350700, '武夷山', 3, '0602', '354300', '中国,福建省,南平市,武夷山市', '118.03665', '27.75543', 'Wuyishan', 1);
INSERT INTO `provinces`
VALUES (350783, '建瓯市', 350700, '建瓯', 3, '0603', '353100', '中国,福建省,南平市,建瓯市', '118.29766', '27.02301', 'Jianou', 1);
INSERT INTO `provinces`
VALUES (350800, '龙岩市', 350000, '龙岩', 2, '0597', '364000', '中国,福建省,龙岩市', '117.02978', '25.091603', 'Longyan', 1);
INSERT INTO `provinces`
VALUES (350802, '新罗区', 350800, '新罗', 3, '0597', '364000', '中国,福建省,龙岩市,新罗区', '117.03693', '25.09834', 'Xinluo', 1);
INSERT INTO `provinces`
VALUES (350821, '长汀县', 350800, '长汀', 3, '0597', '366300', '中国,福建省,龙岩市,长汀县', '116.35888', '25.82773', 'Changting', 1);
INSERT INTO `provinces`
VALUES (350822, '永定区', 350800, '永定', 3, '0597', '364100', '中国,福建省,龙岩市,永定区', '116.73199', '24.72302', 'Yongding', 1);
INSERT INTO `provinces`
VALUES (350823, '上杭县', 350800, '上杭', 3, '0597', '364200', '中国,福建省,龙岩市,上杭县', '116.42022', '25.04943', 'Shanghang', 1);
INSERT INTO `provinces`
VALUES (350824, '武平县', 350800, '武平', 3, '0597', '364300', '中国,福建省,龙岩市,武平县', '116.10229', '25.09244', 'Wuping', 1);
INSERT INTO `provinces`
VALUES (350825, '连城县', 350800, '连城', 3, '0597', '366200', '中国,福建省,龙岩市,连城县', '116.75454', '25.7103', 'Liancheng', 1);
INSERT INTO `provinces`
VALUES (350881, '漳平市', 350800, '漳平', 3, '0597', '364400', '中国,福建省,龙岩市,漳平市', '117.41992', '25.29109', 'Zhangping', 1);
INSERT INTO `provinces`
VALUES (350900, '宁德市', 350000, '宁德', 2, '0593', '352100', '中国,福建省,宁德市', '119.527082', '26.65924', 'Ningde', 1);
INSERT INTO `provinces`
VALUES (350902, '蕉城区', 350900, '蕉城', 3, '0593', '352100', '中国,福建省,宁德市,蕉城区', '119.52643', '26.66048', 'Jiaocheng', 1);
INSERT INTO `provinces`
VALUES (350921, '霞浦县', 350900, '霞浦', 3, '0593', '355100', '中国,福建省,宁德市,霞浦县', '119.99893', '26.88578', 'Xiapu', 1);
INSERT INTO `provinces`
VALUES (350922, '古田县', 350900, '古田', 3, '0593', '352200', '中国,福建省,宁德市,古田县', '118.74688', '26.57682', 'Gutian', 1);
INSERT INTO `provinces`
VALUES (350923, '屏南县', 350900, '屏南', 3, '0593', '352300', '中国,福建省,宁德市,屏南县', '118.98861', '26.91099', 'Pingnan', 1);
INSERT INTO `provinces`
VALUES (350924, '寿宁县', 350900, '寿宁', 3, '0593', '355500', '中国,福建省,宁德市,寿宁县', '119.5039', '27.45996', 'Shouning', 1);
INSERT INTO `provinces`
VALUES (350925, '周宁县', 350900, '周宁', 3, '0593', '355400', '中国,福建省,宁德市,周宁县', '119.33837', '27.10664', 'Zhouning', 1);
INSERT INTO `provinces`
VALUES (350926, '柘荣县', 350900, '柘荣', 3, '0593', '355300', '中国,福建省,宁德市,柘荣县', '119.89971', '27.23543', 'Zherong', 1);
INSERT INTO `provinces`
VALUES (350981, '福安市', 350900, '福安', 3, '0593', '355000', '中国,福建省,宁德市,福安市', '119.6495', '27.08673', 'Fu\'an', 1);
INSERT INTO `provinces`
VALUES (350982, '福鼎市', 350900, '福鼎', 3, '0593', '355200', '中国,福建省,宁德市,福鼎市', '120.21664', '27.3243', 'Fuding', 1);
INSERT INTO `provinces`
VALUES (360000, '江西省', 100000, '江西', 1, '', '', '中国,江西省', '115.892151', '28.676493', 'Jiangxi', 1);
INSERT INTO `provinces`
VALUES (360100, '南昌市', 360000, '南昌', 2, '0791', '330008', '中国,江西省,南昌市', '115.892151', '28.676493', 'Nanchang', 1);
INSERT INTO `provinces`
VALUES (360102, '东湖区', 360100, '东湖', 3, '0791', '330006', '中国,江西省,南昌市,东湖区', '115.8988', '28.68505', 'Donghu', 1);
INSERT INTO `provinces`
VALUES (360103, '西湖区', 360100, '西湖', 3, '0791', '330009', '中国,江西省,南昌市,西湖区', '115.87728', '28.65688', 'Xihu', 1);
INSERT INTO `provinces`
VALUES (360104, '青云谱区', 360100, '青云谱', 3, '0791', '330001', '中国,江西省,南昌市,青云谱区', '115.915', '28.63199', 'Qingyunpu', 1);
INSERT INTO `provinces`
VALUES (360105, '湾里区', 360100, '湾里', 3, '0791', '330004', '中国,江西省,南昌市,湾里区', '115.73104', '28.71529', 'Wanli', 1);
INSERT INTO `provinces`
VALUES (360111, '青山湖区', 360100, '青山湖', 3, '0791', '330029', '中国,江西省,南昌市,青山湖区', '115.9617', '28.68206', 'Qingshanhu', 1);
INSERT INTO `provinces`
VALUES (360121, '南昌县', 360100, '南昌', 3, '0791', '330200', '中国,江西省,南昌市,南昌县', '115.94393', '28.54559', 'Nanchang', 1);
INSERT INTO `provinces`
VALUES (360122, '新建县', 360100, '新建', 3, '0791', '330100', '中国,江西省,南昌市,新建县', '115.81546', '28.69248', 'Xinjian', 1);
INSERT INTO `provinces`
VALUES (360123, '安义县', 360100, '安义', 3, '0791', '330500', '中国,江西省,南昌市,安义县', '115.54879', '28.84602', 'Anyi', 1);
INSERT INTO `provinces`
VALUES (360124, '进贤县', 360100, '进贤', 3, '0791', '331700', '中国,江西省,南昌市,进贤县', '116.24087', '28.37679', 'Jinxian', 1);
INSERT INTO `provinces`
VALUES (360200, '景德镇市', 360000, '景德镇', 2, '0798', '333000', '中国,江西省,景德镇市', '117.214664', '29.29256', 'Jingdezhen', 1);
INSERT INTO `provinces`
VALUES (360202, '昌江区', 360200, '昌江', 3, '0799', '333000', '中国,江西省,景德镇市,昌江区', '117.18359', '29.27321', 'Changjiang', 1);
INSERT INTO `provinces`
VALUES (360203, '珠山区', 360200, '珠山', 3, '0800', '333000', '中国,江西省,景德镇市,珠山区', '117.20233', '29.30127', 'Zhushan', 1);
INSERT INTO `provinces`
VALUES (360222, '浮梁县', 360200, '浮梁', 3, '0802', '333400', '中国,江西省,景德镇市,浮梁县', '117.21517', '29.35156', 'Fuliang', 1);
INSERT INTO `provinces`
VALUES (360281, '乐平市', 360200, '乐平', 3, '0801', '333300', '中国,江西省,景德镇市,乐平市', '117.12887', '28.96295', 'Leping', 1);
INSERT INTO `provinces`
VALUES (360300, '萍乡市', 360000, '萍乡', 2, '0799', '337000', '中国,江西省,萍乡市', '113.852186', '27.622946', 'Pingxiang', 1);
INSERT INTO `provinces`
VALUES (360302, '安源区', 360300, '安源', 3, '0800', '337000', '中国,江西省,萍乡市,安源区', '113.89135', '27.61653', 'Anyuan', 1);
INSERT INTO `provinces`
VALUES (360313, '湘东区', 360300, '湘东', 3, '0801', '337016', '中国,江西省,萍乡市,湘东区', '113.73294', '27.64007', 'Xiangdong', 1);
INSERT INTO `provinces`
VALUES (360321, '莲花县', 360300, '莲花', 3, '0802', '337100', '中国,江西省,萍乡市,莲花县', '113.96142', '27.12866', 'Lianhua', 1);
INSERT INTO `provinces`
VALUES (360322, '上栗县', 360300, '上栗', 3, '0803', '337009', '中国,江西省,萍乡市,上栗县', '113.79403', '27.87467', 'Shangli', 1);
INSERT INTO `provinces`
VALUES (360323, '芦溪县', 360300, '芦溪', 3, '0804', '337053', '中国,江西省,萍乡市,芦溪县', '114.02951', '27.63063', 'Luxi', 1);
INSERT INTO `provinces`
VALUES (360400, '九江市', 360000, '九江', 2, '0792', '332000', '中国,江西省,九江市', '115.992811', '29.712034', 'Jiujiang', 1);
INSERT INTO `provinces`
VALUES (360402, '庐山区', 360400, '庐山', 3, '0792', '332005', '中国,江西省,九江市,庐山区', '115.98904', '29.67177', 'Lushan', 1);
INSERT INTO `provinces`
VALUES (360403, '浔阳区', 360400, '浔阳', 3, '0792', '332000', '中国,江西省,九江市,浔阳区', '115.98986', '29.72786', 'Xunyang', 1);
INSERT INTO `provinces`
VALUES (360421, '九江县', 360400, '九江', 3, '0792', '332100', '中国,江西省,九江市,九江县', '115.91128', '29.60852', 'Jiujiang', 1);
INSERT INTO `provinces`
VALUES (360423, '武宁县', 360400, '武宁', 3, '0792', '332300', '中国,江西省,九江市,武宁县', '115.10061', '29.2584', 'Wuning', 1);
INSERT INTO `provinces`
VALUES (360424, '修水县', 360400, '修水', 3, '0792', '332400', '中国,江西省,九江市,修水县', '114.54684', '29.02539', 'Xiushui', 1);
INSERT INTO `provinces`
VALUES (360425, '永修县', 360400, '永修', 3, '0792', '330300', '中国,江西省,九江市,永修县', '115.80911', '29.02093', 'Yongxiu', 1);
INSERT INTO `provinces`
VALUES (360426, '德安县', 360400, '德安', 3, '0792', '330400', '中国,江西省,九江市,德安县', '115.75601', '29.31341', 'De\'an', 1);
INSERT INTO `provinces`
VALUES (360427, '星子县', 360400, '星子', 3, '0792', '332800', '中国,江西省,九江市,星子县', '116.04492', '29.44608', 'Xingzi', 1);
INSERT INTO `provinces`
VALUES (360428, '都昌县', 360400, '都昌', 3, '0792', '332600', '中国,江西省,九江市,都昌县', '116.20401', '29.27327', 'Duchang', 1);
INSERT INTO `provinces`
VALUES (360429, '湖口县', 360400, '湖口', 3, '0792', '332500', '中国,江西省,九江市,湖口县', '116.21853', '29.73818', 'Hukou', 1);
INSERT INTO `provinces`
VALUES (360430, '彭泽县', 360400, '彭泽', 3, '0792', '332700', '中国,江西省,九江市,彭泽县', '116.55011', '29.89589', 'Pengze', 1);
INSERT INTO `provinces`
VALUES (360481, '瑞昌市', 360400, '瑞昌', 3, '0792', '332200', '中国,江西省,九江市,瑞昌市', '115.66705', '29.67183', 'Ruichang', 1);
INSERT INTO `provinces`
VALUES (360482, '共青城市', 360400, '共青城', 3, '0792', '332020', '中国,江西省,九江市,共青城市', '115.801939', '29.238785',
        'Gongqingcheng', 1);
INSERT INTO `provinces`
VALUES (360500, '新余市', 360000, '新余', 2, '0790', '338025', '中国,江西省,新余市', '114.930835', '27.810834', 'Xinyu', 1);
INSERT INTO `provinces`
VALUES (360502, '渝水区', 360500, '渝水', 3, '0790', '338025', '中国,江西省,新余市,渝水区', '114.944', '27.80098', 'Yushui', 1);
INSERT INTO `provinces`
VALUES (360521, '分宜县', 360500, '分宜', 3, '0790', '336600', '中国,江西省,新余市,分宜县', '114.69189', '27.81475', 'Fenyi', 1);
INSERT INTO `provinces`
VALUES (360600, '鹰潭市', 360000, '鹰潭', 2, '0701', '335000', '中国,江西省,鹰潭市', '117.033838', '28.238638', 'Yingtan', 1);
INSERT INTO `provinces`
VALUES (360602, '月湖区', 360600, '月湖', 3, '0701', '335000', '中国,江西省,鹰潭市,月湖区', '117.03732', '28.23913', 'Yuehu', 1);
INSERT INTO `provinces`
VALUES (360622, '余江县', 360600, '余江', 3, '0701', '335200', '中国,江西省,鹰潭市,余江县', '116.81851', '28.21034', 'Yujiang', 1);
INSERT INTO `provinces`
VALUES (360681, '贵溪市', 360600, '贵溪', 3, '0701', '335400', '中国,江西省,鹰潭市,贵溪市', '117.24246', '28.2926', 'Guixi', 1);
INSERT INTO `provinces`
VALUES (360700, '赣州市', 360000, '赣州', 2, '0797', '341000', '中国,江西省,赣州市', '114.940278', '25.85097', 'Ganzhou', 1);
INSERT INTO `provinces`
VALUES (360702, '章贡区', 360700, '章贡', 3, '0797', '341000', '中国,江西省,赣州市,章贡区', '114.94284', '25.8624', 'Zhanggong', 1);
INSERT INTO `provinces`
VALUES (360703, '南康区', 360700, '南康', 3, '0797', '341400', '中国,江西省,赣州市,南康区', '114.756933', '25.661721', 'Nankang', 1);
INSERT INTO `provinces`
VALUES (360721, '赣县', 360700, '赣县', 3, '0797', '341100', '中国,江西省,赣州市,赣县', '115.01171', '25.86149', 'Ganxian', 1);
INSERT INTO `provinces`
VALUES (360722, '信丰县', 360700, '信丰', 3, '0797', '341600', '中国,江西省,赣州市,信丰县', '114.92279', '25.38612', 'Xinfeng', 1);
INSERT INTO `provinces`
VALUES (360723, '大余县', 360700, '大余', 3, '0797', '341500', '中国,江西省,赣州市,大余县', '114.35757', '25.39561', 'Dayu', 1);
INSERT INTO `provinces`
VALUES (360724, '上犹县', 360700, '上犹', 3, '0797', '341200', '中国,江西省,赣州市,上犹县', '114.54138', '25.79567', 'Shangyou', 1);
INSERT INTO `provinces`
VALUES (360725, '崇义县', 360700, '崇义', 3, '0797', '341300', '中国,江西省,赣州市,崇义县', '114.30835', '25.68186', 'Chongyi', 1);
INSERT INTO `provinces`
VALUES (360726, '安远县', 360700, '安远', 3, '0797', '342100', '中国,江西省,赣州市,安远县', '115.39483', '25.1371', 'Anyuan', 1);
INSERT INTO `provinces`
VALUES (360727, '龙南县', 360700, '龙南', 3, '0797', '341700', '中国,江西省,赣州市,龙南县', '114.78994', '24.91086', 'Longnan', 1);
INSERT INTO `provinces`
VALUES (360728, '定南县', 360700, '定南', 3, '0797', '341900', '中国,江西省,赣州市,定南县', '115.02713', '24.78395', 'Dingnan', 1);
INSERT INTO `provinces`
VALUES (360729, '全南县', 360700, '全南', 3, '0797', '341800', '中国,江西省,赣州市,全南县', '114.5292', '24.74324', 'Quannan', 1);
INSERT INTO `provinces`
VALUES (360730, '宁都县', 360700, '宁都', 3, '0797', '342800', '中国,江西省,赣州市,宁都县', '116.01565', '26.47227', 'Ningdu', 1);
INSERT INTO `provinces`
VALUES (360731, '于都县', 360700, '于都', 3, '0797', '342300', '中国,江西省,赣州市,于都县', '115.41415', '25.95257', 'Yudu', 1);
INSERT INTO `provinces`
VALUES (360732, '兴国县', 360700, '兴国', 3, '0797', '342400', '中国,江西省,赣州市,兴国县', '115.36309', '26.33776', 'Xingguo', 1);
INSERT INTO `provinces`
VALUES (360733, '会昌县', 360700, '会昌', 3, '0797', '342600', '中国,江西省,赣州市,会昌县', '115.78555', '25.60068', 'Huichang', 1);
INSERT INTO `provinces`
VALUES (360734, '寻乌县', 360700, '寻乌', 3, '0797', '342200', '中国,江西省,赣州市,寻乌县', '115.64852', '24.95513', 'Xunwu', 1);
INSERT INTO `provinces`
VALUES (360735, '石城县', 360700, '石城', 3, '0797', '342700', '中国,江西省,赣州市,石城县', '116.3442', '26.32617', 'Shicheng', 1);
INSERT INTO `provinces`
VALUES (360781, '瑞金市', 360700, '瑞金', 3, '0797', '342500', '中国,江西省,赣州市,瑞金市', '116.02703', '25.88557', 'Ruijin', 1);
INSERT INTO `provinces`
VALUES (360800, '吉安市', 360000, '吉安', 2, '0796', '343000', '中国,江西省,吉安市', '114.986373', '27.111699', 'Ji\'an', 1);
INSERT INTO `provinces`
VALUES (360802, '吉州区', 360800, '吉州', 3, '0796', '343000', '中国,江西省,吉安市,吉州区', '114.97598', '27.10669', 'Jizhou', 1);
INSERT INTO `provinces`
VALUES (360803, '青原区', 360800, '青原', 3, '0796', '343009', '中国,江西省,吉安市,青原区', '115.01747', '27.10577', 'Qingyuan', 1);
INSERT INTO `provinces`
VALUES (360821, '吉安县', 360800, '吉安', 3, '0796', '343100', '中国,江西省,吉安市,吉安县', '114.90695', '27.04048', 'Ji\'an', 1);
INSERT INTO `provinces`
VALUES (360822, '吉水县', 360800, '吉水', 3, '0796', '331600', '中国,江西省,吉安市,吉水县', '115.1343', '27.21071', 'Jishui', 1);
INSERT INTO `provinces`
VALUES (360823, '峡江县', 360800, '峡江', 3, '0796', '331409', '中国,江西省,吉安市,峡江县', '115.31723', '27.576', 'Xiajiang', 1);
INSERT INTO `provinces`
VALUES (360824, '新干县', 360800, '新干', 3, '0796', '331300', '中国,江西省,吉安市,新干县', '115.39306', '27.74092', 'Xingan', 1);
INSERT INTO `provinces`
VALUES (360825, '永丰县', 360800, '永丰', 3, '0796', '331500', '中国,江西省,吉安市,永丰县', '115.44238', '27.31785', 'Yongfeng', 1);
INSERT INTO `provinces`
VALUES (360826, '泰和县', 360800, '泰和', 3, '0796', '343700', '中国,江西省,吉安市,泰和县', '114.90789', '26.79113', 'Taihe', 1);
INSERT INTO `provinces`
VALUES (360827, '遂川县', 360800, '遂川', 3, '0796', '343900', '中国,江西省,吉安市,遂川县', '114.51629', '26.32598', 'Suichuan', 1);
INSERT INTO `provinces`
VALUES (360828, '万安县', 360800, '万安', 3, '0796', '343800', '中国,江西省,吉安市,万安县', '114.78659', '26.45931', 'Wan\'an', 1);
INSERT INTO `provinces`
VALUES (360829, '安福县', 360800, '安福', 3, '0796', '343200', '中国,江西省,吉安市,安福县', '114.61956', '27.39276', 'Anfu', 1);
INSERT INTO `provinces`
VALUES (360830, '永新县', 360800, '永新', 3, '0796', '343400', '中国,江西省,吉安市,永新县', '114.24246', '26.94488', 'Yongxin', 1);
INSERT INTO `provinces`
VALUES (360881, '井冈山市', 360800, '井冈山', 3, '0796', '343600', '中国,江西省,吉安市,井冈山市', '114.28949', '26.74804', 'Jinggangshan',
        1);
INSERT INTO `provinces`
VALUES (360900, '宜春市', 360000, '宜春', 2, '0795', '336000', '中国,江西省,宜春市', '114.391136', '27.8043', 'Yichun', 1);
INSERT INTO `provinces`
VALUES (360902, '袁州区', 360900, '袁州', 3, '0795', '336000', '中国,江西省,宜春市,袁州区', '114.38246', '27.79649', 'Yuanzhou', 1);
INSERT INTO `provinces`
VALUES (360921, '奉新县', 360900, '奉新', 3, '0795', '330700', '中国,江西省,宜春市,奉新县', '115.40036', '28.6879', 'Fengxin', 1);
INSERT INTO `provinces`
VALUES (360922, '万载县', 360900, '万载', 3, '0795', '336100', '中国,江西省,宜春市,万载县', '114.4458', '28.10656', 'Wanzai', 1);
INSERT INTO `provinces`
VALUES (360923, '上高县', 360900, '上高', 3, '0795', '336400', '中国,江西省,宜春市,上高县', '114.92459', '28.23423', 'Shanggao', 1);
INSERT INTO `provinces`
VALUES (360924, '宜丰县', 360900, '宜丰', 3, '0795', '336300', '中国,江西省,宜春市,宜丰县', '114.7803', '28.38555', 'Yifeng', 1);
INSERT INTO `provinces`
VALUES (360925, '靖安县', 360900, '靖安', 3, '0795', '330600', '中国,江西省,宜春市,靖安县', '115.36279', '28.86167', 'Jing\'an', 1);
INSERT INTO `provinces`
VALUES (360926, '铜鼓县', 360900, '铜鼓', 3, '0795', '336200', '中国,江西省,宜春市,铜鼓县', '114.37036', '28.52311', 'Tonggu', 1);
INSERT INTO `provinces`
VALUES (360981, '丰城市', 360900, '丰城', 3, '0795', '331100', '中国,江西省,宜春市,丰城市', '115.77114', '28.15918', 'Fengcheng', 1);
INSERT INTO `provinces`
VALUES (360982, '樟树市', 360900, '樟树', 3, '0795', '331200', '中国,江西省,宜春市,樟树市', '115.5465', '28.05332', 'Zhangshu', 1);
INSERT INTO `provinces`
VALUES (360983, '高安市', 360900, '高安', 3, '0795', '330800', '中国,江西省,宜春市,高安市', '115.3753', '28.4178', 'Gao\'an', 1);
INSERT INTO `provinces`
VALUES (361000, '抚州市', 360000, '抚州', 2, '0794', '344000', '中国,江西省,抚州市', '116.358351', '27.98385', 'Fuzhou', 1);
INSERT INTO `provinces`
VALUES (361002, '临川区', 361000, '临川', 3, '0794', '344000', '中国,江西省,抚州市,临川区', '116.35919', '27.97721', 'Linchuan', 1);
INSERT INTO `provinces`
VALUES (361021, '南城县', 361000, '南城', 3, '0794', '344700', '中国,江西省,抚州市,南城县', '116.64419', '27.55381', 'Nancheng', 1);
INSERT INTO `provinces`
VALUES (361022, '黎川县', 361000, '黎川', 3, '0794', '344600', '中国,江西省,抚州市,黎川县', '116.90771', '27.28232', 'Lichuan', 1);
INSERT INTO `provinces`
VALUES (361023, '南丰县', 361000, '南丰', 3, '0794', '344500', '中国,江西省,抚州市,南丰县', '116.5256', '27.21842', 'Nanfeng', 1);
INSERT INTO `provinces`
VALUES (361024, '崇仁县', 361000, '崇仁', 3, '0794', '344200', '中国,江西省,抚州市,崇仁县', '116.06021', '27.75962', 'Chongren', 1);
INSERT INTO `provinces`
VALUES (361025, '乐安县', 361000, '乐安', 3, '0794', '344300', '中国,江西省,抚州市,乐安县', '115.83108', '27.42812', 'Le\'an', 1);
INSERT INTO `provinces`
VALUES (361026, '宜黄县', 361000, '宜黄', 3, '0794', '344400', '中国,江西省,抚州市,宜黄县', '116.23626', '27.55487', 'Yihuang', 1);
INSERT INTO `provinces`
VALUES (361027, '金溪县', 361000, '金溪', 3, '0794', '344800', '中国,江西省,抚州市,金溪县', '116.77392', '27.90753', 'Jinxi', 1);
INSERT INTO `provinces`
VALUES (361028, '资溪县', 361000, '资溪', 3, '0794', '335300', '中国,江西省,抚州市,资溪县', '117.06939', '27.70493', 'Zixi', 1);
INSERT INTO `provinces`
VALUES (361029, '东乡县', 361000, '东乡', 3, '0794', '331800', '中国,江西省,抚州市,东乡县', '116.59039', '28.23614', 'Dongxiang', 1);
INSERT INTO `provinces`
VALUES (361030, '广昌县', 361000, '广昌', 3, '0794', '344900', '中国,江西省,抚州市,广昌县', '116.32547', '26.8341', 'Guangchang', 1);
INSERT INTO `provinces`
VALUES (361100, '上饶市', 360000, '上饶', 2, '0793', '334000', '中国,江西省,上饶市', '117.971185', '28.44442', 'Shangrao', 1);
INSERT INTO `provinces`
VALUES (361102, '信州区', 361100, '信州', 3, '0793', '334000', '中国,江西省,上饶市,信州区', '117.96682', '28.43121', 'Xinzhou', 1);
INSERT INTO `provinces`
VALUES (361121, '上饶县', 361100, '上饶', 3, '0793', '334100', '中国,江西省,上饶市,上饶县', '117.90884', '28.44856', 'Shangrao', 1);
INSERT INTO `provinces`
VALUES (361122, '广丰县', 361100, '广丰', 3, '0793', '334600', '中国,江西省,上饶市,广丰县', '118.19158', '28.43766', 'Guangfeng', 1);
INSERT INTO `provinces`
VALUES (361123, '玉山县', 361100, '玉山', 3, '0793', '334700', '中国,江西省,上饶市,玉山县', '118.24462', '28.6818', 'Yushan', 1);
INSERT INTO `provinces`
VALUES (361124, '铅山县', 361100, '铅山', 3, '0793', '334500', '中国,江西省,上饶市,铅山县', '117.70996', '28.31549', 'Yanshan', 1);
INSERT INTO `provinces`
VALUES (361125, '横峰县', 361100, '横峰', 3, '0793', '334300', '中国,江西省,上饶市,横峰县', '117.5964', '28.40716', 'Hengfeng', 1);
INSERT INTO `provinces`
VALUES (361126, '弋阳县', 361100, '弋阳', 3, '0793', '334400', '中国,江西省,上饶市,弋阳县', '117.45929', '28.37451', 'Yiyang', 1);
INSERT INTO `provinces`
VALUES (361127, '余干县', 361100, '余干', 3, '0793', '335100', '中国,江西省,上饶市,余干县', '116.69555', '28.70206', 'Yugan', 1);
INSERT INTO `provinces`
VALUES (361128, '鄱阳县', 361100, '鄱阳', 3, '0793', '333100', '中国,江西省,上饶市,鄱阳县', '116.69967', '29.0118', 'Poyang', 1);
INSERT INTO `provinces`
VALUES (361129, '万年县', 361100, '万年', 3, '0793', '335500', '中国,江西省,上饶市,万年县', '117.06884', '28.69537', 'Wannian', 1);
INSERT INTO `provinces`
VALUES (361130, '婺源县', 361100, '婺源', 3, '0793', '333200', '中国,江西省,上饶市,婺源县', '117.86105', '29.24841', 'Wuyuan', 1);
INSERT INTO `provinces`
VALUES (361181, '德兴市', 361100, '德兴', 3, '0793', '334200', '中国,江西省,上饶市,德兴市', '117.57919', '28.94736', 'Dexing', 1);
INSERT INTO `provinces`
VALUES (370000, '山东省', 100000, '山东', 1, '', '', '中国,山东省', '117.000923', '36.675807', 'Shandong', 1);
INSERT INTO `provinces`
VALUES (370100, '济南市', 370000, '济南', 2, '0531', '250001', '中国,山东省,济南市', '117.000923', '36.675807', 'Jinan', 1);
INSERT INTO `provinces`
VALUES (370102, '历下区', 370100, '历下', 3, '0531', '250014', '中国,山东省,济南市,历下区', '117.0768', '36.66661', 'Lixia', 1);
INSERT INTO `provinces`
VALUES (370103, '市中区', 370100, '市中区', 3, '0531', '250001', '中国,山东省,济南市,市中区', '116.99741', '36.65101', 'Shizhongqu', 1);
INSERT INTO `provinces`
VALUES (370104, '槐荫区', 370100, '槐荫', 3, '0531', '250117', '中国,山东省,济南市,槐荫区', '116.90075', '36.65136', 'Huaiyin', 1);
INSERT INTO `provinces`
VALUES (370105, '天桥区', 370100, '天桥', 3, '0531', '250031', '中国,山东省,济南市,天桥区', '116.98749', '36.67801', 'Tianqiao', 1);
INSERT INTO `provinces`
VALUES (370112, '历城区', 370100, '历城', 3, '0531', '250100', '中国,山东省,济南市,历城区', '117.06509', '36.67995', 'Licheng', 1);
INSERT INTO `provinces`
VALUES (370113, '长清区', 370100, '长清', 3, '0531', '250300', '中国,山东省,济南市,长清区', '116.75192', '36.55352', 'Changqing', 1);
INSERT INTO `provinces`
VALUES (370124, '平阴县', 370100, '平阴', 3, '0531', '250400', '中国,山东省,济南市,平阴县', '116.45587', '36.28955', 'Pingyin', 1);
INSERT INTO `provinces`
VALUES (370125, '济阳县', 370100, '济阳', 3, '0531', '251400', '中国,山东省,济南市,济阳县', '117.17327', '36.97845', 'Jiyang', 1);
INSERT INTO `provinces`
VALUES (370126, '商河县', 370100, '商河', 3, '0531', '251600', '中国,山东省,济南市,商河县', '117.15722', '37.31119', 'Shanghe', 1);
INSERT INTO `provinces`
VALUES (370181, '章丘市', 370100, '章丘', 3, '0531', '250200', '中国,山东省,济南市,章丘市', '117.53677', '36.71392', 'Zhangqiu', 1);
INSERT INTO `provinces`
VALUES (370200, '青岛市', 370000, '青岛', 2, '0532', '266001', '中国,山东省,青岛市', '120.369557', '36.094406', 'Qingdao', 1);
INSERT INTO `provinces`
VALUES (370202, '市南区', 370200, '市南', 3, '0532', '266001', '中国,山东省,青岛市,市南区', '120.38773', '36.06671', 'Shinan', 1);
INSERT INTO `provinces`
VALUES (370203, '市北区', 370200, '市北', 3, '0532', '266011', '中国,山东省,青岛市,市北区', '120.37469', '36.08734', 'Shibei', 1);
INSERT INTO `provinces`
VALUES (370211, '黄岛区', 370200, '黄岛', 3, '0532', '266500', '中国,山东省,青岛市,黄岛区', '120.19775', '35.96065', 'Huangdao', 1);
INSERT INTO `provinces`
VALUES (370212, '崂山区', 370200, '崂山', 3, '0532', '266100', '中国,山东省,青岛市,崂山区', '120.46923', '36.10717', 'Laoshan', 1);
INSERT INTO `provinces`
VALUES (370213, '李沧区', 370200, '李沧', 3, '0532', '266021', '中国,山东省,青岛市,李沧区', '120.43286', '36.14502', 'Licang', 1);
INSERT INTO `provinces`
VALUES (370214, '城阳区', 370200, '城阳', 3, '0532', '266041', '中国,山东省,青岛市,城阳区', '120.39621', '36.30735', 'Chengyang', 1);
INSERT INTO `provinces`
VALUES (370281, '胶州市', 370200, '胶州', 3, '0532', '266300', '中国,山东省,青岛市,胶州市', '120.0335', '36.26442', 'Jiaozhou', 1);
INSERT INTO `provinces`
VALUES (370282, '即墨市', 370200, '即墨', 3, '0532', '266200', '中国,山东省,青岛市,即墨市', '120.44699', '36.38907', 'Jimo', 1);
INSERT INTO `provinces`
VALUES (370283, '平度市', 370200, '平度', 3, '0532', '266700', '中国,山东省,青岛市,平度市', '119.95996', '36.78688', 'Pingdu', 1);
INSERT INTO `provinces`
VALUES (370285, '莱西市', 370200, '莱西', 3, '0532', '266600', '中国,山东省,青岛市,莱西市', '120.51773', '36.88804', 'Laixi', 1);
INSERT INTO `provinces`
VALUES (370286, '西海岸新区', 370200, '西海岸', 3, '0532', '266500', '中国,山东省,青岛市,西海岸新区', '120.19775', '35.96065', 'Xihai\'an',
        1);
INSERT INTO `provinces`
VALUES (370300, '淄博市', 370000, '淄博', 2, '0533', '255039', '中国,山东省,淄博市', '118.047648', '36.814939', 'Zibo', 1);
INSERT INTO `provinces`
VALUES (370302, '淄川区', 370300, '淄川', 3, '0533', '255100', '中国,山东省,淄博市,淄川区', '117.96655', '36.64339', 'Zichuan', 1);
INSERT INTO `provinces`
VALUES (370303, '张店区', 370300, '张店', 3, '0533', '255022', '中国,山东省,淄博市,张店区', '118.01788', '36.80676', 'Zhangdian', 1);
INSERT INTO `provinces`
VALUES (370304, '博山区', 370300, '博山', 3, '0533', '255200', '中国,山东省,淄博市,博山区', '117.86166', '36.49469', 'Boshan', 1);
INSERT INTO `provinces`
VALUES (370305, '临淄区', 370300, '临淄', 3, '0533', '255400', '中国,山东省,淄博市,临淄区', '118.30966', '36.8259', 'Linzi', 1);
INSERT INTO `provinces`
VALUES (370306, '周村区', 370300, '周村', 3, '0533', '255300', '中国,山东省,淄博市,周村区', '117.86969', '36.80322', 'Zhoucun', 1);
INSERT INTO `provinces`
VALUES (370321, '桓台县', 370300, '桓台', 3, '0533', '256400', '中国,山东省,淄博市,桓台县', '118.09698', '36.96036', 'Huantai', 1);
INSERT INTO `provinces`
VALUES (370322, '高青县', 370300, '高青', 3, '0533', '256300', '中国,山东省,淄博市,高青县', '117.82708', '37.17197', 'Gaoqing', 1);
INSERT INTO `provinces`
VALUES (370323, '沂源县', 370300, '沂源', 3, '0533', '256100', '中国,山东省,淄博市,沂源县', '118.17105', '36.18536', 'Yiyuan', 1);
INSERT INTO `provinces`
VALUES (370400, '枣庄市', 370000, '枣庄', 2, '0632', '277101', '中国,山东省,枣庄市', '117.557964', '34.856424', 'Zaozhuang', 1);
INSERT INTO `provinces`
VALUES (370402, '市中区', 370400, '市中区', 3, '0632', '277101', '中国,山东省,枣庄市,市中区', '117.55603', '34.86391', 'Shizhongqu', 1);
INSERT INTO `provinces`
VALUES (370403, '薛城区', 370400, '薛城', 3, '0632', '277000', '中国,山东省,枣庄市,薛城区', '117.26318', '34.79498', 'Xuecheng', 1);
INSERT INTO `provinces`
VALUES (370404, '峄城区', 370400, '峄城', 3, '0632', '277300', '中国,山东省,枣庄市,峄城区', '117.59057', '34.77126', 'Yicheng', 1);
INSERT INTO `provinces`
VALUES (370405, '台儿庄区', 370400, '台儿庄', 3, '0632', '277400', '中国,山东省,枣庄市,台儿庄区', '117.73452', '34.56363', 'Taierzhuang',
        1);
INSERT INTO `provinces`
VALUES (370406, '山亭区', 370400, '山亭', 3, '0632', '277200', '中国,山东省,枣庄市,山亭区', '117.4663', '35.09541', 'Shanting', 1);
INSERT INTO `provinces`
VALUES (370481, '滕州市', 370400, '滕州', 3, '0632', '277500', '中国,山东省,枣庄市,滕州市', '117.165', '35.10534', 'Tengzhou', 1);
INSERT INTO `provinces`
VALUES (370500, '东营市', 370000, '东营', 2, '0546', '257093', '中国,山东省,东营市', '118.4963', '37.461266', 'Dongying', 1);
INSERT INTO `provinces`
VALUES (370502, '东营区', 370500, '东营', 3, '0546', '257029', '中国,山东省,东营市,东营区', '118.5816', '37.44875', 'Dongying', 1);
INSERT INTO `provinces`
VALUES (370503, '河口区', 370500, '河口', 3, '0546', '257200', '中国,山东省,东营市,河口区', '118.5249', '37.88541', 'Hekou', 1);
INSERT INTO `provinces`
VALUES (370521, '垦利县', 370500, '垦利', 3, '0546', '257500', '中国,山东省,东营市,垦利县', '118.54815', '37.58825', 'Kenli', 1);
INSERT INTO `provinces`
VALUES (370522, '利津县', 370500, '利津', 3, '0546', '257400', '中国,山东省,东营市,利津县', '118.25637', '37.49157', 'Lijin', 1);
INSERT INTO `provinces`
VALUES (370523, '广饶县', 370500, '广饶', 3, '0546', '257300', '中国,山东省,东营市,广饶县', '118.40704', '37.05381', 'Guangrao', 1);
INSERT INTO `provinces`
VALUES (370600, '烟台市', 370000, '烟台', 2, '0635', '264010', '中国,山东省,烟台市', '121.391382', '37.539297', 'Yantai', 1);
INSERT INTO `provinces`
VALUES (370602, '芝罘区', 370600, '芝罘', 3, '0635', '264001', '中国,山东省,烟台市,芝罘区', '121.40023', '37.54064', 'Zhifu', 1);
INSERT INTO `provinces`
VALUES (370611, '福山区', 370600, '福山', 3, '0635', '265500', '中国,山东省,烟台市,福山区', '121.26812', '37.49841', 'Fushan', 1);
INSERT INTO `provinces`
VALUES (370612, '牟平区', 370600, '牟平', 3, '0635', '264100', '中国,山东省,烟台市,牟平区', '121.60067', '37.38846', 'Muping', 1);
INSERT INTO `provinces`
VALUES (370613, '莱山区', 370600, '莱山', 3, '0635', '264600', '中国,山东省,烟台市,莱山区', '121.44512', '37.51165', 'Laishan', 1);
INSERT INTO `provinces`
VALUES (370634, '长岛县', 370600, '长岛', 3, '0635', '265800', '中国,山东省,烟台市,长岛县', '120.738', '37.91754', 'Changdao', 1);
INSERT INTO `provinces`
VALUES (370681, '龙口市', 370600, '龙口', 3, '0635', '265700', '中国,山东省,烟台市,龙口市', '120.50634', '37.64064', 'Longkou', 1);
INSERT INTO `provinces`
VALUES (370682, '莱阳市', 370600, '莱阳', 3, '0635', '265200', '中国,山东省,烟台市,莱阳市', '120.71066', '36.98012', 'Laiyang', 1);
INSERT INTO `provinces`
VALUES (370683, '莱州市', 370600, '莱州', 3, '0635', '261400', '中国,山东省,烟台市,莱州市', '119.94137', '37.17806', 'Laizhou', 1);
INSERT INTO `provinces`
VALUES (370684, '蓬莱市', 370600, '蓬莱', 3, '0635', '265600', '中国,山东省,烟台市,蓬莱市', '120.75988', '37.81119', 'Penglai', 1);
INSERT INTO `provinces`
VALUES (370685, '招远市', 370600, '招远', 3, '0635', '265400', '中国,山东省,烟台市,招远市', '120.40481', '37.36269', 'Zhaoyuan', 1);
INSERT INTO `provinces`
VALUES (370686, '栖霞市', 370600, '栖霞', 3, '0635', '265300', '中国,山东省,烟台市,栖霞市', '120.85025', '37.33571', 'Qixia', 1);
INSERT INTO `provinces`
VALUES (370687, '海阳市', 370600, '海阳', 3, '0635', '265100', '中国,山东省,烟台市,海阳市', '121.15976', '36.77622', 'Haiyang', 1);
INSERT INTO `provinces`
VALUES (370700, '潍坊市', 370000, '潍坊', 2, '0536', '261041', '中国,山东省,潍坊市', '119.107078', '36.70925', 'Weifang', 1);
INSERT INTO `provinces`
VALUES (370702, '潍城区', 370700, '潍城', 3, '0536', '261021', '中国,山东省,潍坊市,潍城区', '119.10582', '36.7139', 'Weicheng', 1);
INSERT INTO `provinces`
VALUES (370703, '寒亭区', 370700, '寒亭', 3, '0536', '261100', '中国,山东省,潍坊市,寒亭区', '119.21832', '36.77504', 'Hanting', 1);
INSERT INTO `provinces`
VALUES (370704, '坊子区', 370700, '坊子', 3, '0536', '261200', '中国,山东省,潍坊市,坊子区', '119.16476', '36.65218', 'Fangzi', 1);
INSERT INTO `provinces`
VALUES (370705, '奎文区', 370700, '奎文', 3, '0536', '261031', '中国,山东省,潍坊市,奎文区', '119.12532', '36.70723', 'Kuiwen', 1);
INSERT INTO `provinces`
VALUES (370724, '临朐县', 370700, '临朐', 3, '0536', '262600', '中国,山东省,潍坊市,临朐县', '118.544', '36.51216', 'Linqu', 1);
INSERT INTO `provinces`
VALUES (370725, '昌乐县', 370700, '昌乐', 3, '0536', '262400', '中国,山东省,潍坊市,昌乐县', '118.83017', '36.7078', 'Changle', 1);
INSERT INTO `provinces`
VALUES (370781, '青州市', 370700, '青州', 3, '0536', '262500', '中国,山东省,潍坊市,青州市', '118.47915', '36.68505', 'Qingzhou', 1);
INSERT INTO `provinces`
VALUES (370782, '诸城市', 370700, '诸城', 3, '0536', '262200', '中国,山东省,潍坊市,诸城市', '119.40988', '35.99662', 'Zhucheng', 1);
INSERT INTO `provinces`
VALUES (370783, '寿光市', 370700, '寿光', 3, '0536', '262700', '中国,山东省,潍坊市,寿光市', '118.74047', '36.88128', 'Shouguang', 1);
INSERT INTO `provinces`
VALUES (370784, '安丘市', 370700, '安丘', 3, '0536', '262100', '中国,山东省,潍坊市,安丘市', '119.2189', '36.47847', 'Anqiu', 1);
INSERT INTO `provinces`
VALUES (370785, '高密市', 370700, '高密', 3, '0536', '261500', '中国,山东省,潍坊市,高密市', '119.75701', '36.38397', 'Gaomi', 1);
INSERT INTO `provinces`
VALUES (370786, '昌邑市', 370700, '昌邑', 3, '0536', '261300', '中国,山东省,潍坊市,昌邑市', '119.39767', '36.86008', 'Changyi', 1);
INSERT INTO `provinces`
VALUES (370800, '济宁市', 370000, '济宁', 2, '0537', '272119', '中国,山东省,济宁市', '116.587245', '35.415393', 'Jining', 1);
INSERT INTO `provinces`
VALUES (370811, '任城区', 370800, '任城', 3, '0537', '272113', '中国,山东省,济宁市,任城区', '116.59504', '35.40659', 'Rencheng', 1);
INSERT INTO `provinces`
VALUES (370812, '兖州区', 370800, '兖州', 3, '0537', '272000', '中国,山东省,济宁市,兖州区', '116.826546', '35.552305', 'Yanzhou ', 1);
INSERT INTO `provinces`
VALUES (370826, '微山县', 370800, '微山', 3, '0537', '277600', '中国,山东省,济宁市,微山县', '117.12875', '34.80712', 'Weishan', 1);
INSERT INTO `provinces`
VALUES (370827, '鱼台县', 370800, '鱼台', 3, '0537', '272300', '中国,山东省,济宁市,鱼台县', '116.64761', '34.99674', 'Yutai', 1);
INSERT INTO `provinces`
VALUES (370828, '金乡县', 370800, '金乡', 3, '0537', '272200', '中国,山东省,济宁市,金乡县', '116.31146', '35.065', 'Jinxiang', 1);
INSERT INTO `provinces`
VALUES (370829, '嘉祥县', 370800, '嘉祥', 3, '0537', '272400', '中国,山东省,济宁市,嘉祥县', '116.34249', '35.40836', 'Jiaxiang', 1);
INSERT INTO `provinces`
VALUES (370830, '汶上县', 370800, '汶上', 3, '0537', '272501', '中国,山东省,济宁市,汶上县', '116.48742', '35.73295', 'Wenshang', 1);
INSERT INTO `provinces`
VALUES (370831, '泗水县', 370800, '泗水', 3, '0537', '273200', '中国,山东省,济宁市,泗水县', '117.27948', '35.66113', 'Sishui', 1);
INSERT INTO `provinces`
VALUES (370832, '梁山县', 370800, '梁山', 3, '0537', '272600', '中国,山东省,济宁市,梁山县', '116.09683', '35.80322', 'Liangshan', 1);
INSERT INTO `provinces`
VALUES (370881, '曲阜市', 370800, '曲阜', 3, '0537', '273100', '中国,山东省,济宁市,曲阜市', '116.98645', '35.58091', 'Qufu', 1);
INSERT INTO `provinces`
VALUES (370883, '邹城市', 370800, '邹城', 3, '0537', '273500', '中国,山东省,济宁市,邹城市', '116.97335', '35.40531', 'Zoucheng', 1);
INSERT INTO `provinces`
VALUES (370900, '泰安市', 370000, '泰安', 2, '0538', '271000', '中国,山东省,泰安市', '117.129063', '36.194968', 'Tai\'an', 1);
INSERT INTO `provinces`
VALUES (370902, '泰山区', 370900, '泰山', 3, '0538', '271000', '中国,山东省,泰安市,泰山区', '117.13446', '36.19411', 'Taishan', 1);
INSERT INTO `provinces`
VALUES (370911, '岱岳区', 370900, '岱岳', 3, '0538', '271000', '中国,山东省,泰安市,岱岳区', '117.04174', '36.1875', 'Daiyue', 1);
INSERT INTO `provinces`
VALUES (370921, '宁阳县', 370900, '宁阳', 3, '0538', '271400', '中国,山东省,泰安市,宁阳县', '116.80542', '35.7599', 'Ningyang', 1);
INSERT INTO `provinces`
VALUES (370923, '东平县', 370900, '东平', 3, '0538', '271500', '中国,山东省,泰安市,东平县', '116.47113', '35.93792', 'Dongping', 1);
INSERT INTO `provinces`
VALUES (370982, '新泰市', 370900, '新泰', 3, '0538', '271200', '中国,山东省,泰安市,新泰市', '117.76959', '35.90887', 'Xintai', 1);
INSERT INTO `provinces`
VALUES (370983, '肥城市', 370900, '肥城', 3, '0538', '271600', '中国,山东省,泰安市,肥城市', '116.76815', '36.18247', 'Feicheng', 1);
INSERT INTO `provinces`
VALUES (371000, '威海市', 370000, '威海', 2, '0631', '264200', '中国,山东省,威海市', '122.116394', '37.509691', 'Weihai', 1);
INSERT INTO `provinces`
VALUES (371002, '环翠区', 371000, '环翠', 3, '0631', '264200', '中国,山东省,威海市,环翠区', '122.12344', '37.50199', 'Huancui', 1);
INSERT INTO `provinces`
VALUES (371003, '文登区', 371000, '文登', 3, '0631', '266440', '中国,山东省,威海市,文登区', '122.057139', '37.196211', 'Wendeng', 1);
INSERT INTO `provinces`
VALUES (371082, '荣成市', 371000, '荣成', 3, '0631', '264300', '中国,山东省,威海市,荣成市', '122.48773', '37.1652', 'Rongcheng', 1);
INSERT INTO `provinces`
VALUES (371083, '乳山市', 371000, '乳山', 3, '0631', '264500', '中国,山东省,威海市,乳山市', '121.53814', '36.91918', 'Rushan', 1);
INSERT INTO `provinces`
VALUES (371100, '日照市', 370000, '日照', 2, '0633', '276800', '中国,山东省,日照市', '119.461208', '35.428588', 'Rizhao', 1);
INSERT INTO `provinces`
VALUES (371102, '东港区', 371100, '东港', 3, '0633', '276800', '中国,山东省,日照市,东港区', '119.46237', '35.42541', 'Donggang', 1);
INSERT INTO `provinces`
VALUES (371103, '岚山区', 371100, '岚山', 3, '0633', '276808', '中国,山东省,日照市,岚山区', '119.31884', '35.12203', 'Lanshan', 1);
INSERT INTO `provinces`
VALUES (371121, '五莲县', 371100, '五莲', 3, '0633', '262300', '中国,山东省,日照市,五莲县', '119.207', '35.75004', 'Wulian', 1);
INSERT INTO `provinces`
VALUES (371122, '莒县', 371100, '莒县', 3, '0633', '276500', '中国,山东省,日照市,莒县', '118.83789', '35.58054', 'Juxian', 1);
INSERT INTO `provinces`
VALUES (371200, '莱芜市', 370000, '莱芜', 2, '0634', '271100', '中国,山东省,莱芜市', '117.677736', '36.214397', 'Laiwu', 1);
INSERT INTO `provinces`
VALUES (371202, '莱城区', 371200, '莱城', 3, '0634', '271199', '中国,山东省,莱芜市,莱城区', '117.65986', '36.2032', 'Laicheng', 1);
INSERT INTO `provinces`
VALUES (371203, '钢城区', 371200, '钢城', 3, '0634', '271100', '中国,山东省,莱芜市,钢城区', '117.8049', '36.06319', 'Gangcheng', 1);
INSERT INTO `provinces`
VALUES (371300, '临沂市', 370000, '临沂', 2, '0539', '253000', '中国,山东省,临沂市', '118.326443', '35.065282', 'Linyi', 1);
INSERT INTO `provinces`
VALUES (371302, '兰山区', 371300, '兰山', 3, '0539', '276002', '中国,山东省,临沂市,兰山区', '118.34817', '35.06872', 'Lanshan', 1);
INSERT INTO `provinces`
VALUES (371311, '罗庄区', 371300, '罗庄', 3, '0539', '276022', '中国,山东省,临沂市,罗庄区', '118.28466', '34.99627', 'Luozhuang', 1);
INSERT INTO `provinces`
VALUES (371312, '河东区', 371300, '河东', 3, '0539', '276034', '中国,山东省,临沂市,河东区', '118.41055', '35.08803', 'Hedong', 1);
INSERT INTO `provinces`
VALUES (371321, '沂南县', 371300, '沂南', 3, '0539', '276300', '中国,山东省,临沂市,沂南县', '118.47061', '35.55131', 'Yinan', 1);
INSERT INTO `provinces`
VALUES (371322, '郯城县', 371300, '郯城', 3, '0539', '276100', '中国,山东省,临沂市,郯城县', '118.36712', '34.61354', 'Tancheng', 1);
INSERT INTO `provinces`
VALUES (371323, '沂水县', 371300, '沂水', 3, '0539', '276400', '中国,山东省,临沂市,沂水县', '118.63009', '35.78731', 'Yishui', 1);
INSERT INTO `provinces`
VALUES (371324, '兰陵县', 371300, '兰陵', 3, '0539', '277700', '中国,山东省,临沂市,兰陵县', '117.856592', '34.738315', 'Lanling', 1);
INSERT INTO `provinces`
VALUES (371325, '费县', 371300, '费县', 3, '0539', '273400', '中国,山东省,临沂市,费县', '117.97836', '35.26562', 'Feixian', 1);
INSERT INTO `provinces`
VALUES (371326, '平邑县', 371300, '平邑', 3, '0539', '273300', '中国,山东省,临沂市,平邑县', '117.63867', '35.50573', 'Pingyi', 1);
INSERT INTO `provinces`
VALUES (371327, '莒南县', 371300, '莒南', 3, '0539', '276600', '中国,山东省,临沂市,莒南县', '118.83227', '35.17539', 'Junan', 1);
INSERT INTO `provinces`
VALUES (371328, '蒙阴县', 371300, '蒙阴', 3, '0539', '276200', '中国,山东省,临沂市,蒙阴县', '117.94592', '35.70996', 'Mengyin', 1);
INSERT INTO `provinces`
VALUES (371329, '临沭县', 371300, '临沭', 3, '0539', '276700', '中国,山东省,临沂市,临沭县', '118.65267', '34.92091', 'Linshu', 1);
INSERT INTO `provinces`
VALUES (371400, '德州市', 370000, '德州', 2, '0534', '253000', '中国,山东省,德州市', '116.307428', '37.453968', 'Dezhou', 1);
INSERT INTO `provinces`
VALUES (371402, '德城区', 371400, '德城', 3, '0534', '253012', '中国,山东省,德州市,德城区', '116.29943', '37.45126', 'Decheng', 1);
INSERT INTO `provinces`
VALUES (371403, '陵城区', 371400, '陵城', 3, '0534', '253500', '中国,山东省,德州市,陵城区', '116.57601', '37.33571', 'Lingcheng', 1);
INSERT INTO `provinces`
VALUES (371422, '宁津县', 371400, '宁津', 3, '0534', '253400', '中国,山东省,德州市,宁津县', '116.79702', '37.65301', 'Ningjin', 1);
INSERT INTO `provinces`
VALUES (371423, '庆云县', 371400, '庆云', 3, '0534', '253700', '中国,山东省,德州市,庆云县', '117.38635', '37.77616', 'Qingyun', 1);
INSERT INTO `provinces`
VALUES (371424, '临邑县', 371400, '临邑', 3, '0534', '251500', '中国,山东省,德州市,临邑县', '116.86547', '37.19053', 'Linyi', 1);
INSERT INTO `provinces`
VALUES (371425, '齐河县', 371400, '齐河', 3, '0534', '251100', '中国,山东省,德州市,齐河县', '116.75515', '36.79532', 'Qihe', 1);
INSERT INTO `provinces`
VALUES (371426, '平原县', 371400, '平原', 3, '0534', '253100', '中国,山东省,德州市,平原县', '116.43432', '37.16632', 'Pingyuan', 1);
INSERT INTO `provinces`
VALUES (371427, '夏津县', 371400, '夏津', 3, '0534', '253200', '中国,山东省,德州市,夏津县', '116.0017', '36.94852', 'Xiajin', 1);
INSERT INTO `provinces`
VALUES (371428, '武城县', 371400, '武城', 3, '0534', '253300', '中国,山东省,德州市,武城县', '116.07009', '37.21403', 'Wucheng', 1);
INSERT INTO `provinces`
VALUES (371481, '乐陵市', 371400, '乐陵', 3, '0534', '253600', '中国,山东省,德州市,乐陵市', '117.23141', '37.73164', 'Leling', 1);
INSERT INTO `provinces`
VALUES (371482, '禹城市', 371400, '禹城', 3, '0534', '251200', '中国,山东省,德州市,禹城市', '116.64309', '36.93444', 'Yucheng', 1);
INSERT INTO `provinces`
VALUES (371500, '聊城市', 370000, '聊城', 2, '0635', '252052', '中国,山东省,聊城市', '115.980367', '36.456013', 'Liaocheng', 1);
INSERT INTO `provinces`
VALUES (371502, '东昌府区', 371500, '东昌府', 3, '0635', '252000', '中国,山东省,聊城市,东昌府区', '115.97383', '36.44458', 'Dongchangfu',
        1);
INSERT INTO `provinces`
VALUES (371521, '阳谷县', 371500, '阳谷', 3, '0635', '252300', '中国,山东省,聊城市,阳谷县', '115.79126', '36.11444', 'Yanggu', 1);
INSERT INTO `provinces`
VALUES (371522, '莘县', 371500, '莘县', 3, '0635', '252400', '中国,山东省,聊城市,莘县', '115.6697', '36.23423', 'Shenxian', 1);
INSERT INTO `provinces`
VALUES (371523, '茌平县', 371500, '茌平', 3, '0635', '252100', '中国,山东省,聊城市,茌平县', '116.25491', '36.57969', 'Chiping', 1);
INSERT INTO `provinces`
VALUES (371524, '东阿县', 371500, '东阿', 3, '0635', '252200', '中国,山东省,聊城市,东阿县', '116.25012', '36.33209', 'Dong\'e', 1);
INSERT INTO `provinces`
VALUES (371525, '冠县', 371500, '冠县', 3, '0635', '252500', '中国,山东省,聊城市,冠县', '115.44195', '36.48429', 'Guanxian', 1);
INSERT INTO `provinces`
VALUES (371526, '高唐县', 371500, '高唐', 3, '0635', '252800', '中国,山东省,聊城市,高唐县', '116.23172', '36.86535', 'Gaotang', 1);
INSERT INTO `provinces`
VALUES (371581, '临清市', 371500, '临清', 3, '0635', '252600', '中国,山东省,聊城市,临清市', '115.70629', '36.83945', 'Linqing', 1);
INSERT INTO `provinces`
VALUES (371600, '滨州市', 370000, '滨州', 2, '0543', '256619', '中国,山东省,滨州市', '118.016974', '37.383542', 'Binzhou', 1);
INSERT INTO `provinces`
VALUES (371602, '滨城区', 371600, '滨城', 3, '0543', '256613', '中国,山东省,滨州市,滨城区', '118.02026', '37.38524', 'Bincheng', 1);
INSERT INTO `provinces`
VALUES (371603, '沾化区', 371600, '沾化', 3, '0543', '256800', '中国,山东省,滨州市,沾化区', '118.13214', '37.69832', 'Zhanhua', 1);
INSERT INTO `provinces`
VALUES (371621, '惠民县', 371600, '惠民', 3, '0543', '251700', '中国,山东省,滨州市,惠民县', '117.51113', '37.49013', 'Huimin', 1);
INSERT INTO `provinces`
VALUES (371622, '阳信县', 371600, '阳信', 3, '0543', '251800', '中国,山东省,滨州市,阳信县', '117.58139', '37.64198', 'Yangxin', 1);
INSERT INTO `provinces`
VALUES (371623, '无棣县', 371600, '无棣', 3, '0543', '251900', '中国,山东省,滨州市,无棣县', '117.61395', '37.74009', 'Wudi', 1);
INSERT INTO `provinces`
VALUES (371625, '博兴县', 371600, '博兴', 3, '0543', '256500', '中国,山东省,滨州市,博兴县', '118.1336', '37.14316', 'Boxing', 1);
INSERT INTO `provinces`
VALUES (371626, '邹平县', 371600, '邹平', 3, '0543', '256200', '中国,山东省,滨州市,邹平县', '117.74307', '36.86295', 'Zouping', 1);
INSERT INTO `provinces`
VALUES (371627, '北海新区', 371600, '北海新区', 3, '0543', '256200', '中国,山东省,滨州市,北海新区', '118.016974', '37.383542',
        'Beihaixinqu', 1);
INSERT INTO `provinces`
VALUES (371700, '菏泽市', 370000, '菏泽', 2, '0530', '274020', '中国,山东省,菏泽市', '115.469381', '35.246531', 'Heze', 1);
INSERT INTO `provinces`
VALUES (371702, '牡丹区', 371700, '牡丹', 3, '0530', '274009', '中国,山东省,菏泽市,牡丹区', '115.41662', '35.25091', 'Mudan', 1);
INSERT INTO `provinces`
VALUES (371721, '曹县', 371700, '曹县', 3, '0530', '274400', '中国,山东省,菏泽市,曹县', '115.54226', '34.82659', 'Caoxian', 1);
INSERT INTO `provinces`
VALUES (371722, '单县', 371700, '单县', 3, '0530', '273700', '中国,山东省,菏泽市,单县', '116.08703', '34.79514', 'Shanxian', 1);
INSERT INTO `provinces`
VALUES (371723, '成武县', 371700, '成武', 3, '0530', '274200', '中国,山东省,菏泽市,成武县', '115.8897', '34.95332', 'Chengwu', 1);
INSERT INTO `provinces`
VALUES (371724, '巨野县', 371700, '巨野', 3, '0530', '274900', '中国,山东省,菏泽市,巨野县', '116.09497', '35.39788', 'Juye', 1);
INSERT INTO `provinces`
VALUES (371725, '郓城县', 371700, '郓城', 3, '0530', '274700', '中国,山东省,菏泽市,郓城县', '115.94439', '35.60044', 'Yuncheng', 1);
INSERT INTO `provinces`
VALUES (371726, '鄄城县', 371700, '鄄城', 3, '0530', '274600', '中国,山东省,菏泽市,鄄城县', '115.50997', '35.56412', 'Juancheng', 1);
INSERT INTO `provinces`
VALUES (371727, '定陶县', 371700, '定陶', 3, '0530', '274100', '中国,山东省,菏泽市,定陶县', '115.57287', '35.07118', 'Dingtao', 1);
INSERT INTO `provinces`
VALUES (371728, '东明县', 371700, '东明', 3, '0530', '274500', '中国,山东省,菏泽市,东明县', '115.09079', '35.28906', 'Dongming', 1);
INSERT INTO `provinces`
VALUES (410000, '河南省', 100000, '河南', 1, '', '', '中国,河南省', '113.665412', '34.757975', 'Henan', 1);
INSERT INTO `provinces`
VALUES (410100, '郑州市', 410000, '郑州', 2, '0371', '450000', '中国,河南省,郑州市', '113.665412', '34.757975', 'Zhengzhou', 1);
INSERT INTO `provinces`
VALUES (410102, '中原区', 410100, '中原', 3, '0371', '450007', '中国,河南省,郑州市,中原区', '113.61333', '34.74827', 'Zhongyuan', 1);
INSERT INTO `provinces`
VALUES (410103, '二七区', 410100, '二七', 3, '0371', '450052', '中国,河南省,郑州市,二七区', '113.63931', '34.72336', 'Erqi', 1);
INSERT INTO `provinces`
VALUES (410104, '管城回族区', 410100, '管城', 3, '0371', '450000', '中国,河南省,郑州市,管城回族区', '113.67734', '34.75383', 'Guancheng',
        1);
INSERT INTO `provinces`
VALUES (410105, '金水区', 410100, '金水', 3, '0371', '450003', '中国,河南省,郑州市,金水区', '113.66057', '34.80028', 'Jinshui', 1);
INSERT INTO `provinces`
VALUES (410106, '上街区', 410100, '上街', 3, '0371', '450041', '中国,河南省,郑州市,上街区', '113.30897', '34.80276', 'Shangjie', 1);
INSERT INTO `provinces`
VALUES (410108, '惠济区', 410100, '惠济', 3, '0371', '450053', '中国,河南省,郑州市,惠济区', '113.61688', '34.86735', 'Huiji', 1);
INSERT INTO `provinces`
VALUES (410122, '中牟县', 410100, '中牟', 3, '0371', '451450', '中国,河南省,郑州市,中牟县', '113.97619', '34.71899', 'Zhongmu', 1);
INSERT INTO `provinces`
VALUES (410126, '兰考县', 410200, '兰考', 3, '0378', '475300', '中国,河南省,开封市,兰考县', '114.81961', '34.8235', 'Lankao', 1);
INSERT INTO `provinces`
VALUES (410181, '巩义市', 410100, '巩义', 3, '0371', '451200', '中国,河南省,郑州市,巩义市', '113.022', '34.74794', 'Gongyi', 1);
INSERT INTO `provinces`
VALUES (410182, '荥阳市', 410100, '荥阳', 3, '0371', '450100', '中国,河南省,郑州市,荥阳市', '113.38345', '34.78759', 'Xingyang', 1);
INSERT INTO `provinces`
VALUES (410183, '新密市', 410100, '新密', 3, '0371', '452300', '中国,河南省,郑州市,新密市', '113.3869', '34.53704', 'Xinmi', 1);
INSERT INTO `provinces`
VALUES (410184, '新郑市', 410100, '新郑', 3, '0371', '451100', '中国,河南省,郑州市,新郑市', '113.73645', '34.3955', 'Xinzheng', 1);
INSERT INTO `provinces`
VALUES (410185, '登封市', 410100, '登封', 3, '0371', '452470', '中国,河南省,郑州市,登封市', '113.05023', '34.45345', 'Dengfeng', 1);
INSERT INTO `provinces`
VALUES (410200, '开封市', 410000, '开封', 2, '0378', '475001', '中国,河南省,开封市', '114.341447', '34.797049', 'Kaifeng', 1);
INSERT INTO `provinces`
VALUES (410202, '龙亭区', 410200, '龙亭', 3, '0378', '475100', '中国,河南省,开封市,龙亭区', '114.35484', '34.79995', 'Longting', 1);
INSERT INTO `provinces`
VALUES (410203, '顺河回族区', 410200, '顺河', 3, '0378', '475000', '中国,河南省,开封市,顺河回族区', '114.36123', '34.79586', 'Shunhe', 1);
INSERT INTO `provinces`
VALUES (410204, '鼓楼区', 410200, '鼓楼', 3, '0378', '475000', '中国,河南省,开封市,鼓楼区', '114.35559', '34.79517', 'Gulou', 1);
INSERT INTO `provinces`
VALUES (410205, '禹王台区', 410200, '禹王台', 3, '0378', '475003', '中国,河南省,开封市,禹王台区', '114.34787', '34.77693', 'Yuwangtai', 1);
INSERT INTO `provinces`
VALUES (410212, '祥符区', 410200, '祥符', 3, '0378', '475100', '中国,河南省,开封市,祥符区', '114.43859', '34.75874', 'Xiangfu', 1);
INSERT INTO `provinces`
VALUES (410221, '杞县', 410200, '杞县', 3, '0378', '475200', '中国,河南省,开封市,杞县', '114.7828', '34.55033', 'Qixian', 1);
INSERT INTO `provinces`
VALUES (410222, '通许县', 410200, '通许', 3, '0378', '475400', '中国,河南省,开封市,通许县', '114.46716', '34.47522', 'Tongxu', 1);
INSERT INTO `provinces`
VALUES (410223, '尉氏县', 410200, '尉氏', 3, '0378', '475500', '中国,河南省,开封市,尉氏县', '114.19284', '34.41223', 'Weishi', 1);
INSERT INTO `provinces`
VALUES (410300, '洛阳市', 410000, '洛阳', 2, '0379', '471000', '中国,河南省,洛阳市', '112.434468', '34.663041', 'Luoyang', 1);
INSERT INTO `provinces`
VALUES (410302, '老城区', 410300, '老城', 3, '0379', '471002', '中国,河南省,洛阳市,老城区', '112.46902', '34.68364', 'Laocheng', 1);
INSERT INTO `provinces`
VALUES (410303, '西工区', 410300, '西工', 3, '0379', '471000', '中国,河南省,洛阳市,西工区', '112.4371', '34.67', 'Xigong', 1);
INSERT INTO `provinces`
VALUES (410304, '瀍河回族区', 410300, '瀍河', 3, '0379', '471002', '中国,河南省,洛阳市,瀍河回族区', '112.50018', '34.67985', 'Chanhe', 1);
INSERT INTO `provinces`
VALUES (410305, '涧西区', 410300, '涧西', 3, '0379', '471003', '中国,河南省,洛阳市,涧西区', '112.39588', '34.65823', 'Jianxi', 1);
INSERT INTO `provinces`
VALUES (410306, '吉利区', 410300, '吉利', 3, '0379', '471012', '中国,河南省,洛阳市,吉利区', '112.58905', '34.90088', 'Jili', 1);
INSERT INTO `provinces`
VALUES (410311, '洛龙区', 410300, '洛龙', 3, '0379', '471000', '中国,河南省,洛阳市,洛龙区', '112.46412', '34.61866', 'Luolong', 1);
INSERT INTO `provinces`
VALUES (410322, '孟津县', 410300, '孟津', 3, '0379', '471100', '中国,河南省,洛阳市,孟津县', '112.44351', '34.826', 'Mengjin', 1);
INSERT INTO `provinces`
VALUES (410323, '新安县', 410300, '新安', 3, '0379', '471800', '中国,河南省,洛阳市,新安县', '112.13238', '34.72814', 'Xin\'an', 1);
INSERT INTO `provinces`
VALUES (410324, '栾川县', 410300, '栾川', 3, '0379', '471500', '中国,河南省,洛阳市,栾川县', '111.61779', '33.78576', 'Luanchuan', 1);
INSERT INTO `provinces`
VALUES (410325, '嵩县', 410300, '嵩县', 3, '0379', '471400', '中国,河南省,洛阳市,嵩县', '112.08526', '34.13466', 'Songxian', 1);
INSERT INTO `provinces`
VALUES (410326, '汝阳县', 410300, '汝阳', 3, '0379', '471200', '中国,河南省,洛阳市,汝阳县', '112.47314', '34.15387', 'Ruyang', 1);
INSERT INTO `provinces`
VALUES (410327, '宜阳县', 410300, '宜阳', 3, '0379', '471600', '中国,河南省,洛阳市,宜阳县', '112.17907', '34.51523', 'Yiyang', 1);
INSERT INTO `provinces`
VALUES (410328, '洛宁县', 410300, '洛宁', 3, '0379', '471700', '中国,河南省,洛阳市,洛宁县', '111.65087', '34.38913', 'Luoning', 1);
INSERT INTO `provinces`
VALUES (410329, '伊川县', 410300, '伊川', 3, '0379', '471300', '中国,河南省,洛阳市,伊川县', '112.42947', '34.42205', 'Yichuan', 1);
INSERT INTO `provinces`
VALUES (410381, '偃师市', 410300, '偃师', 3, '0379', '471900', '中国,河南省,洛阳市,偃师市', '112.7922', '34.7281', 'Yanshi', 1);
INSERT INTO `provinces`
VALUES (410400, '平顶山市', 410000, '平顶山', 2, '0375', '467000', '中国,河南省,平顶山市', '113.307718', '33.735241', 'Pingdingshan',
        1);
INSERT INTO `provinces`
VALUES (410402, '新华区', 410400, '新华', 3, '0375', '467002', '中国,河南省,平顶山市,新华区', '113.29402', '33.7373', 'Xinhua', 1);
INSERT INTO `provinces`
VALUES (410403, '卫东区', 410400, '卫东', 3, '0375', '467021', '中国,河南省,平顶山市,卫东区', '113.33511', '33.73472', 'Weidong', 1);
INSERT INTO `provinces`
VALUES (410404, '石龙区', 410400, '石龙', 3, '0375', '467045', '中国,河南省,平顶山市,石龙区', '112.89879', '33.89878', 'Shilong', 1);
INSERT INTO `provinces`
VALUES (410411, '湛河区', 410400, '湛河', 3, '0375', '467000', '中国,河南省,平顶山市,湛河区', '113.29252', '33.7362', 'Zhanhe', 1);
INSERT INTO `provinces`
VALUES (410421, '宝丰县', 410400, '宝丰', 3, '0375', '467400', '中国,河南省,平顶山市,宝丰县', '113.05493', '33.86916', 'Baofeng', 1);
INSERT INTO `provinces`
VALUES (410422, '叶县', 410400, '叶县', 3, '0375', '467200', '中国,河南省,平顶山市,叶县', '113.35104', '33.62126', 'Yexian', 1);
INSERT INTO `provinces`
VALUES (410423, '鲁山县', 410400, '鲁山', 3, '0375', '467300', '中国,河南省,平顶山市,鲁山县', '112.9057', '33.73879', 'Lushan', 1);
INSERT INTO `provinces`
VALUES (410425, '郏县', 410400, '郏县', 3, '0375', '467100', '中国,河南省,平顶山市,郏县', '113.21588', '33.97072', 'Jiaxian', 1);
INSERT INTO `provinces`
VALUES (410481, '舞钢市', 410400, '舞钢', 3, '0375', '462500', '中国,河南省,平顶山市,舞钢市', '113.52417', '33.2938', 'Wugang', 1);
INSERT INTO `provinces`
VALUES (410482, '汝州市', 410400, '汝州', 3, '0375', '467500', '中国,河南省,平顶山市,汝州市', '112.84301', '34.16135', 'Ruzhou', 1);
INSERT INTO `provinces`
VALUES (410500, '安阳市', 410000, '安阳', 2, '0372', '455000', '中国,河南省,安阳市', '114.352482', '36.103442', 'Anyang', 1);
INSERT INTO `provinces`
VALUES (410502, '文峰区', 410500, '文峰', 3, '0372', '455000', '中国,河南省,安阳市,文峰区', '114.35708', '36.09046', 'Wenfeng', 1);
INSERT INTO `provinces`
VALUES (410503, '北关区', 410500, '北关', 3, '0372', '455001', '中国,河南省,安阳市,北关区', '114.35735', '36.11872', 'Beiguan', 1);
INSERT INTO `provinces`
VALUES (410505, '殷都区', 410500, '殷都', 3, '0372', '455004', '中国,河南省,安阳市,殷都区', '114.3034', '36.1099', 'Yindu', 1);
INSERT INTO `provinces`
VALUES (410506, '龙安区', 410500, '龙安', 3, '0372', '455001', '中国,河南省,安阳市,龙安区', '114.34814', '36.11904', 'Long\'an', 1);
INSERT INTO `provinces`
VALUES (410522, '安阳县', 410500, '安阳', 3, '0372', '455000', '中国,河南省,安阳市,安阳县', '114.36605', '36.06695', 'Anyang', 1);
INSERT INTO `provinces`
VALUES (410523, '汤阴县', 410500, '汤阴', 3, '0372', '456150', '中国,河南省,安阳市,汤阴县', '114.35839', '35.92152', 'Tangyin', 1);
INSERT INTO `provinces`
VALUES (410526, '滑县', 410500, '滑县', 3, '0372', '456400', '中国,河南省,安阳市,滑县', '114.52066', '35.5807', 'Huaxian', 1);
INSERT INTO `provinces`
VALUES (410527, '内黄县', 410500, '内黄', 3, '0372', '456350', '中国,河南省,安阳市,内黄县', '114.90673', '35.95269', 'Neihuang', 1);
INSERT INTO `provinces`
VALUES (410581, '林州市', 410500, '林州', 3, '0372', '456550', '中国,河南省,安阳市,林州市', '113.81558', '36.07804', 'Linzhou', 1);
INSERT INTO `provinces`
VALUES (410600, '鹤壁市', 410000, '鹤壁', 2, '0392', '458030', '中国,河南省,鹤壁市', '114.295444', '35.748236', 'Hebi', 1);
INSERT INTO `provinces`
VALUES (410602, '鹤山区', 410600, '鹤山', 3, '0392', '458010', '中国,河南省,鹤壁市,鹤山区', '114.16336', '35.95458', 'Heshan', 1);
INSERT INTO `provinces`
VALUES (410603, '山城区', 410600, '山城', 3, '0392', '458000', '中国,河南省,鹤壁市,山城区', '114.18443', '35.89773', 'Shancheng', 1);
INSERT INTO `provinces`
VALUES (410611, '淇滨区', 410600, '淇滨', 3, '0392', '458000', '中国,河南省,鹤壁市,淇滨区', '114.29867', '35.74127', 'Qibin', 1);
INSERT INTO `provinces`
VALUES (410621, '浚县', 410600, '浚县', 3, '0392', '456250', '中国,河南省,鹤壁市,浚县', '114.54879', '35.67085', 'Xunxian', 1);
INSERT INTO `provinces`
VALUES (410622, '淇县', 410600, '淇县', 3, '0392', '456750', '中国,河南省,鹤壁市,淇县', '114.1976', '35.60782', 'Qixian', 1);
INSERT INTO `provinces`
VALUES (410700, '新乡市', 410000, '新乡', 2, '0373', '453000', '中国,河南省,新乡市', '113.883991', '35.302616', 'Xinxiang', 1);
INSERT INTO `provinces`
VALUES (410702, '红旗区', 410700, '红旗', 3, '0373', '453000', '中国,河南省,新乡市,红旗区', '113.87523', '35.30367', 'Hongqi', 1);
INSERT INTO `provinces`
VALUES (410703, '卫滨区', 410700, '卫滨', 3, '0373', '453000', '中国,河南省,新乡市,卫滨区', '113.86578', '35.30211', 'Weibin', 1);
INSERT INTO `provinces`
VALUES (410704, '凤泉区', 410700, '凤泉', 3, '0373', '453011', '中国,河南省,新乡市,凤泉区', '113.91507', '35.38399', 'Fengquan', 1);
INSERT INTO `provinces`
VALUES (410711, '牧野区', 410700, '牧野', 3, '0373', '453002', '中国,河南省,新乡市,牧野区', '113.9086', '35.3149', 'Muye', 1);
INSERT INTO `provinces`
VALUES (410721, '新乡县', 410700, '新乡', 3, '0373', '453700', '中国,河南省,新乡市,新乡县', '113.80511', '35.19075', 'Xinxiang', 1);
INSERT INTO `provinces`
VALUES (410724, '获嘉县', 410700, '获嘉', 3, '0373', '453800', '中国,河南省,新乡市,获嘉县', '113.66159', '35.26521', 'Huojia', 1);
INSERT INTO `provinces`
VALUES (410725, '原阳县', 410700, '原阳', 3, '0373', '453500', '中国,河南省,新乡市,原阳县', '113.93994', '35.06565', 'Yuanyang', 1);
INSERT INTO `provinces`
VALUES (410726, '延津县', 410700, '延津', 3, '0373', '453200', '中国,河南省,新乡市,延津县', '114.20266', '35.14327', 'Yanjin', 1);
INSERT INTO `provinces`
VALUES (410727, '封丘县', 410700, '封丘', 3, '0373', '453300', '中国,河南省,新乡市,封丘县', '114.41915', '35.04166', 'Fengqiu', 1);
INSERT INTO `provinces`
VALUES (410728, '长垣县', 410700, '长垣', 3, '0373', '453400', '中国,河南省,新乡市,长垣县', '114.66882', '35.20046', 'Changyuan', 1);
INSERT INTO `provinces`
VALUES (410781, '卫辉市', 410700, '卫辉', 3, '0373', '453100', '中国,河南省,新乡市,卫辉市', '114.06454', '35.39843', 'Weihui', 1);
INSERT INTO `provinces`
VALUES (410782, '辉县市', 410700, '辉县', 3, '0373', '453600', '中国,河南省,新乡市,辉县市', '113.8067', '35.46307', 'Huixian', 1);
INSERT INTO `provinces`
VALUES (410800, '焦作市', 410000, '焦作', 2, '0391', '454002', '中国,河南省,焦作市', '113.238266', '35.23904', 'Jiaozuo', 1);
INSERT INTO `provinces`
VALUES (410802, '解放区', 410800, '解放', 3, '0391', '454000', '中国,河南省,焦作市,解放区', '113.22933', '35.24023', 'Jiefang', 1);
INSERT INTO `provinces`
VALUES (410803, '中站区', 410800, '中站', 3, '0391', '454191', '中国,河南省,焦作市,中站区', '113.18315', '35.23665', 'Zhongzhan', 1);
INSERT INTO `provinces`
VALUES (410804, '马村区', 410800, '马村', 3, '0391', '454171', '中国,河南省,焦作市,马村区', '113.3187', '35.26908', 'Macun', 1);
INSERT INTO `provinces`
VALUES (410811, '山阳区', 410800, '山阳', 3, '0391', '454002', '中国,河南省,焦作市,山阳区', '113.25464', '35.21436', 'Shanyang', 1);
INSERT INTO `provinces`
VALUES (410821, '修武县', 410800, '修武', 3, '0391', '454350', '中国,河南省,焦作市,修武县', '113.44775', '35.22357', 'Xiuwu', 1);
INSERT INTO `provinces`
VALUES (410822, '博爱县', 410800, '博爱', 3, '0391', '454450', '中国,河南省,焦作市,博爱县', '113.06698', '35.16943', 'Boai', 1);
INSERT INTO `provinces`
VALUES (410823, '武陟县', 410800, '武陟', 3, '0391', '454950', '中国,河南省,焦作市,武陟县', '113.39718', '35.09505', 'Wuzhi', 1);
INSERT INTO `provinces`
VALUES (410825, '温县', 410800, '温县', 3, '0391', '454850', '中国,河南省,焦作市,温县', '113.08065', '34.94022', 'Wenxian', 1);
INSERT INTO `provinces`
VALUES (410882, '沁阳市', 410800, '沁阳', 3, '0391', '454550', '中国,河南省,焦作市,沁阳市', '112.94494', '35.08935', 'Qinyang', 1);
INSERT INTO `provinces`
VALUES (410883, '孟州市', 410800, '孟州', 3, '0391', '454750', '中国,河南省,焦作市,孟州市', '112.79138', '34.9071', 'Mengzhou', 1);
INSERT INTO `provinces`
VALUES (410900, '濮阳市', 410000, '濮阳', 2, '0393', '457000', '中国,河南省,濮阳市', '115.041299', '35.768234', 'Puyang', 1);
INSERT INTO `provinces`
VALUES (410902, '华龙区', 410900, '华龙', 3, '0393', '457001', '中国,河南省,濮阳市,华龙区', '115.07446', '35.77736', 'Hualong', 1);
INSERT INTO `provinces`
VALUES (410922, '清丰县', 410900, '清丰', 3, '0393', '457300', '中国,河南省,濮阳市,清丰县', '115.10415', '35.88507', 'Qingfeng', 1);
INSERT INTO `provinces`
VALUES (410923, '南乐县', 410900, '南乐', 3, '0393', '457400', '中国,河南省,濮阳市,南乐县', '115.20639', '36.07686', 'Nanle', 1);
INSERT INTO `provinces`
VALUES (410926, '范县', 410900, '范县', 3, '0393', '457500', '中国,河南省,濮阳市,范县', '115.50405', '35.85178', 'Fanxian', 1);
INSERT INTO `provinces`
VALUES (410927, '台前县', 410900, '台前', 3, '0393', '457600', '中国,河南省,濮阳市,台前县', '115.87158', '35.96923', 'Taiqian', 1);
INSERT INTO `provinces`
VALUES (410928, '濮阳县', 410900, '濮阳', 3, '0393', '457100', '中国,河南省,濮阳市,濮阳县', '115.03057', '35.70745', 'Puyang', 1);
INSERT INTO `provinces`
VALUES (411000, '许昌市', 410000, '许昌', 2, '0374', '461000', '中国,河南省,许昌市', '113.826063', '34.022956', 'Xuchang', 1);
INSERT INTO `provinces`
VALUES (411002, '魏都区', 411000, '魏都', 3, '0374', '461000', '中国,河南省,许昌市,魏都区', '113.8227', '34.02544', 'Weidu', 1);
INSERT INTO `provinces`
VALUES (411023, '许昌县', 411000, '许昌', 3, '0374', '461100', '中国,河南省,许昌市,许昌县', '113.84707', '34.00406', 'Xuchang', 1);
INSERT INTO `provinces`
VALUES (411024, '鄢陵县', 411000, '鄢陵', 3, '0374', '461200', '中国,河南省,许昌市,鄢陵县', '114.18795', '34.10317', 'Yanling', 1);
INSERT INTO `provinces`
VALUES (411025, '襄城县', 411000, '襄城', 3, '0374', '461700', '中国,河南省,许昌市,襄城县', '113.48196', '33.84928', 'Xiangcheng', 1);
INSERT INTO `provinces`
VALUES (411081, '禹州市', 411000, '禹州', 3, '0374', '461670', '中国,河南省,许昌市,禹州市', '113.48803', '34.14054', 'Yuzhou', 1);
INSERT INTO `provinces`
VALUES (411082, '长葛市', 411000, '长葛', 3, '0374', '461500', '中国,河南省,许昌市,长葛市', '113.77328', '34.21846', 'Changge', 1);
INSERT INTO `provinces`
VALUES (411100, '漯河市', 410000, '漯河', 2, '0395', '462000', '中国,河南省,漯河市', '114.026405', '33.575855', 'Luohe', 1);
INSERT INTO `provinces`
VALUES (411102, '源汇区', 411100, '源汇', 3, '0395', '462000', '中国,河南省,漯河市,源汇区', '114.00647', '33.55627', 'Yuanhui', 1);
INSERT INTO `provinces`
VALUES (411103, '郾城区', 411100, '郾城', 3, '0395', '462300', '中国,河南省,漯河市,郾城区', '114.00694', '33.58723', 'Yancheng', 1);
INSERT INTO `provinces`
VALUES (411104, '召陵区', 411100, '召陵', 3, '0395', '462300', '中国,河南省,漯河市,召陵区', '114.09399', '33.58601', 'Zhaoling', 1);
INSERT INTO `provinces`
VALUES (411121, '舞阳县', 411100, '舞阳', 3, '0395', '462400', '中国,河南省,漯河市,舞阳县', '113.59848', '33.43243', 'Wuyang', 1);
INSERT INTO `provinces`
VALUES (411122, '临颍县', 411100, '临颍', 3, '0395', '462600', '中国,河南省,漯河市,临颍县', '113.93661', '33.81123', 'Linying', 1);
INSERT INTO `provinces`
VALUES (411200, '三门峡市', 410000, '三门峡', 2, '0398', '472000', '中国,河南省,三门峡市', '111.194099', '34.777338', 'Sanmenxia', 1);
INSERT INTO `provinces`
VALUES (411202, '湖滨区', 411200, '湖滨', 3, '0398', '472000', '中国,河南省,三门峡市,湖滨区', '111.20006', '34.77872', 'Hubin', 1);
INSERT INTO `provinces`
VALUES (411221, '渑池县', 411200, '渑池', 3, '0398', '472400', '中国,河南省,三门峡市,渑池县', '111.76184', '34.76725', 'Mianchi', 1);
INSERT INTO `provinces`
VALUES (411222, '陕县', 411200, '陕县', 3, '0398', '472100', '中国,河南省,三门峡市,陕县', '111.10333', '34.72052', 'Shanxian', 1);
INSERT INTO `provinces`
VALUES (411224, '卢氏县', 411200, '卢氏', 3, '0398', '472200', '中国,河南省,三门峡市,卢氏县', '111.04782', '34.05436', 'Lushi', 1);
INSERT INTO `provinces`
VALUES (411281, '义马市', 411200, '义马', 3, '0398', '472300', '中国,河南省,三门峡市,义马市', '111.87445', '34.74721', 'Yima', 1);
INSERT INTO `provinces`
VALUES (411282, '灵宝市', 411200, '灵宝', 3, '0398', '472500', '中国,河南省,三门峡市,灵宝市', '110.8945', '34.51682', 'Lingbao', 1);
INSERT INTO `provinces`
VALUES (411300, '南阳市', 410000, '南阳', 2, '0377', '473002', '中国,河南省,南阳市', '112.540918', '32.999082', 'Nanyang', 1);
INSERT INTO `provinces`
VALUES (411302, '宛城区', 411300, '宛城', 3, '0377', '473001', '中国,河南省,南阳市,宛城区', '112.53955', '33.00378', 'Wancheng', 1);
INSERT INTO `provinces`
VALUES (411303, '卧龙区', 411300, '卧龙', 3, '0377', '473003', '中国,河南省,南阳市,卧龙区', '112.53479', '32.98615', 'Wolong', 1);
INSERT INTO `provinces`
VALUES (411321, '南召县', 411300, '南召', 3, '0377', '474650', '中国,河南省,南阳市,南召县', '112.43194', '33.49098', 'Nanzhao', 1);
INSERT INTO `provinces`
VALUES (411322, '方城县', 411300, '方城', 3, '0377', '473200', '中国,河南省,南阳市,方城县', '113.01269', '33.25453', 'Fangcheng', 1);
INSERT INTO `provinces`
VALUES (411323, '西峡县', 411300, '西峡', 3, '0377', '474550', '中国,河南省,南阳市,西峡县', '111.48187', '33.29772', 'Xixia', 1);
INSERT INTO `provinces`
VALUES (411324, '镇平县', 411300, '镇平', 3, '0377', '474250', '中国,河南省,南阳市,镇平县', '112.2398', '33.03629', 'Zhenping', 1);
INSERT INTO `provinces`
VALUES (411325, '内乡县', 411300, '内乡', 3, '0377', '474350', '中国,河南省,南阳市,内乡县', '111.84957', '33.04671', 'Neixiang', 1);
INSERT INTO `provinces`
VALUES (411326, '淅川县', 411300, '淅川', 3, '0377', '474450', '中国,河南省,南阳市,淅川县', '111.48663', '33.13708', 'Xichuan', 1);
INSERT INTO `provinces`
VALUES (411327, '社旗县', 411300, '社旗', 3, '0377', '473300', '中国,河南省,南阳市,社旗县', '112.94656', '33.05503', 'Sheqi', 1);
INSERT INTO `provinces`
VALUES (411328, '唐河县', 411300, '唐河', 3, '0377', '473400', '中国,河南省,南阳市,唐河县', '112.83609', '32.69453', 'Tanghe', 1);
INSERT INTO `provinces`
VALUES (411329, '新野县', 411300, '新野', 3, '0377', '473500', '中国,河南省,南阳市,新野县', '112.36151', '32.51698', 'Xinye', 1);
INSERT INTO `provinces`
VALUES (411330, '桐柏县', 411300, '桐柏', 3, '0377', '474750', '中国,河南省,南阳市,桐柏县', '113.42886', '32.37917', 'Tongbai', 1);
INSERT INTO `provinces`
VALUES (411381, '邓州市', 411300, '邓州', 3, '0377', '474150', '中国,河南省,南阳市,邓州市', '112.0896', '32.68577', 'Dengzhou', 1);
INSERT INTO `provinces`
VALUES (411400, '商丘市', 410000, '商丘', 2, '0370', '476000', '中国,河南省,商丘市', '115.650497', '34.437054', 'Shangqiu', 1);
INSERT INTO `provinces`
VALUES (411402, '梁园区', 411400, '梁园', 3, '0370', '476000', '中国,河南省,商丘市,梁园区', '115.64487', '34.44341', 'Liangyuan', 1);
INSERT INTO `provinces`
VALUES (411403, '睢阳区', 411400, '睢阳', 3, '0370', '476100', '中国,河南省,商丘市,睢阳区', '115.65338', '34.38804', 'Suiyang', 1);
INSERT INTO `provinces`
VALUES (411421, '民权县', 411400, '民权', 3, '0370', '476800', '中国,河南省,商丘市,民权县', '115.14621', '34.64931', 'Minquan', 1);
INSERT INTO `provinces`
VALUES (411422, '睢县', 411400, '睢县', 3, '0370', '476900', '中国,河南省,商丘市,睢县', '115.07168', '34.44539', 'Suixian', 1);
INSERT INTO `provinces`
VALUES (411423, '宁陵县', 411400, '宁陵', 3, '0370', '476700', '中国,河南省,商丘市,宁陵县', '115.30511', '34.45463', 'Ningling', 1);
INSERT INTO `provinces`
VALUES (411424, '柘城县', 411400, '柘城', 3, '0370', '476200', '中国,河南省,商丘市,柘城县', '115.30538', '34.0911', 'Zhecheng', 1);
INSERT INTO `provinces`
VALUES (411425, '虞城县', 411400, '虞城', 3, '0370', '476300', '中国,河南省,商丘市,虞城县', '115.86337', '34.40189', 'Yucheng', 1);
INSERT INTO `provinces`
VALUES (411426, '夏邑县', 411400, '夏邑', 3, '0370', '476400', '中国,河南省,商丘市,夏邑县', '116.13348', '34.23242', 'Xiayi', 1);
INSERT INTO `provinces`
VALUES (411481, '永城市', 411400, '永城', 3, '0370', '476600', '中国,河南省,商丘市,永城市', '116.44943', '33.92911', 'Yongcheng', 1);
INSERT INTO `provinces`
VALUES (411500, '信阳市', 410000, '信阳', 2, '0376', '464000', '中国,河南省,信阳市', '114.075031', '32.123274', 'Xinyang', 1);
INSERT INTO `provinces`
VALUES (411502, '浉河区', 411500, '浉河', 3, '0376', '464000', '中国,河南省,信阳市,浉河区', '114.05871', '32.1168', 'Shihe', 1);
INSERT INTO `provinces`
VALUES (411503, '平桥区', 411500, '平桥', 3, '0376', '464100', '中国,河南省,信阳市,平桥区', '114.12435', '32.10095', 'Pingqiao', 1);
INSERT INTO `provinces`
VALUES (411521, '罗山县', 411500, '罗山', 3, '0376', '464200', '中国,河南省,信阳市,罗山县', '114.5314', '32.20277', 'Luoshan', 1);
INSERT INTO `provinces`
VALUES (411522, '光山县', 411500, '光山', 3, '0376', '465450', '中国,河南省,信阳市,光山县', '114.91873', '32.00992', 'Guangshan', 1);
INSERT INTO `provinces`
VALUES (411523, '新县', 411500, '新县', 3, '0376', '465550', '中国,河南省,信阳市,新县', '114.87924', '31.64386', 'Xinxian', 1);
INSERT INTO `provinces`
VALUES (411524, '商城县', 411500, '商城', 3, '0376', '465350', '中国,河南省,信阳市,商城县', '115.40856', '31.79986', 'Shangcheng', 1);
INSERT INTO `provinces`
VALUES (411525, '固始县', 411500, '固始', 3, '0376', '465250', '中国,河南省,信阳市,固始县', '115.68298', '32.18011', 'Gushi', 1);
INSERT INTO `provinces`
VALUES (411526, '潢川县', 411500, '潢川', 3, '0376', '465150', '中国,河南省,信阳市,潢川县', '115.04696', '32.13763', 'Huangchuan', 1);
INSERT INTO `provinces`
VALUES (411527, '淮滨县', 411500, '淮滨', 3, '0376', '464400', '中国,河南省,信阳市,淮滨县', '115.4205', '32.46614', 'Huaibin', 1);
INSERT INTO `provinces`
VALUES (411528, '息县', 411500, '息县', 3, '0376', '464300', '中国,河南省,信阳市,息县', '114.7402', '32.34279', 'Xixian', 1);
INSERT INTO `provinces`
VALUES (411600, '周口市', 410000, '周口', 2, '0394', '466000', '中国,河南省,周口市', '114.649653', '33.620357', 'Zhoukou', 1);
INSERT INTO `provinces`
VALUES (411602, '川汇区', 411600, '川汇', 3, '0394', '466000', '中国,河南省,周口市,川汇区', '114.64202', '33.6256', 'Chuanhui', 1);
INSERT INTO `provinces`
VALUES (411621, '扶沟县', 411600, '扶沟', 3, '0394', '461300', '中国,河南省,周口市,扶沟县', '114.39477', '34.05999', 'Fugou', 1);
INSERT INTO `provinces`
VALUES (411622, '西华县', 411600, '西华', 3, '0394', '466600', '中国,河南省,周口市,西华县', '114.52279', '33.78548', 'Xihua', 1);
INSERT INTO `provinces`
VALUES (411623, '商水县', 411600, '商水', 3, '0394', '466100', '中国,河南省,周口市,商水县', '114.60604', '33.53912', 'Shangshui', 1);
INSERT INTO `provinces`
VALUES (411624, '沈丘县', 411600, '沈丘', 3, '0394', '466300', '中国,河南省,周口市,沈丘县', '115.09851', '33.40936', 'Shenqiu', 1);
INSERT INTO `provinces`
VALUES (411625, '郸城县', 411600, '郸城', 3, '0394', '477150', '中国,河南省,周口市,郸城县', '115.17715', '33.64485', 'Dancheng', 1);
INSERT INTO `provinces`
VALUES (411626, '淮阳县', 411600, '淮阳', 3, '0394', '466700', '中国,河南省,周口市,淮阳县', '114.88848', '33.73211', 'Huaiyang', 1);
INSERT INTO `provinces`
VALUES (411627, '太康县', 411600, '太康', 3, '0394', '461400', '中国,河南省,周口市,太康县', '114.83773', '34.06376', 'Taikang', 1);
INSERT INTO `provinces`
VALUES (411628, '鹿邑县', 411600, '鹿邑', 3, '0394', '477200', '中国,河南省,周口市,鹿邑县', '115.48553', '33.85931', 'Luyi', 1);
INSERT INTO `provinces`
VALUES (411681, '项城市', 411600, '项城', 3, '0394', '466200', '中国,河南省,周口市,项城市', '114.87558', '33.4672', 'Xiangcheng', 1);
INSERT INTO `provinces`
VALUES (411700, '驻马店市', 410000, '驻马店', 2, '0396', '463000', '中国,河南省,驻马店市', '114.024736', '32.980169', 'Zhumadian', 1);
INSERT INTO `provinces`
VALUES (411702, '驿城区', 411700, '驿城', 3, '0396', '463000', '中国,河南省,驻马店市,驿城区', '113.99377', '32.97316', 'Yicheng', 1);
INSERT INTO `provinces`
VALUES (411721, '西平县', 411700, '西平', 3, '0396', '463900', '中国,河南省,驻马店市,西平县', '114.02322', '33.3845', 'Xiping', 1);
INSERT INTO `provinces`
VALUES (411722, '上蔡县', 411700, '上蔡', 3, '0396', '463800', '中国,河南省,驻马店市,上蔡县', '114.26825', '33.26825', 'Shangcai', 1);
INSERT INTO `provinces`
VALUES (411723, '平舆县', 411700, '平舆', 3, '0396', '463400', '中国,河南省,驻马店市,平舆县', '114.63552', '32.95727', 'Pingyu', 1);
INSERT INTO `provinces`
VALUES (411724, '正阳县', 411700, '正阳', 3, '0396', '463600', '中国,河南省,驻马店市,正阳县', '114.38952', '32.6039', 'Zhengyang', 1);
INSERT INTO `provinces`
VALUES (411725, '确山县', 411700, '确山', 3, '0396', '463200', '中国,河南省,驻马店市,确山县', '114.02917', '32.80281', 'Queshan', 1);
INSERT INTO `provinces`
VALUES (411726, '泌阳县', 411700, '泌阳', 3, '0396', '463700', '中国,河南省,驻马店市,泌阳县', '113.32681', '32.71781', 'Biyang', 1);
INSERT INTO `provinces`
VALUES (411727, '汝南县', 411700, '汝南', 3, '0396', '463300', '中国,河南省,驻马店市,汝南县', '114.36138', '33.00461', 'Runan', 1);
INSERT INTO `provinces`
VALUES (411728, '遂平县', 411700, '遂平', 3, '0396', '463100', '中国,河南省,驻马店市,遂平县', '114.01297', '33.14571', 'Suiping', 1);
INSERT INTO `provinces`
VALUES (411729, '新蔡县', 411700, '新蔡', 3, '0396', '463500', '中国,河南省,驻马店市,新蔡县', '114.98199', '32.7502', 'Xincai', 1);
INSERT INTO `provinces`
VALUES (419000, '直辖县级', 410000, ' ', 2, '', '', '中国,河南省,直辖县级', '113.665412', '34.757975', '', 1);
INSERT INTO `provinces`
VALUES (419001, '济源市', 419000, '济源', 3, '0391', '454650', '中国,河南省,直辖县级,济源市', '112.590047', '35.090378', 'Jiyuan', 1);
INSERT INTO `provinces`
VALUES (420000, '湖北省', 100000, '湖北', 1, '', '', '中国,湖北省', '114.298572', '30.584355', 'Hubei', 1);
INSERT INTO `provinces`
VALUES (420100, '武汉市', 420000, '武汉', 2, '', '430014', '中国,湖北省,武汉市', '114.298572', '30.584355', 'Wuhan', 1);
INSERT INTO `provinces`
VALUES (420102, '江岸区', 420100, '江岸', 3, '027', '430014', '中国,湖北省,武汉市,江岸区', '114.30943', '30.59982', 'Jiang\'an', 1);
INSERT INTO `provinces`
VALUES (420103, '江汉区', 420100, '江汉', 3, '027', '430021', '中国,湖北省,武汉市,江汉区', '114.27093', '30.60146', 'Jianghan', 1);
INSERT INTO `provinces`
VALUES (420104, '硚口区', 420100, '硚口', 3, '027', '430033', '中国,湖北省,武汉市,硚口区', '114.26422', '30.56945', 'Qiaokou', 1);
INSERT INTO `provinces`
VALUES (420105, '汉阳区', 420100, '汉阳', 3, '027', '430050', '中国,湖北省,武汉市,汉阳区', '114.27478', '30.54915', 'Hanyang', 1);
INSERT INTO `provinces`
VALUES (420106, '武昌区', 420100, '武昌', 3, '027', '430061', '中国,湖北省,武汉市,武昌区', '114.31589', '30.55389', 'Wuchang', 1);
INSERT INTO `provinces`
VALUES (420107, '青山区', 420100, '青山', 3, '027', '430080', '中国,湖北省,武汉市,青山区', '114.39117', '30.63427', 'Qingshan', 1);
INSERT INTO `provinces`
VALUES (420111, '洪山区', 420100, '洪山', 3, '027', '430070', '中国,湖北省,武汉市,洪山区', '114.34375', '30.49989', 'Hongshan', 1);
INSERT INTO `provinces`
VALUES (420112, '东西湖区', 420100, '东西湖', 3, '027', '430040', '中国,湖北省,武汉市,东西湖区', '114.13708', '30.61989', 'Dongxihu', 1);
INSERT INTO `provinces`
VALUES (420113, '汉南区', 420100, '汉南', 3, '027', '430090', '中国,湖北省,武汉市,汉南区', '114.08462', '30.30879', 'Hannan', 1);
INSERT INTO `provinces`
VALUES (420114, '蔡甸区', 420100, '蔡甸', 3, '027', '430100', '中国,湖北省,武汉市,蔡甸区', '114.02929', '30.58197', 'Caidian', 1);
INSERT INTO `provinces`
VALUES (420115, '江夏区', 420100, '江夏', 3, '027', '430200', '中国,湖北省,武汉市,江夏区', '114.31301', '30.34653', 'Jiangxia', 1);
INSERT INTO `provinces`
VALUES (420116, '黄陂区', 420100, '黄陂', 3, '027', '432200', '中国,湖北省,武汉市,黄陂区', '114.37512', '30.88151', 'Huangpi', 1);
INSERT INTO `provinces`
VALUES (420117, '新洲区', 420100, '新洲', 3, '027', '431400', '中国,湖北省,武汉市,新洲区', '114.80136', '30.84145', 'Xinzhou', 1);
INSERT INTO `provinces`
VALUES (420200, '黄石市', 420000, '黄石', 2, '0714', '435003', '中国,湖北省,黄石市', '115.077048', '30.220074', 'Huangshi', 1);
INSERT INTO `provinces`
VALUES (420202, '黄石港区', 420200, '黄石港', 3, '0714', '435000', '中国,湖北省,黄石市,黄石港区', '115.06604', '30.22279', 'Huangshigang',
        1);
INSERT INTO `provinces`
VALUES (420203, '西塞山区', 420200, '西塞山', 3, '0714', '435001', '中国,湖北省,黄石市,西塞山区', '115.11016', '30.20487', 'Xisaishan', 1);
INSERT INTO `provinces`
VALUES (420204, '下陆区', 420200, '下陆', 3, '0714', '435005', '中国,湖北省,黄石市,下陆区', '114.96112', '30.17368', 'Xialu', 1);
INSERT INTO `provinces`
VALUES (420205, '铁山区', 420200, '铁山', 3, '0714', '435006', '中国,湖北省,黄石市,铁山区', '114.90109', '30.20678', 'Tieshan', 1);
INSERT INTO `provinces`
VALUES (420222, '阳新县', 420200, '阳新', 3, '0714', '435200', '中国,湖北省,黄石市,阳新县', '115.21527', '29.83038', 'Yangxin', 1);
INSERT INTO `provinces`
VALUES (420281, '大冶市', 420200, '大冶', 3, '0714', '435100', '中国,湖北省,黄石市,大冶市', '114.97174', '30.09438', 'Daye', 1);
INSERT INTO `provinces`
VALUES (420300, '十堰市', 420000, '十堰', 2, '0719', '442000', '中国,湖北省,十堰市', '110.785239', '32.647017', 'Shiyan', 1);
INSERT INTO `provinces`
VALUES (420302, '茅箭区', 420300, '茅箭', 3, '0719', '442012', '中国,湖北省,十堰市,茅箭区', '110.81341', '32.59153', 'Maojian', 1);
INSERT INTO `provinces`
VALUES (420303, '张湾区', 420300, '张湾', 3, '0719', '442001', '中国,湖北省,十堰市,张湾区', '110.77067', '32.65195', 'Zhangwan', 1);
INSERT INTO `provinces`
VALUES (420304, '郧阳区', 420300, '郧阳', 3, '0719', '442500', '中国,湖北省,十堰市,郧阳区', '110.81854', '32.83593', 'Yunyang', 1);
INSERT INTO `provinces`
VALUES (420322, '郧西县', 420300, '郧西', 3, '0719', '442600', '中国,湖北省,十堰市,郧西县', '110.42556', '32.99349', 'Yunxi', 1);
INSERT INTO `provinces`
VALUES (420323, '竹山县', 420300, '竹山', 3, '0719', '442200', '中国,湖北省,十堰市,竹山县', '110.23071', '32.12636', 'Zhushan', 1);
INSERT INTO `provinces`
VALUES (420324, '竹溪县', 420300, '竹溪', 3, '0719', '442300', '中国,湖北省,十堰市,竹溪县', '109.71798', '32.31901', 'Zhuxi', 1);
INSERT INTO `provinces`
VALUES (420325, '房县', 420300, '房县', 3, '0719', '442100', '中国,湖北省,十堰市,房县', '110.74386', '32.05794', 'Fangxian', 1);
INSERT INTO `provinces`
VALUES (420381, '丹江口市', 420300, '丹江口', 3, '0719', '442700', '中国,湖北省,十堰市,丹江口市', '111.51525', '32.54085', 'Danjiangkou',
        1);
INSERT INTO `provinces`
VALUES (420500, '宜昌市', 420000, '宜昌', 2, '0717', '443000', '中国,湖北省,宜昌市', '111.290843', '30.702636', 'Yichang', 1);
INSERT INTO `provinces`
VALUES (420502, '西陵区', 420500, '西陵', 3, '0717', '443000', '中国,湖北省,宜昌市,西陵区', '111.28573', '30.71077', 'Xiling', 1);
INSERT INTO `provinces`
VALUES (420503, '伍家岗区', 420500, '伍家岗', 3, '0717', '443001', '中国,湖北省,宜昌市,伍家岗区', '111.3609', '30.64434', 'Wujiagang', 1);
INSERT INTO `provinces`
VALUES (420504, '点军区', 420500, '点军', 3, '0717', '443006', '中国,湖北省,宜昌市,点军区', '111.26828', '30.6934', 'Dianjun', 1);
INSERT INTO `provinces`
VALUES (420505, '猇亭区', 420500, '猇亭', 3, '0717', '443007', '中国,湖北省,宜昌市,猇亭区', '111.44079', '30.52663', 'Xiaoting', 1);
INSERT INTO `provinces`
VALUES (420506, '夷陵区', 420500, '夷陵', 3, '0717', '443100', '中国,湖北省,宜昌市,夷陵区', '111.3262', '30.76881', 'Yiling', 1);
INSERT INTO `provinces`
VALUES (420525, '远安县', 420500, '远安', 3, '0717', '444200', '中国,湖北省,宜昌市,远安县', '111.6416', '31.05989', 'Yuan\'an', 1);
INSERT INTO `provinces`
VALUES (420526, '兴山县', 420500, '兴山', 3, '0717', '443711', '中国,湖北省,宜昌市,兴山县', '110.74951', '31.34686', 'Xingshan', 1);
INSERT INTO `provinces`
VALUES (420527, '秭归县', 420500, '秭归', 3, '0717', '443600', '中国,湖北省,宜昌市,秭归县', '110.98156', '30.82702', 'Zigui', 1);
INSERT INTO `provinces`
VALUES (420528, '长阳土家族自治县', 420500, '长阳', 3, '0717', '443500', '中国,湖北省,宜昌市,长阳土家族自治县', '111.20105', '30.47052',
        'Changyang', 1);
INSERT INTO `provinces`
VALUES (420529, '五峰土家族自治县', 420500, '五峰', 3, '0717', '443413', '中国,湖北省,宜昌市,五峰土家族自治县', '110.6748', '30.19856', 'Wufeng',
        1);
INSERT INTO `provinces`
VALUES (420581, '宜都市', 420500, '宜都', 3, '0717', '443300', '中国,湖北省,宜昌市,宜都市', '111.45025', '30.37807', 'Yidu', 1);
INSERT INTO `provinces`
VALUES (420582, '当阳市', 420500, '当阳', 3, '0717', '444100', '中国,湖北省,宜昌市,当阳市', '111.78912', '30.8208', 'Dangyang', 1);
INSERT INTO `provinces`
VALUES (420583, '枝江市', 420500, '枝江', 3, '0717', '443200', '中国,湖北省,宜昌市,枝江市', '111.76855', '30.42612', 'Zhijiang', 1);
INSERT INTO `provinces`
VALUES (420600, '襄阳市', 420000, '襄阳', 2, '0710', '441021', '中国,湖北省,襄阳市', '112.144146', '32.042426', 'Xiangyang', 1);
INSERT INTO `provinces`
VALUES (420602, '襄城区', 420600, '襄城', 3, '0710', '441021', '中国,湖北省,襄阳市,襄城区', '112.13372', '32.01017', 'Xiangcheng', 1);
INSERT INTO `provinces`
VALUES (420606, '樊城区', 420600, '樊城', 3, '0710', '441001', '中国,湖北省,襄阳市,樊城区', '112.13546', '32.04482', 'Fancheng', 1);
INSERT INTO `provinces`
VALUES (420607, '襄州区', 420600, '襄州', 3, '0710', '441100', '中国,湖北省,襄阳市,襄州区', '112.150327', '32.015088', 'Xiangzhou', 1);
INSERT INTO `provinces`
VALUES (420624, '南漳县', 420600, '南漳', 3, '0710', '441500', '中国,湖北省,襄阳市,南漳县', '111.84603', '31.77653', 'Nanzhang', 1);
INSERT INTO `provinces`
VALUES (420625, '谷城县', 420600, '谷城', 3, '0710', '441700', '中国,湖北省,襄阳市,谷城县', '111.65267', '32.26377', 'Gucheng', 1);
INSERT INTO `provinces`
VALUES (420626, '保康县', 420600, '保康', 3, '0710', '441600', '中国,湖北省,襄阳市,保康县', '111.26138', '31.87874', 'Baokang', 1);
INSERT INTO `provinces`
VALUES (420682, '老河口市', 420600, '老河口', 3, '0710', '441800', '中国,湖北省,襄阳市,老河口市', '111.67117', '32.38476', 'Laohekou', 1);
INSERT INTO `provinces`
VALUES (420683, '枣阳市', 420600, '枣阳', 3, '0710', '441200', '中国,湖北省,襄阳市,枣阳市', '112.77444', '32.13142', 'Zaoyang', 1);
INSERT INTO `provinces`
VALUES (420684, '宜城市', 420600, '宜城', 3, '0710', '441400', '中国,湖北省,襄阳市,宜城市', '112.25772', '31.71972', 'Yicheng', 1);
INSERT INTO `provinces`
VALUES (420700, '鄂州市', 420000, '鄂州', 2, '0711', '436000', '中国,湖北省,鄂州市', '114.890593', '30.396536', 'Ezhou', 1);
INSERT INTO `provinces`
VALUES (420702, '梁子湖区', 420700, '梁子湖', 3, '0711', '436064', '中国,湖北省,鄂州市,梁子湖区', '114.68463', '30.10003', 'Liangzihu', 1);
INSERT INTO `provinces`
VALUES (420703, '华容区', 420700, '华容', 3, '0711', '436030', '中国,湖北省,鄂州市,华容区', '114.73568', '30.53328', 'Huarong', 1);
INSERT INTO `provinces`
VALUES (420704, '鄂城区', 420700, '鄂城', 3, '0711', '436000', '中国,湖北省,鄂州市,鄂城区', '114.89158', '30.40024', 'Echeng', 1);
INSERT INTO `provinces`
VALUES (420800, '荆门市', 420000, '荆门', 2, '0724', '448000', '中国,湖北省,荆门市', '112.204251', '31.03542', 'Jingmen', 1);
INSERT INTO `provinces`
VALUES (420802, '东宝区', 420800, '东宝', 3, '0724', '448004', '中国,湖北省,荆门市,东宝区', '112.20147', '31.05192', 'Dongbao', 1);
INSERT INTO `provinces`
VALUES (420804, '掇刀区', 420800, '掇刀', 3, '0724', '448124', '中国,湖北省,荆门市,掇刀区', '112.208', '30.97316', 'Duodao', 1);
INSERT INTO `provinces`
VALUES (420821, '京山县', 420800, '京山', 3, '0724', '431800', '中国,湖北省,荆门市,京山县', '113.11074', '31.0224', 'Jingshan', 1);
INSERT INTO `provinces`
VALUES (420822, '沙洋县', 420800, '沙洋', 3, '0724', '448200', '中国,湖北省,荆门市,沙洋县', '112.58853', '30.70916', 'Shayang', 1);
INSERT INTO `provinces`
VALUES (420881, '钟祥市', 420800, '钟祥', 3, '0724', '431900', '中国,湖北省,荆门市,钟祥市', '112.58932', '31.1678', 'Zhongxiang', 1);
INSERT INTO `provinces`
VALUES (420900, '孝感市', 420000, '孝感', 2, '0712', '432100', '中国,湖北省,孝感市', '113.926655', '30.926423', 'Xiaogan', 1);
INSERT INTO `provinces`
VALUES (420902, '孝南区', 420900, '孝南', 3, '0712', '432100', '中国,湖北省,孝感市,孝南区', '113.91111', '30.9168', 'Xiaonan', 1);
INSERT INTO `provinces`
VALUES (420921, '孝昌县', 420900, '孝昌', 3, '0712', '432900', '中国,湖北省,孝感市,孝昌县', '113.99795', '31.25799', 'Xiaochang', 1);
INSERT INTO `provinces`
VALUES (420922, '大悟县', 420900, '大悟', 3, '0712', '432800', '中国,湖北省,孝感市,大悟县', '114.12564', '31.56176', 'Dawu', 1);
INSERT INTO `provinces`
VALUES (420923, '云梦县', 420900, '云梦', 3, '0712', '432500', '中国,湖北省,孝感市,云梦县', '113.75289', '31.02093', 'Yunmeng', 1);
INSERT INTO `provinces`
VALUES (420981, '应城市', 420900, '应城', 3, '0712', '432400', '中国,湖北省,孝感市,应城市', '113.57287', '30.92834', 'Yingcheng', 1);
INSERT INTO `provinces`
VALUES (420982, '安陆市', 420900, '安陆', 3, '0712', '432600', '中国,湖北省,孝感市,安陆市', '113.68557', '31.25693', 'Anlu', 1);
INSERT INTO `provinces`
VALUES (420984, '汉川市', 420900, '汉川', 3, '0712', '432300', '中国,湖北省,孝感市,汉川市', '113.83898', '30.66117', 'Hanchuan', 1);
INSERT INTO `provinces`
VALUES (421000, '荆州市', 420000, '荆州', 2, '0716', '434000', '中国,湖北省,荆州市', '112.23813', '30.326857', 'Jingzhou', 1);
INSERT INTO `provinces`
VALUES (421002, '沙市区', 421000, '沙市', 3, '0716', '434000', '中国,湖北省,荆州市,沙市区', '112.25543', '30.31107', 'Shashi', 1);
INSERT INTO `provinces`
VALUES (421003, '荆州区', 421000, '荆州', 3, '0716', '434020', '中国,湖北省,荆州市,荆州区', '112.19006', '30.35264', 'Jingzhou', 1);
INSERT INTO `provinces`
VALUES (421022, '公安县', 421000, '公安', 3, '0716', '434300', '中国,湖北省,荆州市,公安县', '112.23242', '30.05902', 'Gong\'an', 1);
INSERT INTO `provinces`
VALUES (421023, '监利县', 421000, '监利', 3, '0716', '433300', '中国,湖北省,荆州市,监利县', '112.89462', '29.81494', 'Jianli', 1);
INSERT INTO `provinces`
VALUES (421024, '江陵县', 421000, '江陵', 3, '0716', '434101', '中国,湖北省,荆州市,江陵县', '112.42468', '30.04174', 'Jiangling', 1);
INSERT INTO `provinces`
VALUES (421081, '石首市', 421000, '石首', 3, '0716', '434400', '中国,湖北省,荆州市,石首市', '112.42636', '29.72127', 'Shishou', 1);
INSERT INTO `provinces`
VALUES (421083, '洪湖市', 421000, '洪湖', 3, '0716', '433200', '中国,湖北省,荆州市,洪湖市', '113.47598', '29.827', 'Honghu', 1);
INSERT INTO `provinces`
VALUES (421087, '松滋市', 421000, '松滋', 3, '0716', '434200', '中国,湖北省,荆州市,松滋市', '111.76739', '30.16965', 'Songzi', 1);
INSERT INTO `provinces`
VALUES (421100, '黄冈市', 420000, '黄冈', 2, '0713', '438000', '中国,湖北省,黄冈市', '114.879365', '30.447711', 'Huanggang', 1);
INSERT INTO `provinces`
VALUES (421102, '黄州区', 421100, '黄州', 3, '0713', '438000', '中国,湖北省,黄冈市,黄州区', '114.88008', '30.43436', 'Huangzhou', 1);
INSERT INTO `provinces`
VALUES (421121, '团风县', 421100, '团风', 3, '0713', '438800', '中国,湖北省,黄冈市,团风县', '114.87228', '30.64359', 'Tuanfeng', 1);
INSERT INTO `provinces`
VALUES (421122, '红安县', 421100, '红安', 3, '0713', '438401', '中国,湖北省,黄冈市,红安县', '114.6224', '31.28668', 'Hong\'an', 1);
INSERT INTO `provinces`
VALUES (421123, '罗田县', 421100, '罗田', 3, '0713', '438600', '中国,湖北省,黄冈市,罗田县', '115.39971', '30.78255', 'Luotian', 1);
INSERT INTO `provinces`
VALUES (421124, '英山县', 421100, '英山', 3, '0713', '438700', '中国,湖北省,黄冈市,英山县', '115.68142', '30.73516', 'Yingshan', 1);
INSERT INTO `provinces`
VALUES (421125, '浠水县', 421100, '浠水', 3, '0713', '438200', '中国,湖北省,黄冈市,浠水县', '115.26913', '30.45265', 'Xishui', 1);
INSERT INTO `provinces`
VALUES (421126, '蕲春县', 421100, '蕲春', 3, '0713', '435300', '中国,湖北省,黄冈市,蕲春县', '115.43615', '30.22613', 'Qichun', 1);
INSERT INTO `provinces`
VALUES (421127, '黄梅县', 421100, '黄梅', 3, '0713', '435500', '中国,湖北省,黄冈市,黄梅县', '115.94427', '30.07033', 'Huangmei', 1);
INSERT INTO `provinces`
VALUES (421181, '麻城市', 421100, '麻城', 3, '0713', '438300', '中国,湖北省,黄冈市,麻城市', '115.00988', '31.17228', 'Macheng', 1);
INSERT INTO `provinces`
VALUES (421182, '武穴市', 421100, '武穴', 3, '0713', '435400', '中国,湖北省,黄冈市,武穴市', '115.55975', '29.84446', 'Wuxue', 1);
INSERT INTO `provinces`
VALUES (421200, '咸宁市', 420000, '咸宁', 2, '0715', '437000', '中国,湖北省,咸宁市', '114.328963', '29.832798', 'Xianning', 1);
INSERT INTO `provinces`
VALUES (421202, '咸安区', 421200, '咸安', 3, '0715', '437000', '中国,湖北省,咸宁市,咸安区', '114.29872', '29.8529', 'Xian\'an', 1);
INSERT INTO `provinces`
VALUES (421221, '嘉鱼县', 421200, '嘉鱼', 3, '0715', '437200', '中国,湖北省,咸宁市,嘉鱼县', '113.93927', '29.97054', 'Jiayu', 1);
INSERT INTO `provinces`
VALUES (421222, '通城县', 421200, '通城', 3, '0715', '437400', '中国,湖北省,咸宁市,通城县', '113.81582', '29.24568', 'Tongcheng', 1);
INSERT INTO `provinces`
VALUES (421223, '崇阳县', 421200, '崇阳', 3, '0715', '437500', '中国,湖北省,咸宁市,崇阳县', '114.03982', '29.55564', 'Chongyang', 1);
INSERT INTO `provinces`
VALUES (421224, '通山县', 421200, '通山', 3, '0715', '437600', '中国,湖北省,咸宁市,通山县', '114.48239', '29.6063', 'Tongshan', 1);
INSERT INTO `provinces`
VALUES (421281, '赤壁市', 421200, '赤壁', 3, '0715', '437300', '中国,湖北省,咸宁市,赤壁市', '113.90039', '29.72454', 'Chibi', 1);
INSERT INTO `provinces`
VALUES (421300, '随州市', 420000, '随州', 2, '0722', '441300', '中国,湖北省,随州市', '113.37377', '31.717497', 'Suizhou', 1);
INSERT INTO `provinces`
VALUES (421303, '曾都区', 421300, '曾都', 3, '0722', '441300', '中国,湖北省,随州市,曾都区', '113.37128', '31.71614', 'Zengdu', 1);
INSERT INTO `provinces`
VALUES (421321, '随县', 421300, '随县', 3, '0722', '441309', '中国,湖北省,随州市,随县', '113.82663', '31.6179', 'Suixian', 1);
INSERT INTO `provinces`
VALUES (421381, '广水市', 421300, '广水', 3, '0722', '432700', '中国,湖北省,随州市,广水市', '113.82663', '31.6179', 'Guangshui', 1);
INSERT INTO `provinces`
VALUES (422800, '恩施土家族苗族自治州', 420000, '恩施', 2, '0718', '445000', '中国,湖北省,恩施土家族苗族自治州', '109.48699', '30.283114', 'Enshi',
        1);
INSERT INTO `provinces`
VALUES (422801, '恩施市', 422800, '恩施', 3, '0718', '445000', '中国,湖北省,恩施土家族苗族自治州,恩施市', '109.47942', '30.29502', 'Enshi', 1);
INSERT INTO `provinces`
VALUES (422802, '利川市', 422800, '利川', 3, '0718', '445400', '中国,湖北省,恩施土家族苗族自治州,利川市', '108.93591', '30.29117', 'Lichuan',
        1);
INSERT INTO `provinces`
VALUES (422822, '建始县', 422800, '建始', 3, '0718', '445300', '中国,湖北省,恩施土家族苗族自治州,建始县', '109.72207', '30.60209', 'Jianshi',
        1);
INSERT INTO `provinces`
VALUES (422823, '巴东县', 422800, '巴东', 3, '0718', '444300', '中国,湖北省,恩施土家族苗族自治州,巴东县', '110.34066', '31.04233', 'Badong',
        1);
INSERT INTO `provinces`
VALUES (422825, '宣恩县', 422800, '宣恩', 3, '0718', '445500', '中国,湖北省,恩施土家族苗族自治州,宣恩县', '109.49179', '29.98714', 'Xuanen',
        1);
INSERT INTO `provinces`
VALUES (422826, '咸丰县', 422800, '咸丰', 3, '0718', '445600', '中国,湖北省,恩施土家族苗族自治州,咸丰县', '109.152', '29.67983', 'Xianfeng',
        1);
INSERT INTO `provinces`
VALUES (422827, '来凤县', 422800, '来凤', 3, '0718', '445700', '中国,湖北省,恩施土家族苗族自治州,来凤县', '109.40716', '29.49373', 'Laifeng',
        1);
INSERT INTO `provinces`
VALUES (422828, '鹤峰县', 422800, '鹤峰', 3, '0718', '445800', '中国,湖北省,恩施土家族苗族自治州,鹤峰县', '110.03091', '29.89072', 'Hefeng',
        1);
INSERT INTO `provinces`
VALUES (429000, '直辖县级', 420000, ' ', 2, '', '', '中国,湖北省,直辖县级', '114.298572', '30.584355', '', 1);
INSERT INTO `provinces`
VALUES (429004, '仙桃市', 429000, '仙桃', 3, '0728', '433000', '中国,湖北省,直辖县级,仙桃市', '113.453974', '30.364953', 'Xiantao', 1);
INSERT INTO `provinces`
VALUES (429005, '潜江市', 429000, '潜江', 3, '0728', '433100', '中国,湖北省,直辖县级,潜江市', '112.896866', '30.421215', 'Qianjiang', 1);
INSERT INTO `provinces`
VALUES (429006, '天门市', 429000, '天门', 3, '0728', '431700', '中国,湖北省,直辖县级,天门市', '113.165862', '30.653061', 'Tianmen', 1);
INSERT INTO `provinces`
VALUES (429021, '神农架林区', 429000, '神农架', 3, '0719', '442400', '中国,湖北省,直辖县级,神农架林区', '110.671525', '31.744449',
        'Shennongjia', 1);
INSERT INTO `provinces`
VALUES (430000, '湖南省', 100000, '湖南', 1, '', '', '中国,湖南省', '112.982279', '28.19409', 'Hunan', 1);
INSERT INTO `provinces`
VALUES (430100, '长沙市', 430000, '长沙', 2, '0731', '410005', '中国,湖南省,长沙市', '112.982279', '28.19409', 'Changsha', 1);
INSERT INTO `provinces`
VALUES (430102, '芙蓉区', 430100, '芙蓉', 3, '0731', '410011', '中国,湖南省,长沙市,芙蓉区', '113.03176', '28.1844', 'Furong', 1);
INSERT INTO `provinces`
VALUES (430103, '天心区', 430100, '天心', 3, '0731', '410004', '中国,湖南省,长沙市,天心区', '112.98991', '28.1127', 'Tianxin', 1);
INSERT INTO `provinces`
VALUES (430104, '岳麓区', 430100, '岳麓', 3, '0731', '410013', '中国,湖南省,长沙市,岳麓区', '112.93133', '28.2351', 'Yuelu', 1);
INSERT INTO `provinces`
VALUES (430105, '开福区', 430100, '开福', 3, '0731', '410008', '中国,湖南省,长沙市,开福区', '112.98623', '28.25585', 'Kaifu', 1);
INSERT INTO `provinces`
VALUES (430111, '雨花区', 430100, '雨花', 3, '0731', '410011', '中国,湖南省,长沙市,雨花区', '113.03567', '28.13541', 'Yuhua', 1);
INSERT INTO `provinces`
VALUES (430112, '望城区', 430100, '望城', 3, '0731', '410200', '中国,湖南省,长沙市,望城区', '112.819549', '28.347458', 'Wangcheng', 1);
INSERT INTO `provinces`
VALUES (430121, '长沙县', 430100, '长沙', 3, '0731', '410100', '中国,湖南省,长沙市,长沙县', '113.08071', '28.24595', 'Changsha', 1);
INSERT INTO `provinces`
VALUES (430124, '宁乡县', 430100, '宁乡', 3, '0731', '410600', '中国,湖南省,长沙市,宁乡县', '112.55749', '28.25358', 'Ningxiang', 1);
INSERT INTO `provinces`
VALUES (430126, '炎陵县', 430200, '炎陵', 3, '0731', '412500', '中国,湖南省,株洲市,炎陵县', '113.77163', '26.48818', 'Yanling', 1);
INSERT INTO `provinces`
VALUES (430181, '浏阳市', 430100, '浏阳', 3, '0731', '410300', '中国,湖南省,长沙市,浏阳市', '113.64312', '28.16375', 'Liuyang', 1);
INSERT INTO `provinces`
VALUES (430200, '株洲市', 430000, '株洲', 2, '0731', '412000', '中国,湖南省,株洲市', '113.151737', '27.835806', 'Zhuzhou', 1);
INSERT INTO `provinces`
VALUES (430202, '荷塘区', 430200, '荷塘', 3, '0731', '412000', '中国,湖南省,株洲市,荷塘区', '113.17315', '27.85569', 'Hetang', 1);
INSERT INTO `provinces`
VALUES (430203, '芦淞区', 430200, '芦淞', 3, '0731', '412000', '中国,湖南省,株洲市,芦淞区', '113.15562', '27.78525', 'Lusong', 1);
INSERT INTO `provinces`
VALUES (430204, '石峰区', 430200, '石峰', 3, '0731', '412005', '中国,湖南省,株洲市,石峰区', '113.11776', '27.87552', 'Shifeng', 1);
INSERT INTO `provinces`
VALUES (430211, '天元区', 430200, '天元', 3, '0731', '412007', '中国,湖南省,株洲市,天元区', '113.12335', '27.83103', 'Tianyuan', 1);
INSERT INTO `provinces`
VALUES (430221, '株洲县', 430200, '株洲', 3, '0731', '412100', '中国,湖南省,株洲市,株洲县', '113.14428', '27.69826', 'Zhuzhou', 1);
INSERT INTO `provinces`
VALUES (430223, '攸县', 430200, '攸县', 3, '0731', '412300', '中国,湖南省,株洲市,攸县', '113.34365', '27.00352', 'Youxian', 1);
INSERT INTO `provinces`
VALUES (430224, '茶陵县', 430200, '茶陵', 3, '0731', '412400', '中国,湖南省,株洲市,茶陵县', '113.54364', '26.7915', 'Chaling', 1);
INSERT INTO `provinces`
VALUES (430281, '醴陵市', 430200, '醴陵', 3, '0731', '412200', '中国,湖南省,株洲市,醴陵市', '113.49704', '27.64615', 'Liling', 1);
INSERT INTO `provinces`
VALUES (430300, '湘潭市', 430000, '湘潭', 2, '0731', '411100', '中国,湖南省,湘潭市', '112.925083', '27.846725', 'Xiangtan', 1);
INSERT INTO `provinces`
VALUES (430302, '雨湖区', 430300, '雨湖', 3, '0731', '411100', '中国,湖南省,湘潭市,雨湖区', '112.90399', '27.86859', 'Yuhu', 1);
INSERT INTO `provinces`
VALUES (430304, '岳塘区', 430300, '岳塘', 3, '0731', '411101', '中国,湖南省,湘潭市,岳塘区', '112.9606', '27.85784', 'Yuetang', 1);
INSERT INTO `provinces`
VALUES (430321, '湘潭县', 430300, '湘潭', 3, '0731', '411228', '中国,湖南省,湘潭市,湘潭县', '112.9508', '27.77893', 'Xiangtan', 1);
INSERT INTO `provinces`
VALUES (430381, '湘乡市', 430300, '湘乡', 3, '0731', '411400', '中国,湖南省,湘潭市,湘乡市', '112.53512', '27.73543', 'Xiangxiang', 1);
INSERT INTO `provinces`
VALUES (430382, '韶山市', 430300, '韶山', 3, '0731', '411300', '中国,湖南省,湘潭市,韶山市', '112.52655', '27.91503', 'Shaoshan', 1);
INSERT INTO `provinces`
VALUES (430400, '衡阳市', 430000, '衡阳', 2, '0734', '421001', '中国,湖南省,衡阳市', '112.607693', '26.900358', 'Hengyang', 1);
INSERT INTO `provinces`
VALUES (430405, '珠晖区', 430400, '珠晖', 3, '0734', '421002', '中国,湖南省,衡阳市,珠晖区', '112.62054', '26.89361', 'Zhuhui', 1);
INSERT INTO `provinces`
VALUES (430406, '雁峰区', 430400, '雁峰', 3, '0734', '421001', '中国,湖南省,衡阳市,雁峰区', '112.61654', '26.88866', 'Yanfeng', 1);
INSERT INTO `provinces`
VALUES (430407, '石鼓区', 430400, '石鼓', 3, '0734', '421005', '中国,湖南省,衡阳市,石鼓区', '112.61069', '26.90232', 'Shigu', 1);
INSERT INTO `provinces`
VALUES (430408, '蒸湘区', 430400, '蒸湘', 3, '0734', '421001', '中国,湖南省,衡阳市,蒸湘区', '112.6033', '26.89651', 'Zhengxiang', 1);
INSERT INTO `provinces`
VALUES (430412, '南岳区', 430400, '南岳', 3, '0734', '421900', '中国,湖南省,衡阳市,南岳区', '112.7384', '27.23262', 'Nanyue', 1);
INSERT INTO `provinces`
VALUES (430421, '衡阳县', 430400, '衡阳', 3, '0734', '421200', '中国,湖南省,衡阳市,衡阳县', '112.37088', '26.9706', 'Hengyang', 1);
INSERT INTO `provinces`
VALUES (430422, '衡南县', 430400, '衡南', 3, '0734', '421131', '中国,湖南省,衡阳市,衡南县', '112.67788', '26.73828', 'Hengnan', 1);
INSERT INTO `provinces`
VALUES (430423, '衡山县', 430400, '衡山', 3, '0734', '421300', '中国,湖南省,衡阳市,衡山县', '112.86776', '27.23134', 'Hengshan', 1);
INSERT INTO `provinces`
VALUES (430424, '衡东县', 430400, '衡东', 3, '0734', '421400', '中国,湖南省,衡阳市,衡东县', '112.94833', '27.08093', 'Hengdong', 1);
INSERT INTO `provinces`
VALUES (430426, '祁东县', 430400, '祁东', 3, '0734', '421600', '中国,湖南省,衡阳市,祁东县', '112.09039', '26.79964', 'Qidong', 1);
INSERT INTO `provinces`
VALUES (430481, '耒阳市', 430400, '耒阳', 3, '0734', '421800', '中国,湖南省,衡阳市,耒阳市', '112.85998', '26.42132', 'Leiyang', 1);
INSERT INTO `provinces`
VALUES (430482, '常宁市', 430400, '常宁', 3, '0734', '421500', '中国,湖南省,衡阳市,常宁市', '112.4009', '26.40692', 'Changning', 1);
INSERT INTO `provinces`
VALUES (430500, '邵阳市', 430000, '邵阳', 2, '0739', '422000', '中国,湖南省,邵阳市', '111.46923', '27.237842', 'Shaoyang', 1);
INSERT INTO `provinces`
VALUES (430502, '双清区', 430500, '双清', 3, '0739', '422001', '中国,湖南省,邵阳市,双清区', '111.49715', '27.23291', 'Shuangqing', 1);
INSERT INTO `provinces`
VALUES (430503, '大祥区', 430500, '大祥', 3, '0739', '422000', '中国,湖南省,邵阳市,大祥区', '111.45412', '27.23332', 'Daxiang', 1);
INSERT INTO `provinces`
VALUES (430511, '北塔区', 430500, '北塔', 3, '0739', '422007', '中国,湖南省,邵阳市,北塔区', '111.45219', '27.24648', 'Beita', 1);
INSERT INTO `provinces`
VALUES (430521, '邵东县', 430500, '邵东', 3, '0739', '422800', '中国,湖南省,邵阳市,邵东县', '111.74441', '27.2584', 'Shaodong', 1);
INSERT INTO `provinces`
VALUES (430522, '新邵县', 430500, '新邵', 3, '0739', '422900', '中国,湖南省,邵阳市,新邵县', '111.46066', '27.32169', 'Xinshao', 1);
INSERT INTO `provinces`
VALUES (430523, '邵阳县', 430500, '邵阳', 3, '0739', '422100', '中国,湖南省,邵阳市,邵阳县', '111.27459', '26.99143', 'Shaoyang', 1);
INSERT INTO `provinces`
VALUES (430524, '隆回县', 430500, '隆回', 3, '0739', '422200', '中国,湖南省,邵阳市,隆回县', '111.03216', '27.10937', 'Longhui', 1);
INSERT INTO `provinces`
VALUES (430525, '洞口县', 430500, '洞口', 3, '0739', '422300', '中国,湖南省,邵阳市,洞口县', '110.57388', '27.05462', 'Dongkou', 1);
INSERT INTO `provinces`
VALUES (430527, '绥宁县', 430500, '绥宁', 3, '0739', '422600', '中国,湖南省,邵阳市,绥宁县', '110.15576', '26.58636', 'Suining', 1);
INSERT INTO `provinces`
VALUES (430528, '新宁县', 430500, '新宁', 3, '0739', '422700', '中国,湖南省,邵阳市,新宁县', '110.85131', '26.42936', 'Xinning', 1);
INSERT INTO `provinces`
VALUES (430529, '城步苗族自治县', 430500, '城步', 3, '0739', '412600', '中国,湖南省,邵阳市,城步苗族自治县', '110.3222', '26.39048', 'Chengbu',
        1);
INSERT INTO `provinces`
VALUES (430581, '武冈市', 430500, '武冈', 3, '0739', '422400', '中国,湖南省,邵阳市,武冈市', '110.63281', '26.72817', 'Wugang', 1);
INSERT INTO `provinces`
VALUES (430600, '岳阳市', 430000, '岳阳', 2, '0730', '414000', '中国,湖南省,岳阳市', '113.132855', '29.37029', 'Yueyang', 1);
INSERT INTO `provinces`
VALUES (430602, '岳阳楼区', 430600, '岳阳楼', 3, '0730', '414000', '中国,湖南省,岳阳市,岳阳楼区', '113.12942', '29.3719', 'Yueyanglou', 1);
INSERT INTO `provinces`
VALUES (430603, '云溪区', 430600, '云溪', 3, '0730', '414009', '中国,湖南省,岳阳市,云溪区', '113.27713', '29.47357', 'Yunxi', 1);
INSERT INTO `provinces`
VALUES (430611, '君山区', 430600, '君山', 3, '0730', '414005', '中国,湖南省,岳阳市,君山区', '113.00439', '29.45941', 'Junshan', 1);
INSERT INTO `provinces`
VALUES (430621, '岳阳县', 430600, '岳阳', 3, '0730', '414100', '中国,湖南省,岳阳市,岳阳县', '113.11987', '29.14314', 'Yueyang', 1);
INSERT INTO `provinces`
VALUES (430623, '华容县', 430600, '华容', 3, '0730', '414200', '中国,湖南省,岳阳市,华容县', '112.54089', '29.53019', 'Huarong', 1);
INSERT INTO `provinces`
VALUES (430624, '湘阴县', 430600, '湘阴', 3, '0730', '414600', '中国,湖南省,岳阳市,湘阴县', '112.90911', '28.68922', 'Xiangyin', 1);
INSERT INTO `provinces`
VALUES (430626, '平江县', 430600, '平江', 3, '0730', '414500', '中国,湖南省,岳阳市,平江县', '113.58105', '28.70664', 'Pingjiang', 1);
INSERT INTO `provinces`
VALUES (430681, '汨罗市', 430600, '汨罗', 3, '0730', '414400', '中国,湖南省,岳阳市,汨罗市', '113.06707', '28.80631', 'Miluo', 1);
INSERT INTO `provinces`
VALUES (430682, '临湘市', 430600, '临湘', 3, '0730', '414300', '中国,湖南省,岳阳市,临湘市', '113.4501', '29.47701', 'Linxiang', 1);
INSERT INTO `provinces`
VALUES (430700, '常德市', 430000, '常德', 2, '0736', '415000', '中国,湖南省,常德市', '111.691347', '29.040126', 'Changde', 1);
INSERT INTO `provinces`
VALUES (430702, '武陵区', 430700, '武陵', 3, '0736', '415000', '中国,湖南省,常德市,武陵区', '111.69791', '29.02876', 'Wuling', 1);
INSERT INTO `provinces`
VALUES (430703, '鼎城区', 430700, '鼎城', 3, '0736', '415101', '中国,湖南省,常德市,鼎城区', '111.68078', '29.01859', 'Dingcheng', 1);
INSERT INTO `provinces`
VALUES (430721, '安乡县', 430700, '安乡', 3, '0736', '415600', '中国,湖南省,常德市,安乡县', '112.16732', '29.41326', 'Anxiang', 1);
INSERT INTO `provinces`
VALUES (430722, '汉寿县', 430700, '汉寿', 3, '0736', '415900', '中国,湖南省,常德市,汉寿县', '111.96691', '28.90299', 'Hanshou', 1);
INSERT INTO `provinces`
VALUES (430723, '澧县', 430700, '澧县', 3, '0736', '415500', '中国,湖南省,常德市,澧县', '111.75866', '29.63317', 'Lixian', 1);
INSERT INTO `provinces`
VALUES (430724, '临澧县', 430700, '临澧', 3, '0736', '415200', '中国,湖南省,常德市,临澧县', '111.65161', '29.44163', 'Linli', 1);
INSERT INTO `provinces`
VALUES (430725, '桃源县', 430700, '桃源', 3, '0736', '415700', '中国,湖南省,常德市,桃源县', '111.48892', '28.90474', 'Taoyuan', 1);
INSERT INTO `provinces`
VALUES (430726, '石门县', 430700, '石门', 3, '0736', '415300', '中国,湖南省,常德市,石门县', '111.37966', '29.58424', 'Shimen', 1);
INSERT INTO `provinces`
VALUES (430781, '津市市', 430700, '津市', 3, '0736', '415400', '中国,湖南省,常德市,津市市', '111.87756', '29.60563', 'Jinshi', 1);
INSERT INTO `provinces`
VALUES (430800, '张家界市', 430000, '张家界', 2, '0744', '427000', '中国,湖南省,张家界市', '110.479921', '29.127401', 'Zhangjiajie', 1);
INSERT INTO `provinces`
VALUES (430802, '永定区', 430800, '永定', 3, '0744', '427000', '中国,湖南省,张家界市,永定区', '110.47464', '29.13387', 'Yongding', 1);
INSERT INTO `provinces`
VALUES (430811, '武陵源区', 430800, '武陵源', 3, '0744', '427400', '中国,湖南省,张家界市,武陵源区', '110.55026', '29.34574', 'Wulingyuan',
        1);
INSERT INTO `provinces`
VALUES (430821, '慈利县', 430800, '慈利', 3, '0744', '427200', '中国,湖南省,张家界市,慈利县', '111.13946', '29.42989', 'Cili', 1);
INSERT INTO `provinces`
VALUES (430822, '桑植县', 430800, '桑植', 3, '0744', '427100', '中国,湖南省,张家界市,桑植县', '110.16308', '29.39815', 'Sangzhi', 1);
INSERT INTO `provinces`
VALUES (430900, '益阳市', 430000, '益阳', 2, '0737', '413000', '中国,湖南省,益阳市', '112.355042', '28.570066', 'Yiyang', 1);
INSERT INTO `provinces`
VALUES (430902, '资阳区', 430900, '资阳', 3, '0737', '413001', '中国,湖南省,益阳市,资阳区', '112.32447', '28.59095', 'Ziyang', 1);
INSERT INTO `provinces`
VALUES (430903, '赫山区', 430900, '赫山', 3, '0737', '413002', '中国,湖南省,益阳市,赫山区', '112.37265', '28.57425', 'Heshan', 1);
INSERT INTO `provinces`
VALUES (430921, '南县', 430900, '南县', 3, '0737', '413200', '中国,湖南省,益阳市,南县', '112.3963', '29.36159', 'Nanxian', 1);
INSERT INTO `provinces`
VALUES (430922, '桃江县', 430900, '桃江', 3, '0737', '413400', '中国,湖南省,益阳市,桃江县', '112.1557', '28.51814', 'Taojiang', 1);
INSERT INTO `provinces`
VALUES (430923, '安化县', 430900, '安化', 3, '0737', '413500', '中国,湖南省,益阳市,安化县', '111.21298', '28.37424', 'Anhua', 1);
INSERT INTO `provinces`
VALUES (430981, '沅江市', 430900, '沅江', 3, '0737', '413100', '中国,湖南省,益阳市,沅江市', '112.35427', '28.84403', 'Yuanjiang', 1);
INSERT INTO `provinces`
VALUES (431000, '郴州市', 430000, '郴州', 2, '0735', '423000', '中国,湖南省,郴州市', '113.032067', '25.793589', 'Chenzhou', 1);
INSERT INTO `provinces`
VALUES (431002, '北湖区', 431000, '北湖', 3, '0735', '423000', '中国,湖南省,郴州市,北湖区', '113.01103', '25.78405', 'Beihu', 1);
INSERT INTO `provinces`
VALUES (431003, '苏仙区', 431000, '苏仙', 3, '0735', '423000', '中国,湖南省,郴州市,苏仙区', '113.04226', '25.80045', 'Suxian', 1);
INSERT INTO `provinces`
VALUES (431021, '桂阳县', 431000, '桂阳', 3, '0735', '424400', '中国,湖南省,郴州市,桂阳县', '112.73364', '25.75406', 'Guiyang', 1);
INSERT INTO `provinces`
VALUES (431022, '宜章县', 431000, '宜章', 3, '0735', '424200', '中国,湖南省,郴州市,宜章县', '112.95147', '25.39931', 'Yizhang', 1);
INSERT INTO `provinces`
VALUES (431023, '永兴县', 431000, '永兴', 3, '0735', '423300', '中国,湖南省,郴州市,永兴县', '113.11242', '26.12646', 'Yongxing', 1);
INSERT INTO `provinces`
VALUES (431024, '嘉禾县', 431000, '嘉禾', 3, '0735', '424500', '中国,湖南省,郴州市,嘉禾县', '112.36935', '25.58795', 'Jiahe', 1);
INSERT INTO `provinces`
VALUES (431025, '临武县', 431000, '临武', 3, '0735', '424300', '中国,湖南省,郴州市,临武县', '112.56369', '25.27602', 'Linwu', 1);
INSERT INTO `provinces`
VALUES (431026, '汝城县', 431000, '汝城', 3, '0735', '424100', '中国,湖南省,郴州市,汝城县', '113.68582', '25.55204', 'Rucheng', 1);
INSERT INTO `provinces`
VALUES (431027, '桂东县', 431000, '桂东', 3, '0735', '423500', '中国,湖南省,郴州市,桂东县', '113.9468', '26.07987', 'Guidong', 1);
INSERT INTO `provinces`
VALUES (431028, '安仁县', 431000, '安仁', 3, '0735', '423600', '中国,湖南省,郴州市,安仁县', '113.26944', '26.70931', 'Anren', 1);
INSERT INTO `provinces`
VALUES (431081, '资兴市', 431000, '资兴', 3, '0735', '423400', '中国,湖南省,郴州市,资兴市', '113.23724', '25.97668', 'Zixing', 1);
INSERT INTO `provinces`
VALUES (431100, '永州市', 430000, '永州', 2, '0746', '425000', '中国,湖南省,永州市', '111.608019', '26.434516', 'Yongzhou', 1);
INSERT INTO `provinces`
VALUES (431102, '零陵区', 431100, '零陵', 3, '0746', '425100', '中国,湖南省,永州市,零陵区', '111.62103', '26.22109', 'Lingling', 1);
INSERT INTO `provinces`
VALUES (431103, '冷水滩区', 431100, '冷水滩', 3, '0746', '425100', '中国,湖南省,永州市,冷水滩区', '111.59214', '26.46107', 'Lengshuitan',
        1);
INSERT INTO `provinces`
VALUES (431121, '祁阳县', 431100, '祁阳', 3, '0746', '426100', '中国,湖南省,永州市,祁阳县', '111.84011', '26.58009', 'Qiyang', 1);
INSERT INTO `provinces`
VALUES (431122, '东安县', 431100, '东安', 3, '0746', '425900', '中国,湖南省,永州市,东安县', '111.3164', '26.39202', 'Dong\'an', 1);
INSERT INTO `provinces`
VALUES (431123, '双牌县', 431100, '双牌', 3, '0746', '425200', '中国,湖南省,永州市,双牌县', '111.65927', '25.95988', 'Shuangpai', 1);
INSERT INTO `provinces`
VALUES (431124, '道县', 431100, '道县', 3, '0746', '425300', '中国,湖南省,永州市,道县', '111.60195', '25.52766', 'Daoxian', 1);
INSERT INTO `provinces`
VALUES (431125, '江永县', 431100, '江永', 3, '0746', '425400', '中国,湖南省,永州市,江永县', '111.34082', '25.27233', 'Jiangyong', 1);
INSERT INTO `provinces`
VALUES (431126, '宁远县', 431100, '宁远', 3, '0746', '425600', '中国,湖南省,永州市,宁远县', '111.94625', '25.56913', 'Ningyuan', 1);
INSERT INTO `provinces`
VALUES (431127, '蓝山县', 431100, '蓝山', 3, '0746', '425800', '中国,湖南省,永州市,蓝山县', '112.19363', '25.36794', 'Lanshan', 1);
INSERT INTO `provinces`
VALUES (431128, '新田县', 431100, '新田', 3, '0746', '425700', '中国,湖南省,永州市,新田县', '112.22103', '25.9095', 'Xintian', 1);
INSERT INTO `provinces`
VALUES (431129, '江华瑶族自治县', 431100, '江华', 3, '0746', '425500', '中国,湖南省,永州市,江华瑶族自治县', '111.58847', '25.1845', 'Jianghua',
        1);
INSERT INTO `provinces`
VALUES (431200, '怀化市', 430000, '怀化', 2, '0745', '418000', '中国,湖南省,怀化市', '109.97824', '27.550082', 'Huaihua', 1);
INSERT INTO `provinces`
VALUES (431202, '鹤城区', 431200, '鹤城', 3, '0745', '418000', '中国,湖南省,怀化市,鹤城区', '109.96509', '27.54942', 'Hecheng', 1);
INSERT INTO `provinces`
VALUES (431221, '中方县', 431200, '中方', 3, '0745', '418005', '中国,湖南省,怀化市,中方县', '109.94497', '27.43988', 'Zhongfang', 1);
INSERT INTO `provinces`
VALUES (431222, '沅陵县', 431200, '沅陵', 3, '0745', '419600', '中国,湖南省,怀化市,沅陵县', '110.39633', '28.45548', 'Yuanling', 1);
INSERT INTO `provinces`
VALUES (431223, '辰溪县', 431200, '辰溪', 3, '0745', '419500', '中国,湖南省,怀化市,辰溪县', '110.18942', '28.00406', 'Chenxi', 1);
INSERT INTO `provinces`
VALUES (431224, '溆浦县', 431200, '溆浦', 3, '0745', '419300', '中国,湖南省,怀化市,溆浦县', '110.59384', '27.90836', 'Xupu', 1);
INSERT INTO `provinces`
VALUES (431302, '娄星区', 431300, '娄星', 3, '0738', '417000', '中国,湖南省,娄底市,娄星区', '112.00193', '27.72992', 'Louxing', 1);
INSERT INTO `provinces`
VALUES (431321, '双峰县', 431300, '双峰', 3, '0738', '417700', '中国,湖南省,娄底市,双峰县', '112.19921', '27.45418', 'Shuangfeng', 1);
INSERT INTO `provinces`
VALUES (431322, '新化县', 431300, '新化', 3, '0738', '417600', '中国,湖南省,娄底市,新化县', '111.32739', '27.7266', 'Xinhua', 1);
INSERT INTO `provinces`
VALUES (431381, '冷水江市', 431300, '冷水江', 3, '0738', '417500', '中国,湖南省,娄底市,冷水江市', '111.43554', '27.68147', 'Lengshuijiang',
        1);
INSERT INTO `provinces`
VALUES (431382, '涟源市', 431300, '涟源', 3, '0738', '417100', '中国,湖南省,娄底市,涟源市', '111.67233', '27.68831', 'Lianyuan', 1);
INSERT INTO `provinces`
VALUES (433100, '湘西土家族苗族自治州', 430000, '湘西', 2, '0743', '416000', '中国,湖南省,湘西土家族苗族自治州', '109.739735', '28.32186',
        'Xiangxi', 1);
INSERT INTO `provinces`
VALUES (433101, '吉首市', 433100, '吉首', 3, '0743', '416000', '中国,湖南省,湘西土家族苗族自治州,吉首市', '109.69799', '28.26247', 'Jishou',
        1);
INSERT INTO `provinces`
VALUES (433122, '泸溪县', 433100, '泸溪', 3, '0743', '416100', '中国,湖南省,湘西土家族苗族自治州,泸溪县', '110.21682', '28.2205', 'Luxi', 1);
INSERT INTO `provinces`
VALUES (433123, '凤凰县', 433100, '凤凰', 3, '0743', '416200', '中国,湖南省,湘西土家族苗族自治州,凤凰县', '109.60156', '27.94822', 'Fenghuang',
        1);
INSERT INTO `provinces`
VALUES (433124, '花垣县', 433100, '花垣', 3, '0743', '416400', '中国,湖南省,湘西土家族苗族自治州,花垣县', '109.48217', '28.5721', 'Huayuan',
        1);
INSERT INTO `provinces`
VALUES (433125, '保靖县', 433100, '保靖', 3, '0743', '416500', '中国,湖南省,湘西土家族苗族自治州,保靖县', '109.66049', '28.69997', 'Baojing',
        1);
INSERT INTO `provinces`
VALUES (433126, '古丈县', 433100, '古丈', 3, '0743', '416300', '中国,湖南省,湘西土家族苗族自治州,古丈县', '109.94812', '28.61944', 'Guzhang',
        1);
INSERT INTO `provinces`
VALUES (433127, '永顺县', 433100, '永顺', 3, '0743', '416700', '中国,湖南省,湘西土家族苗族自治州,永顺县', '109.85266', '29.00103', 'Yongshun',
        1);
INSERT INTO `provinces`
VALUES (433130, '龙山县', 433100, '龙山', 3, '0743', '416800', '中国,湖南省,湘西土家族苗族自治州,龙山县', '109.4432', '29.45693', 'Longshan',
        1);
INSERT INTO `provinces`
VALUES (440000, '广东省', 100000, '广东', 1, '', '', '中国,广东省', '113.280637', '23.125178', 'Guangdong', 1);
INSERT INTO `provinces`
VALUES (440100, '广州市', 440000, '广州', 2, '020', '510032', '中国,广东省,广州市', '113.280637', '23.125178', 'Guangzhou', 1);
INSERT INTO `provinces`
VALUES (440103, '荔湾区', 440100, '荔湾', 3, '020', '510170', '中国,广东省,广州市,荔湾区', '113.2442', '23.12592', 'Liwan', 1);
INSERT INTO `provinces`
VALUES (440104, '越秀区', 440100, '越秀', 3, '020', '510030', '中国,广东省,广州市,越秀区', '113.26683', '23.12897', 'Yuexiu', 1);
INSERT INTO `provinces`
VALUES (440105, '海珠区', 440100, '海珠', 3, '020', '510300', '中国,广东省,广州市,海珠区', '113.26197', '23.10379', 'Haizhu', 1);
INSERT INTO `provinces`
VALUES (440106, '天河区', 440100, '天河', 3, '020', '510665', '中国,广东省,广州市,天河区', '113.36112', '23.12467', 'Tianhe', 1);
INSERT INTO `provinces`
VALUES (440111, '白云区', 440100, '白云', 3, '020', '510405', '中国,广东省,广州市,白云区', '113.27307', '23.15787', 'Baiyun', 1);
INSERT INTO `provinces`
VALUES (440112, '黄埔区', 440100, '黄埔', 3, '020', '510700', '中国,广东省,广州市,黄埔区', '113.45895', '23.10642', 'Huangpu', 1);
INSERT INTO `provinces`
VALUES (440113, '番禺区', 440100, '番禺', 3, '020', '511400', '中国,广东省,广州市,番禺区', '113.38397', '22.93599', 'Panyu', 1);
INSERT INTO `provinces`
VALUES (440114, '花都区', 440100, '花都', 3, '020', '510800', '中国,广东省,广州市,花都区', '113.22033', '23.40358', 'Huadu', 1);
INSERT INTO `provinces`
VALUES (440115, '南沙区', 440100, '南沙', 3, '020', '511458', '中国,广东省,广州市,南沙区', '113.60845', '22.77144', 'Nansha', 1);
INSERT INTO `provinces`
VALUES (440117, '从化区', 440100, '从化', 3, '020', '510900', '中国,广东省,广州市,从化区', '113.587386', '23.545283', 'Conghua', 1);
INSERT INTO `provinces`
VALUES (440118, '增城区', 440100, '增城', 3, '020', '511300', '中国,广东省,广州市,增城区', '113.829579', '23.290497', 'Zengcheng', 1);
INSERT INTO `provinces`
VALUES (440200, '韶关市', 440000, '韶关', 2, '0751', '512002', '中国,广东省,韶关市', '113.591544', '24.801322', 'Shaoguan', 1);
INSERT INTO `provinces`
VALUES (440203, '武江区', 440200, '武江', 3, '0751', '512026', '中国,广东省,韶关市,武江区', '113.58767', '24.79264', 'Wujiang', 1);
INSERT INTO `provinces`
VALUES (440204, '浈江区', 440200, '浈江', 3, '0751', '512023', '中国,广东省,韶关市,浈江区', '113.61109', '24.80438', 'Zhenjiang', 1);
INSERT INTO `provinces`
VALUES (440205, '曲江区', 440200, '曲江', 3, '0751', '512101', '中国,广东省,韶关市,曲江区', '113.60165', '24.67915', 'Qujiang', 1);
INSERT INTO `provinces`
VALUES (440222, '始兴县', 440200, '始兴', 3, '0751', '512500', '中国,广东省,韶关市,始兴县', '114.06799', '24.94759', 'Shixing', 1);
INSERT INTO `provinces`
VALUES (440224, '仁化县', 440200, '仁化', 3, '0751', '512300', '中国,广东省,韶关市,仁化县', '113.74737', '25.08742', 'Renhua', 1);
INSERT INTO `provinces`
VALUES (440229, '翁源县', 440200, '翁源', 3, '0751', '512600', '中国,广东省,韶关市,翁源县', '114.13385', '24.3495', 'Wengyuan', 1);
INSERT INTO `provinces`
VALUES (440232, '乳源瑶族自治县', 440200, '乳源', 3, '0751', '512700', '中国,广东省,韶关市,乳源瑶族自治县', '113.27734', '24.77803', 'Ruyuan',
        1);
INSERT INTO `provinces`
VALUES (440233, '新丰县', 440200, '新丰', 3, '0751', '511100', '中国,广东省,韶关市,新丰县', '114.20788', '24.05924', 'Xinfeng', 1);
INSERT INTO `provinces`
VALUES (440281, '乐昌市', 440200, '乐昌', 3, '0751', '512200', '中国,广东省,韶关市,乐昌市', '113.35653', '25.12799', 'Lechang', 1);
INSERT INTO `provinces`
VALUES (440282, '南雄市', 440200, '南雄', 3, '0751', '512400', '中国,广东省,韶关市,南雄市', '114.30966', '25.11706', 'Nanxiong', 1);
INSERT INTO `provinces`
VALUES (440300, '深圳市', 440000, '深圳', 2, '0755', '518035', '中国,广东省,深圳市', '114.085947', '22.547', 'Shenzhen', 1);
INSERT INTO `provinces`
VALUES (440303, '罗湖区', 440300, '罗湖', 3, '0755', '518021', '中国,广东省,深圳市,罗湖区', '114.13116', '22.54836', 'Luohu', 1);
INSERT INTO `provinces`
VALUES (440304, '福田区', 440300, '福田', 3, '0755', '518048', '中国,广东省,深圳市,福田区', '114.05571', '22.52245', 'Futian', 1);
INSERT INTO `provinces`
VALUES (440305, '南山区', 440300, '南山', 3, '0755', '518051', '中国,广东省,深圳市,南山区', '113.93029', '22.53291', 'Nanshan', 1);
INSERT INTO `provinces`
VALUES (440306, '宝安区', 440300, '宝安', 3, '0755', '518101', '中国,广东省,深圳市,宝安区', '113.88311', '22.55371', 'Bao\'an', 1);
INSERT INTO `provinces`
VALUES (440307, '龙岗区', 440300, '龙岗', 3, '0755', '518172', '中国,广东省,深圳市,龙岗区', '114.24771', '22.71986', 'Longgang', 1);
INSERT INTO `provinces`
VALUES (440308, '盐田区', 440300, '盐田', 3, '0755', '518081', '中国,广东省,深圳市,盐田区', '114.23733', '22.5578', 'Yantian', 1);
INSERT INTO `provinces`
VALUES (440309, '光明新区', 440300, '光明新区', 3, '0755', '518100', '中国,广东省,深圳市,光明新区', '113.896026', '22.777292',
        'Guangmingxinqu', 1);
INSERT INTO `provinces`
VALUES (440310, '坪山新区', 440300, '坪山新区', 3, '0755', '518000', '中国,广东省,深圳市,坪山新区', '114.34637', '22.690529',
        'Pingshanxinqu', 1);
INSERT INTO `provinces`
VALUES (440311, '大鹏新区', 440300, '大鹏新区', 3, '0755', '518000', '中国,广东省,深圳市,大鹏新区', '114.479901', '22.587862',
        'Dapengxinqu', 1);
INSERT INTO `provinces`
VALUES (440312, '龙华新区', 440300, '龙华新区', 3, '0755', '518100', '中国,广东省,深圳市,龙华新区', '114.036585', '22.68695',
        'Longhuaxinqu', 1);
INSERT INTO `provinces`
VALUES (440400, '珠海市', 440000, '珠海', 2, '0756', '519000', '中国,广东省,珠海市', '113.552724', '22.255899', 'Zhuhai', 1);
INSERT INTO `provinces`
VALUES (440402, '香洲区', 440400, '香洲', 3, '0756', '519000', '中国,广东省,珠海市,香洲区', '113.5435', '22.26654', 'Xiangzhou', 1);
INSERT INTO `provinces`
VALUES (440403, '斗门区', 440400, '斗门', 3, '0756', '519110', '中国,广东省,珠海市,斗门区', '113.29644', '22.20898', 'Doumen', 1);
INSERT INTO `provinces`
VALUES (440404, '金湾区', 440400, '金湾', 3, '0756', '519040', '中国,广东省,珠海市,金湾区', '113.36361', '22.14691', 'Jinwan', 1);
INSERT INTO `provinces`
VALUES (440500, '汕头市', 440000, '汕头', 2, '0754', '515041', '中国,广东省,汕头市', '116.708463', '23.37102', 'Shantou', 1);
INSERT INTO `provinces`
VALUES (440507, '龙湖区', 440500, '龙湖', 3, '0754', '515041', '中国,广东省,汕头市,龙湖区', '116.71641', '23.37166', 'Longhu', 1);
INSERT INTO `provinces`
VALUES (440511, '金平区', 440500, '金平', 3, '0754', '515041', '中国,广东省,汕头市,金平区', '116.70364', '23.36637', 'Jinping', 1);
INSERT INTO `provinces`
VALUES (440512, '濠江区', 440500, '濠江', 3, '0754', '515071', '中国,广东省,汕头市,濠江区', '116.72659', '23.28588', 'Haojiang', 1);
INSERT INTO `provinces`
VALUES (440513, '潮阳区', 440500, '潮阳', 3, '0754', '515100', '中国,广东省,汕头市,潮阳区', '116.6015', '23.26485', 'Chaoyang', 1);
INSERT INTO `provinces`
VALUES (440514, '潮南区', 440500, '潮南', 3, '0754', '515144', '中国,广东省,汕头市,潮南区', '116.43188', '23.25', 'Chaonan', 1);
INSERT INTO `provinces`
VALUES (440515, '澄海区', 440500, '澄海', 3, '0754', '515800', '中国,广东省,汕头市,澄海区', '116.75589', '23.46728', 'Chenghai', 1);
INSERT INTO `provinces`
VALUES (440523, '南澳县', 440500, '南澳', 3, '0754', '515900', '中国,广东省,汕头市,南澳县', '117.01889', '23.4223', 'Nanao', 1);
INSERT INTO `provinces`
VALUES (440600, '佛山市', 440000, '佛山', 2, '0757', '528000', '中国,广东省,佛山市', '113.122717', '23.028762', 'Foshan', 1);
INSERT INTO `provinces`
VALUES (440604, '禅城区', 440600, '禅城', 3, '0757', '528000', '中国,广东省,佛山市,禅城区', '113.1228', '23.00842', 'Chancheng', 1);
INSERT INTO `provinces`
VALUES (440605, '南海区', 440600, '南海', 3, '0757', '528251', '中国,广东省,佛山市,南海区', '113.2189', '23.02877', 'Nanhai', 1);
INSERT INTO `provinces`
VALUES (440606, '顺德区', 440600, '顺德', 3, '0757', '528300', '中国,广东省,佛山市,顺德区', '113.29394', '22.80452', 'Shunde', 1);
INSERT INTO `provinces`
VALUES (440607, '三水区', 440600, '三水', 3, '0757', '528133', '中国,广东省,佛山市,三水区', '112.89703', '23.15564', 'Sanshui', 1);
INSERT INTO `provinces`
VALUES (440608, '高明区', 440600, '高明', 3, '0757', '528500', '中国,广东省,佛山市,高明区', '112.89254', '22.90022', 'Gaoming', 1);
INSERT INTO `provinces`
VALUES (440700, '江门市', 440000, '江门', 2, '0750', '529000', '中国,广东省,江门市', '113.094942', '22.590431', 'Jiangmen', 1);
INSERT INTO `provinces`
VALUES (440703, '蓬江区', 440700, '蓬江', 3, '0750', '529000', '中国,广东省,江门市,蓬江区', '113.07849', '22.59515', 'Pengjiang', 1);
INSERT INTO `provinces`
VALUES (440704, '江海区', 440700, '江海', 3, '0750', '529040', '中国,广东省,江门市,江海区', '113.11099', '22.56024', 'Jianghai', 1);
INSERT INTO `provinces`
VALUES (440705, '新会区', 440700, '新会', 3, '0750', '529100', '中国,广东省,江门市,新会区', '113.03126', '22.45876', 'Xinhui', 1);
INSERT INTO `provinces`
VALUES (440781, '台山市', 440700, '台山', 3, '0750', '529200', '中国,广东省,江门市,台山市', '112.79382', '22.2515', 'Taishan', 1);
INSERT INTO `provinces`
VALUES (440783, '开平市', 440700, '开平', 3, '0750', '529337', '中国,广东省,江门市,开平市', '112.69842', '22.37622', 'Kaiping', 1);
INSERT INTO `provinces`
VALUES (440784, '鹤山市', 440700, '鹤山', 3, '0750', '529700', '中国,广东省,江门市,鹤山市', '112.96429', '22.76523', 'Heshan', 1);
INSERT INTO `provinces`
VALUES (440785, '恩平市', 440700, '恩平', 3, '0750', '529400', '中国,广东省,江门市,恩平市', '112.30496', '22.18288', 'Enping', 1);
INSERT INTO `provinces`
VALUES (440800, '湛江市', 440000, '湛江', 2, '0759', '524047', '中国,广东省,湛江市', '110.405529', '21.195338', 'Zhanjiang', 1);
INSERT INTO `provinces`
VALUES (440802, '赤坎区', 440800, '赤坎', 3, '0759', '524033', '中国,广东省,湛江市,赤坎区', '110.36592', '21.26606', 'Chikan', 1);
INSERT INTO `provinces`
VALUES (440803, '霞山区', 440800, '霞山', 3, '0759', '524011', '中国,广东省,湛江市,霞山区', '110.39822', '21.19181', 'Xiashan', 1);
INSERT INTO `provinces`
VALUES (440804, '坡头区', 440800, '坡头', 3, '0759', '524057', '中国,广东省,湛江市,坡头区', '110.45533', '21.24472', 'Potou', 1);
INSERT INTO `provinces`
VALUES (440811, '麻章区', 440800, '麻章', 3, '0759', '524094', '中国,广东省,湛江市,麻章区', '110.3342', '21.26333', 'Mazhang', 1);
INSERT INTO `provinces`
VALUES (440823, '遂溪县', 440800, '遂溪', 3, '0759', '524300', '中国,广东省,湛江市,遂溪县', '110.25003', '21.37721', 'Suixi', 1);
INSERT INTO `provinces`
VALUES (440825, '徐闻县', 440800, '徐闻', 3, '0759', '524100', '中国,广东省,湛江市,徐闻县', '110.17379', '20.32812', 'Xuwen', 1);
INSERT INTO `provinces`
VALUES (440881, '廉江市', 440800, '廉江', 3, '0759', '524400', '中国,广东省,湛江市,廉江市', '110.28442', '21.60917', 'Lianjiang', 1);
INSERT INTO `provinces`
VALUES (440882, '雷州市', 440800, '雷州', 3, '0759', '524200', '中国,广东省,湛江市,雷州市', '110.10092', '20.91428', 'Leizhou', 1);
INSERT INTO `provinces`
VALUES (440883, '吴川市', 440800, '吴川', 3, '0759', '524500', '中国,广东省,湛江市,吴川市', '110.77703', '21.44584', 'Wuchuan', 1);
INSERT INTO `provinces`
VALUES (440900, '茂名市', 440000, '茂名', 2, '0668', '525000', '中国,广东省,茂名市', '110.919229', '21.659751', 'Maoming', 1);
INSERT INTO `provinces`
VALUES (440902, '茂南区', 440900, '茂南', 3, '0668', '525000', '中国,广东省,茂名市,茂南区', '110.9187', '21.64103', 'Maonan', 1);
INSERT INTO `provinces`
VALUES (440904, '电白区', 440900, '电白', 3, '0668', '525400', '中国,广东省,茂名市,电白区', '111.007264', '21.507219', 'Dianbai', 1);
INSERT INTO `provinces`
VALUES (440981, '高州市', 440900, '高州', 3, '0668', '525200', '中国,广东省,茂名市,高州市', '110.85519', '21.92057', 'Gaozhou', 1);
INSERT INTO `provinces`
VALUES (440982, '化州市', 440900, '化州', 3, '0668', '525100', '中国,广东省,茂名市,化州市', '110.63949', '21.66394', 'Huazhou', 1);
INSERT INTO `provinces`
VALUES (440983, '信宜市', 440900, '信宜', 3, '0668', '525300', '中国,广东省,茂名市,信宜市', '110.94647', '22.35351', 'Xinyi', 1);
INSERT INTO `provinces`
VALUES (441126, '封开县', 441200, '封开', 3, '0758', '526500', '中国,广东省,肇庆市,封开县', '111.50332', '23.43571', 'Fengkai', 1);
INSERT INTO `provinces`
VALUES (441200, '肇庆市', 440000, '肇庆', 2, '0758', '526040', '中国,广东省,肇庆市', '112.472529', '23.051546', 'Zhaoqing', 1);
INSERT INTO `provinces`
VALUES (441202, '端州区', 441200, '端州', 3, '0758', '526060', '中国,广东省,肇庆市,端州区', '112.48495', '23.0519', 'Duanzhou', 1);
INSERT INTO `provinces`
VALUES (441203, '鼎湖区', 441200, '鼎湖', 3, '0758', '526070', '中国,广东省,肇庆市,鼎湖区', '112.56643', '23.15846', 'Dinghu', 1);
INSERT INTO `provinces`
VALUES (441223, '广宁县', 441200, '广宁', 3, '0758', '526300', '中国,广东省,肇庆市,广宁县', '112.44064', '23.6346', 'Guangning', 1);
INSERT INTO `provinces`
VALUES (441224, '怀集县', 441200, '怀集', 3, '0758', '526400', '中国,广东省,肇庆市,怀集县', '112.18396', '23.90918', 'Huaiji', 1);
INSERT INTO `provinces`
VALUES (441226, '德庆县', 441200, '德庆', 3, '0758', '526600', '中国,广东省,肇庆市,德庆县', '111.78555', '23.14371', 'Deqing', 1);
INSERT INTO `provinces`
VALUES (441283, '高要市', 441200, '高要', 3, '0758', '526100', '中国,广东省,肇庆市,高要市', '112.45834', '23.02577', 'Gaoyao', 1);
INSERT INTO `provinces`
VALUES (441284, '四会市', 441200, '四会', 3, '0758', '526200', '中国,广东省,肇庆市,四会市', '112.73416', '23.32686', 'Sihui', 1);
INSERT INTO `provinces`
VALUES (441300, '惠州市', 440000, '惠州', 2, '0752', '516000', '中国,广东省,惠州市', '114.412599', '23.079404', 'Huizhou', 1);
INSERT INTO `provinces`
VALUES (441302, '惠城区', 441300, '惠城', 3, '0752', '516008', '中国,广东省,惠州市,惠城区', '114.3828', '23.08377', 'Huicheng', 1);
INSERT INTO `provinces`
VALUES (441303, '惠阳区', 441300, '惠阳', 3, '0752', '516211', '中国,广东省,惠州市,惠阳区', '114.45639', '22.78845', 'Huiyang', 1);
INSERT INTO `provinces`
VALUES (441322, '博罗县', 441300, '博罗', 3, '0752', '516100', '中国,广东省,惠州市,博罗县', '114.28964', '23.17307', 'Boluo', 1);
INSERT INTO `provinces`
VALUES (441323, '惠东县', 441300, '惠东', 3, '0752', '516300', '中国,广东省,惠州市,惠东县', '114.72009', '22.98484', 'Huidong', 1);
INSERT INTO `provinces`
VALUES (441324, '龙门县', 441300, '龙门', 3, '0752', '516800', '中国,广东省,惠州市,龙门县', '114.25479', '23.72758', 'Longmen', 1);
INSERT INTO `provinces`
VALUES (441400, '梅州市', 440000, '梅州', 2, '0753', '514021', '中国,广东省,梅州市', '116.117582', '24.299112', 'Meizhou', 1);
INSERT INTO `provinces`
VALUES (441402, '梅江区', 441400, '梅江', 3, '0753', '514000', '中国,广东省,梅州市,梅江区', '116.11663', '24.31062', 'Meijiang', 1);
INSERT INTO `provinces`
VALUES (441403, '梅县区', 441400, '梅县', 3, '0753', '514787', '中国,广东省,梅州市,梅县区', '116.097753', '24.286739', 'Meixian', 1);
INSERT INTO `provinces`
VALUES (441422, '大埔县', 441400, '大埔', 3, '0753', '514200', '中国,广东省,梅州市,大埔县', '116.69662', '24.35325', 'Dabu', 1);
INSERT INTO `provinces`
VALUES (441423, '丰顺县', 441400, '丰顺', 3, '0753', '514300', '中国,广东省,梅州市,丰顺县', '116.18219', '23.74094', 'Fengshun', 1);
INSERT INTO `provinces`
VALUES (441424, '五华县', 441400, '五华', 3, '0753', '514400', '中国,广东省,梅州市,五华县', '115.77893', '23.92417', 'Wuhua', 1);
INSERT INTO `provinces`
VALUES (441426, '平远县', 441400, '平远', 3, '0753', '514600', '中国,广东省,梅州市,平远县', '115.89556', '24.57116', 'Pingyuan', 1);
INSERT INTO `provinces`
VALUES (441427, '蕉岭县', 441400, '蕉岭', 3, '0753', '514100', '中国,广东省,梅州市,蕉岭县', '116.17089', '24.65732', 'Jiaoling', 1);
INSERT INTO `provinces`
VALUES (441481, '兴宁市', 441400, '兴宁', 3, '0753', '514500', '中国,广东省,梅州市,兴宁市', '115.73141', '24.14001', 'Xingning', 1);
INSERT INTO `provinces`
VALUES (441500, '汕尾市', 440000, '汕尾', 2, '0660', '516600', '中国,广东省,汕尾市', '115.364238', '22.774485', 'Shanwei', 1);
INSERT INTO `provinces`
VALUES (441502, '城区', 441500, '城区', 3, '0660', '516600', '中国,广东省,汕尾市,城区', '115.36503', '22.7789', 'Chengqu', 1);
INSERT INTO `provinces`
VALUES (441521, '海丰县', 441500, '海丰', 3, '0660', '516400', '中国,广东省,汕尾市,海丰县', '115.32336', '22.96653', 'Haifeng', 1);
INSERT INTO `provinces`
VALUES (441523, '陆河县', 441500, '陆河', 3, '0660', '516700', '中国,广东省,汕尾市,陆河县', '115.65597', '23.30365', 'Luhe', 1);
INSERT INTO `provinces`
VALUES (441581, '陆丰市', 441500, '陆丰', 3, '0660', '516500', '中国,广东省,汕尾市,陆丰市', '115.64813', '22.94335', 'Lufeng', 1);
INSERT INTO `provinces`
VALUES (441600, '河源市', 440000, '河源', 2, '0762', '517000', '中国,广东省,河源市', '114.697802', '23.746266', 'Heyuan', 1);
INSERT INTO `provinces`
VALUES (441602, '源城区', 441600, '源城', 3, '0762', '517000', '中国,广东省,河源市,源城区', '114.70242', '23.7341', 'Yuancheng', 1);
INSERT INTO `provinces`
VALUES (441621, '紫金县', 441600, '紫金', 3, '0762', '517400', '中国,广东省,河源市,紫金县', '115.18365', '23.63867', 'Zijin', 1);
INSERT INTO `provinces`
VALUES (441622, '龙川县', 441600, '龙川', 3, '0762', '517300', '中国,广东省,河源市,龙川县', '115.26025', '24.10142', 'Longchuan', 1);
INSERT INTO `provinces`
VALUES (441623, '连平县', 441600, '连平', 3, '0762', '517100', '中国,广东省,河源市,连平县', '114.49026', '24.37156', 'Lianping', 1);
INSERT INTO `provinces`
VALUES (441624, '和平县', 441600, '和平', 3, '0762', '517200', '中国,广东省,河源市,和平县', '114.93841', '24.44319', 'Heping', 1);
INSERT INTO `provinces`
VALUES (441625, '东源县', 441600, '东源', 3, '0762', '517583', '中国,广东省,河源市,东源县', '114.74633', '23.78835', 'Dongyuan', 1);
INSERT INTO `provinces`
VALUES (441700, '阳江市', 440000, '阳江', 2, '0662', '529500', '中国,广东省,阳江市', '111.975107', '21.859222', 'Yangjiang', 1);
INSERT INTO `provinces`
VALUES (441702, '江城区', 441700, '江城', 3, '0662', '529500', '中国,广东省,阳江市,江城区', '111.95488', '21.86193', 'Jiangcheng', 1);
INSERT INTO `provinces`
VALUES (441704, '阳东区', 441700, '阳东', 3, '0662', '529900', '中国,广东省,阳江市,阳东区', '112.01467', '21.87398', 'Yangdong', 1);
INSERT INTO `provinces`
VALUES (441721, '阳西县', 441700, '阳西', 3, '0662', '529800', '中国,广东省,阳江市,阳西县', '111.61785', '21.75234', 'Yangxi', 1);
INSERT INTO `provinces`
VALUES (441781, '阳春市', 441700, '阳春', 3, '0662', '529600', '中国,广东省,阳江市,阳春市', '111.78854', '22.17232', 'Yangchun', 1);
INSERT INTO `provinces`
VALUES (441800, '清远市', 440000, '清远', 2, '0763', '511500', '中国,广东省,清远市', '113.036779', '23.704188', 'Qingyuan', 1);
INSERT INTO `provinces`
VALUES (441802, '清城区', 441800, '清城', 3, '0763', '511515', '中国,广东省,清远市,清城区', '113.06265', '23.69784', 'Qingcheng', 1);
INSERT INTO `provinces`
VALUES (441803, '清新区', 441800, '清新', 3, '0763', '511810', '中国,广东省,清远市,清新区', '113.015203', '23.736949', 'Qingxin', 1);
INSERT INTO `provinces`
VALUES (441821, '佛冈县', 441800, '佛冈', 3, '0763', '511600', '中国,广东省,清远市,佛冈县', '113.53286', '23.87231', 'Fogang', 1);
INSERT INTO `provinces`
VALUES (441823, '阳山县', 441800, '阳山', 3, '0763', '513100', '中国,广东省,清远市,阳山县', '112.64129', '24.46516', 'Yangshan', 1);
INSERT INTO `provinces`
VALUES (441825, '连山壮族瑶族自治县', 441800, '连山', 3, '0763', '513200', '中国,广东省,清远市,连山壮族瑶族自治县', '112.0802', '24.56807',
        'Lianshan', 1);
INSERT INTO `provinces`
VALUES (441826, '连南瑶族自治县', 441800, '连南', 3, '0763', '513300', '中国,广东省,清远市,连南瑶族自治县', '112.28842', '24.71726', 'Liannan',
        1);
INSERT INTO `provinces`
VALUES (441881, '英德市', 441800, '英德', 3, '0763', '513000', '中国,广东省,清远市,英德市', '113.415', '24.18571', 'Yingde', 1);
INSERT INTO `provinces`
VALUES (441882, '连州市', 441800, '连州', 3, '0763', '513400', '中国,广东省,清远市,连州市', '112.38153', '24.77913', 'Lianzhou', 1);
INSERT INTO `provinces`
VALUES (441900, '东莞市', 440000, '东莞', 2, '0769', '523888', '中国,广东省,东莞市', '113.760234', '23.048884', 'Dongguan', 1);
INSERT INTO `provinces`
VALUES (441901, '莞城区', 441900, '莞城', 3, '0769', '523128', '中国,广东省,东莞市,莞城区', '113.751043', '23.053412', 'Guancheng', 1);
INSERT INTO `provinces`
VALUES (441902, '南城区', 441900, '南城', 3, '0769', '523617', '中国,广东省,东莞市,南城区', '113.752125', '23.02018', 'Nancheng', 1);
INSERT INTO `provinces`
VALUES (441904, '万江区', 441900, '万江', 3, '0769', '523039', '中国,广东省,东莞市,万江区', '113.739053', '23.043842', 'Wanjiang', 1);
INSERT INTO `provinces`
VALUES (441905, '石碣镇', 441900, '石碣', 3, '0769', '523290', '中国,广东省,东莞市,石碣镇', '113.80217', '23.09899', 'Shijie', 1);
INSERT INTO `provinces`
VALUES (441906, '石龙镇', 441900, '石龙', 3, '0769', '523326', '中国,广东省,东莞市,石龙镇', '113.876381', '23.107444', 'Shilong', 1);
INSERT INTO `provinces`
VALUES (441907, '茶山镇', 441900, '茶山', 3, '0769', '523380', '中国,广东省,东莞市,茶山镇', '113.883526', '23.062375', 'Chashan', 1);
INSERT INTO `provinces`
VALUES (441908, '石排镇', 441900, '石排', 3, '0769', '523346', '中国,广东省,东莞市,石排镇', '113.919859', '23.0863', 'Shipai', 1);
INSERT INTO `provinces`
VALUES (441909, '企石镇', 441900, '企石', 3, '0769', '523507', '中国,广东省,东莞市,企石镇', '114.013233', '23.066044', 'Qishi', 1);
INSERT INTO `provinces`
VALUES (441910, '横沥镇', 441900, '横沥', 3, '0769', '523471', '中国,广东省,东莞市,横沥镇', '113.957436', '23.025732', 'Hengli', 1);
INSERT INTO `provinces`
VALUES (441911, '桥头镇', 441900, '桥头', 3, '0769', '523520', '中国,广东省,东莞市,桥头镇', '114.01385', '22.939727', 'Qiaotou', 1);
INSERT INTO `provinces`
VALUES (441912, '谢岗镇', 441900, '谢岗', 3, '0769', '523592', '中国,广东省,东莞市,谢岗镇', '114.141396', '22.959664', 'Xiegang', 1);
INSERT INTO `provinces`
VALUES (441913, '东坑镇', 441900, '东坑', 3, '0769', '523451', '中国,广东省,东莞市,东坑镇', '113.939835', '22.992804', 'Dongkeng', 1);
INSERT INTO `provinces`
VALUES (441914, '常平镇', 441900, '常平', 3, '0769', '523560', '中国,广东省,东莞市,常平镇', '114.029627', '23.016116', 'Changping', 1);
INSERT INTO `provinces`
VALUES (441915, '寮步镇', 441900, '寮步', 3, '0769', '523411', '中国,广东省,东莞市,寮步镇', '113.884745', '22.991738', 'Liaobu', 1);
INSERT INTO `provinces`
VALUES (441916, '大朗镇', 441900, '大朗', 3, '0769', '523770', '中国,广东省,东莞市,大朗镇', '113.9271', '22.965748', 'Dalang', 1);
INSERT INTO `provinces`
VALUES (441917, '麻涌镇', 441900, '麻涌', 3, '0769', '523143', '中国,广东省,东莞市,麻涌镇', '113.546177', '23.045315', 'Machong', 1);
INSERT INTO `provinces`
VALUES (441918, '中堂镇', 441900, '中堂', 3, '0769', '523233', '中国,广东省,东莞市,中堂镇', '113.654422', '23.090164', 'Zhongtang', 1);
INSERT INTO `provinces`
VALUES (441919, '高埗镇', 441900, '高埗', 3, '0769', '523282', '中国,广东省,东莞市,高埗镇', '113.735917', '23.068415', 'Gaobu', 1);
INSERT INTO `provinces`
VALUES (441920, '樟木头镇', 441900, '樟木头', 3, '0769', '523619', '中国,广东省,东莞市,樟木头镇', '114.066298', '22.956682', 'Zhangmutou',
        1);
INSERT INTO `provinces`
VALUES (441921, '大岭山镇', 441900, '大岭山', 3, '0769', '523835', '中国,广东省,东莞市,大岭山镇', '113.782955', '22.885366', 'Dalingshan',
        1);
INSERT INTO `provinces`
VALUES (441922, '望牛墩镇', 441900, '望牛墩', 3, '0769', '523203', '中国,广东省,东莞市,望牛墩镇', '113.658847', '23.055018', 'Wangniudun',
        1);
INSERT INTO `provinces`
VALUES (441923, '黄江镇', 441900, '黄江', 3, '0769', '523755', '中国,广东省,东莞市,黄江镇', '113.992635', '22.877536', 'Huangjiang', 1);
INSERT INTO `provinces`
VALUES (441924, '洪梅镇', 441900, '洪梅', 3, '0769', '523163', '中国,广东省,东莞市,洪梅镇', '113.613081', '22.992675', 'Hongmei', 1);
INSERT INTO `provinces`
VALUES (441925, '清溪镇', 441900, '清溪', 3, '0769', '523660', '中国,广东省,东莞市,清溪镇', '114.155796', '22.844456', 'Qingxi', 1);
INSERT INTO `provinces`
VALUES (441926, '沙田镇', 441900, '沙田', 3, '0769', '523988', '中国,广东省,东莞市,沙田镇', '113.760234', '23.048884', 'Shatian', 1);
INSERT INTO `provinces`
VALUES (441927, '道滘镇', 441900, '道滘', 3, '0769', '523171', '中国,广东省,东莞市,道滘镇', '113.760234', '23.048884', 'Daojiao', 1);
INSERT INTO `provinces`
VALUES (441928, '塘厦镇', 441900, '塘厦', 3, '0769', '523713', '中国,广东省,东莞市,塘厦镇', '114.10765', '22.822862', 'Tangxia', 1);
INSERT INTO `provinces`
VALUES (441929, '虎门镇', 441900, '虎门', 3, '0769', '523932', '中国,广东省,东莞市,虎门镇', '113.71118', '22.82615', 'Humen', 1);
INSERT INTO `provinces`
VALUES (441930, '厚街镇', 441900, '厚街', 3, '0769', '523960', '中国,广东省,东莞市,厚街镇', '113.67301', '22.940815', 'Houjie', 1);
INSERT INTO `provinces`
VALUES (441931, '凤岗镇', 441900, '凤岗', 3, '0769', '523690', '中国,广东省,东莞市,凤岗镇', '114.141194', '22.744598', 'Fenggang', 1);
INSERT INTO `provinces`
VALUES (441932, '长安镇', 441900, '长安', 3, '0769', '523850', '中国,广东省,东莞市,长安镇', '113.803939', '22.816644', 'Chang\'an', 1);
INSERT INTO `provinces`
VALUES (442000, '中山市', 440000, '中山', 2, '0760', '528403', '中国,广东省,中山市', '113.382391', '22.521113', 'Zhongshan', 1);
INSERT INTO `provinces`
VALUES (442001, '石岐区', 442000, '石岐', 3, '0760', '528400', '中国,广东省,中山市,石岐区', '113.378835', '22.52522', 'Shiqi', 1);
INSERT INTO `provinces`
VALUES (442004, '南区', 442000, '南区', 3, '0760', '528400', '中国,广东省,中山市,南区', '113.355896', '22.486568', 'Nanqu', 1);
INSERT INTO `provinces`
VALUES (442005, '五桂山区', 442000, '五桂山', 3, '0760', '528458', '中国,广东省,中山市,五桂山区', '113.41079', '22.51968', 'Wuguishan', 1);
INSERT INTO `provinces`
VALUES (442006, '火炬开发区', 442000, '火炬', 3, '0760', '528437', '中国,广东省,中山市,火炬开发区', '113.480523', '22.566082', 'Huoju', 1);
INSERT INTO `provinces`
VALUES (442007, '黄圃镇', 442000, '黄圃', 3, '0760', '528429', '中国,广东省,中山市,黄圃镇', '113.342359', '22.715116', 'Huangpu', 1);
INSERT INTO `provinces`
VALUES (442008, '南头镇', 442000, '南头', 3, '0760', '528421', '中国,广东省,中山市,南头镇', '113.296358', '22.713907', 'Nantou', 1);
INSERT INTO `provinces`
VALUES (442009, '东凤镇', 442000, '东凤', 3, '0760', '528425', '中国,广东省,中山市,东凤镇', '113.26114', '22.68775', 'Dongfeng', 1);
INSERT INTO `provinces`
VALUES (442010, '阜沙镇', 442000, '阜沙', 3, '0760', '528434', '中国,广东省,中山市,阜沙镇', '113.353024', '22.666364', 'Fusha', 1);
INSERT INTO `provinces`
VALUES (442011, '小榄镇', 442000, '小榄', 3, '0760', '528415', '中国,广东省,中山市,小榄镇', '113.244235', '22.666951', 'Xiaolan', 1);
INSERT INTO `provinces`
VALUES (442012, '东升镇', 442000, '东升', 3, '0760', '528400', '中国,广东省,中山市,东升镇', '113.296298', '22.614003', 'Dongsheng', 1);
INSERT INTO `provinces`
VALUES (442013, '古镇镇', 442000, '古镇', 3, '0760', '528422', '中国,广东省,中山市,古镇镇', '113.179745', '22.611019', 'Guzhen', 1);
INSERT INTO `provinces`
VALUES (442014, '横栏镇', 442000, '横栏', 3, '0760', '528478', '中国,广东省,中山市,横栏镇', '113.265845', '22.523202', 'Henglan', 1);
INSERT INTO `provinces`
VALUES (442015, '三角镇', 442000, '三角', 3, '0760', '528422', '中国,广东省,中山市,三角镇', '113.423624', '22.677033', 'Sanjiao', 1);
INSERT INTO `provinces`
VALUES (442016, '民众镇', 442000, '民众', 3, '0760', '528441', '中国,广东省,中山市,民众镇', '113.486025', '22.623468', 'Minzhong', 1);
INSERT INTO `provinces`
VALUES (442017, '南朗镇', 442000, '南朗', 3, '0760', '528454', '中国,广东省,中山市,南朗镇', '113.533939', '22.492378', 'Nanlang', 1);
INSERT INTO `provinces`
VALUES (442018, '港口镇', 442000, '港口', 3, '0760', '528447', '中国,广东省,中山市,港口镇', '113.382391', '22.521113', 'Gangkou', 1);
INSERT INTO `provinces`
VALUES (442019, '大涌镇', 442000, '大涌', 3, '0760', '528476', '中国,广东省,中山市,大涌镇', '113.291708', '22.467712', 'Dayong', 1);
INSERT INTO `provinces`
VALUES (442020, '沙溪镇', 442000, '沙溪', 3, '0760', '528471', '中国,广东省,中山市,沙溪镇', '113.328369', '22.526325', 'Shaxi', 1);
INSERT INTO `provinces`
VALUES (442021, '三乡镇', 442000, '三乡', 3, '0760', '528463', '中国,广东省,中山市,三乡镇', '113.4334', '22.352494', 'Sanxiang', 1);
INSERT INTO `provinces`
VALUES (442022, '板芙镇', 442000, '板芙', 3, '0760', '528459', '中国,广东省,中山市,板芙镇', '113.320346', '22.415674', 'Banfu', 1);
INSERT INTO `provinces`
VALUES (442023, '神湾镇', 442000, '神湾', 3, '0760', '528462', '中国,广东省,中山市,神湾镇', '113.359387', '22.312476', 'Shenwan', 1);
INSERT INTO `provinces`
VALUES (442024, '坦洲镇', 442000, '坦洲', 3, '0760', '528467', '中国,广东省,中山市,坦洲镇', '113.485677', '22.261269', 'Tanzhou', 1);
INSERT INTO `provinces`
VALUES (445100, '潮州市', 440000, '潮州', 2, '0768', '521000', '中国,广东省,潮州市', '116.632301', '23.661701', 'Chaozhou', 1);
INSERT INTO `provinces`
VALUES (445102, '湘桥区', 445100, '湘桥', 3, '0768', '521000', '中国,广东省,潮州市,湘桥区', '116.62805', '23.67451', 'Xiangqiao', 1);
INSERT INTO `provinces`
VALUES (445103, '潮安区', 445100, '潮安', 3, '0768', '515638', '中国,广东省,潮州市,潮安区', '116.592895', '23.643656', 'Chao\'an', 1);
INSERT INTO `provinces`
VALUES (445122, '饶平县', 445100, '饶平', 3, '0768', '515700', '中国,广东省,潮州市,饶平县', '117.00692', '23.66994', 'Raoping', 1);
INSERT INTO `provinces`
VALUES (445200, '揭阳市', 440000, '揭阳', 2, '0633', '522000', '中国,广东省,揭阳市', '116.355733', '23.543778', 'Jieyang', 1);
INSERT INTO `provinces`
VALUES (445202, '榕城区', 445200, '榕城', 3, '0633', '522000', '中国,广东省,揭阳市,榕城区', '116.3671', '23.52508', 'Rongcheng', 1);
INSERT INTO `provinces`
VALUES (445203, '揭东区', 445200, '揭东', 3, '0633', '515500', '中国,广东省,揭阳市,揭东区', '116.412947', '23.569887', 'Jiedong', 1);
INSERT INTO `provinces`
VALUES (445222, '揭西县', 445200, '揭西', 3, '0633', '515400', '中国,广东省,揭阳市,揭西县', '115.83883', '23.42714', 'Jiexi', 1);
INSERT INTO `provinces`
VALUES (445224, '惠来县', 445200, '惠来', 3, '0633', '515200', '中国,广东省,揭阳市,惠来县', '116.29599', '23.03289', 'Huilai', 1);
INSERT INTO `provinces`
VALUES (445281, '普宁市', 445200, '普宁', 3, '0633', '515300', '中国,广东省,揭阳市,普宁市', '116.16564', '23.29732', 'Puning', 1);
INSERT INTO `provinces`
VALUES (445300, '云浮市', 440000, '云浮', 2, '0766', '527300', '中国,广东省,云浮市', '112.044439', '22.929801', 'Yunfu', 1);
INSERT INTO `provinces`
VALUES (445302, '云城区', 445300, '云城', 3, '0766', '527300', '中国,广东省,云浮市,云城区', '112.03908', '22.92996', 'Yuncheng', 1);
INSERT INTO `provinces`
VALUES (445303, '云安区', 445300, '云安', 3, '0766', '527500', '中国,广东省,云浮市,云安区', '112.00936', '23.07779', 'Yun\'an', 1);
INSERT INTO `provinces`
VALUES (445321, '新兴县', 445300, '新兴', 3, '0766', '527400', '中国,广东省,云浮市,新兴县', '112.23019', '22.69734', 'Xinxing', 1);
INSERT INTO `provinces`
VALUES (445322, '郁南县', 445300, '郁南', 3, '0766', '527100', '中国,广东省,云浮市,郁南县', '111.53387', '23.23307', 'Yunan', 1);
INSERT INTO `provinces`
VALUES (445381, '罗定市', 445300, '罗定', 3, '0766', '527200', '中国,广东省,云浮市,罗定市', '111.56979', '22.76967', 'Luoding', 1);
INSERT INTO `provinces`
VALUES (450000, '广西壮族自治区', 100000, '广西', 1, '', '', '中国,广西壮族自治区', '108.320004', '22.82402', 'Guangxi', 1);
INSERT INTO `provinces`
VALUES (450100, '南宁市', 450000, '南宁', 2, '0771', '530028', '中国,广西壮族自治区,南宁市', '108.320004', '22.82402', 'Nanning', 1);
INSERT INTO `provinces`
VALUES (450102, '兴宁区', 450100, '兴宁', 3, '0771', '530023', '中国,广西壮族自治区,南宁市,兴宁区', '108.36694', '22.85355', 'Xingning', 1);
INSERT INTO `provinces`
VALUES (450103, '青秀区', 450100, '青秀', 3, '0771', '530213', '中国,广西壮族自治区,南宁市,青秀区', '108.49545', '22.78511', 'Qingxiu', 1);
INSERT INTO `provinces`
VALUES (450105, '江南区', 450100, '江南', 3, '0771', '530031', '中国,广西壮族自治区,南宁市,江南区', '108.27325', '22.78127', 'Jiangnan', 1);
INSERT INTO `provinces`
VALUES (450107, '西乡塘区', 450100, '西乡塘', 3, '0771', '530001', '中国,广西壮族自治区,南宁市,西乡塘区', '108.31347', '22.83386',
        'Xixiangtang', 1);
INSERT INTO `provinces`
VALUES (450108, '良庆区', 450100, '良庆', 3, '0771', '530219', '中国,广西壮族自治区,南宁市,良庆区', '108.41284', '22.74914', 'Liangqing',
        1);
INSERT INTO `provinces`
VALUES (450109, '邕宁区', 450100, '邕宁', 3, '0771', '530200', '中国,广西壮族自治区,南宁市,邕宁区', '108.48684', '22.75628', 'Yongning', 1);
INSERT INTO `provinces`
VALUES (450122, '武鸣县', 450100, '武鸣', 3, '0771', '530100', '中国,广西壮族自治区,南宁市,武鸣县', '108.27719', '23.15643', 'Wuming', 1);
INSERT INTO `provinces`
VALUES (450123, '隆安县', 450100, '隆安', 3, '0771', '532700', '中国,广西壮族自治区,南宁市,隆安县', '107.69192', '23.17336', 'Long\'an', 1);
INSERT INTO `provinces`
VALUES (450124, '马山县', 450100, '马山', 3, '0771', '530600', '中国,广西壮族自治区,南宁市,马山县', '108.17697', '23.70931', 'Mashan', 1);
INSERT INTO `provinces`
VALUES (450125, '上林县', 450100, '上林', 3, '0771', '530500', '中国,广西壮族自治区,南宁市,上林县', '108.60522', '23.432', 'Shanglin', 1);
INSERT INTO `provinces`
VALUES (450126, '宾阳县', 450100, '宾阳', 3, '0771', '530400', '中国,广西壮族自治区,南宁市,宾阳县', '108.81185', '23.2196', 'Binyang', 1);
INSERT INTO `provinces`
VALUES (450127, '横县', 450100, '横县', 3, '0771', '530300', '中国,广西壮族自治区,南宁市,横县', '109.26608', '22.68448', 'Hengxian', 1);
INSERT INTO `provinces`
VALUES (450128, '埌东新区', 450100, '埌东', 3, '0771', '530000', '中国,广西壮族自治区,南宁市,埌东新区', '108.419094', '22.812976', 'Langdong',
        1);
INSERT INTO `provinces`
VALUES (450200, '柳州市', 450000, '柳州', 2, '0772', '545001', '中国,广西壮族自治区,柳州市', '109.411703', '24.314617', 'Liuzhou', 1);
INSERT INTO `provinces`
VALUES (450202, '城中区', 450200, '城中', 3, '0772', '545001', '中国,广西壮族自治区,柳州市,城中区', '109.41082', '24.31543', 'Chengzhong',
        1);
INSERT INTO `provinces`
VALUES (450203, '鱼峰区', 450200, '鱼峰', 3, '0772', '545005', '中国,广西壮族自治区,柳州市,鱼峰区', '109.4533', '24.31868', 'Yufeng', 1);
INSERT INTO `provinces`
VALUES (450204, '柳南区', 450200, '柳南', 3, '0772', '545007', '中国,广西壮族自治区,柳州市,柳南区', '109.38548', '24.33599', 'Liunan', 1);
INSERT INTO `provinces`
VALUES (450205, '柳北区', 450200, '柳北', 3, '0772', '545002', '中国,广西壮族自治区,柳州市,柳北区', '109.40202', '24.36267', 'Liubei', 1);
INSERT INTO `provinces`
VALUES (450221, '柳江县', 450200, '柳江', 3, '0772', '545100', '中国,广西壮族自治区,柳州市,柳江县', '109.33273', '24.25596', 'Liujiang', 1);
INSERT INTO `provinces`
VALUES (450222, '柳城县', 450200, '柳城', 3, '0772', '545200', '中国,广西壮族自治区,柳州市,柳城县', '109.23877', '24.64951', 'Liucheng', 1);
INSERT INTO `provinces`
VALUES (450223, '鹿寨县', 450200, '鹿寨', 3, '0772', '545600', '中国,广西壮族自治区,柳州市,鹿寨县', '109.75177', '24.47306', 'Luzhai', 1);
INSERT INTO `provinces`
VALUES (450224, '融安县', 450200, '融安', 3, '0772', '545400', '中国,广西壮族自治区,柳州市,融安县', '109.39761', '25.22465', 'Rong\'an', 1);
INSERT INTO `provinces`
VALUES (469024, '临高县', 469000, '临高', 3, '0898', '571800', '中国,海南省,直辖县级,临高县', '109.687697', '19.908293', 'Lingao', 1);
INSERT INTO `provinces`
VALUES (469025, '白沙黎族自治县', 469000, '白沙', 3, '0898', '572800', '中国,海南省,直辖县级,白沙黎族自治县', '109.452606', '19.224584',
        'Baisha', 1);
INSERT INTO `provinces`
VALUES (469026, '昌江黎族自治县', 469000, '昌江', 3, '0898', '572700', '中国,海南省,直辖县级,昌江黎族自治县', '109.053351', '19.260968',
        'Changjiang', 1);
INSERT INTO `provinces`
VALUES (469027, '乐东黎族自治县', 469000, '乐东', 3, '0898', '572500', '中国,海南省,直辖县级,乐东黎族自治县', '109.175444', '18.74758', 'Ledong',
        1);
INSERT INTO `provinces`
VALUES (469028, '陵水黎族自治县', 469000, '陵水', 3, '0898', '572400', '中国,海南省,直辖县级,陵水黎族自治县', '110.037218', '18.505006',
        'Lingshui', 1);
INSERT INTO `provinces`
VALUES (469029, '保亭黎族苗族自治县', 469000, '保亭', 3, '0898', '572300', '中国,海南省,直辖县级,保亭黎族苗族自治县', '109.70245', '18.636371',
        'Baoting', 1);
INSERT INTO `provinces`
VALUES (469030, '琼中黎族苗族自治县', 469000, '琼中', 3, '0898', '572900', '中国,海南省,直辖县级,琼中黎族苗族自治县', '109.839996', '19.03557',
        'Qiongzhong', 1);
INSERT INTO `provinces`
VALUES (500000, '重庆', 100000, '重庆', 1, '', '', '中国,重庆', '106.504962', '29.533155', 'Chongqing', 1);
INSERT INTO `provinces`
VALUES (500100, '重庆市', 500000, '重庆', 2, '023', '400000', '中国,重庆,重庆市', '106.504962', '29.533155', 'Chongqing', 1);
INSERT INTO `provinces`
VALUES (500101, '万州区', 500100, '万州', 3, '023', '404000', '中国,重庆,重庆市,万州区', '108.40869', '30.80788', 'Wanzhou', 1);
INSERT INTO `provinces`
VALUES (500102, '涪陵区', 500100, '涪陵', 3, '023', '408000', '中国,重庆,重庆市,涪陵区', '107.39007', '29.70292', 'Fuling', 1);
INSERT INTO `provinces`
VALUES (500103, '渝中区', 500100, '渝中', 3, '023', '400010', '中国,重庆,重庆市,渝中区', '106.56901', '29.55279', 'Yuzhong', 1);
INSERT INTO `provinces`
VALUES (500104, '大渡口区', 500100, '大渡口', 3, '023', '400080', '中国,重庆,重庆市,大渡口区', '106.48262', '29.48447', 'Dadukou', 1);
INSERT INTO `provinces`
VALUES (500105, '江北区', 500100, '江北', 3, '023', '400020', '中国,重庆,重庆市,江北区', '106.57434', '29.60658', 'Jiangbei', 1);
INSERT INTO `provinces`
VALUES (500106, '沙坪坝区', 500100, '沙坪坝', 3, '023', '400030', '中国,重庆,重庆市,沙坪坝区', '106.45752', '29.54113', 'Shapingba', 1);
INSERT INTO `provinces`
VALUES (500107, '九龙坡区', 500100, '九龙坡', 3, '023', '400050', '中国,重庆,重庆市,九龙坡区', '106.51107', '29.50197', 'Jiulongpo', 1);
INSERT INTO `provinces`
VALUES (500108, '南岸区', 500100, '南岸', 3, '023', '400064', '中国,重庆,重庆市,南岸区', '106.56347', '29.52311', 'Nan\'an', 1);
INSERT INTO `provinces`
VALUES (500109, '北碚区', 500100, '北碚', 3, '023', '400700', '中国,重庆,重庆市,北碚区', '106.39614', '29.80574', 'Beibei', 1);
INSERT INTO `provinces`
VALUES (500110, '綦江区', 500100, '綦江', 3, '023', '400800', '中国,重庆,重庆市,綦江区', '106.926779', '28.960656', 'Qijiang', 1);
INSERT INTO `provinces`
VALUES (500111, '大足区', 500100, '大足', 3, '023', '400900', '中国,重庆,重庆市,大足区', '105.768121', '29.484025', 'Dazu', 1);
INSERT INTO `provinces`
VALUES (500112, '渝北区', 500100, '渝北', 3, '023', '401120', '中国,重庆,重庆市,渝北区', '106.6307', '29.7182', 'Yubei', 1);
INSERT INTO `provinces`
VALUES (500113, '巴南区', 500100, '巴南', 3, '023', '401320', '中国,重庆,重庆市,巴南区', '106.52365', '29.38311', 'Banan', 1);
INSERT INTO `provinces`
VALUES (500114, '黔江区', 500100, '黔江', 3, '023', '409700', '中国,重庆,重庆市,黔江区', '108.7709', '29.5332', 'Qianjiang', 1);
INSERT INTO `provinces`
VALUES (500115, '长寿区', 500100, '长寿', 3, '023', '401220', '中国,重庆,重庆市,长寿区', '107.08166', '29.85359', 'Changshou', 1);
INSERT INTO `provinces`
VALUES (500116, '江津区', 500100, '江津', 3, '023', '402260', '中国,重庆,重庆市,江津区', '106.25912', '29.29008', 'Jiangjin', 1);
INSERT INTO `provinces`
VALUES (500117, '合川区', 500100, '合川', 3, '023', '401520', '中国,重庆,重庆市,合川区', '106.27633', '29.97227', 'Hechuan', 1);
INSERT INTO `provinces`
VALUES (500118, '永川区', 500100, '永川', 3, '023', '402160', '中国,重庆,重庆市,永川区', '105.927', '29.35593', 'Yongchuan', 1);
INSERT INTO `provinces`
VALUES (500119, '南川区', 500100, '南川', 3, '023', '408400', '中国,重庆,重庆市,南川区', '107.09936', '29.15751', 'Nanchuan', 1);
INSERT INTO `provinces`
VALUES (500120, '璧山区', 500100, '璧山', 3, '023', '402760', '中国,重庆,重庆市,璧山区', '106.231126', '29.593581', 'Bishan', 1);
INSERT INTO `provinces`
VALUES (500151, '铜梁区', 500100, '铜梁', 3, '023', '402560', '中国,重庆,重庆市,铜梁区', '106.054948', '29.839944', 'Tongliang', 1);
INSERT INTO `provinces`
VALUES (500223, '潼南县', 500100, '潼南', 3, '023', '402660', '中国,重庆,重庆市,潼南县', '105.84005', '30.1912', 'Tongnan', 1);
INSERT INTO `provinces`
VALUES (500226, '荣昌县', 500100, '荣昌', 3, '023', '402460', '中国,重庆,重庆市,荣昌县', '105.59442', '29.40488', 'Rongchang', 1);
INSERT INTO `provinces`
VALUES (500228, '梁平县', 500100, '梁平', 3, '023', '405200', '中国,重庆,重庆市,梁平县', '107.79998', '30.67545', 'Liangping', 1);
INSERT INTO `provinces`
VALUES (500229, '城口县', 500100, '城口', 3, '023', '405900', '中国,重庆,重庆市,城口县', '108.66513', '31.94801', 'Chengkou', 1);
INSERT INTO `provinces`
VALUES (500230, '丰都县', 500100, '丰都', 3, '023', '408200', '中国,重庆,重庆市,丰都县', '107.73098', '29.86348', 'Fengdu', 1);
INSERT INTO `provinces`
VALUES (500231, '垫江县', 500100, '垫江', 3, '023', '408300', '中国,重庆,重庆市,垫江县', '107.35446', '30.33359', 'Dianjiang', 1);
INSERT INTO `provinces`
VALUES (500232, '武隆县', 500100, '武隆', 3, '023', '408500', '中国,重庆,重庆市,武隆县', '107.7601', '29.32548', 'Wulong', 1);
INSERT INTO `provinces`
VALUES (500233, '忠县', 500100, '忠县', 3, '023', '404300', '中国,重庆,重庆市,忠县', '108.03689', '30.28898', 'Zhongxian', 1);
INSERT INTO `provinces`
VALUES (500234, '开县', 500100, '开县', 3, '023', '405400', '中国,重庆,重庆市,开县', '108.39306', '31.16095', 'Kaixian', 1);
INSERT INTO `provinces`
VALUES (500235, '云阳县', 500100, '云阳', 3, '023', '404500', '中国,重庆,重庆市,云阳县', '108.69726', '30.93062', 'Yunyang', 1);
INSERT INTO `provinces`
VALUES (500236, '奉节县', 500100, '奉节', 3, '023', '404600', '中国,重庆,重庆市,奉节县', '109.46478', '31.01825', 'Fengjie', 1);
INSERT INTO `provinces`
VALUES (500237, '巫山县', 500100, '巫山', 3, '023', '404700', '中国,重庆,重庆市,巫山县', '109.87814', '31.07458', 'Wushan', 1);
INSERT INTO `provinces`
VALUES (500238, '巫溪县', 500100, '巫溪', 3, '023', '405800', '中国,重庆,重庆市,巫溪县', '109.63128', '31.39756', 'Wuxi', 1);
INSERT INTO `provinces`
VALUES (500240, '石柱土家族自治县', 500100, '石柱', 3, '023', '409100', '中国,重庆,重庆市,石柱土家族自治县', '108.11389', '30.00054', 'Shizhu',
        1);
INSERT INTO `provinces`
VALUES (500241, '秀山土家族苗族自治县', 500100, '秀山', 3, '023', '409900', '中国,重庆,重庆市,秀山土家族苗族自治县', '108.98861', '28.45062',
        'Xiushan', 1);
INSERT INTO `provinces`
VALUES (500242, '酉阳土家族苗族自治县', 500100, '酉阳', 3, '023', '409800', '中国,重庆,重庆市,酉阳土家族苗族自治县', '108.77212', '28.8446',
        'Youyang', 1);
INSERT INTO `provinces`
VALUES (500243, '彭水苗族土家族自治县', 500100, '彭水', 3, '023', '409600', '中国,重庆,重庆市,彭水苗族土家族自治县', '108.16638', '29.29516',
        'Pengshui', 1);
INSERT INTO `provinces`
VALUES (500300, '两江新区', 500000, '两江新区', 2, '023', '400000', '中国,重庆,两江新区', '106.463344', '29.729153', 'Liangjiangxinqu',
        1);
INSERT INTO `provinces`
VALUES (500301, '北部新区', 500300, '北部新区', 3, '023', '400000', '中国,重庆,两江新区,北部新区', '106.488841', '29.667062', 'Beibuxinqu',
        1);
INSERT INTO `provinces`
VALUES (500302, '保税港区', 500300, '保税港区', 3, '023', '400000', '中国,重庆,两江新区,保税港区', '106.638184', '29.716311',
        'Baoshuigangqu', 1);
INSERT INTO `provinces`
VALUES (500303, '工业园区', 500300, '工业园区', 3, '023', '400000', '中国,重庆,两江新区,工业园区', '106.626434', '29.55554', 'Gongyeyuanqu',
        1);
INSERT INTO `provinces`
VALUES (510000, '四川省', 100000, '四川', 1, '', '', '中国,四川省', '104.065735', '30.659462', 'Sichuan', 1);
INSERT INTO `provinces`
VALUES (510100, '成都市', 510000, '成都', 2, '028', '610015', '中国,四川省,成都市', '104.065735', '30.659462', 'Chengdu', 1);
INSERT INTO `provinces`
VALUES (510104, '锦江区', 510100, '锦江', 3, '028', '610021', '中国,四川省,成都市,锦江区', '104.08347', '30.65614', 'Jinjiang', 1);
INSERT INTO `provinces`
VALUES (510105, '青羊区', 510100, '青羊', 3, '028', '610031', '中国,四川省,成都市,青羊区', '104.06151', '30.67387', 'Qingyang', 1);
INSERT INTO `provinces`
VALUES (510106, '金牛区', 510100, '金牛', 3, '028', '610036', '中国,四川省,成都市,金牛区', '104.05114', '30.69126', 'Jinniu', 1);
INSERT INTO `provinces`
VALUES (510107, '武侯区', 510100, '武侯', 3, '028', '610041', '中国,四川省,成都市,武侯区', '104.04303', '30.64235', 'Wuhou', 1);
INSERT INTO `provinces`
VALUES (510108, '成华区', 510100, '成华', 3, '028', '610066', '中国,四川省,成都市,成华区', '104.10193', '30.65993', 'Chenghua', 1);
INSERT INTO `provinces`
VALUES (510112, '龙泉驿区', 510100, '龙泉驿', 3, '028', '610100', '中国,四川省,成都市,龙泉驿区', '104.27462', '30.55658', 'Longquanyi', 1);
INSERT INTO `provinces`
VALUES (510113, '青白江区', 510100, '青白江', 3, '028', '610300', '中国,四川省,成都市,青白江区', '104.251', '30.87841', 'Qingbaijiang', 1);
INSERT INTO `provinces`
VALUES (510114, '新都区', 510100, '新都', 3, '028', '610500', '中国,四川省,成都市,新都区', '104.15921', '30.82314', 'Xindu', 1);
INSERT INTO `provinces`
VALUES (510115, '温江区', 510100, '温江', 3, '028', '611130', '中国,四川省,成都市,温江区', '103.84881', '30.68444', 'Wenjiang', 1);
INSERT INTO `provinces`
VALUES (510121, '金堂县', 510100, '金堂', 3, '028', '610400', '中国,四川省,成都市,金堂县', '104.41195', '30.86195', 'Jintang', 1);
INSERT INTO `provinces`
VALUES (510122, '双流县', 510100, '双流', 3, '028', '610200', '中国,四川省,成都市,双流县', '103.92373', '30.57444', 'Shuangliu', 1);
INSERT INTO `provinces`
VALUES (510124, '郫县', 510100, '郫县', 3, '028', '611730', '中国,四川省,成都市,郫县', '103.88717', '30.81054', 'Pixian', 1);
INSERT INTO `provinces`
VALUES (510129, '大邑县', 510100, '大邑', 3, '028', '611330', '中国,四川省,成都市,大邑县', '103.52075', '30.58738', 'Dayi', 1);
INSERT INTO `provinces`
VALUES (510131, '蒲江县', 510100, '蒲江', 3, '028', '611630', '中国,四川省,成都市,蒲江县', '103.50616', '30.19667', 'Pujiang', 1);
INSERT INTO `provinces`
VALUES (510132, '新津县', 510100, '新津', 3, '028', '611430', '中国,四川省,成都市,新津县', '103.8114', '30.40983', 'Xinjin', 1);
INSERT INTO `provinces`
VALUES (510181, '都江堰市', 510100, '都江堰', 3, '028', '611830', '中国,四川省,成都市,都江堰市', '103.61941', '30.99825', 'Dujiangyan', 1);
INSERT INTO `provinces`
VALUES (510182, '彭州市', 510100, '彭州', 3, '028', '611930', '中国,四川省,成都市,彭州市', '103.958', '30.99011', 'Pengzhou', 1);
INSERT INTO `provinces`
VALUES (510183, '邛崃市', 510100, '邛崃', 3, '028', '611530', '中国,四川省,成都市,邛崃市', '103.46283', '30.41489', 'Qionglai', 1);
INSERT INTO `provinces`
VALUES (510184, '崇州市', 510100, '崇州', 3, '028', '611230', '中国,四川省,成都市,崇州市', '103.67285', '30.63014', 'Chongzhou', 1);
INSERT INTO `provinces`
VALUES (510300, '自贡市', 510000, '自贡', 2, '0813', '643000', '中国,四川省,自贡市', '104.773447', '29.352765', 'Zigong', 1);
INSERT INTO `provinces`
VALUES (510302, '自流井区', 510300, '自流井', 3, '0813', '643000', '中国,四川省,自贡市,自流井区', '104.77719', '29.33745', 'Ziliujing', 1);
INSERT INTO `provinces`
VALUES (510303, '贡井区', 510300, '贡井', 3, '0813', '643020', '中国,四川省,自贡市,贡井区', '104.71536', '29.34576', 'Gongjing', 1);
INSERT INTO `provinces`
VALUES (510304, '大安区', 510300, '大安', 3, '0813', '643010', '中国,四川省,自贡市,大安区', '104.77383', '29.36364', 'Da\'an', 1);
INSERT INTO `provinces`
VALUES (510311, '沿滩区', 510300, '沿滩', 3, '0813', '643030', '中国,四川省,自贡市,沿滩区', '104.88012', '29.26611', 'Yantan', 1);
INSERT INTO `provinces`
VALUES (510321, '荣县', 510300, '荣县', 3, '0813', '643100', '中国,四川省,自贡市,荣县', '104.4176', '29.44445', 'Rongxian', 1);
INSERT INTO `provinces`
VALUES (510322, '富顺县', 510300, '富顺', 3, '0813', '643200', '中国,四川省,自贡市,富顺县', '104.97491', '29.18123', 'Fushun', 1);
INSERT INTO `provinces`
VALUES (510400, '攀枝花市', 510000, '攀枝花', 2, '0812', '617000', '中国,四川省,攀枝花市', '101.716007', '26.580446', 'Panzhihua', 1);
INSERT INTO `provinces`
VALUES (510402, '东区', 510400, '东区', 3, '0812', '617067', '中国,四川省,攀枝花市,东区', '101.7052', '26.54677', 'Dongqu', 1);
INSERT INTO `provinces`
VALUES (510403, '西区', 510400, '西区', 3, '0812', '617068', '中国,四川省,攀枝花市,西区', '101.63058', '26.59753', 'Xiqu', 1);
INSERT INTO `provinces`
VALUES (510411, '仁和区', 510400, '仁和', 3, '0812', '617061', '中国,四川省,攀枝花市,仁和区', '101.73812', '26.49841', 'Renhe', 1);
INSERT INTO `provinces`
VALUES (510421, '米易县', 510400, '米易', 3, '0812', '617200', '中国,四川省,攀枝花市,米易县', '102.11132', '26.88718', 'Miyi', 1);
INSERT INTO `provinces`
VALUES (510422, '盐边县', 510400, '盐边', 3, '0812', '617100', '中国,四川省,攀枝花市,盐边县', '101.85446', '26.68847', 'Yanbian', 1);
INSERT INTO `provinces`
VALUES (510500, '泸州市', 510000, '泸州', 2, '0830', '646000', '中国,四川省,泸州市', '105.443348', '28.889138', 'Luzhou', 1);
INSERT INTO `provinces`
VALUES (510502, '江阳区', 510500, '江阳', 3, '0830', '646000', '中国,四川省,泸州市,江阳区', '105.45336', '28.88934', 'Jiangyang', 1);
INSERT INTO `provinces`
VALUES (510503, '纳溪区', 510500, '纳溪', 3, '0830', '646300', '中国,四川省,泸州市,纳溪区', '105.37255', '28.77343', 'Naxi', 1);
INSERT INTO `provinces`
VALUES (510504, '龙马潭区', 510500, '龙马潭', 3, '0830', '646000', '中国,四川省,泸州市,龙马潭区', '105.43774', '28.91308', 'Longmatan', 1);
INSERT INTO `provinces`
VALUES (510521, '泸县', 510500, '泸县', 3, '0830', '646106', '中国,四川省,泸州市,泸县', '105.38192', '29.15041', 'Luxian', 1);
INSERT INTO `provinces`
VALUES (510522, '合江县', 510500, '合江', 3, '0830', '646200', '中国,四川省,泸州市,合江县', '105.8352', '28.81005', 'Hejiang', 1);
INSERT INTO `provinces`
VALUES (510524, '叙永县', 510500, '叙永', 3, '0830', '646400', '中国,四川省,泸州市,叙永县', '105.44473', '28.15586', 'Xuyong', 1);
INSERT INTO `provinces`
VALUES (510525, '古蔺县', 510500, '古蔺', 3, '0830', '646500', '中国,四川省,泸州市,古蔺县', '105.81347', '28.03867', 'Gulin', 1);
INSERT INTO `provinces`
VALUES (510600, '德阳市', 510000, '德阳', 2, '0838', '618000', '中国,四川省,德阳市', '104.398651', '31.127991', 'Deyang', 1);
INSERT INTO `provinces`
VALUES (510603, '旌阳区', 510600, '旌阳', 3, '0838', '618000', '中国,四川省,德阳市,旌阳区', '104.39367', '31.13906', 'Jingyang', 1);
INSERT INTO `provinces`
VALUES (510623, '中江县', 510600, '中江', 3, '0838', '618100', '中国,四川省,德阳市,中江县', '104.67861', '31.03297', 'Zhongjiang', 1);
INSERT INTO `provinces`
VALUES (510626, '罗江县', 510600, '罗江', 3, '0838', '618500', '中国,四川省,德阳市,罗江县', '104.51025', '31.31665', 'Luojiang', 1);
INSERT INTO `provinces`
VALUES (510681, '广汉市', 510600, '广汉', 3, '0838', '618300', '中国,四川省,德阳市,广汉市', '104.28234', '30.97686', 'Guanghan', 1);
INSERT INTO `provinces`
VALUES (510682, '什邡市', 510600, '什邡', 3, '0838', '618400', '中国,四川省,德阳市,什邡市', '104.16754', '31.1264', 'Shifang', 1);
INSERT INTO `provinces`
VALUES (510683, '绵竹市', 510600, '绵竹', 3, '0838', '618200', '中国,四川省,德阳市,绵竹市', '104.22076', '31.33772', 'Mianzhu', 1);
INSERT INTO `provinces`
VALUES (510700, '绵阳市', 510000, '绵阳', 2, '0816', '621000', '中国,四川省,绵阳市', '104.741722', '31.46402', 'Mianyang', 1);
INSERT INTO `provinces`
VALUES (510703, '涪城区', 510700, '涪城', 3, '0816', '621000', '中国,四川省,绵阳市,涪城区', '104.75719', '31.45522', 'Fucheng', 1);
INSERT INTO `provinces`
VALUES (510704, '游仙区', 510700, '游仙', 3, '0816', '621022', '中国,四川省,绵阳市,游仙区', '104.77092', '31.46574', 'Youxian', 1);
INSERT INTO `provinces`
VALUES (510722, '三台县', 510700, '三台', 3, '0816', '621100', '中国,四川省,绵阳市,三台县', '105.09079', '31.09179', 'Santai', 1);
INSERT INTO `provinces`
VALUES (510723, '盐亭县', 510700, '盐亭', 3, '0816', '621600', '中国,四川省,绵阳市,盐亭县', '105.3898', '31.22176', 'Yanting', 1);
INSERT INTO `provinces`
VALUES (510724, '安县', 510700, '安县', 3, '0816', '622650', '中国,四川省,绵阳市,安县', '104.56738', '31.53487', 'Anxian', 1);
INSERT INTO `provinces`
VALUES (510725, '梓潼县', 510700, '梓潼', 3, '0816', '622150', '中国,四川省,绵阳市,梓潼县', '105.16183', '31.6359', 'Zitong', 1);
INSERT INTO `provinces`
VALUES (510726, '北川羌族自治县', 510700, '北川', 3, '0816', '622750', '中国,四川省,绵阳市,北川羌族自治县', '104.46408', '31.83286', 'Beichuan',
        1);
INSERT INTO `provinces`
VALUES (510727, '平武县', 510700, '平武', 3, '0816', '612650', '中国,四川省,绵阳市,平武县', '104.52862', '32.40791', 'Pingwu', 1);
INSERT INTO `provinces`
VALUES (510781, '江油市', 510700, '江油', 3, '0816', '621700', '中国,四川省,绵阳市,江油市', '104.74539', '31.77775', 'Jiangyou', 1);
INSERT INTO `provinces`
VALUES (510800, '广元市', 510000, '广元', 2, '0839', '628000', '中国,四川省,广元市', '105.829757', '32.433668', 'Guangyuan', 1);
INSERT INTO `provinces`
VALUES (510802, '利州区', 510800, '利州', 3, '0839', '628017', '中国,四川省,广元市,利州区', '105.826194', '32.432276', 'Lizhou', 1);
INSERT INTO `provinces`
VALUES (510811, '昭化区', 510800, '昭化', 3, '0839', '628017', '中国,四川省,广元市,昭化区', '105.640491', '32.386518', 'Zhaohua', 1);
INSERT INTO `provinces`
VALUES (510812, '朝天区', 510800, '朝天', 3, '0839', '628017', '中国,四川省,广元市,朝天区', '105.89273', '32.64398', 'Chaotian', 1);
INSERT INTO `provinces`
VALUES (510821, '旺苍县', 510800, '旺苍', 3, '0839', '628200', '中国,四川省,广元市,旺苍县', '106.29022', '32.22845', 'Wangcang', 1);
INSERT INTO `provinces`
VALUES (510822, '青川县', 510800, '青川', 3, '0839', '628100', '中国,四川省,广元市,青川县', '105.2391', '32.58563', 'Qingchuan', 1);
INSERT INTO `provinces`
VALUES (510823, '剑阁县', 510800, '剑阁', 3, '0839', '628300', '中国,四川省,广元市,剑阁县', '105.5252', '32.28845', 'Jiange', 1);
INSERT INTO `provinces`
VALUES (510824, '苍溪县', 510800, '苍溪', 3, '0839', '628400', '中国,四川省,广元市,苍溪县', '105.936', '31.73209', 'Cangxi', 1);
INSERT INTO `provinces`
VALUES (510900, '遂宁市', 510000, '遂宁', 2, '0825', '629000', '中国,四川省,遂宁市', '105.571331', '30.513311', 'Suining', 1);
INSERT INTO `provinces`
VALUES (510903, '船山区', 510900, '船山', 3, '0825', '629000', '中国,四川省,遂宁市,船山区', '105.5809', '30.49991', 'Chuanshan', 1);
INSERT INTO `provinces`
VALUES (510904, '安居区', 510900, '安居', 3, '0825', '629000', '中国,四川省,遂宁市,安居区', '105.46402', '30.35778', 'Anju', 1);
INSERT INTO `provinces`
VALUES (510921, '蓬溪县', 510900, '蓬溪', 3, '0825', '629100', '中国,四川省,遂宁市,蓬溪县', '105.70752', '30.75775', 'Pengxi', 1);
INSERT INTO `provinces`
VALUES (510922, '射洪县', 510900, '射洪', 3, '0825', '629200', '中国,四川省,遂宁市,射洪县', '105.38922', '30.87203', 'Shehong', 1);
INSERT INTO `provinces`
VALUES (510923, '大英县', 510900, '大英', 3, '0825', '629300', '中国,四川省,遂宁市,大英县', '105.24346', '30.59434', 'Daying', 1);
INSERT INTO `provinces`
VALUES (511000, '内江市', 510000, '内江', 2, '0832', '641000', '中国,四川省,内江市', '105.066138', '29.58708', 'Neijiang', 1);
INSERT INTO `provinces`
VALUES (511002, '市中区', 511000, '市中区', 3, '0832', '641000', '中国,四川省,内江市,市中区', '105.0679', '29.58709', 'Shizhongqu', 1);
INSERT INTO `provinces`
VALUES (511011, '东兴区', 511000, '东兴', 3, '0832', '641100', '中国,四川省,内江市,东兴区', '105.07554', '29.59278', 'Dongxing', 1);
INSERT INTO `provinces`
VALUES (511024, '威远县', 511000, '威远', 3, '0832', '642450', '中国,四川省,内江市,威远县', '104.66955', '29.52823', 'Weiyuan', 1);
INSERT INTO `provinces`
VALUES (511025, '资中县', 511000, '资中', 3, '0832', '641200', '中国,四川省,内江市,资中县', '104.85205', '29.76409', 'Zizhong', 1);
INSERT INTO `provinces`
VALUES (511028, '隆昌县', 511000, '隆昌', 3, '0832', '642150', '中国,四川省,内江市,隆昌县', '105.28738', '29.33937', 'Longchang', 1);
INSERT INTO `provinces`
VALUES (511100, '乐山市', 510000, '乐山', 2, '0833', '614000', '中国,四川省,乐山市', '103.761263', '29.582024', 'Leshan', 1);
INSERT INTO `provinces`
VALUES (511102, '市中区', 511100, '市中区', 3, '0833', '614000', '中国,四川省,乐山市,市中区', '103.76159', '29.55543', 'Shizhongqu', 1);
INSERT INTO `provinces`
VALUES (511111, '沙湾区', 511100, '沙湾', 3, '0833', '614900', '中国,四川省,乐山市,沙湾区', '103.54873', '29.41194', 'Shawan', 1);
INSERT INTO `provinces`
VALUES (511112, '五通桥区', 511100, '五通桥', 3, '0833', '614800', '中国,四川省,乐山市,五通桥区', '103.82345', '29.40344', 'Wutongqiao',
        1);
INSERT INTO `provinces`
VALUES (511113, '金口河区', 511100, '金口河', 3, '0833', '614700', '中国,四川省,乐山市,金口河区', '103.07858', '29.24578', 'Jinkouhe', 1);
INSERT INTO `provinces`
VALUES (511123, '犍为县', 511100, '犍为', 3, '0833', '614400', '中国,四川省,乐山市,犍为县', '103.94989', '29.20973', 'Qianwei', 1);
INSERT INTO `provinces`
VALUES (511124, '井研县', 511100, '井研', 3, '0833', '613100', '中国,四川省,乐山市,井研县', '104.07019', '29.65228', 'Jingyan', 1);
INSERT INTO `provinces`
VALUES (511126, '夹江县', 511100, '夹江', 3, '0833', '614100', '中国,四川省,乐山市,夹江县', '103.57199', '29.73868', 'Jiajiang', 1);
INSERT INTO `provinces`
VALUES (511129, '沐川县', 511100, '沐川', 3, '0833', '614500', '中国,四川省,乐山市,沐川县', '103.90353', '28.95646', 'Muchuan', 1);
INSERT INTO `provinces`
VALUES (511132, '峨边彝族自治县', 511100, '峨边', 3, '0833', '614300', '中国,四川省,乐山市,峨边彝族自治县', '103.26339', '29.23004', 'Ebian',
        1);
INSERT INTO `provinces`
VALUES (511133, '马边彝族自治县', 511100, '马边', 3, '0833', '614600', '中国,四川省,乐山市,马边彝族自治县', '103.54617', '28.83593', 'Mabian',
        1);
INSERT INTO `provinces`
VALUES (511181, '峨眉山市', 511100, '峨眉山', 3, '0833', '614200', '中国,四川省,乐山市,峨眉山市', '103.4844', '29.60117', 'Emeishan', 1);
INSERT INTO `provinces`
VALUES (511300, '南充市', 510000, '南充', 2, '0817', '637000', '中国,四川省,南充市', '106.082974', '30.795281', 'Nanchong', 1);
INSERT INTO `provinces`
VALUES (511302, '顺庆区', 511300, '顺庆', 3, '0817', '637000', '中国,四川省,南充市,顺庆区', '106.09216', '30.79642', 'Shunqing', 1);
INSERT INTO `provinces`
VALUES (511303, '高坪区', 511300, '高坪', 3, '0817', '637100', '中国,四川省,南充市,高坪区', '106.11894', '30.78162', 'Gaoping', 1);
INSERT INTO `provinces`
VALUES (511304, '嘉陵区', 511300, '嘉陵', 3, '0817', '637100', '中国,四川省,南充市,嘉陵区', '106.07141', '30.75848', 'Jialing', 1);
INSERT INTO `provinces`
VALUES (511321, '南部县', 511300, '南部', 3, '0817', '637300', '中国,四川省,南充市,南部县', '106.06738', '31.35451', 'Nanbu', 1);
INSERT INTO `provinces`
VALUES (511322, '营山县', 511300, '营山', 3, '0817', '637700', '中国,四川省,南充市,营山县', '106.56637', '31.07747', 'Yingshan', 1);
INSERT INTO `provinces`
VALUES (511323, '蓬安县', 511300, '蓬安', 3, '0817', '637800', '中国,四川省,南充市,蓬安县', '106.41262', '31.02964', 'Peng\'an', 1);
INSERT INTO `provinces`
VALUES (511324, '仪陇县', 511300, '仪陇', 3, '0817', '637600', '中国,四川省,南充市,仪陇县', '106.29974', '31.27628', 'Yilong', 1);
INSERT INTO `provinces`
VALUES (511325, '西充县', 511300, '西充', 3, '0817', '637200', '中国,四川省,南充市,西充县', '105.89996', '30.9969', 'Xichong', 1);
INSERT INTO `provinces`
VALUES (511381, '阆中市', 511300, '阆中', 3, '0817', '637400', '中国,四川省,南充市,阆中市', '106.00494', '31.55832', 'Langzhong', 1);
INSERT INTO `provinces`
VALUES (511400, '眉山市', 510000, '眉山', 2, '028', '620020', '中国,四川省,眉山市', '103.831788', '30.048318', 'Meishan', 1);
INSERT INTO `provinces`
VALUES (511402, '东坡区', 511400, '东坡', 3, '028', '620010', '中国,四川省,眉山市,东坡区', '103.832', '30.04219', 'Dongpo', 1);
INSERT INTO `provinces`
VALUES (511403, '彭山区', 511400, '彭山', 3, '028', '620860', '中国,四川省,眉山市,彭山区', '103.87268', '30.19283', 'Pengshan', 1);
INSERT INTO `provinces`
VALUES (511421, '仁寿县', 511400, '仁寿', 3, '028', '620500', '中国,四川省,眉山市,仁寿县', '104.13412', '29.99599', 'Renshou', 1);
INSERT INTO `provinces`
VALUES (511423, '洪雅县', 511400, '洪雅', 3, '028', '620360', '中国,四川省,眉山市,洪雅县', '103.37313', '29.90661', 'Hongya', 1);
INSERT INTO `provinces`
VALUES (511424, '丹棱县', 511400, '丹棱', 3, '028', '620200', '中国,四川省,眉山市,丹棱县', '103.51339', '30.01562', 'Danling', 1);
INSERT INTO `provinces`
VALUES (511425, '青神县', 511400, '青神', 3, '028', '620460', '中国,四川省,眉山市,青神县', '103.84771', '29.83235', 'Qingshen', 1);
INSERT INTO `provinces`
VALUES (511500, '宜宾市', 510000, '宜宾', 2, '0831', '644000', '中国,四川省,宜宾市', '104.630825', '28.760189', 'Yibin', 1);
INSERT INTO `provinces`
VALUES (511502, '翠屏区', 511500, '翠屏', 3, '0831', '644000', '中国,四川省,宜宾市,翠屏区', '104.61978', '28.76566', 'Cuiping', 1);
INSERT INTO `provinces`
VALUES (511503, '南溪区', 511500, '南溪', 3, '0831', '644100', '中国,四川省,宜宾市,南溪区', '104.981133', '28.839806', 'Nanxi', 1);
INSERT INTO `provinces`
VALUES (511521, '宜宾县', 511500, '宜宾', 3, '0831', '644600', '中国,四川省,宜宾市,宜宾县', '104.53314', '28.68996', 'Yibin', 1);
INSERT INTO `provinces`
VALUES (511523, '江安县', 511500, '江安', 3, '0831', '644200', '中国,四川省,宜宾市,江安县', '105.06683', '28.72385', 'Jiang\'an', 1);
INSERT INTO `provinces`
VALUES (511524, '长宁县', 511500, '长宁', 3, '0831', '644300', '中国,四川省,宜宾市,长宁县', '104.9252', '28.57777', 'Changning', 1);
INSERT INTO `provinces`
VALUES (511525, '高县', 511500, '高县', 3, '0831', '645150', '中国,四川省,宜宾市,高县', '104.51754', '28.43619', 'Gaoxian', 1);
INSERT INTO `provinces`
VALUES (511526, '珙县', 511500, '珙县', 3, '0831', '644500', '中国,四川省,宜宾市,珙县', '104.71398', '28.44512', 'Gongxian', 1);
INSERT INTO `provinces`
VALUES (511527, '筠连县', 511500, '筠连', 3, '0831', '645250', '中国,四川省,宜宾市,筠连县', '104.51217', '28.16495', 'Junlian', 1);
INSERT INTO `provinces`
VALUES (511528, '兴文县', 511500, '兴文', 3, '0831', '644400', '中国,四川省,宜宾市,兴文县', '105.23675', '28.3044', 'Xingwen', 1);
INSERT INTO `provinces`
VALUES (511529, '屏山县', 511500, '屏山', 3, '0831', '645350', '中国,四川省,宜宾市,屏山县', '104.16293', '28.64369', 'Pingshan', 1);
INSERT INTO `provinces`
VALUES (511600, '广安市', 510000, '广安', 2, '0826', '638000', '中国,四川省,广安市', '106.633369', '30.456398', 'Guang\'an', 1);
INSERT INTO `provinces`
VALUES (511602, '广安区', 511600, '广安', 3, '0826', '638000', '中国,四川省,广安市,广安区', '106.64163', '30.47389', 'Guang\'an', 1);
INSERT INTO `provinces`
VALUES (511603, '前锋区', 511600, '前锋', 3, '0826', '638019', '中国,四川省,广安市,前锋区', '106.893537', '30.494572', 'Qianfeng', 1);
INSERT INTO `provinces`
VALUES (511621, '岳池县', 511600, '岳池', 3, '0826', '638300', '中国,四川省,广安市,岳池县', '106.44079', '30.53918', 'Yuechi', 1);
INSERT INTO `provinces`
VALUES (511622, '武胜县', 511600, '武胜', 3, '0826', '638400', '中国,四川省,广安市,武胜县', '106.29592', '30.34932', 'Wusheng', 1);
INSERT INTO `provinces`
VALUES (511623, '邻水县', 511600, '邻水', 3, '0826', '638500', '中国,四川省,广安市,邻水县', '106.92968', '30.33449', 'Linshui', 1);
INSERT INTO `provinces`
VALUES (511681, '华蓥市', 511600, '华蓥', 3, '0826', '638600', '中国,四川省,广安市,华蓥市', '106.78466', '30.39007', 'Huaying', 1);
INSERT INTO `provinces`
VALUES (511700, '达州市', 510000, '达州', 2, '0818', '635000', '中国,四川省,达州市', '107.502262', '31.209484', 'Dazhou', 1);
INSERT INTO `provinces`
VALUES (511702, '通川区', 511700, '通川', 3, '0818', '635000', '中国,四川省,达州市,通川区', '107.50456', '31.21469', 'Tongchuan', 1);
INSERT INTO `provinces`
VALUES (511703, '达川区', 511700, '达川', 3, '0818', '635000', '中国,四川省,达州市,达川区', '107.502262', '31.209484', 'Dachuan', 1);
INSERT INTO `provinces`
VALUES (511722, '宣汉县', 511700, '宣汉', 3, '0818', '636150', '中国,四川省,达州市,宣汉县', '107.72775', '31.35516', 'Xuanhan', 1);
INSERT INTO `provinces`
VALUES (511723, '开江县', 511700, '开江', 3, '0818', '636250', '中国,四川省,达州市,开江县', '107.86889', '31.0841', 'Kaijiang', 1);
INSERT INTO `provinces`
VALUES (511724, '大竹县', 511700, '大竹', 3, '0818', '635100', '中国,四川省,达州市,大竹县', '107.20855', '30.74147', 'Dazhu', 1);
INSERT INTO `provinces`
VALUES (511725, '渠县', 511700, '渠县', 3, '0818', '635200', '中国,四川省,达州市,渠县', '106.97381', '30.8376', 'Quxian', 1);
INSERT INTO `provinces`
VALUES (511781, '万源市', 511700, '万源', 3, '0818', '636350', '中国,四川省,达州市,万源市', '108.03598', '32.08091', 'Wanyuan', 1);
INSERT INTO `provinces`
VALUES (511800, '雅安市', 510000, '雅安', 2, '0835', '625000', '中国,四川省,雅安市', '103.001033', '29.987722', 'Ya\'an', 1);
INSERT INTO `provinces`
VALUES (511802, '雨城区', 511800, '雨城', 3, '0835', '625000', '中国,四川省,雅安市,雨城区', '103.03305', '30.00531', 'Yucheng', 1);
INSERT INTO `provinces`
VALUES (511803, '名山区', 511800, '名山', 3, '0835', '625100', '中国,四川省,雅安市,名山区', '103.112214', '30.084718', 'Mingshan', 1);
INSERT INTO `provinces`
VALUES (511822, '荥经县', 511800, '荥经', 3, '0835', '625200', '中国,四川省,雅安市,荥经县', '102.84652', '29.79402', 'Yingjing', 1);
INSERT INTO `provinces`
VALUES (511823, '汉源县', 511800, '汉源', 3, '0835', '625300', '中国,四川省,雅安市,汉源县', '102.6784', '29.35168', 'Hanyuan', 1);
INSERT INTO `provinces`
VALUES (511824, '石棉县', 511800, '石棉', 3, '0835', '625400', '中国,四川省,雅安市,石棉县', '102.35943', '29.22796', 'Shimian', 1);
INSERT INTO `provinces`
VALUES (511825, '天全县', 511800, '天全', 3, '0835', '625500', '中国,四川省,雅安市,天全县', '102.75906', '30.06754', 'Tianquan', 1);
INSERT INTO `provinces`
VALUES (511826, '芦山县', 511800, '芦山', 3, '0835', '625600', '中国,四川省,雅安市,芦山县', '102.92791', '30.14369', 'Lushan', 1);
INSERT INTO `provinces`
VALUES (511827, '宝兴县', 511800, '宝兴', 3, '0835', '625700', '中国,四川省,雅安市,宝兴县', '102.81555', '30.36836', 'Baoxing', 1);
INSERT INTO `provinces`
VALUES (511900, '巴中市', 510000, '巴中', 2, '0827', '636000', '中国,四川省,巴中市', '106.753669', '31.858809', 'Bazhong', 1);
INSERT INTO `provinces`
VALUES (511902, '巴州区', 511900, '巴州', 3, '0827', '636001', '中国,四川省,巴中市,巴州区', '106.76889', '31.85125', 'Bazhou', 1);
INSERT INTO `provinces`
VALUES (511903, '恩阳区', 511900, '恩阳', 3, '0827', '636064', '中国,四川省,巴中市,恩阳区', '106.753669', '31.858809', 'Enyang', 1);
INSERT INTO `provinces`
VALUES (511921, '通江县', 511900, '通江', 3, '0827', '636700', '中国,四川省,巴中市,通江县', '107.24398', '31.91294', 'Tongjiang', 1);
INSERT INTO `provinces`
VALUES (511922, '南江县', 511900, '南江', 3, '0827', '636600', '中国,四川省,巴中市,南江县', '106.84164', '32.35335', 'Nanjiang', 1);
INSERT INTO `provinces`
VALUES (511923, '平昌县', 511900, '平昌', 3, '0827', '636400', '中国,四川省,巴中市,平昌县', '107.10424', '31.5594', 'Pingchang', 1);
INSERT INTO `provinces`
VALUES (512000, '资阳市', 510000, '资阳', 2, '028', '641300', '中国,四川省,资阳市', '104.641917', '30.122211', 'Ziyang', 1);
INSERT INTO `provinces`
VALUES (512002, '雁江区', 512000, '雁江', 3, '028', '641300', '中国,四川省,资阳市,雁江区', '104.65216', '30.11525', 'Yanjiang', 1);
INSERT INTO `provinces`
VALUES (512021, '安岳县', 512000, '安岳', 3, '028', '642350', '中国,四川省,资阳市,安岳县', '105.3363', '30.09786', 'Anyue', 1);
INSERT INTO `provinces`
VALUES (512022, '乐至县', 512000, '乐至', 3, '028', '641500', '中国,四川省,资阳市,乐至县', '105.03207', '30.27227', 'Lezhi', 1);
INSERT INTO `provinces`
VALUES (512081, '简阳市', 512000, '简阳', 3, '028', '641400', '中国,四川省,资阳市,简阳市', '104.54864', '30.3904', 'Jianyang', 1);
INSERT INTO `provinces`
VALUES (513126, '九寨沟县', 513200, '九寨沟', 3, '0837', '623400', '中国,四川省,阿坝藏族羌族自治州,九寨沟县', '104.23672', '33.26318',
        'Jiuzhaigou', 1);
INSERT INTO `provinces`
VALUES (513200, '阿坝藏族羌族自治州', 510000, '阿坝', 2, '0837', '624000', '中国,四川省,阿坝藏族羌族自治州', '102.221374', '31.899792', 'Aba',
        1);
INSERT INTO `provinces`
VALUES (513221, '汶川县', 513200, '汶川', 3, '0837', '623000', '中国,四川省,阿坝藏族羌族自治州,汶川县', '103.59079', '31.47326', 'Wenchuan',
        1);
INSERT INTO `provinces`
VALUES (513222, '理县', 513200, '理县', 3, '0837', '623100', '中国,四川省,阿坝藏族羌族自治州,理县', '103.17175', '31.43603', 'Lixian', 1);
INSERT INTO `provinces`
VALUES (513223, '茂县', 513200, '茂县', 3, '0837', '623200', '中国,四川省,阿坝藏族羌族自治州,茂县', '103.85372', '31.682', 'Maoxian', 1);
INSERT INTO `provinces`
VALUES (513224, '松潘县', 513200, '松潘', 3, '0837', '623300', '中国,四川省,阿坝藏族羌族自治州,松潘县', '103.59924', '32.63871', 'Songpan',
        1);
INSERT INTO `provinces`
VALUES (513226, '金川县', 513200, '金川', 3, '0837', '624100', '中国,四川省,阿坝藏族羌族自治州,金川县', '102.06555', '31.47623', 'Jinchuan',
        1);
INSERT INTO `provinces`
VALUES (513227, '小金县', 513200, '小金', 3, '0837', '624200', '中国,四川省,阿坝藏族羌族自治州,小金县', '102.36499', '30.99934', 'Xiaojin',
        1);
INSERT INTO `provinces`
VALUES (513228, '黑水县', 513200, '黑水', 3, '0837', '623500', '中国,四川省,阿坝藏族羌族自治州,黑水县', '102.99176', '32.06184', 'Heishui',
        1);
INSERT INTO `provinces`
VALUES (513229, '马尔康县', 513200, '马尔康', 3, '0837', '624000', '中国,四川省,阿坝藏族羌族自治州,马尔康县', '102.20625', '31.90584',
        'Maerkang', 1);
INSERT INTO `provinces`
VALUES (513230, '壤塘县', 513200, '壤塘', 3, '0837', '624300', '中国,四川省,阿坝藏族羌族自治州,壤塘县', '100.9783', '32.26578', 'Rangtang',
        1);
INSERT INTO `provinces`
VALUES (513231, '阿坝县', 513200, '阿坝', 3, '0837', '624600', '中国,四川省,阿坝藏族羌族自治州,阿坝县', '101.70632', '32.90301', 'Aba', 1);
INSERT INTO `provinces`
VALUES (513232, '若尔盖县', 513200, '若尔盖', 3, '0837', '624500', '中国,四川省,阿坝藏族羌族自治州,若尔盖县', '102.9598', '33.57432', 'Ruoergai',
        1);
INSERT INTO `provinces`
VALUES (513233, '红原县', 513200, '红原', 3, '0837', '624400', '中国,四川省,阿坝藏族羌族自治州,红原县', '102.54525', '32.78989', 'Hongyuan',
        1);
INSERT INTO `provinces`
VALUES (513300, '甘孜藏族自治州', 510000, '甘孜', 2, '0836', '626000', '中国,四川省,甘孜藏族自治州', '101.963815', '30.050663', 'Garze', 1);
INSERT INTO `provinces`
VALUES (513321, '康定县', 513300, '康定', 3, '0836', '626000', '中国,四川省,甘孜藏族自治州,康定县', '101.96487', '30.05532', 'Kangding', 1);
INSERT INTO `provinces`
VALUES (513322, '泸定县', 513300, '泸定', 3, '0836', '626100', '中国,四川省,甘孜藏族自治州,泸定县', '102.23507', '29.91475', 'Luding', 1);
INSERT INTO `provinces`
VALUES (513323, '丹巴县', 513300, '丹巴', 3, '0836', '626300', '中国,四川省,甘孜藏族自治州,丹巴县', '101.88424', '30.87656', 'Danba', 1);
INSERT INTO `provinces`
VALUES (513324, '九龙县', 513300, '九龙', 3, '0836', '626200', '中国,四川省,甘孜藏族自治州,九龙县', '101.50848', '29.00091', 'Jiulong', 1);
INSERT INTO `provinces`
VALUES (513325, '雅江县', 513300, '雅江', 3, '0836', '627450', '中国,四川省,甘孜藏族自治州,雅江县', '101.01492', '30.03281', 'Yajiang', 1);
INSERT INTO `provinces`
VALUES (513326, '道孚县', 513300, '道孚', 3, '0836', '626400', '中国,四川省,甘孜藏族自治州,道孚县', '101.12554', '30.98046', 'Daofu', 1);
INSERT INTO `provinces`
VALUES (513327, '炉霍县', 513300, '炉霍', 3, '0836', '626500', '中国,四川省,甘孜藏族自治州,炉霍县', '100.67681', '31.3917', 'Luhuo', 1);
INSERT INTO `provinces`
VALUES (513328, '甘孜县', 513300, '甘孜', 3, '0836', '626700', '中国,四川省,甘孜藏族自治州,甘孜县', '99.99307', '31.62672', 'Ganzi', 1);
INSERT INTO `provinces`
VALUES (513329, '新龙县', 513300, '新龙', 3, '0836', '626800', '中国,四川省,甘孜藏族自治州,新龙县', '100.3125', '30.94067', 'Xinlong', 1);
INSERT INTO `provinces`
VALUES (513330, '德格县', 513300, '德格', 3, '0836', '627250', '中国,四川省,甘孜藏族自治州,德格县', '98.58078', '31.80615', 'Dege', 1);
INSERT INTO `provinces`
VALUES (513331, '白玉县', 513300, '白玉', 3, '0836', '627150', '中国,四川省,甘孜藏族自治州,白玉县', '98.82568', '31.20902', 'Baiyu', 1);
INSERT INTO `provinces`
VALUES (513332, '石渠县', 513300, '石渠', 3, '0836', '627350', '中国,四川省,甘孜藏族自治州,石渠县', '98.10156', '32.97884', 'Shiqu', 1);
INSERT INTO `provinces`
VALUES (513333, '色达县', 513300, '色达', 3, '0836', '626600', '中国,四川省,甘孜藏族自治州,色达县', '100.33224', '32.26839', 'Seda', 1);
INSERT INTO `provinces`
VALUES (513334, '理塘县', 513300, '理塘', 3, '0836', '627550', '中国,四川省,甘孜藏族自治州,理塘县', '100.27005', '29.99674', 'Litang', 1);
INSERT INTO `provinces`
VALUES (513335, '巴塘县', 513300, '巴塘', 3, '0836', '627650', '中国,四川省,甘孜藏族自治州,巴塘县', '99.10409', '30.00423', 'Batang', 1);
INSERT INTO `provinces`
VALUES (513336, '乡城县', 513300, '乡城', 3, '0836', '627850', '中国,四川省,甘孜藏族自治州,乡城县', '99.79943', '28.93554', 'Xiangcheng',
        1);
INSERT INTO `provinces`
VALUES (513337, '稻城县', 513300, '稻城', 3, '0836', '627750', '中国,四川省,甘孜藏族自治州,稻城县', '100.29809', '29.0379', 'Daocheng', 1);
INSERT INTO `provinces`
VALUES (513338, '得荣县', 513300, '得荣', 3, '0836', '627950', '中国,四川省,甘孜藏族自治州,得荣县', '99.28628', '28.71297', 'Derong', 1);
INSERT INTO `provinces`
VALUES (513400, '凉山彝族自治州', 510000, '凉山', 2, '0834', '615000', '中国,四川省,凉山彝族自治州', '102.258746', '27.886762', 'Liangshan',
        1);
INSERT INTO `provinces`
VALUES (513401, '西昌市', 513400, '西昌', 3, '0835', '615000', '中国,四川省,凉山彝族自治州,西昌市', '102.26413', '27.89524', 'Xichang', 1);
INSERT INTO `provinces`
VALUES (513422, '木里藏族自治县', 513400, '木里', 3, '0851', '615800', '中国,四川省,凉山彝族自治州,木里藏族自治县', '101.2796', '27.92875', 'Muli',
        1);
INSERT INTO `provinces`
VALUES (513423, '盐源县', 513400, '盐源', 3, '0836', '615700', '中国,四川省,凉山彝族自治州,盐源县', '101.5097', '27.42177', 'Yanyuan', 1);
INSERT INTO `provinces`
VALUES (513424, '德昌县', 513400, '德昌', 3, '0837', '615500', '中国,四川省,凉山彝族自治州,德昌县', '102.18017', '27.40482', 'Dechang', 1);
INSERT INTO `provinces`
VALUES (513425, '会理县', 513400, '会理', 3, '0838', '615100', '中国,四川省,凉山彝族自治州,会理县', '102.24539', '26.65627', 'Huili', 1);
INSERT INTO `provinces`
VALUES (513426, '会东县', 513400, '会东', 3, '0839', '615200', '中国,四川省,凉山彝族自治州,会东县', '102.57815', '26.63429', 'Huidong', 1);
INSERT INTO `provinces`
VALUES (513427, '宁南县', 513400, '宁南', 3, '0840', '615400', '中国,四川省,凉山彝族自治州,宁南县', '102.76116', '27.06567', 'Ningnan', 1);
INSERT INTO `provinces`
VALUES (513428, '普格县', 513400, '普格', 3, '0841', '615300', '中国,四川省,凉山彝族自治州,普格县', '102.54055', '27.37485', 'Puge', 1);
INSERT INTO `provinces`
VALUES (513429, '布拖县', 513400, '布拖', 3, '0842', '616350', '中国,四川省,凉山彝族自治州,布拖县', '102.81234', '27.7079', 'Butuo', 1);
INSERT INTO `provinces`
VALUES (513430, '金阳县', 513400, '金阳', 3, '0843', '616250', '中国,四川省,凉山彝族自治州,金阳县', '103.24774', '27.69698', 'Jinyang', 1);
INSERT INTO `provinces`
VALUES (513431, '昭觉县', 513400, '昭觉', 3, '0844', '616150', '中国,四川省,凉山彝族自治州,昭觉县', '102.84661', '28.01155', 'Zhaojue', 1);
INSERT INTO `provinces`
VALUES (513432, '喜德县', 513400, '喜德', 3, '0845', '616750', '中国,四川省,凉山彝族自治州,喜德县', '102.41336', '28.30739', 'Xide', 1);
INSERT INTO `provinces`
VALUES (513433, '冕宁县', 513400, '冕宁', 3, '0846', '615600', '中国,四川省,凉山彝族自治州,冕宁县', '102.17108', '28.55161', 'Mianning', 1);
INSERT INTO `provinces`
VALUES (513434, '越西县', 513400, '越西', 3, '0847', '616650', '中国,四川省,凉山彝族自治州,越西县', '102.5079', '28.64133', 'Yuexi', 1);
INSERT INTO `provinces`
VALUES (513435, '甘洛县', 513400, '甘洛', 3, '0848', '616850', '中国,四川省,凉山彝族自治州,甘洛县', '102.77154', '28.96624', 'Ganluo', 1);
INSERT INTO `provinces`
VALUES (513436, '美姑县', 513400, '美姑', 3, '0849', '616450', '中国,四川省,凉山彝族自治州,美姑县', '103.13116', '28.32596', 'Meigu', 1);
INSERT INTO `provinces`
VALUES (513437, '雷波县', 513400, '雷波', 3, '0850', '616550', '中国,四川省,凉山彝族自治州,雷波县', '103.57287', '28.26407', 'Leibo', 1);
INSERT INTO `provinces`
VALUES (520000, '贵州省', 100000, '贵州', 1, '', '', '中国,贵州省', '106.713478', '26.578343', 'Guizhou', 1);
INSERT INTO `provinces`
VALUES (520100, '贵阳市', 520000, '贵阳', 2, '0851', '550001', '中国,贵州省,贵阳市', '106.713478', '26.578343', 'Guiyang', 1);
INSERT INTO `provinces`
VALUES (520102, '南明区', 520100, '南明', 3, '0851', '550001', '中国,贵州省,贵阳市,南明区', '106.7145', '26.56819', 'Nanming', 1);
INSERT INTO `provinces`
VALUES (520103, '云岩区', 520100, '云岩', 3, '0851', '550001', '中国,贵州省,贵阳市,云岩区', '106.72485', '26.60484', 'Yunyan', 1);
INSERT INTO `provinces`
VALUES (520111, '花溪区', 520100, '花溪', 3, '0851', '550025', '中国,贵州省,贵阳市,花溪区', '106.67688', '26.43343', 'Huaxi', 1);
INSERT INTO `provinces`
VALUES (520112, '乌当区', 520100, '乌当', 3, '0851', '550018', '中国,贵州省,贵阳市,乌当区', '106.7521', '26.6302', 'Wudang', 1);
INSERT INTO `provinces`
VALUES (520113, '白云区', 520100, '白云', 3, '0851', '550014', '中国,贵州省,贵阳市,白云区', '106.63088', '26.68284', 'Baiyun', 1);
INSERT INTO `provinces`
VALUES (520115, '观山湖区', 520100, '观山湖', 3, '0851', '550009', '中国,贵州省,贵阳市,观山湖区', '106.625442', '26.618209', 'Guanshanhu',
        1);
INSERT INTO `provinces`
VALUES (520121, '开阳县', 520100, '开阳', 3, '0851', '550300', '中国,贵州省,贵阳市,开阳县', '106.9692', '27.05533', 'Kaiyang', 1);
INSERT INTO `provinces`
VALUES (520122, '息烽县', 520100, '息烽', 3, '0851', '551100', '中国,贵州省,贵阳市,息烽县', '106.738', '27.09346', 'Xifeng', 1);
INSERT INTO `provinces`
VALUES (520123, '修文县', 520100, '修文', 3, '0851', '550200', '中国,贵州省,贵阳市,修文县', '106.59487', '26.83783', 'Xiuwen', 1);
INSERT INTO `provinces`
VALUES (520181, '清镇市', 520100, '清镇', 3, '0851', '551400', '中国,贵州省,贵阳市,清镇市', '106.46862', '26.55261', 'Qingzhen', 1);
INSERT INTO `provinces`
VALUES (520200, '六盘水市', 520000, '六盘水', 2, '0858', '553400', '中国,贵州省,六盘水市', '104.846743', '26.584643', 'Liupanshui', 1);
INSERT INTO `provinces`
VALUES (520201, '钟山区', 520200, '钟山', 3, '0858', '553000', '中国,贵州省,六盘水市,钟山区', '104.87848', '26.57699', 'Zhongshan', 1);
INSERT INTO `provinces`
VALUES (520203, '六枝特区', 520200, '六枝', 3, '0858', '553400', '中国,贵州省,六盘水市,六枝特区', '105.48062', '26.20117', 'Liuzhi', 1);
INSERT INTO `provinces`
VALUES (520221, '水城县', 520200, '水城', 3, '0858', '553000', '中国,贵州省,六盘水市,水城县', '104.95764', '26.54785', 'Shuicheng', 1);
INSERT INTO `provinces`
VALUES (520222, '盘县', 520200, '盘县', 3, '0858', '561601', '中国,贵州省,六盘水市,盘县', '104.47061', '25.7136', 'Panxian', 1);
INSERT INTO `provinces`
VALUES (520300, '遵义市', 520000, '遵义', 2, '0852', '563000', '中国,贵州省,遵义市', '106.937265', '27.706626', 'Zunyi', 1);
INSERT INTO `provinces`
VALUES (520302, '红花岗区', 520300, '红花岗', 3, '0852', '563000', '中国,贵州省,遵义市,红花岗区', '106.89404', '27.64471', 'Honghuagang',
        1);
INSERT INTO `provinces`
VALUES (520303, '汇川区', 520300, '汇川', 3, '0852', '563000', '中国,贵州省,遵义市,汇川区', '106.9393', '27.70625', 'Huichuan', 1);
INSERT INTO `provinces`
VALUES (520321, '遵义县', 520300, '遵义', 3, '0852', '563100', '中国,贵州省,遵义市,遵义县', '106.83331', '27.53772', 'Zunyi', 1);
INSERT INTO `provinces`
VALUES (520322, '桐梓县', 520300, '桐梓', 3, '0852', '563200', '中国,贵州省,遵义市,桐梓县', '106.82568', '28.13806', 'Tongzi', 1);
INSERT INTO `provinces`
VALUES (520323, '绥阳县', 520300, '绥阳', 3, '0852', '563300', '中国,贵州省,遵义市,绥阳县', '107.19064', '27.94702', 'Suiyang', 1);
INSERT INTO `provinces`
VALUES (520324, '正安县', 520300, '正安', 3, '0852', '563400', '中国,贵州省,遵义市,正安县', '107.44357', '28.5512', 'Zheng\'an', 1);
INSERT INTO `provinces`
VALUES (520325, '道真仡佬族苗族自治县', 520300, '道真', 3, '0852', '563500', '中国,贵州省,遵义市,道真仡佬族苗族自治县', '107.61152', '28.864',
        'Daozhen', 1);
INSERT INTO `provinces`
VALUES (520326, '务川仡佬族苗族自治县', 520300, '务川', 3, '0852', '564300', '中国,贵州省,遵义市,务川仡佬族苗族自治县', '107.88935', '28.52227',
        'Wuchuan', 1);
INSERT INTO `provinces`
VALUES (520327, '凤冈县', 520300, '凤冈', 3, '0852', '564200', '中国,贵州省,遵义市,凤冈县', '107.71682', '27.95461', 'Fenggang', 1);
INSERT INTO `provinces`
VALUES (520328, '湄潭县', 520300, '湄潭', 3, '0852', '564100', '中国,贵州省,遵义市,湄潭县', '107.48779', '27.76676', 'Meitan', 1);
INSERT INTO `provinces`
VALUES (520329, '余庆县', 520300, '余庆', 3, '0852', '564400', '中国,贵州省,遵义市,余庆县', '107.88821', '27.12632', 'Yuqing', 1);
INSERT INTO `provinces`
VALUES (520330, '习水县', 520300, '习水', 3, '0852', '564600', '中国,贵州省,遵义市,习水县', '106.21267', '28.31976', 'Xishui', 1);
INSERT INTO `provinces`
VALUES (520381, '赤水市', 520300, '赤水', 3, '0852', '564700', '中国,贵州省,遵义市,赤水市', '105.69845', '28.58921', 'Chishui', 1);
INSERT INTO `provinces`
VALUES (520382, '仁怀市', 520300, '仁怀', 3, '0852', '564500', '中国,贵州省,遵义市,仁怀市', '106.40152', '27.79231', 'Renhuai', 1);
INSERT INTO `provinces`
VALUES (520400, '安顺市', 520000, '安顺', 2, '0853', '561000', '中国,贵州省,安顺市', '105.932188', '26.245544', 'Anshun', 1);
INSERT INTO `provinces`
VALUES (520402, '西秀区', 520400, '西秀', 3, '0853', '561000', '中国,贵州省,安顺市,西秀区', '105.96585', '26.24491', 'Xixiu', 1);
INSERT INTO `provinces`
VALUES (520421, '平坝区', 520400, '平坝', 3, '0853', '561100', '中国,贵州省,安顺市,平坝区', '106.25683', '26.40543', 'Pingba', 1);
INSERT INTO `provinces`
VALUES (520422, '普定县', 520400, '普定', 3, '0853', '562100', '中国,贵州省,安顺市,普定县', '105.74285', '26.30141', 'Puding', 1);
INSERT INTO `provinces`
VALUES (520423, '镇宁布依族苗族自治县', 520400, '镇宁', 3, '0853', '561200', '中国,贵州省,安顺市,镇宁布依族苗族自治县', '105.76513', '26.05533',
        'Zhenning', 1);
INSERT INTO `provinces`
VALUES (520424, '关岭布依族苗族自治县', 520400, '关岭', 3, '0853', '561300', '中国,贵州省,安顺市,关岭布依族苗族自治县', '105.61883', '25.94248',
        'Guanling', 1);
INSERT INTO `provinces`
VALUES (520425, '紫云苗族布依族自治县', 520400, '紫云', 3, '0853', '550800', '中国,贵州省,安顺市,紫云苗族布依族自治县', '106.08364', '25.75258',
        'Ziyun', 1);
INSERT INTO `provinces`
VALUES (520500, '毕节市', 520000, '毕节', 2, '0857', '551700', '中国,贵州省,毕节市', '105.28501', '27.301693', 'Bijie', 1);
INSERT INTO `provinces`
VALUES (520502, '七星关区', 520500, '七星关', 3, '0857', '551700', '中国,贵州省,毕节市,七星关区', '104.9497', '27.153556', 'Qixingguan',
        1);
INSERT INTO `provinces`
VALUES (520521, '大方县', 520500, '大方', 3, '0857', '551600', '中国,贵州省,毕节市,大方县', '105.609254', '27.143521', 'Dafang', 1);
INSERT INTO `provinces`
VALUES (520522, '黔西县', 520500, '黔西', 3, '0857', '551500', '中国,贵州省,毕节市,黔西县', '106.038299', '27.024923', 'Qianxi', 1);
INSERT INTO `provinces`
VALUES (520523, '金沙县', 520500, '金沙', 3, '0857', '551800', '中国,贵州省,毕节市,金沙县', '106.222103', '27.459693', 'Jinsha', 1);
INSERT INTO `provinces`
VALUES (520524, '织金县', 520500, '织金', 3, '0857', '552100', '中国,贵州省,毕节市,织金县', '105.768997', '26.668497', 'Zhijin', 1);
INSERT INTO `provinces`
VALUES (520525, '纳雍县', 520500, '纳雍', 3, '0857', '553300', '中国,贵州省,毕节市,纳雍县', '105.375322', '26.769875', 'Nayong', 1);
INSERT INTO `provinces`
VALUES (520526, '威宁彝族回族苗族自治县', 520500, '威宁', 3, '0857', '553100', '中国,贵州省,毕节市,威宁彝族回族苗族自治县', '104.286523', '26.859099',
        'Weining', 1);
INSERT INTO `provinces`
VALUES (520527, '赫章县', 520500, '赫章', 3, '0857', '553200', '中国,贵州省,毕节市,赫章县', '104.726438', '27.119243', 'Hezhang', 1);
INSERT INTO `provinces`
VALUES (520600, '铜仁市', 520000, '铜仁', 2, '0856', '554300', '中国,贵州省,铜仁市', '109.191555', '27.718346', 'Tongren', 1);
INSERT INTO `provinces`
VALUES (520602, '碧江区', 520600, '碧江', 3, '0856', '554300', '中国,贵州省,铜仁市,碧江区', '109.191555', '27.718346', 'Bijiang', 1);
INSERT INTO `provinces`
VALUES (520603, '万山区', 520600, '万山', 3, '0856', '554200', '中国,贵州省,铜仁市,万山区', '109.21199', '27.51903', 'Wanshan', 1);
INSERT INTO `provinces`
VALUES (520621, '江口县', 520600, '江口', 3, '0856', '554400', '中国,贵州省,铜仁市,江口县', '108.848427', '27.691904', 'Jiangkou', 1);
INSERT INTO `provinces`
VALUES (520622, '玉屏侗族自治县', 520600, '玉屏', 3, '0856', '554004', '中国,贵州省,铜仁市,玉屏侗族自治县', '108.917882', '27.238024', 'Yuping',
        1);
INSERT INTO `provinces`
VALUES (520623, '石阡县', 520600, '石阡', 3, '0856', '555100', '中国,贵州省,铜仁市,石阡县', '108.229854', '27.519386', 'Shiqian', 1);
INSERT INTO `provinces`
VALUES (520624, '思南县', 520600, '思南', 3, '0856', '565100', '中国,贵州省,铜仁市,思南县', '108.255827', '27.941331', 'Sinan', 1);
INSERT INTO `provinces`
VALUES (520625, '印江土家族苗族自治县', 520600, '印江', 3, '0856', '555200', '中国,贵州省,铜仁市,印江土家族苗族自治县', '108.405517', '27.997976',
        'Yinjiang', 1);
INSERT INTO `provinces`
VALUES (520626, '德江县', 520600, '德江', 3, '0856', '565200', '中国,贵州省,铜仁市,德江县', '108.117317', '28.26094', 'Dejiang', 1);
INSERT INTO `provinces`
VALUES (520627, '沿河土家族自治县', 520600, '沿河', 3, '0856', '565300', '中国,贵州省,铜仁市,沿河土家族自治县', '108.495746', '28.560487',
        'Yuanhe', 1);
INSERT INTO `provinces`
VALUES (520628, '松桃苗族自治县', 520600, '松桃', 3, '0856', '554100', '中国,贵州省,铜仁市,松桃苗族自治县', '109.202627', '28.165419',
        'Songtao', 1);
INSERT INTO `provinces`
VALUES (522300, '黔西南布依族苗族自治州', 520000, '黔西南', 2, '0859', '562400', '中国,贵州省,黔西南布依族苗族自治州', '104.897971', '25.08812',
        'Qianxinan', 1);
INSERT INTO `provinces`
VALUES (522301, '兴义市 ', 522300, '兴义', 3, '0859', '562400', '中国,贵州省,黔西南布依族苗族自治州,兴义市 ', '104.89548', '25.09205', 'Xingyi',
        1);
INSERT INTO `provinces`
VALUES (522322, '兴仁县', 522300, '兴仁', 3, '0859', '562300', '中国,贵州省,黔西南布依族苗族自治州,兴仁县', '105.18652', '25.43282', 'Xingren',
        1);
INSERT INTO `provinces`
VALUES (522323, '普安县', 522300, '普安', 3, '0859', '561500', '中国,贵州省,黔西南布依族苗族自治州,普安县', '104.95529', '25.78603', 'Pu\'an',
        1);
INSERT INTO `provinces`
VALUES (522324, '晴隆县', 522300, '晴隆', 3, '0859', '561400', '中国,贵州省,黔西南布依族苗族自治州,晴隆县', '105.2192', '25.83522', 'Qinglong',
        1);
INSERT INTO `provinces`
VALUES (522325, '贞丰县', 522300, '贞丰', 3, '0859', '562200', '中国,贵州省,黔西南布依族苗族自治州,贞丰县', '105.65454', '25.38464', 'Zhenfeng',
        1);
INSERT INTO `provinces`
VALUES (522326, '望谟县', 522300, '望谟', 3, '0859', '552300', '中国,贵州省,黔西南布依族苗族自治州,望谟县', '106.09957', '25.17822', 'Wangmo',
        1);
INSERT INTO `provinces`
VALUES (522327, '册亨县', 522300, '册亨', 3, '0859', '552200', '中国,贵州省,黔西南布依族苗族自治州,册亨县', '105.8124', '24.98376', 'Ceheng',
        1);
INSERT INTO `provinces`
VALUES (522328, '安龙县', 522300, '安龙', 3, '0859', '552400', '中国,贵州省,黔西南布依族苗族自治州,安龙县', '105.44268', '25.09818', 'Anlong',
        1);
INSERT INTO `provinces`
VALUES (522600, '黔东南苗族侗族自治州', 520000, '黔东南', 2, '0855', '556000', '中国,贵州省,黔东南苗族侗族自治州', '107.977488', '26.583352',
        'Qiandongnan', 1);
INSERT INTO `provinces`
VALUES (522601, '凯里市', 522600, '凯里', 3, '0855', '556000', '中国,贵州省,黔东南苗族侗族自治州,凯里市', '107.98132', '26.56689', 'Kaili', 1);
INSERT INTO `provinces`
VALUES (522622, '黄平县', 522600, '黄平', 3, '0855', '556100', '中国,贵州省,黔东南苗族侗族自治州,黄平县', '107.90179', '26.89573', 'Huangping',
        1);
INSERT INTO `provinces`
VALUES (522623, '施秉县', 522600, '施秉', 3, '0855', '556200', '中国,贵州省,黔东南苗族侗族自治州,施秉县', '108.12597', '27.03495', 'Shibing',
        1);
INSERT INTO `provinces`
VALUES (522624, '三穗县', 522600, '三穗', 3, '0855', '556500', '中国,贵州省,黔东南苗族侗族自治州,三穗县', '108.67132', '26.94765', 'Sansui',
        1);
INSERT INTO `provinces`
VALUES (522625, '镇远县', 522600, '镇远', 3, '0855', '557700', '中国,贵州省,黔东南苗族侗族自治州,镇远县', '108.42721', '27.04933', 'Zhenyuan',
        1);
INSERT INTO `provinces`
VALUES (522626, '岑巩县', 522600, '岑巩', 3, '0855', '557800', '中国,贵州省,黔东南苗族侗族自治州,岑巩县', '108.81884', '27.17539', 'Cengong',
        1);
INSERT INTO `provinces`
VALUES (522627, '天柱县', 522600, '天柱', 3, '0855', '556600', '中国,贵州省,黔东南苗族侗族自治州,天柱县', '109.20718', '26.90781', 'Tianzhu',
        1);
INSERT INTO `provinces`
VALUES (522628, '锦屏县', 522600, '锦屏', 3, '0855', '556700', '中国,贵州省,黔东南苗族侗族自治州,锦屏县', '109.19982', '26.67635', 'Jinping',
        1);
INSERT INTO `provinces`
VALUES (522629, '剑河县', 522600, '剑河', 3, '0855', '556400', '中国,贵州省,黔东南苗族侗族自治州,剑河县', '108.5913', '26.6525', 'Jianhe', 1);
INSERT INTO `provinces`
VALUES (522630, '台江县', 522600, '台江', 3, '0855', '556300', '中国,贵州省,黔东南苗族侗族自治州,台江县', '108.31814', '26.66916', 'Taijiang',
        1);
INSERT INTO `provinces`
VALUES (522631, '黎平县', 522600, '黎平', 3, '0855', '557300', '中国,贵州省,黔东南苗族侗族自治州,黎平县', '109.13607', '26.23114', 'Liping',
        1);
INSERT INTO `provinces`
VALUES (522632, '榕江县', 522600, '榕江', 3, '0855', '557200', '中国,贵州省,黔东南苗族侗族自治州,榕江县', '108.52072', '25.92421', 'Rongjiang',
        1);
INSERT INTO `provinces`
VALUES (522633, '从江县', 522600, '从江', 3, '0855', '557400', '中国,贵州省,黔东南苗族侗族自治州,从江县', '108.90527', '25.75415', 'Congjiang',
        1);
INSERT INTO `provinces`
VALUES (522634, '雷山县', 522600, '雷山', 3, '0855', '557100', '中国,贵州省,黔东南苗族侗族自治州,雷山县', '108.07745', '26.38385', 'Leishan',
        1);
INSERT INTO `provinces`
VALUES (522635, '麻江县', 522600, '麻江', 3, '0855', '557600', '中国,贵州省,黔东南苗族侗族自治州,麻江县', '107.59155', '26.49235', 'Majiang',
        1);
INSERT INTO `provinces`
VALUES (522636, '丹寨县', 522600, '丹寨', 3, '0855', '557500', '中国,贵州省,黔东南苗族侗族自治州,丹寨县', '107.79718', '26.19816', 'Danzhai',
        1);
INSERT INTO `provinces`
VALUES (522700, '黔南布依族苗族自治州', 520000, '黔南', 2, '0854', '558000', '中国,贵州省,黔南布依族苗族自治州', '107.517156', '26.258219',
        'Qiannan', 1);
INSERT INTO `provinces`
VALUES (522701, '都匀市', 522700, '都匀', 3, '0854', '558000', '中国,贵州省,黔南布依族苗族自治州,都匀市', '107.51872', '26.2594', 'Duyun', 1);
INSERT INTO `provinces`
VALUES (522702, '福泉市', 522700, '福泉', 3, '0854', '550500', '中国,贵州省,黔南布依族苗族自治州,福泉市', '107.51715', '26.67989', 'Fuquan',
        1);
INSERT INTO `provinces`
VALUES (522722, '荔波县', 522700, '荔波', 3, '0854', '558400', '中国,贵州省,黔南布依族苗族自治州,荔波县', '107.88592', '25.4139', 'Libo', 1);
INSERT INTO `provinces`
VALUES (522723, '贵定县', 522700, '贵定', 3, '0854', '551300', '中国,贵州省,黔南布依族苗族自治州,贵定县', '107.23654', '26.57812', 'Guiding',
        1);
INSERT INTO `provinces`
VALUES (522725, '瓮安县', 522700, '瓮安', 3, '0854', '550400', '中国,贵州省,黔南布依族苗族自治州,瓮安县', '107.4757', '27.06813', 'Weng\'an',
        1);
INSERT INTO `provinces`
VALUES (522726, '独山县', 522700, '独山', 3, '0854', '558200', '中国,贵州省,黔南布依族苗族自治州,独山县', '107.54101', '25.8245', 'Dushan', 1);
INSERT INTO `provinces`
VALUES (522727, '平塘县', 522700, '平塘', 3, '0854', '558300', '中国,贵州省,黔南布依族苗族自治州,平塘县', '107.32428', '25.83294', 'Pingtang',
        1);
INSERT INTO `provinces`
VALUES (522728, '罗甸县', 522700, '罗甸', 3, '0854', '550100', '中国,贵州省,黔南布依族苗族自治州,罗甸县', '106.75186', '25.42586', 'Luodian',
        1);
INSERT INTO `provinces`
VALUES (522729, '长顺县', 522700, '长顺', 3, '0854', '550700', '中国,贵州省,黔南布依族苗族自治州,长顺县', '106.45217', '26.02299', 'Changshun',
        1);
INSERT INTO `provinces`
VALUES (522730, '龙里县', 522700, '龙里', 3, '0854', '551200', '中国,贵州省,黔南布依族苗族自治州,龙里县', '106.97662', '26.45076', 'Longli',
        1);
INSERT INTO `provinces`
VALUES (522731, '惠水县', 522700, '惠水', 3, '0854', '550600', '中国,贵州省,黔南布依族苗族自治州,惠水县', '106.65911', '26.13389', 'Huishui',
        1);
INSERT INTO `provinces`
VALUES (522732, '三都水族自治县', 522700, '三都', 3, '0854', '558100', '中国,贵州省,黔南布依族苗族自治州,三都水族自治县', '107.87464', '25.98562',
        'Sandu', 1);
INSERT INTO `provinces`
VALUES (530000, '云南省', 100000, '云南', 1, '', '', '中国,云南省', '102.711261', '25.040609', 'Yunnan', 1);
INSERT INTO `provinces`
VALUES (530100, '昆明市', 530000, '昆明', 2, '0871', '650500', '中国,云南省,昆明市', '102.711261', '25.040609', 'Kunming', 1);
INSERT INTO `provinces`
VALUES (530102, '五华区', 530100, '五华', 3, '0871', '650021', '中国,云南省,昆明市,五华区', '102.70786', '25.03521', 'Wuhua', 1);
INSERT INTO `provinces`
VALUES (530103, '盘龙区', 530100, '盘龙', 3, '0871', '650051', '中国,云南省,昆明市,盘龙区', '102.71994', '25.04053', 'Panlong', 1);
INSERT INTO `provinces`
VALUES (530111, '官渡区', 530100, '官渡', 3, '0871', '650200', '中国,云南省,昆明市,官渡区', '102.74362', '25.01497', 'Guandu', 1);
INSERT INTO `provinces`
VALUES (530112, '西山区', 530100, '西山', 3, '0871', '650118', '中国,云南省,昆明市,西山区', '102.66464', '25.03796', 'Xishan', 1);
INSERT INTO `provinces`
VALUES (530113, '东川区', 530100, '东川', 3, '0871', '654100', '中国,云南省,昆明市,东川区', '103.18832', '26.083', 'Dongchuan', 1);
INSERT INTO `provinces`
VALUES (530114, '呈贡区', 530100, '呈贡', 3, '0871', '650500', '中国,云南省,昆明市,呈贡区', '102.801382', '24.889275', 'Chenggong', 1);
INSERT INTO `provinces`
VALUES (530122, '晋宁县', 530100, '晋宁', 3, '0871', '650600', '中国,云南省,昆明市,晋宁县', '102.59393', '24.6665', 'Jinning', 1);
INSERT INTO `provinces`
VALUES (530124, '富民县', 530100, '富民', 3, '0871', '650400', '中国,云南省,昆明市,富民县', '102.4985', '25.22119', 'Fumin', 1);
INSERT INTO `provinces`
VALUES (530125, '宜良县', 530100, '宜良', 3, '0871', '652100', '中国,云南省,昆明市,宜良县', '103.14117', '24.91705', 'Yiliang', 1);
INSERT INTO `provinces`
VALUES (530126, '石林彝族自治县', 530100, '石林', 3, '0871', '652200', '中国,云南省,昆明市,石林彝族自治县', '103.27148', '24.75897', 'Shilin',
        1);
INSERT INTO `provinces`
VALUES (530127, '嵩明县', 530100, '嵩明', 3, '0871', '651700', '中国,云南省,昆明市,嵩明县', '103.03729', '25.33986', 'Songming', 1);
INSERT INTO `provinces`
VALUES (530128, '禄劝彝族苗族自治县', 530100, '禄劝', 3, '0871', '651500', '中国,云南省,昆明市,禄劝彝族苗族自治县', '102.4671', '25.55387',
        'Luquan', 1);
INSERT INTO `provinces`
VALUES (530129, '寻甸回族彝族自治县 ', 530100, '寻甸', 3, '0871', '655200', '中国,云南省,昆明市,寻甸回族彝族自治县 ', '103.2557', '25.55961',
        'Xundian', 1);
INSERT INTO `provinces`
VALUES (530181, '安宁市', 530100, '安宁', 3, '0871', '650300', '中国,云南省,昆明市,安宁市', '102.46972', '24.91652', 'Anning', 1);
INSERT INTO `provinces`
VALUES (530300, '曲靖市', 530000, '曲靖', 2, '0874', '655000', '中国,云南省,曲靖市', '103.797851', '25.501557', 'Qujing', 1);
INSERT INTO `provinces`
VALUES (530302, '麒麟区', 530300, '麒麟', 3, '0874', '655000', '中国,云南省,曲靖市,麒麟区', '103.80504', '25.49515', 'Qilin', 1);
INSERT INTO `provinces`
VALUES (530321, '马龙县', 530300, '马龙', 3, '0874', '655100', '中国,云南省,曲靖市,马龙县', '103.57873', '25.42521', 'Malong', 1);
INSERT INTO `provinces`
VALUES (530322, '陆良县', 530300, '陆良', 3, '0874', '655600', '中国,云南省,曲靖市,陆良县', '103.6665', '25.02335', 'Luliang', 1);
INSERT INTO `provinces`
VALUES (530323, '师宗县', 530300, '师宗', 3, '0874', '655700', '中国,云南省,曲靖市,师宗县', '103.99084', '24.82822', 'Shizong', 1);
INSERT INTO `provinces`
VALUES (530324, '罗平县', 530300, '罗平', 3, '0874', '655800', '中国,云南省,曲靖市,罗平县', '104.30859', '24.88444', 'Luoping', 1);
INSERT INTO `provinces`
VALUES (530325, '富源县', 530300, '富源', 3, '0874', '655500', '中国,云南省,曲靖市,富源县', '104.25387', '25.66587', 'Fuyuan', 1);
INSERT INTO `provinces`
VALUES (530326, '会泽县', 530300, '会泽', 3, '0874', '654200', '中国,云南省,曲靖市,会泽县', '103.30017', '26.41076', 'Huize', 1);
INSERT INTO `provinces`
VALUES (530328, '沾益县', 530300, '沾益', 3, '0874', '655331', '中国,云南省,曲靖市,沾益县', '103.82135', '25.60715', 'Zhanyi', 1);
INSERT INTO `provinces`
VALUES (530381, '宣威市', 530300, '宣威', 3, '0874', '655400', '中国,云南省,曲靖市,宣威市', '104.10409', '26.2173', 'Xuanwei', 1);
INSERT INTO `provinces`
VALUES (530400, '玉溪市', 530000, '玉溪', 2, '0877', '653100', '中国,云南省,玉溪市', '102.543907', '24.350461', 'Yuxi', 1);
INSERT INTO `provinces`
VALUES (530402, '红塔区', 530400, '红塔', 3, '0877', '653100', '中国,云南省,玉溪市,红塔区', '102.5449', '24.35411', 'Hongta', 1);
INSERT INTO `provinces`
VALUES (530421, '江川县', 530400, '江川', 3, '0877', '652600', '中国,云南省,玉溪市,江川县', '102.75412', '24.28863', 'Jiangchuan', 1);
INSERT INTO `provinces`
VALUES (530422, '澄江县', 530400, '澄江', 3, '0877', '652500', '中国,云南省,玉溪市,澄江县', '102.90817', '24.67376', 'Chengjiang', 1);
INSERT INTO `provinces`
VALUES (530423, '通海县', 530400, '通海', 3, '0877', '652700', '中国,云南省,玉溪市,通海县', '102.76641', '24.11362', 'Tonghai', 1);
INSERT INTO `provinces`
VALUES (530424, '华宁县', 530400, '华宁', 3, '0877', '652800', '中国,云南省,玉溪市,华宁县', '102.92831', '24.1926', 'Huaning', 1);
INSERT INTO `provinces`
VALUES (530425, '易门县', 530400, '易门', 3, '0877', '651100', '中国,云南省,玉溪市,易门县', '102.16354', '24.67122', 'Yimen', 1);
INSERT INTO `provinces`
VALUES (530426, '峨山彝族自治县', 530400, '峨山', 3, '0877', '653200', '中国,云南省,玉溪市,峨山彝族自治县', '102.40576', '24.16904', 'Eshan',
        1);
INSERT INTO `provinces`
VALUES (530427, '新平彝族傣族自治县', 530400, '新平', 3, '0877', '653400', '中国,云南省,玉溪市,新平彝族傣族自治县', '101.98895', '24.06886',
        'Xinping', 1);
INSERT INTO `provinces`
VALUES (530428, '元江哈尼族彝族傣族自治县', 530400, '元江', 3, '0877', '653300', '中国,云南省,玉溪市,元江哈尼族彝族傣族自治县', '101.99812', '23.59655',
        'Yuanjiang', 1);
INSERT INTO `provinces`
VALUES (530500, '保山市', 530000, '保山', 2, '0875', '678000', '中国,云南省,保山市', '99.167133', '25.111802', 'Baoshan', 1);
INSERT INTO `provinces`
VALUES (530502, '隆阳区', 530500, '隆阳', 3, '0875', '678000', '中国,云南省,保山市,隆阳区', '99.16334', '25.11163', 'Longyang', 1);
INSERT INTO `provinces`
VALUES (530521, '施甸县', 530500, '施甸', 3, '0875', '678200', '中国,云南省,保山市,施甸县', '99.18768', '24.72418', 'Shidian', 1);
INSERT INTO `provinces`
VALUES (530522, '腾冲县', 530500, '腾冲', 3, '0875', '679100', '中国,云南省,保山市,腾冲县', '98.49414', '25.02539', 'Tengchong', 1);
INSERT INTO `provinces`
VALUES (530523, '龙陵县', 530500, '龙陵', 3, '0875', '678300', '中国,云南省,保山市,龙陵县', '98.69024', '24.58746', 'Longling', 1);
INSERT INTO `provinces`
VALUES (530524, '昌宁县', 530500, '昌宁', 3, '0875', '678100', '中国,云南省,保山市,昌宁县', '99.6036', '24.82763', 'Changning', 1);
INSERT INTO `provinces`
VALUES (530600, '昭通市', 530000, '昭通', 2, '0870', '657000', '中国,云南省,昭通市', '103.717216', '27.336999', 'Zhaotong', 1);
INSERT INTO `provinces`
VALUES (530602, '昭阳区', 530600, '昭阳', 3, '0870', '657000', '中国,云南省,昭通市,昭阳区', '103.70654', '27.31998', 'Zhaoyang', 1);
INSERT INTO `provinces`
VALUES (530621, '鲁甸县', 530600, '鲁甸', 3, '0870', '657100', '中国,云南省,昭通市,鲁甸县', '103.54721', '27.19238', 'Ludian', 1);
INSERT INTO `provinces`
VALUES (530622, '巧家县', 530600, '巧家', 3, '0870', '654600', '中国,云南省,昭通市,巧家县', '102.92416', '26.91237', 'Qiaojia', 1);
INSERT INTO `provinces`
VALUES (530623, '盐津县', 530600, '盐津', 3, '0870', '657500', '中国,云南省,昭通市,盐津县', '104.23461', '28.10856', 'Yanjin', 1);
INSERT INTO `provinces`
VALUES (530624, '大关县', 530600, '大关', 3, '0870', '657400', '中国,云南省,昭通市,大关县', '103.89254', '27.7488', 'Daguan', 1);
INSERT INTO `provinces`
VALUES (530625, '永善县', 530600, '永善', 3, '0870', '657300', '中国,云南省,昭通市,永善县', '103.63504', '28.2279', 'Yongshan', 1);
INSERT INTO `provinces`
VALUES (530626, '绥江县', 530600, '绥江', 3, '0870', '657700', '中国,云南省,昭通市,绥江县', '103.94937', '28.59661', 'Suijiang', 1);
INSERT INTO `provinces`
VALUES (530627, '镇雄县', 530600, '镇雄', 3, '0870', '657200', '中国,云南省,昭通市,镇雄县', '104.87258', '27.43981', 'Zhenxiong', 1);
INSERT INTO `provinces`
VALUES (530628, '彝良县', 530600, '彝良', 3, '0870', '657600', '中国,云南省,昭通市,彝良县', '104.04983', '27.62809', 'Yiliang', 1);
INSERT INTO `provinces`
VALUES (530629, '威信县', 530600, '威信', 3, '0870', '657900', '中国,云南省,昭通市,威信县', '105.04754', '27.84065', 'Weixin', 1);
INSERT INTO `provinces`
VALUES (530630, '水富县', 530600, '水富', 3, '0870', '657800', '中国,云南省,昭通市,水富县', '104.4158', '28.62986', 'Shuifu', 1);
INSERT INTO `provinces`
VALUES (530700, '丽江市', 530000, '丽江', 2, '0888', '674100', '中国,云南省,丽江市', '100.233026', '26.872108', 'Lijiang', 1);
INSERT INTO `provinces`
VALUES (530702, '古城区', 530700, '古城', 3, '0888', '674100', '中国,云南省,丽江市,古城区', '100.1267', '26.87697', 'Gucheng', 1);
INSERT INTO `provinces`
VALUES (530721, '玉龙纳西族自治县', 530700, '玉龙', 3, '0888', '674100', '中国,云南省,丽江市,玉龙纳西族自治县', '100.2369', '26.82149', 'Yulong',
        1);
INSERT INTO `provinces`
VALUES (530722, '永胜县', 530700, '永胜', 3, '0888', '674200', '中国,云南省,丽江市,永胜县', '100.74667', '26.68591', 'Yongsheng', 1);
INSERT INTO `provinces`
VALUES (530723, '华坪县', 530700, '华坪', 3, '0888', '674800', '中国,云南省,丽江市,华坪县', '101.26562', '26.62967', 'Huaping', 1);
INSERT INTO `provinces`
VALUES (530724, '宁蒗彝族自治县', 530700, '宁蒗', 3, '0888', '674300', '中国,云南省,丽江市,宁蒗彝族自治县', '100.8507', '27.28179', 'Ninglang',
        1);
INSERT INTO `provinces`
VALUES (530800, '普洱市', 530000, '普洱', 2, '0879', '665000', '中国,云南省,普洱市', '100.972344', '22.777321', 'Pu\'er', 1);
INSERT INTO `provinces`
VALUES (530802, '思茅区', 530800, '思茅', 3, '0879', '665000', '中国,云南省,普洱市,思茅区', '100.97716', '22.78691', 'Simao', 1);
INSERT INTO `provinces`
VALUES (530821, '宁洱哈尼族彝族自治县', 530800, '宁洱', 3, '0879', '665100', '中国,云南省,普洱市,宁洱哈尼族彝族自治县', '101.04653', '23.06341',
        'Ninger', 1);
INSERT INTO `provinces`
VALUES (530822, '墨江哈尼族自治县', 530800, '墨江', 3, '0879', '654800', '中国,云南省,普洱市,墨江哈尼族自治县', '101.69171', '23.43214',
        'Mojiang', 1);
INSERT INTO `provinces`
VALUES (530823, '景东彝族自治县', 530800, '景东', 3, '0879', '676200', '中国,云南省,普洱市,景东彝族自治县', '100.83599', '24.44791', 'Jingdong',
        1);
INSERT INTO `provinces`
VALUES (530824, '景谷傣族彝族自治县', 530800, '景谷', 3, '0879', '666400', '中国,云南省,普洱市,景谷傣族彝族自治县', '100.70251', '23.49705',
        'Jinggu', 1);
INSERT INTO `provinces`
VALUES (530825, '镇沅彝族哈尼族拉祜族自治县', 530800, '镇沅', 3, '0879', '666500', '中国,云南省,普洱市,镇沅彝族哈尼族拉祜族自治县', '101.10675', '24.00557',
        'Zhenyuan', 1);
INSERT INTO `provinces`
VALUES (530826, '江城哈尼族彝族自治县', 530800, '江城', 3, '0879', '665900', '中国,云南省,普洱市,江城哈尼族彝族自治县', '101.85788', '22.58424',
        'Jiangcheng', 1);
INSERT INTO `provinces`
VALUES (530827, '孟连傣族拉祜族佤族自治县', 530800, '孟连', 3, '0879', '665800', '中国,云南省,普洱市,孟连傣族拉祜族佤族自治县', '99.58424', '22.32922',
        'Menglian', 1);
INSERT INTO `provinces`
VALUES (530828, '澜沧拉祜族自治县', 530800, '澜沧', 3, '0879', '665600', '中国,云南省,普洱市,澜沧拉祜族自治县', '99.93591', '22.55474', 'Lancang',
        1);
INSERT INTO `provinces`
VALUES (530829, '西盟佤族自治县', 530800, '西盟', 3, '0879', '665700', '中国,云南省,普洱市,西盟佤族自治县', '99.59869', '22.64774', 'Ximeng',
        1);
INSERT INTO `provinces`
VALUES (530900, '临沧市', 530000, '临沧', 2, '0883', '677000', '中国,云南省,临沧市', '100.08697', '23.886567', 'Lincang', 1);
INSERT INTO `provinces`
VALUES (530902, '临翔区', 530900, '临翔', 3, '0883', '677000', '中国,云南省,临沧市,临翔区', '100.08242', '23.89497', 'Linxiang', 1);
INSERT INTO `provinces`
VALUES (530921, '凤庆县', 530900, '凤庆', 3, '0883', '675900', '中国,云南省,临沧市,凤庆县', '99.92837', '24.58034', 'Fengqing', 1);
INSERT INTO `provinces`
VALUES (530922, '云县', 530900, '云县', 3, '0883', '675800', '中国,云南省,临沧市,云县', '100.12808', '24.44675', 'Yunxian', 1);
INSERT INTO `provinces`
VALUES (530923, '永德县', 530900, '永德', 3, '0883', '677600', '中国,云南省,临沧市,永德县', '99.25326', '24.0276', 'Yongde', 1);
INSERT INTO `provinces`
VALUES (530924, '镇康县', 530900, '镇康', 3, '0883', '677704', '中国,云南省,临沧市,镇康县', '98.8255', '23.76241', 'Zhenkang', 1);
INSERT INTO `provinces`
VALUES (530925, '双江拉祜族佤族布朗族傣族自治县', 530900, '双江', 3, '0883', '677300', '中国,云南省,临沧市,双江拉祜族佤族布朗族傣族自治县', '99.82769',
        '23.47349', 'Shuangjiang', 1);
INSERT INTO `provinces`
VALUES (530926, '耿马傣族佤族自治县', 530900, '耿马', 3, '0883', '677500', '中国,云南省,临沧市,耿马傣族佤族自治县', '99.39785', '23.53776',
        'Gengma', 1);
INSERT INTO `provinces`
VALUES (530927, '沧源佤族自治县', 530900, '沧源', 3, '0883', '677400', '中国,云南省,临沧市,沧源佤族自治县', '99.24545', '23.14821', 'Cangyuan',
        1);
INSERT INTO `provinces`
VALUES (532300, '楚雄彝族自治州', 530000, '楚雄', 2, '0878', '675000', '中国,云南省,楚雄彝族自治州', '101.546046', '25.041988', 'Chuxiong',
        1);
INSERT INTO `provinces`
VALUES (532301, '楚雄市', 532300, '楚雄', 3, '0878', '675000', '中国,云南省,楚雄彝族自治州,楚雄市', '101.54615', '25.0329', 'Chuxiong', 1);
INSERT INTO `provinces`
VALUES (532322, '双柏县', 532300, '双柏', 3, '0878', '675100', '中国,云南省,楚雄彝族自治州,双柏县', '101.64205', '24.68882', 'Shuangbai',
        1);
INSERT INTO `provinces`
VALUES (532323, '牟定县', 532300, '牟定', 3, '0878', '675500', '中国,云南省,楚雄彝族自治州,牟定县', '101.54', '25.31551', 'Mouding', 1);
INSERT INTO `provinces`
VALUES (532324, '南华县', 532300, '南华', 3, '0878', '675200', '中国,云南省,楚雄彝族自治州,南华县', '101.27313', '25.19293', 'Nanhua', 1);
INSERT INTO `provinces`
VALUES (532325, '姚安县', 532300, '姚安', 3, '0878', '675300', '中国,云南省,楚雄彝族自治州,姚安县', '101.24279', '25.50467', 'Yao\'an', 1);
INSERT INTO `provinces`
VALUES (532326, '大姚县', 532300, '大姚', 3, '0878', '675400', '中国,云南省,楚雄彝族自治州,大姚县', '101.32397', '25.72218', 'Dayao', 1);
INSERT INTO `provinces`
VALUES (532327, '永仁县', 532300, '永仁', 3, '0878', '651400', '中国,云南省,楚雄彝族自治州,永仁县', '101.6716', '26.05794', 'Yongren', 1);
INSERT INTO `provinces`
VALUES (532328, '元谋县', 532300, '元谋', 3, '0878', '651300', '中国,云南省,楚雄彝族自治州,元谋县', '101.87728', '25.70438', 'Yuanmou', 1);
INSERT INTO `provinces`
VALUES (532329, '武定县', 532300, '武定', 3, '0878', '651600', '中国,云南省,楚雄彝族自治州,武定县', '102.4038', '25.5295', 'Wuding', 1);
INSERT INTO `provinces`
VALUES (532331, '禄丰县', 532300, '禄丰', 3, '0878', '651200', '中国,云南省,楚雄彝族自治州,禄丰县', '102.07797', '25.14815', 'Lufeng', 1);
INSERT INTO `provinces`
VALUES (532500, '红河哈尼族彝族自治州', 530000, '红河', 2, '0873', '661400', '中国,云南省,红河哈尼族彝族自治州', '103.384182', '23.366775',
        'Honghe', 1);
INSERT INTO `provinces`
VALUES (532501, '个旧市', 532500, '个旧', 3, '0873', '661000', '中国,云南省,红河哈尼族彝族自治州,个旧市', '103.15966', '23.35894', 'Gejiu', 1);
INSERT INTO `provinces`
VALUES (532502, '开远市', 532500, '开远', 3, '0873', '661600', '中国,云南省,红河哈尼族彝族自治州,开远市', '103.26986', '23.71012', 'Kaiyuan',
        1);
INSERT INTO `provinces`
VALUES (532503, '蒙自市', 532500, '蒙自', 3, '0873', '661101', '中国,云南省,红河哈尼族彝族自治州,蒙自市', '103.385005', '23.366843', 'Mengzi',
        1);
INSERT INTO `provinces`
VALUES (532504, '弥勒市', 532500, '弥勒', 3, '0873', '652300', '中国,云南省,红河哈尼族彝族自治州,弥勒市', '103.436988', '24.40837', 'Mile ',
        1);
INSERT INTO `provinces`
VALUES (532523, '屏边苗族自治县', 532500, '屏边', 3, '0873', '661200', '中国,云南省,红河哈尼族彝族自治州,屏边苗族自治县', '103.68554', '22.98425',
        'Pingbian', 1);
INSERT INTO `provinces`
VALUES (532524, '建水县', 532500, '建水', 3, '0873', '654300', '中国,云南省,红河哈尼族彝族自治州,建水县', '102.82656', '23.63472', 'Jianshui',
        1);
INSERT INTO `provinces`
VALUES (532525, '石屏县', 532500, '石屏', 3, '0873', '662200', '中国,云南省,红河哈尼族彝族自治州,石屏县', '102.49408', '23.71441', 'Shiping',
        1);
INSERT INTO `provinces`
VALUES (532527, '泸西县', 532500, '泸西', 3, '0873', '652400', '中国,云南省,红河哈尼族彝族自治州,泸西县', '103.76373', '24.52854', 'Luxi', 1);
INSERT INTO `provinces`
VALUES (532528, '元阳县', 532500, '元阳', 3, '0873', '662400', '中国,云南省,红河哈尼族彝族自治州,元阳县', '102.83261', '23.22281', 'Yuanyang',
        1);
INSERT INTO `provinces`
VALUES (532529, '红河县', 532500, '红河县', 3, '0873', '654400', '中国,云南省,红河哈尼族彝族自治州,红河县', '102.42059', '23.36767',
        'Honghexian', 1);
INSERT INTO `provinces`
VALUES (532530, '金平苗族瑶族傣族自治县', 532500, '金平', 3, '0873', '661500', '中国,云南省,红河哈尼族彝族自治州,金平苗族瑶族傣族自治县', '103.22651',
        '22.77959', 'Jinping', 1);
INSERT INTO `provinces`
VALUES (532531, '绿春县', 532500, '绿春', 3, '0873', '662500', '中国,云南省,红河哈尼族彝族自治州,绿春县', '102.39672', '22.99371', 'Lvchun',
        1);
INSERT INTO `provinces`
VALUES (532532, '河口瑶族自治县', 532500, '河口', 3, '0873', '661300', '中国,云南省,红河哈尼族彝族自治州,河口瑶族自治县', '103.93936', '22.52929',
        'Hekou', 1);
INSERT INTO `provinces`
VALUES (532600, '文山壮族苗族自治州', 530000, '文山', 2, '0876', '663000', '中国,云南省,文山壮族苗族自治州', '104.24401', '23.36951', 'Wenshan',
        1);
INSERT INTO `provinces`
VALUES (532601, '文山市', 532600, '文山', 3, '0876', '663000', '中国,云南省,文山壮族苗族自治州,文山市', '104.244277', '23.369216', 'Wenshan',
        1);
INSERT INTO `provinces`
VALUES (532622, '砚山县', 532600, '砚山', 3, '0876', '663100', '中国,云南省,文山壮族苗族自治州,砚山县', '104.33306', '23.60723', 'Yanshan',
        1);
INSERT INTO `provinces`
VALUES (532623, '西畴县', 532600, '西畴', 3, '0876', '663500', '中国,云南省,文山壮族苗族自治州,西畴县', '104.67419', '23.43941', 'Xichou', 1);
INSERT INTO `provinces`
VALUES (532624, '麻栗坡县', 532600, '麻栗坡', 3, '0876', '663600', '中国,云南省,文山壮族苗族自治州,麻栗坡县', '104.70132', '23.12028', 'Malipo',
        1);
INSERT INTO `provinces`
VALUES (532625, '马关县', 532600, '马关', 3, '0876', '663700', '中国,云南省,文山壮族苗族自治州,马关县', '104.39514', '23.01293', 'Maguan', 1);
INSERT INTO `provinces`
VALUES (532626, '丘北县', 532600, '丘北', 3, '0876', '663200', '中国,云南省,文山壮族苗族自治州,丘北县', '104.19256', '24.03957', 'Qiubei', 1);
INSERT INTO `provinces`
VALUES (532627, '广南县', 532600, '广南', 3, '0876', '663300', '中国,云南省,文山壮族苗族自治州,广南县', '105.05511', '24.0464', 'Guangnan',
        1);
INSERT INTO `provinces`
VALUES (532628, '富宁县', 532600, '富宁', 3, '0876', '663400', '中国,云南省,文山壮族苗族自治州,富宁县', '105.63085', '23.62536', 'Funing', 1);
INSERT INTO `provinces`
VALUES (532800, '西双版纳傣族自治州', 530000, '西双版纳', 2, '0691', '666100', '中国,云南省,西双版纳傣族自治州', '100.797941', '22.001724',
        'Xishuangbanna', 1);
INSERT INTO `provinces`
VALUES (532801, '景洪市', 532800, '景洪', 3, '0691', '666100', '中国,云南省,西双版纳傣族自治州,景洪市', '100.79977', '22.01071', 'Jinghong',
        1);
INSERT INTO `provinces`
VALUES (532822, '勐海县', 532800, '勐海', 3, '0691', '666200', '中国,云南省,西双版纳傣族自治州,勐海县', '100.44931', '21.96175', 'Menghai',
        1);
INSERT INTO `provinces`
VALUES (532823, '勐腊县', 532800, '勐腊', 3, '0691', '666300', '中国,云南省,西双版纳傣族自治州,勐腊县', '101.56488', '21.48162', 'Mengla', 1);
INSERT INTO `provinces`
VALUES (532900, '大理白族自治州', 530000, '大理', 2, '0872', '671000', '中国,云南省,大理白族自治州', '100.240037', '25.592765', 'Dali', 1);
INSERT INTO `provinces`
VALUES (532901, '大理市', 532900, '大理', 3, '0872', '671000', '中国,云南省,大理白族自治州,大理市', '100.22998', '25.59157', 'Dali', 1);
INSERT INTO `provinces`
VALUES (532922, '漾濞彝族自治县', 532900, '漾濞', 3, '0872', '672500', '中国,云南省,大理白族自治州,漾濞彝族自治县', '99.95474', '25.6652', 'Yangbi',
        1);
INSERT INTO `provinces`
VALUES (532923, '祥云县', 532900, '祥云', 3, '0872', '672100', '中国,云南省,大理白族自治州,祥云县', '100.55761', '25.47342', 'Xiangyun', 1);
INSERT INTO `provinces`
VALUES (532924, '宾川县', 532900, '宾川', 3, '0872', '671600', '中国,云南省,大理白族自治州,宾川县', '100.57666', '25.83144', 'Binchuan', 1);
INSERT INTO `provinces`
VALUES (532925, '弥渡县', 532900, '弥渡', 3, '0872', '675600', '中国,云南省,大理白族自治州,弥渡县', '100.49075', '25.34179', 'Midu', 1);
INSERT INTO `provinces`
VALUES (532926, '南涧彝族自治县', 532900, '南涧', 3, '0872', '675700', '中国,云南省,大理白族自治州,南涧彝族自治县', '100.50964', '25.04349',
        'Nanjian', 1);
INSERT INTO `provinces`
VALUES (532927, '巍山彝族回族自治县', 532900, '巍山', 3, '0872', '672400', '中国,云南省,大理白族自治州,巍山彝族回族自治县', '100.30612', '25.23197',
        'Weishan', 1);
INSERT INTO `provinces`
VALUES (532928, '永平县', 532900, '永平', 3, '0872', '672600', '中国,云南省,大理白族自治州,永平县', '99.54095', '25.46451', 'Yongping', 1);
INSERT INTO `provinces`
VALUES (532929, '云龙县', 532900, '云龙', 3, '0872', '672700', '中国,云南省,大理白族自治州,云龙县', '99.37255', '25.88505', 'Yunlong', 1);
INSERT INTO `provinces`
VALUES (532930, '洱源县', 532900, '洱源', 3, '0872', '671200', '中国,云南省,大理白族自治州,洱源县', '99.94903', '26.10829', 'Eryuan', 1);
INSERT INTO `provinces`
VALUES (532931, '剑川县', 532900, '剑川', 3, '0872', '671300', '中国,云南省,大理白族自治州,剑川县', '99.90545', '26.53688', 'Jianchuan', 1);
INSERT INTO `provinces`
VALUES (532932, '鹤庆县', 532900, '鹤庆', 3, '0872', '671500', '中国,云南省,大理白族自治州,鹤庆县', '100.17697', '26.55798', 'Heqing', 1);
INSERT INTO `provinces`
VALUES (533100, '德宏傣族景颇族自治州', 530000, '德宏', 2, '0692', '678400', '中国,云南省,德宏傣族景颇族自治州', '98.578363', '24.436694',
        'Dehong', 1);
INSERT INTO `provinces`
VALUES (533102, '瑞丽市', 533100, '瑞丽', 3, '0692', '678600', '中国,云南省,德宏傣族景颇族自治州,瑞丽市', '97.85183', '24.01277', 'Ruili', 1);
INSERT INTO `provinces`
VALUES (533103, '芒市', 533100, '芒市', 3, '0692', '678400', '中国,云南省,德宏傣族景颇族自治州,芒市', '98.588641', '24.433735', 'Mangshi',
        1);
INSERT INTO `provinces`
VALUES (533122, '梁河县', 533100, '梁河', 3, '0692', '679200', '中国,云南省,德宏傣族景颇族自治州,梁河县', '98.29705', '24.80658', 'Lianghe',
        1);
INSERT INTO `provinces`
VALUES (533123, '盈江县', 533100, '盈江', 3, '0692', '679300', '中国,云南省,德宏傣族景颇族自治州,盈江县', '97.93179', '24.70579', 'Yingjiang',
        1);
INSERT INTO `provinces`
VALUES (533124, '陇川县', 533100, '陇川', 3, '0692', '678700', '中国,云南省,德宏傣族景颇族自治州,陇川县', '97.79199', '24.18302', 'Longchuan',
        1);
INSERT INTO `provinces`
VALUES (533300, '怒江傈僳族自治州', 530000, '怒江', 2, '0886', '673100', '中国,云南省,怒江傈僳族自治州', '98.854304', '25.850949', 'Nujiang',
        1);
INSERT INTO `provinces`
VALUES (533321, '泸水县', 533300, '泸水', 3, '0886', '673100', '中国,云南省,怒江傈僳族自治州,泸水县', '98.85534', '25.83772', 'Lushui', 1);
INSERT INTO `provinces`
VALUES (533323, '福贡县', 533300, '福贡', 3, '0886', '673400', '中国,云南省,怒江傈僳族自治州,福贡县', '98.86969', '26.90366', 'Fugong', 1);
INSERT INTO `provinces`
VALUES (533324, '贡山独龙族怒族自治县', 533300, '贡山', 3, '0886', '673500', '中国,云南省,怒江傈僳族自治州,贡山独龙族怒族自治县', '98.66583', '27.74088',
        'Gongshan', 1);
INSERT INTO `provinces`
VALUES (533325, '兰坪白族普米族自治县', 533300, '兰坪', 3, '0886', '671400', '中国,云南省,怒江傈僳族自治州,兰坪白族普米族自治县', '99.41891', '26.45251',
        'Lanping', 1);
INSERT INTO `provinces`
VALUES (533400, '迪庆藏族自治州', 530000, '迪庆', 2, '0887', '674400', '中国,云南省,迪庆藏族自治州', '99.706463', '27.826853', 'Deqen', 1);
INSERT INTO `provinces`
VALUES (533421, '香格里拉市', 533400, '香格里拉', 3, '0887', '674400', '中国,云南省,迪庆藏族自治州,香格里拉市', '99.70601', '27.82308',
        'Xianggelila', 1);
INSERT INTO `provinces`
VALUES (533422, '德钦县', 533400, '德钦', 3, '0887', '674500', '中国,云南省,迪庆藏族自治州,德钦县', '98.91082', '28.4863', 'Deqin', 1);
INSERT INTO `provinces`
VALUES (533423, '维西傈僳族自治县', 533400, '维西', 3, '0887', '674600', '中国,云南省,迪庆藏族自治州,维西傈僳族自治县', '99.28402', '27.1793',
        'Weixi', 1);
INSERT INTO `provinces`
VALUES (540000, '西藏自治区', 100000, '西藏', 1, '', '', '中国,西藏自治区', '91.132212', '29.660361', 'Tibet', 1);
INSERT INTO `provinces`
VALUES (540100, '拉萨市', 540000, '拉萨', 2, '0891', '850000', '中国,西藏自治区,拉萨市', '91.132212', '29.660361', 'Lhasa', 1);
INSERT INTO `provinces`
VALUES (540102, '城关区', 540100, '城关', 3, '0891', '850000', '中国,西藏自治区,拉萨市,城关区', '91.13859', '29.65312', 'Chengguan', 1);
INSERT INTO `provinces`
VALUES (540121, '林周县', 540100, '林周', 3, '0891', '851600', '中国,西藏自治区,拉萨市,林周县', '91.2586', '29.89445', 'Linzhou', 1);
INSERT INTO `provinces`
VALUES (540122, '当雄县', 540100, '当雄', 3, '0891', '851500', '中国,西藏自治区,拉萨市,当雄县', '91.10076', '30.48309', 'Dangxiong', 1);
INSERT INTO `provinces`
VALUES (540123, '尼木县', 540100, '尼木', 3, '0891', '851300', '中国,西藏自治区,拉萨市,尼木县', '90.16378', '29.43353', 'Nimu', 1);
INSERT INTO `provinces`
VALUES (540124, '曲水县', 540100, '曲水', 3, '0891', '850600', '中国,西藏自治区,拉萨市,曲水县', '90.73187', '29.35636', 'Qushui', 1);
INSERT INTO `provinces`
VALUES (540125, '堆龙德庆县', 540100, '堆龙德庆', 3, '0891', '851400', '中国,西藏自治区,拉萨市,堆龙德庆县', '91.00033', '29.65002',
        'Duilongdeqing', 1);
INSERT INTO `provinces`
VALUES (540126, '达孜县', 540100, '达孜', 3, '0891', '850100', '中国,西藏自治区,拉萨市,达孜县', '91.35757', '29.6722', 'Dazi', 1);
INSERT INTO `provinces`
VALUES (540127, '墨竹工卡县', 540100, '墨竹工卡', 3, '0891', '850200', '中国,西藏自治区,拉萨市,墨竹工卡县', '91.72814', '29.83614',
        'Mozhugongka', 1);
INSERT INTO `provinces`
VALUES (540200, '日喀则市', 540000, '日喀则', 2, '0892', '857000', '中国,西藏自治区,日喀则市', '88.884874', '29.263792', 'Rikaze', 1);
INSERT INTO `provinces`
VALUES (540202, '桑珠孜区', 540200, '桑珠孜', 3, '0892', '857000', '中国,西藏自治区,日喀则市,桑珠孜区', '88.880367', '29.269565', 'Sangzhuzi',
        1);
INSERT INTO `provinces`
VALUES (540221, '南木林县', 540200, '南木林', 3, '0892', '857100', '中国,西藏自治区,日喀则市,南木林县', '89.09686', '29.68206', 'Nanmulin',
        1);
INSERT INTO `provinces`
VALUES (540222, '江孜县', 540200, '江孜', 3, '0892', '857400', '中国,西藏自治区,日喀则市,江孜县', '89.60263', '28.91744', 'Jiangzi', 1);
INSERT INTO `provinces`
VALUES (540223, '定日县', 540200, '定日', 3, '0892', '858200', '中国,西藏自治区,日喀则市,定日县', '87.12176', '28.66129', 'Dingri', 1);
INSERT INTO `provinces`
VALUES (540224, '萨迦县', 540200, '萨迦', 3, '0892', '857800', '中国,西藏自治区,日喀则市,萨迦县', '88.02191', '28.90299', 'Sajia', 1);
INSERT INTO `provinces`
VALUES (620521, '清水县', 620500, '清水', 3, '0938', '741400', '中国,甘肃省,天水市,清水县', '106.13671', '34.75032', 'Qingshui', 1);
INSERT INTO `provinces`
VALUES (620522, '秦安县', 620500, '秦安', 3, '0938', '741600', '中国,甘肃省,天水市,秦安县', '105.66955', '34.85894', 'Qin\'an', 1);
INSERT INTO `provinces`
VALUES (620523, '甘谷县', 620500, '甘谷', 3, '0938', '741200', '中国,甘肃省,天水市,甘谷县', '105.33291', '34.73665', 'Gangu', 1);
INSERT INTO `provinces`
VALUES (620524, '武山县', 620500, '武山', 3, '0938', '741300', '中国,甘肃省,天水市,武山县', '104.88382', '34.72123', 'Wushan', 1);
INSERT INTO `provinces`
VALUES (620525, '张家川回族自治县', 620500, '张家川', 3, '0938', '741500', '中国,甘肃省,天水市,张家川回族自治县', '106.21582', '34.99582',
        'Zhangjiachuan', 1);
INSERT INTO `provinces`
VALUES (620600, '武威市', 620000, '武威', 2, '0935', '733000', '中国,甘肃省,武威市', '102.634697', '37.929996', 'Wuwei', 1);
INSERT INTO `provinces`
VALUES (620602, '凉州区', 620600, '凉州', 3, '0935', '733000', '中国,甘肃省,武威市,凉州区', '102.64203', '37.92832', 'Liangzhou', 1);
INSERT INTO `provinces`
VALUES (620621, '民勤县', 620600, '民勤', 3, '0935', '733300', '中国,甘肃省,武威市,民勤县', '103.09011', '38.62487', 'Minqin', 1);
INSERT INTO `provinces`
VALUES (620622, '古浪县', 620600, '古浪', 3, '0935', '733100', '中国,甘肃省,武威市,古浪县', '102.89154', '37.46508', 'Gulang', 1);
INSERT INTO `provinces`
VALUES (620623, '天祝藏族自治县', 620600, '天祝', 3, '0935', '733200', '中国,甘肃省,武威市,天祝藏族自治县', '103.1361', '36.97715', 'Tianzhu',
        1);
INSERT INTO `provinces`
VALUES (620700, '张掖市', 620000, '张掖', 2, '0936', '734000', '中国,甘肃省,张掖市', '100.455472', '38.932897', 'Zhangye', 1);
INSERT INTO `provinces`
VALUES (620702, '甘州区', 620700, '甘州', 3, '0936', '734000', '中国,甘肃省,张掖市,甘州区', '100.4527', '38.92947', 'Ganzhou', 1);
INSERT INTO `provinces`
VALUES (620721, '肃南裕固族自治县', 620700, '肃南', 3, '0936', '734400', '中国,甘肃省,张掖市,肃南裕固族自治县', '99.61407', '38.83776', 'Sunan',
        1);
INSERT INTO `provinces`
VALUES (620722, '民乐县', 620700, '民乐', 3, '0936', '734500', '中国,甘肃省,张掖市,民乐县', '100.81091', '38.43479', 'Minle', 1);
INSERT INTO `provinces`
VALUES (620723, '临泽县', 620700, '临泽', 3, '0936', '734200', '中国,甘肃省,张掖市,临泽县', '100.16445', '39.15252', 'Linze', 1);
INSERT INTO `provinces`
VALUES (620724, '高台县', 620700, '高台', 3, '0936', '734300', '中国,甘肃省,张掖市,高台县', '99.81918', '39.37829', 'Gaotai', 1);
INSERT INTO `provinces`
VALUES (620725, '山丹县', 620700, '山丹', 3, '0936', '734100', '中国,甘肃省,张掖市,山丹县', '101.09359', '38.78468', 'Shandan', 1);
INSERT INTO `provinces`
VALUES (620800, '平凉市', 620000, '平凉', 2, '0933', '744000', '中国,甘肃省,平凉市', '106.684691', '35.54279', 'Pingliang', 1);
INSERT INTO `provinces`
VALUES (620802, '崆峒区', 620800, '崆峒', 3, '0933', '744000', '中国,甘肃省,平凉市,崆峒区', '106.67483', '35.54262', 'Kongtong', 1);
INSERT INTO `provinces`
VALUES (620821, '泾川县', 620800, '泾川', 3, '0933', '744300', '中国,甘肃省,平凉市,泾川县', '107.36581', '35.33223', 'Jingchuan', 1);
INSERT INTO `provinces`
VALUES (620822, '灵台县', 620800, '灵台', 3, '0933', '744400', '中国,甘肃省,平凉市,灵台县', '107.6174', '35.06768', 'Lingtai', 1);
INSERT INTO `provinces`
VALUES (620823, '崇信县', 620800, '崇信', 3, '0933', '744200', '中国,甘肃省,平凉市,崇信县', '107.03738', '35.30344', 'Chongxin', 1);
INSERT INTO `provinces`
VALUES (620824, '华亭县', 620800, '华亭', 3, '0933', '744100', '中国,甘肃省,平凉市,华亭县', '106.65463', '35.2183', 'Huating', 1);
INSERT INTO `provinces`
VALUES (620825, '庄浪县', 620800, '庄浪', 3, '0933', '744600', '中国,甘肃省,平凉市,庄浪县', '106.03662', '35.20235', 'Zhuanglang', 1);
INSERT INTO `provinces`
VALUES (620826, '静宁县', 620800, '静宁', 3, '0933', '743400', '中国,甘肃省,平凉市,静宁县', '105.72723', '35.51991', 'Jingning', 1);
INSERT INTO `provinces`
VALUES (620900, '酒泉市', 620000, '酒泉', 2, '0937', '735000', '中国,甘肃省,酒泉市', '98.510795', '39.744023', 'Jiuquan', 1);
INSERT INTO `provinces`
VALUES (620902, '肃州区', 620900, '肃州', 3, '0937', '735000', '中国,甘肃省,酒泉市,肃州区', '98.50775', '39.74506', 'Suzhou', 1);
INSERT INTO `provinces`
VALUES (620921, '金塔县', 620900, '金塔', 3, '0937', '735300', '中国,甘肃省,酒泉市,金塔县', '98.90002', '39.97733', 'Jinta', 1);
INSERT INTO `provinces`
VALUES (620922, '瓜州县', 620900, '瓜州', 3, '0937', '736100', '中国,甘肃省,酒泉市,瓜州县', '95.78271', '40.51548', 'Guazhou', 1);
INSERT INTO `provinces`
VALUES (620923, '肃北蒙古族自治县', 620900, '肃北', 3, '0937', '736300', '中国,甘肃省,酒泉市,肃北蒙古族自治县', '94.87649', '39.51214', 'Subei',
        1);
INSERT INTO `provinces`
VALUES (620924, '阿克塞哈萨克族自治县', 620900, '阿克塞', 3, '0937', '736400', '中国,甘肃省,酒泉市,阿克塞哈萨克族自治县', '94.34097', '39.63435',
        'Akesai', 1);
INSERT INTO `provinces`
VALUES (620981, '玉门市', 620900, '玉门', 3, '0937', '735200', '中国,甘肃省,酒泉市,玉门市', '97.04538', '40.29172', 'Yumen', 1);
INSERT INTO `provinces`
VALUES (620982, '敦煌市', 620900, '敦煌', 3, '0937', '736200', '中国,甘肃省,酒泉市,敦煌市', '94.66159', '40.14211', 'Dunhuang', 1);
INSERT INTO `provinces`
VALUES (621000, '庆阳市', 620000, '庆阳', 2, '0934', '745000', '中国,甘肃省,庆阳市', '107.638372', '35.734218', 'Qingyang', 1);
INSERT INTO `provinces`
VALUES (621002, '西峰区', 621000, '西峰', 3, '0934', '745000', '中国,甘肃省,庆阳市,西峰区', '107.65107', '35.73065', 'Xifeng', 1);
INSERT INTO `provinces`
VALUES (621021, '庆城县', 621000, '庆城', 3, '0934', '745100', '中国,甘肃省,庆阳市,庆城县', '107.88272', '36.01507', 'Qingcheng', 1);
INSERT INTO `provinces`
VALUES (621022, '环县', 621000, '环县', 3, '0934', '745700', '中国,甘肃省,庆阳市,环县', '107.30835', '36.56846', 'Huanxian', 1);
INSERT INTO `provinces`
VALUES (621023, '华池县', 621000, '华池', 3, '0934', '745600', '中国,甘肃省,庆阳市,华池县', '107.9891', '36.46108', 'Huachi', 1);
INSERT INTO `provinces`
VALUES (621024, '合水县', 621000, '合水', 3, '0934', '745400', '中国,甘肃省,庆阳市,合水县', '108.02032', '35.81911', 'Heshui', 1);
INSERT INTO `provinces`
VALUES (621025, '正宁县', 621000, '正宁', 3, '0934', '745300', '中国,甘肃省,庆阳市,正宁县', '108.36007', '35.49174', 'Zhengning', 1);
INSERT INTO `provinces`
VALUES (621026, '宁县', 621000, '宁县', 3, '0934', '745200', '中国,甘肃省,庆阳市,宁县', '107.92517', '35.50164', 'Ningxian', 1);
INSERT INTO `provinces`
VALUES (621027, '镇原县', 621000, '镇原', 3, '0934', '744500', '中国,甘肃省,庆阳市,镇原县', '107.199', '35.67712', 'Zhenyuan', 1);
INSERT INTO `provinces`
VALUES (621100, '定西市', 620000, '定西', 2, '0932', '743000', '中国,甘肃省,定西市', '104.626294', '35.579578', 'Dingxi', 1);
INSERT INTO `provinces`
VALUES (621102, '安定区', 621100, '安定', 3, '0932', '743000', '中国,甘肃省,定西市,安定区', '104.6106', '35.58066', 'Anding', 1);
INSERT INTO `provinces`
VALUES (621121, '通渭县', 621100, '通渭', 3, '0932', '743300', '中国,甘肃省,定西市,通渭县', '105.24224', '35.21101', 'Tongwei', 1);
INSERT INTO `provinces`
VALUES (621122, '陇西县', 621100, '陇西', 3, '0932', '748100', '中国,甘肃省,定西市,陇西县', '104.63446', '35.00238', 'Longxi', 1);
INSERT INTO `provinces`
VALUES (621123, '渭源县', 621100, '渭源', 3, '0932', '748200', '中国,甘肃省,定西市,渭源县', '104.21435', '35.13649', 'Weiyuan', 1);
INSERT INTO `provinces`
VALUES (621124, '临洮县', 621100, '临洮', 3, '0932', '730500', '中国,甘肃省,定西市,临洮县', '103.86196', '35.3751', 'Lintao', 1);
INSERT INTO `provinces`
VALUES (621125, '漳县', 621100, '漳县', 3, '0932', '748300', '中国,甘肃省,定西市,漳县', '104.46704', '34.84977', 'Zhangxian', 1);
INSERT INTO `provinces`
VALUES (621126, '岷县', 621100, '岷县', 3, '0932', '748400', '中国,甘肃省,定西市,岷县', '104.03772', '34.43444', 'Minxian', 1);
INSERT INTO `provinces`
VALUES (621200, '陇南市', 620000, '陇南', 2, '0939', '746000', '中国,甘肃省,陇南市', '104.929379', '33.388598', 'Longnan', 1);
INSERT INTO `provinces`
VALUES (621202, '武都区', 621200, '武都', 3, '0939', '746000', '中国,甘肃省,陇南市,武都区', '104.92652', '33.39239', 'Wudu', 1);
INSERT INTO `provinces`
VALUES (621221, '成县', 621200, '成县', 3, '0939', '742500', '中国,甘肃省,陇南市,成县', '105.72586', '33.73925', 'Chengxian', 1);
INSERT INTO `provinces`
VALUES (621222, '文县', 621200, '文县', 3, '0939', '746400', '中国,甘肃省,陇南市,文县', '104.68362', '32.94337', 'Wenxian', 1);
INSERT INTO `provinces`
VALUES (621223, '宕昌县', 621200, '宕昌', 3, '0939', '748500', '中国,甘肃省,陇南市,宕昌县', '104.39349', '34.04732', 'Dangchang', 1);
INSERT INTO `provinces`
VALUES (621224, '康县', 621200, '康县', 3, '0939', '746500', '中国,甘肃省,陇南市,康县', '105.60711', '33.32912', 'Kangxian', 1);
INSERT INTO `provinces`
VALUES (710418, '大雅区', 710400, '大雅', 3, '04', '428', '中国,台湾,台中市,大雅区', '120.647780', '24.229230', 'Daya', 1);
INSERT INTO `provinces`
VALUES (710419, '新社区', 710400, '新社', 3, '04', '426', '中国,台湾,台中市,新社区', '120.809500', '24.234140', 'Xinshe', 1);
INSERT INTO `provinces`
VALUES (710420, '石冈区', 710400, '石冈', 3, '04', '422', '中国,台湾,台中市,石冈区', '120.780410', '24.274980', 'Shigang', 1);
INSERT INTO `provinces`
VALUES (710421, '外埔区', 710400, '外埔', 3, '04', '438', '中国,台湾,台中市,外埔区', '120.654370', '24.332010', 'Waipu', 1);
INSERT INTO `provinces`
VALUES (710422, '大安区', 710400, '大安', 3, '04', '439', '中国,台湾,台中市,大安区', '120.58652', '24.34607', 'Da\'an', 1);
INSERT INTO `provinces`
VALUES (710423, '乌日区', 710400, '乌日', 3, '04', '414', '中国,台湾,台中市,乌日区', '120.623810', '24.104500', 'Wuri', 1);
INSERT INTO `provinces`
VALUES (710424, '大肚区', 710400, '大肚', 3, '04', '432', '中国,台湾,台中市,大肚区', '120.540960', '24.153660', 'Dadu', 1);
INSERT INTO `provinces`
VALUES (710425, '龙井区', 710400, '龙井', 3, '04', '434', '中国,台湾,台中市,龙井区', '120.545940', '24.192710', 'Longjing', 1);
INSERT INTO `provinces`
VALUES (710426, '雾峰区', 710400, '雾峰', 3, '04', '413', '中国,台湾,台中市,雾峰区', '120.700200', '24.061520', 'Wufeng', 1);
INSERT INTO `provinces`
VALUES (710427, '太平区', 710400, '太平', 3, '04', '411', '中国,台湾,台中市,太平区', '120.718523', '24.126472', 'Taiping', 1);
INSERT INTO `provinces`
VALUES (710428, '大里区', 710400, '大里', 3, '04', '412', '中国,台湾,台中市,大里区', '120.677860', '24.099390', 'Dali', 1);
INSERT INTO `provinces`
VALUES (710429, '和平区', 710400, '和平', 3, '04', '424', '中国,台湾,台中市,和平区', '120.88349', '24.17477', 'Heping', 1);
INSERT INTO `provinces`
VALUES (710500, '台南市', 710000, '台南', 2, '06', '7', '中国,台湾,台南市', '120.279363', '23.172478', 'Tainan', 1);
INSERT INTO `provinces`
VALUES (710501, '东区', 710500, '东区', 3, '06', '701', '中国,台湾,台南市,东区', '120.224198', '22.980072', 'Dongqu', 1);
INSERT INTO `provinces`
VALUES (710502, '南区', 710500, '南区', 3, '06', '702', '中国,台湾,台南市,南区', '120.188648', '22.960944', 'Nanqu', 1);
INSERT INTO `provinces`
VALUES (710504, '北区', 710500, '北区', 3, '06', '704', '中国,台湾,台南市,北区', '120.682410', '24.166040', 'Beiqu', 1);
INSERT INTO `provinces`
VALUES (710506, '安南区', 710500, '安南', 3, '06', '709', '中国,台湾,台南市,安南区', '120.184617', '23.047230', 'Annan', 1);
INSERT INTO `provinces`
VALUES (710507, '安平区', 710500, '安平', 3, '06', '708', '中国,台湾,台南市,安平区', '120.166810', '23.000763', 'Anping', 1);
INSERT INTO `provinces`
VALUES (710508, '中西区', 710500, '中西', 3, '06', '700', '中国,台湾,台南市,中西区', '120.205957', '22.992152', 'Zhongxi', 1);
INSERT INTO `provinces`
VALUES (710509, '新营区', 710500, '新营', 3, '06', '730', '中国,台湾,台南市,新营区', '120.316698', '23.310274', 'Xinying', 1);
INSERT INTO `provinces`
VALUES (710510, '盐水区', 710500, '盐水', 3, '06', '737', '中国,台湾,台南市,盐水区', '120.266398', '23.319828', 'Yanshui', 1);
INSERT INTO `provinces`
VALUES (710511, '白河区', 710500, '白河', 3, '06', '732', '中国,台湾,台南市,白河区', '120.415810', '23.351221', 'Baihe', 1);
INSERT INTO `provinces`
VALUES (710512, '柳营区', 710500, '柳营', 3, '06', '736', '中国,台湾,台南市,柳营区', '120.311286', '23.278133', 'Liuying', 1);
INSERT INTO `provinces`
VALUES (710513, '后壁区', 710500, '后壁', 3, '06', '731', '中国,台湾,台南市,后壁区', '120.362726', '23.366721', 'Houbi', 1);
INSERT INTO `provinces`
VALUES (710514, '东山区', 710500, '东山', 3, '06', '733', '中国,台湾,台南市,东山区', '120.403984', '23.326092', 'Dongshan', 1);
INSERT INTO `provinces`
VALUES (710515, '麻豆区', 710500, '麻豆', 3, '06', '721', '中国,台湾,台南市,麻豆区', '120.248179', '23.181680', 'Madou', 1);
INSERT INTO `provinces`
VALUES (710516, '下营区', 710500, '下营', 3, '06', '735', '中国,台湾,台南市,下营区', '120.264484', '23.235413', 'Xiaying', 1);
INSERT INTO `provinces`
VALUES (710517, '六甲区', 710500, '六甲', 3, '06', '734', '中国,台湾,台南市,六甲区', '120.347600', '23.231931', 'Liujia', 1);
INSERT INTO `provinces`
VALUES (710518, '官田区', 710500, '官田', 3, '06', '720', '中国,台湾,台南市,官田区', '120.314374', '23.194652', 'Guantian', 1);
INSERT INTO `provinces`
VALUES (710519, '大内区', 710500, '大内', 3, '06', '742', '中国,台湾,台南市,大内区', '120.348853', '23.119460', 'Dana', 1);
INSERT INTO `provinces`
VALUES (710520, '佳里区', 710500, '佳里', 3, '06', '722', '中国,台湾,台南市,佳里区', '120.177211', '23.165121', 'Jiali', 1);
INSERT INTO `provinces`
VALUES (710521, '学甲区', 710500, '学甲', 3, '06', '726', '中国,台湾,台南市,学甲区', '120.180255', '23.232348', 'Xuejia', 1);
INSERT INTO `provinces`
VALUES (710522, '西港区', 710500, '西港', 3, '06', '723', '中国,台湾,台南市,西港区', '120.203618', '23.123057', 'Xigang', 1);
INSERT INTO `provinces`
VALUES (710523, '七股区', 710500, '七股', 3, '06', '724', '中国,台湾,台南市,七股区', '120.140003', '23.140545', 'Qigu', 1);
INSERT INTO `provinces`
VALUES (710524, '将军区', 710500, '将军', 3, '06', '725', '中国,台湾,台南市,将军区', '120.156871', '23.199543', 'Jiangjun', 1);
INSERT INTO `provinces`
VALUES (710525, '北门区', 710500, '北门', 3, '06', '727', '中国,台湾,台南市,北门区', '120.125821', '23.267148', 'Beimen', 1);
INSERT INTO `provinces`
VALUES (710526, '新化区', 710500, '新化', 3, '06', '712', '中国,台湾,台南市,新化区', '120.310807', '23.038533', 'Xinhua', 1);
INSERT INTO `provinces`
VALUES (710527, '善化区', 710500, '善化', 3, '06', '741', '中国,台湾,台南市,善化区', '120.296895', '23.132261', 'Shanhua', 1);
INSERT INTO `provinces`
VALUES (710528, '新市区', 710500, '新市', 3, '06', '744', '中国,台湾,台南市,新市区', '120.295138', '23.07897', 'Xinshi', 1);
INSERT INTO `provinces`
VALUES (710529, '安定区', 710500, '安定', 3, '06', '745', '中国,台湾,台南市,安定区', '120.237083', '23.121498', 'Anding', 1);
INSERT INTO `provinces`
VALUES (710530, '山上区', 710500, '山上', 3, '06', '743', '中国,台湾,台南市,山上区', '120.352908', '23.103223', 'Shanshang', 1);
INSERT INTO `provinces`
VALUES (710531, '玉井区', 710500, '玉井', 3, '06', '714', '中国,台湾,台南市,玉井区', '120.460110', '23.123859', 'Yujing', 1);
INSERT INTO `provinces`
VALUES (710532, '楠西区', 710500, '楠西', 3, '06', '715', '中国,台湾,台南市,楠西区', '120.485396', '23.173454', 'Nanxi', 1);
INSERT INTO `provinces`
VALUES (710533, '南化区', 710500, '南化', 3, '06', '716', '中国,台湾,台南市,南化区', '120.477116', '23.042614', 'Nanhua', 1);
INSERT INTO `provinces`
VALUES (710534, '左镇区', 710500, '左镇', 3, '06', '713', '中国,台湾,台南市,左镇区', '120.407309', '23.057955', 'Zuozhen', 1);
INSERT INTO `provinces`
VALUES (710535, '仁德区', 710500, '仁德', 3, '06', '717', '中国,台湾,台南市,仁德区', '120.251520', '22.972212', 'Rende', 1);
INSERT INTO `provinces`
VALUES (710536, '归仁区', 710500, '归仁', 3, '06', '711', '中国,台湾,台南市,归仁区', '120.293791', '22.967081', 'Guiren', 1);
INSERT INTO `provinces`
VALUES (710537, '关庙区', 710500, '关庙', 3, '06', '718', '中国,台湾,台南市,关庙区', '120.327689', '22.962949', 'Guanmiao', 1);
INSERT INTO `provinces`
VALUES (710538, '龙崎区', 710500, '龙崎', 3, '06', '719', '中国,台湾,台南市,龙崎区', '120.360824', '22.965681', 'Longqi', 1);
INSERT INTO `provinces`
VALUES (710539, '永康区', 710500, '永康', 3, '06', '710', '中国,台湾,台南市,永康区', '120.257069', '23.026061', 'Yongkang', 1);
INSERT INTO `provinces`
VALUES (710600, '新竹市', 710000, '新竹', 2, '03', '3', '中国,台湾,新竹市', '120.968798', '24.806738', 'Hsinchu', 1);
INSERT INTO `provinces`
VALUES (710601, '东区', 710600, '东区', 3, '03', '300', '中国,台湾,新竹市,东区', '120.970239', '24.801337', 'Dongqu', 1);
INSERT INTO `provinces`
VALUES (710602, '北区', 710600, '北区', 3, '03', '', '中国,台湾,新竹市,北区', '120.682410', '24.166040', 'Beiqu', 1);
INSERT INTO `provinces`
VALUES (710603, '香山区', 710600, '香山', 3, '03', '', '中国,台湾,新竹市,香山区', '120.956679', '24.768933', 'Xiangshan', 1);
INSERT INTO `provinces`
VALUES (710700, '嘉义市', 710000, '嘉义', 2, '05', '6', '中国,台湾,嘉义市', '120.452538', '23.481568', 'Chiayi', 1);
INSERT INTO `provinces`
VALUES (710701, '东区', 710700, '东区', 3, '05', '600', '中国,台湾,嘉义市,东区', '120.458009', '23.486213', 'Dongqu', 1);
INSERT INTO `provinces`
VALUES (710702, '西区', 710700, '西区', 3, '05', '600', '中国,台湾,嘉义市,西区', '120.437493', '23.473029', 'Xiqu', 1);
INSERT INTO `provinces`
VALUES (710800, '新北市', 710000, '新北', 2, '02', '2', '中国,台湾,新北市', '121.465746', '25.012366', 'New Taipei', 1);
INSERT INTO `provinces`
VALUES (710801, '板桥区', 710800, '板桥', 3, '02', '220', '中国,台湾,新北市,板桥区', '121.459084', '25.009578', 'Banqiao', 1);
INSERT INTO `provinces`
VALUES (710802, '三重区', 710800, '三重', 3, '02', '241', '中国,台湾,新北市,三重区', '121.488102', '25.061486', 'Sanzhong', 1);
INSERT INTO `provinces`
VALUES (710803, '中和区', 710800, '中和', 3, '02', '235', '中国,台湾,新北市,中和区', '121.498980', '24.999397', 'Zhonghe', 1);
INSERT INTO `provinces`
VALUES (710804, '永和区', 710800, '永和', 3, '02', '234', '中国,台湾,新北市,永和区', '121.513660', '25.007802', 'Yonghe', 1);
INSERT INTO `provinces`
VALUES (710805, '新庄区', 710800, '新庄', 3, '02', '242', '中国,台湾,新北市,新庄区', '121.450413', '25.035947', 'Xinzhuang', 1);
INSERT INTO `provinces`
VALUES (710806, '新店区', 710800, '新店', 3, '02', '231', '中国,台湾,新北市,新店区', '121.541750', '24.967558', 'Xindian', 1);
INSERT INTO `provinces`
VALUES (710807, '树林区', 710800, '树林', 3, '02', '238', '中国,台湾,新北市,树林区', '121.420533', '24.990706', 'Shulin', 1);
INSERT INTO `provinces`
VALUES (710808, '莺歌区', 710800, '莺歌', 3, '02', '239', '中国,台湾,新北市,莺歌区', '121.354573', '24.955413', 'Yingge', 1);
INSERT INTO `provinces`
VALUES (710809, '三峡区', 710800, '三峡', 3, '02', '237', '中国,台湾,新北市,三峡区', '121.368905', '24.934339', 'Sanxia', 1);
INSERT INTO `provinces`
VALUES (710810, '淡水区', 710800, '淡水', 3, '02', '251', '中国,台湾,新北市,淡水区', '121.440915', '25.169452', 'Danshui', 1);
INSERT INTO `provinces`
VALUES (710811, '汐止区', 710800, '汐止', 3, '02', '221', '中国,台湾,新北市,汐止区', '121.629470', '25.062999', 'Xizhi', 1);
INSERT INTO `provinces`
VALUES (710812, '瑞芳区', 710800, '瑞芳', 3, '02', '224', '中国,台湾,新北市,瑞芳区', '121.810061', '25.108895', 'Ruifang', 1);
INSERT INTO `provinces`
VALUES (710813, '土城区', 710800, '土城', 3, '02', '236', '中国,台湾,新北市,土城区', '121.443348', '24.972201', 'Tucheng', 1);
INSERT INTO `provinces`
VALUES (710814, '芦洲区', 710800, '芦洲', 3, '02', '247', '中国,台湾,新北市,芦洲区', '121.473700', '25.084923', 'Luzhou', 1);
INSERT INTO `provinces`
VALUES (710815, '五股区', 710800, '五股', 3, '02', '248', '中国,台湾,新北市,五股区', '121.438156', '25.082743', 'Wugu', 1);
INSERT INTO `provinces`
VALUES (710816, '泰山区', 710800, '泰山', 3, '02', '243', '中国,台湾,新北市,泰山区', '121.430811', '25.058864', 'Taishan', 1);
INSERT INTO `provinces`
VALUES (710817, '林口区', 710800, '林口', 3, '02', '244', '中国,台湾,新北市,林口区', '121.391602', '25.077531', 'Linkou', 1);
INSERT INTO `provinces`
VALUES (710818, '深坑区', 710800, '深坑', 3, '02', '222', '中国,台湾,新北市,深坑区', '121.615670', '25.002329', 'Shenkeng', 1);
INSERT INTO `provinces`
VALUES (710819, '石碇区', 710800, '石碇', 3, '02', '223', '中国,台湾,新北市,石碇区', '121.658567', '24.991679', 'Shiding', 1);
INSERT INTO `provinces`
VALUES (710820, '坪林区', 710800, '坪林', 3, '02', '232', '中国,台湾,新北市,坪林区', '121.711185', '24.937388', 'Pinglin', 1);
INSERT INTO `provinces`
VALUES (710821, '三芝区', 710800, '三芝', 3, '02', '252', '中国,台湾,新北市,三芝区', '121.500866', '25.258047', 'Sanzhi', 1);
INSERT INTO `provinces`
VALUES (710822, '石门区', 710800, '石门', 3, '02', '253', '中国,台湾,新北市,石门区', '121.568491', '25.290412', 'Shimen', 1);
INSERT INTO `provinces`
VALUES (710823, '八里区', 710800, '八里', 3, '02', '249', '中国,台湾,新北市,八里区', '121.398227', '25.146680', 'Bali', 1);
INSERT INTO `provinces`
VALUES (710824, '平溪区', 710800, '平溪', 3, '02', '226', '中国,台湾,新北市,平溪区', '121.738255', '25.025725', 'Pingxi', 1);
INSERT INTO `provinces`
VALUES (710825, '双溪区', 710800, '双溪', 3, '02', '227', '中国,台湾,新北市,双溪区', '121.865676', '25.033409', 'Shuangxi', 1);
INSERT INTO `provinces`
VALUES (710826, '贡寮区', 710800, '贡寮', 3, '02', '228', '中国,台湾,新北市,贡寮区', '121.908185', '25.022388', 'Gongliao', 1);
INSERT INTO `provinces`
VALUES (710827, '金山区', 710800, '金山', 3, '02', '208', '中国,台湾,新北市,金山区', '121.636427', '25.221883', 'Jinshan', 1);
INSERT INTO `provinces`
VALUES (710828, '万里区', 710800, '万里', 3, '02', '207', '中国,台湾,新北市,万里区', '121.688687', '25.181234', 'Wanli', 1);
INSERT INTO `provinces`
VALUES (710829, '乌来区', 710800, '乌来', 3, '02', '233', '中国,台湾,新北市,乌来区', '121.550531', '24.865296', 'Wulai', 1);
INSERT INTO `provinces`
VALUES (712126, '壮围乡', 712200, '壮围', 3, '03', '263', '中国,台湾,宜兰县,壮围乡', '121.781619', '24.744949', 'Zhuangwei', 1);
INSERT INTO `provinces`
VALUES (712200, '宜兰县', 710000, '宜兰', 2, '03', '2', '中国,台湾,宜兰县', '121.500000', '24.600000', 'Yilan', 1);
INSERT INTO `provinces`
VALUES (712201, '宜兰市', 712200, '宜兰', 3, '03', '260', '中国,台湾,宜兰县,宜兰市', '121.753476', '24.751682', 'Yilan', 1);
INSERT INTO `provinces`
VALUES (712221, '罗东镇', 712200, '罗东', 3, '03', '265', '中国,台湾,宜兰县,罗东镇', '121.766919', '24.677033', 'Luodong', 1);
INSERT INTO `provinces`
VALUES (712222, '苏澳镇', 712200, '苏澳', 3, '03', '270', '中国,台湾,宜兰县,苏澳镇', '121.842656', '24.594622', 'Suao', 1);
INSERT INTO `provinces`
VALUES (712223, '头城镇', 712200, '头城', 3, '03', '261', '中国,台湾,宜兰县,头城镇', '121.823307', '24.859217', 'Toucheng', 1);
INSERT INTO `provinces`
VALUES (712224, '礁溪乡', 712200, '礁溪', 3, '03', '262', '中国,台湾,宜兰县,礁溪乡', '121.766680', '24.822345', 'Jiaoxi', 1);
INSERT INTO `provinces`
VALUES (712226, '员山乡', 712200, '员山', 3, '03', '264', '中国,台湾,宜兰县,员山乡', '121.721733', '24.741771', 'Yuanshan', 1);
INSERT INTO `provinces`
VALUES (712227, '冬山乡', 712200, '冬山', 3, '03', '269', '中国,台湾,宜兰县,冬山乡', '121.792280', '24.634514', 'Dongshan', 1);
INSERT INTO `provinces`
VALUES (712228, '五结乡', 712200, '五结', 3, '03', '268', '中国,台湾,宜兰县,五结乡', '121.798297', '24.684640', 'Wujie', 1);
INSERT INTO `provinces`
VALUES (712229, '三星乡', 712200, '三星', 3, '03', '266', '中国,台湾,宜兰县,三星乡', '121.003418', '23.775291', 'Sanxing', 1);
INSERT INTO `provinces`
VALUES (712230, '大同乡', 712200, '大同', 3, '03', '267', '中国,台湾,宜兰县,大同乡', '121.605557', '24.675997', 'Datong', 1);
INSERT INTO `provinces`
VALUES (712231, '南澳乡', 712200, '南澳', 3, '03', '272', '中国,台湾,宜兰县,南澳乡', '121.799810', '24.465393', 'Nanao', 1);
INSERT INTO `provinces`
VALUES (712300, '桃园县', 710000, '桃园', 2, '03', '3', '中国,台湾,桃园县', '121.083000', '25.000000', 'Taoyuan', 1);
INSERT INTO `provinces`
VALUES (712301, '桃园市', 712300, '桃园', 3, '03', '330', '中国,台湾,桃园县,桃园市', '121.301337', '24.993777', 'Taoyuan', 1);
INSERT INTO `provinces`
VALUES (712302, '中坜市', 712300, '中坜', 3, '03', '320', '中国,台湾,桃园县,中坜市', '121.224926', '24.965353', 'Zhongli', 1);
INSERT INTO `provinces`
VALUES (712303, '平镇市', 712300, '平镇', 3, '03', '324', '中国,台湾,桃园县,平镇市', '121.218359', '24.945752', 'Pingzhen', 1);
INSERT INTO `provinces`
VALUES (712304, '八德市', 712300, '八德', 3, '03', '334', '中国,台湾,桃园县,八德市', '121.284655', '24.928651', 'Bade', 1);
INSERT INTO `provinces`
VALUES (712305, '杨梅市', 712300, '杨梅', 3, '03', '326', '中国,台湾,桃园县,杨梅市', '121.145873', '24.907575', 'Yangmei', 1);
INSERT INTO `provinces`
VALUES (712306, '芦竹市', 712300, '芦竹', 3, '03', '338', '中国,台湾,桃园县,芦竹市', '121.292064', '25.045392', 'Luzhu', 1);
INSERT INTO `provinces`
VALUES (712321, '大溪镇', 712300, '大溪', 3, '03', '335', '中国,台湾,桃园县,大溪镇', '121.286962', '24.880584', 'Daxi', 1);
INSERT INTO `provinces`
VALUES (712324, '大园乡', 712300, '大园', 3, '03', '337', '中国,台湾,桃园县,大园乡', '121.196292', '25.064471', 'Dayuan', 1);
INSERT INTO `provinces`
VALUES (712325, '龟山乡', 712300, '龟山', 3, '03', '333', '中国,台湾,桃园县,龟山乡', '121.337767', '24.992517', 'Guishan', 1);
INSERT INTO `provinces`
VALUES (712327, '龙潭乡', 712300, '龙潭', 3, '03', '325', '中国,台湾,桃园县,龙潭乡', '121.216392', '24.863851', 'Longtan', 1);
INSERT INTO `provinces`
VALUES (712329, '新屋乡', 712300, '新屋', 3, '03', '327', '中国,台湾,桃园县,新屋乡', '121.105801', '24.972203', 'Xinwu', 1);
INSERT INTO `provinces`
VALUES (712330, '观音乡', 712300, '观音', 3, '03', '328', '中国,台湾,桃园县,观音乡', '121.077519', '25.033303', 'Guanyin', 1);
INSERT INTO `provinces`
VALUES (712331, '复兴乡', 712300, '复兴', 3, '03', '336', '中国,台湾,桃园县,复兴乡', '121.352613', '24.820908', 'Fuxing', 1);
INSERT INTO `provinces`
VALUES (712400, '新竹县', 710000, '新竹', 2, '03', '3', '中国,台湾,新竹县', '121.160000', '24.600000', 'Hsinchu', 1);
INSERT INTO `provinces`
VALUES (712401, '竹北市', 712400, '竹北', 3, '03', '302', '中国,台湾,新竹县,竹北市', '121.004317', '24.839652', 'Zhubei', 1);
INSERT INTO `provinces`
VALUES (712421, '竹东镇', 712400, '竹东', 3, '03', '310', '中国,台湾,新竹县,竹东镇', '121.086418', '24.733601', 'Zhudong', 1);
INSERT INTO `provinces`
VALUES (712422, '新埔镇', 712400, '新埔', 3, '03', '305', '中国,台湾,新竹县,新埔镇', '121.072804', '24.824820', 'Xinpu', 1);
INSERT INTO `provinces`
VALUES (712423, '关西镇', 712400, '关西', 3, '03', '306', '中国,台湾,新竹县,关西镇', '121.177301', '24.788842', 'Guanxi', 1);
INSERT INTO `provinces`
VALUES (712424, '湖口乡', 712400, '湖口', 3, '03', '303', '中国,台湾,新竹县,湖口乡', '121.043691', '24.903943', 'Hukou', 1);
INSERT INTO `provinces`
VALUES (712425, '新丰乡', 712400, '新丰', 3, '03', '304', '中国,台湾,新竹县,新丰乡', '120.983006', '24.899600', 'Xinfeng', 1);
INSERT INTO `provinces`
VALUES (712426, '芎林乡', 712400, '芎林', 3, '03', '307', '中国,台湾,新竹县,芎林乡', '121.076924', '24.774436', 'Xionglin', 1);
INSERT INTO `provinces`
VALUES (712427, '横山乡', 712400, '横山', 3, '03', '312', '中国,台湾,新竹县,横山乡', '121.116244', '24.720807', 'Hengshan', 1);
INSERT INTO `provinces`
VALUES (712428, '北埔乡', 712400, '北埔', 3, '03', '314', '中国,台湾,新竹县,北埔乡', '121.053156', '24.697126', 'Beipu', 1);
INSERT INTO `provinces`
VALUES (712429, '宝山乡', 712400, '宝山', 3, '03', '308', '中国,台湾,新竹县,宝山乡', '120.985752', '24.760975', 'Baoshan', 1);
INSERT INTO `provinces`
VALUES (712430, '峨眉乡', 712400, '峨眉', 3, '03', '315', '中国,台湾,新竹县,峨眉乡', '121.015291', '24.686127', 'Emei', 1);
INSERT INTO `provinces`
VALUES (712431, '尖石乡', 712400, '尖石', 3, '03', '313', '中国,台湾,新竹县,尖石乡', '121.197802', '24.704360', 'Jianshi', 1);
INSERT INTO `provinces`
VALUES (712432, '五峰乡', 712400, '五峰', 3, '03', '311', '中国,台湾,新竹县,五峰乡', '121.003418', '23.775291', 'Wufeng', 1);
INSERT INTO `provinces`
VALUES (712500, '苗栗县', 710000, '苗栗', 2, '037', '3', '中国,台湾,苗栗县', '120.750000', '24.500000', 'Miaoli', 1);
INSERT INTO `provinces`
VALUES (712501, '苗栗市', 712500, '苗栗', 3, '037', '360', '中国,台湾,苗栗县,苗栗市', '120.818869', '24.561472', 'Miaoli', 1);
INSERT INTO `provinces`
VALUES (712521, '苑里镇', 712500, '苑里', 3, '037', '358', '中国,台湾,苗栗县,苑里镇', '120.648907', '24.441750', 'Yuanli', 1);
INSERT INTO `provinces`
VALUES (712522, '通霄镇', 712500, '通霄', 3, '037', '357', '中国,台湾,苗栗县,通霄镇', '120.676700', '24.489087', 'Tongxiao', 1);
INSERT INTO `provinces`
VALUES (712523, '竹南镇', 712500, '竹南', 3, '037', '350', '中国,台湾,苗栗县,竹南镇', '120.872641', '24.685513', 'Zhunan', 1);
INSERT INTO `provinces`
VALUES (712524, '头份镇', 712500, '头份', 3, '037', '351', '中国,台湾,苗栗县,头份镇', '120.895188', '24.687993', 'Toufen', 1);
INSERT INTO `provinces`
VALUES (712525, '后龙镇', 712500, '后龙', 3, '037', '356', '中国,台湾,苗栗县,后龙镇', '120.786480', '24.612617', 'Houlong', 1);
INSERT INTO `provinces`
VALUES (712526, '卓兰镇', 712500, '卓兰', 3, '037', '369', '中国,台湾,苗栗县,卓兰镇', '120.823441', '24.309509', 'Zhuolan', 1);
INSERT INTO `provinces`
VALUES (712527, '大湖乡', 712500, '大湖', 3, '037', '364', '中国,台湾,苗栗县,大湖乡', '120.863641', '24.412647', 'Dahu', 1);
INSERT INTO `provinces`
VALUES (712528, '公馆乡', 712500, '公馆', 3, '037', '363', '中国,台湾,苗栗县,公馆乡', '120.822983', '24.499108', 'Gongguan', 1);
INSERT INTO `provinces`
VALUES (712529, '铜锣乡', 712500, '铜锣', 3, '037', '366', '中国,台湾,苗栗县,铜锣乡', '121.003418', '23.775291', 'Tongluo', 1);
INSERT INTO `provinces`
VALUES (712530, '南庄乡', 712500, '南庄', 3, '037', '353', '中国,台湾,苗栗县,南庄乡', '120.994957', '24.596835', 'Nanzhuang', 1);
INSERT INTO `provinces`
VALUES (712531, '头屋乡', 712500, '头屋', 3, '037', '362', '中国,台湾,苗栗县,头屋乡', '120.846616', '24.574249', 'Touwu', 1);
INSERT INTO `provinces`
VALUES (712532, '三义乡', 712500, '三义', 3, '037', '367', '中国,台湾,苗栗县,三义乡', '120.742340', '24.350270', 'Sanyi', 1);
INSERT INTO `provinces`
VALUES (712533, '西湖乡', 712500, '西湖', 3, '037', '368', '中国,台湾,苗栗县,西湖乡', '121.003418', '23.775291', 'Xihu', 1);
INSERT INTO `provinces`
VALUES (712534, '造桥乡', 712500, '造桥', 3, '037', '361', '中国,台湾,苗栗县,造桥乡', '120.862399', '24.637537', 'Zaoqiao', 1);
INSERT INTO `provinces`
VALUES (712535, '三湾乡', 712500, '三湾', 3, '037', '352', '中国,台湾,苗栗县,三湾乡', '120.951484', '24.651051', 'Sanwan', 1);
INSERT INTO `provinces`
VALUES (712536, '狮潭乡', 712500, '狮潭', 3, '037', '354', '中国,台湾,苗栗县,狮潭乡', '120.918024', '24.540004', 'Shitan', 1);
INSERT INTO `provinces`
VALUES (712537, '泰安乡', 712500, '泰安', 3, '037', '365', '中国,台湾,苗栗县,泰安乡', '120.904441', '24.442600', 'Tai\'an', 1);
INSERT INTO `provinces`
VALUES (712700, '彰化县', 710000, '彰化', 2, '04', '5', '中国,台湾,彰化县', '120.416000', '24.000000', 'Changhua', 1);
INSERT INTO `provinces`
VALUES (712701, '彰化市', 712700, '彰化市', 3, '04', '500', '中国,台湾,彰化县,彰化市', '120.542294', '24.080911', 'Zhanghuashi', 1);
INSERT INTO `provinces`
VALUES (712721, '鹿港镇', 712700, '鹿港', 3, '04', '505', '中国,台湾,彰化县,鹿港镇', '120.435392', '24.056937', 'Lugang', 1);
INSERT INTO `provinces`
VALUES (712722, '和美镇', 712700, '和美', 3, '04', '508', '中国,台湾,彰化县,和美镇', '120.500265', '24.110904', 'Hemei', 1);
INSERT INTO `provinces`
VALUES (712723, '线西乡', 712700, '线西', 3, '04', '507', '中国,台湾,彰化县,线西乡', '120.465921', '24.128653', 'Xianxi', 1);
INSERT INTO `provinces`
VALUES (712724, '伸港乡', 712700, '伸港', 3, '04', '509', '中国,台湾,彰化县,伸港乡', '120.484224', '24.146081', 'Shengang', 1);
INSERT INTO `provinces`
VALUES (712725, '福兴乡', 712700, '福兴', 3, '04', '506', '中国,台湾,彰化县,福兴乡', '120.443682', '24.047883', 'Fuxing', 1);
INSERT INTO `provinces`
VALUES (712726, '秀水乡', 712700, '秀水', 3, '04', '504', '中国,台湾,彰化县,秀水乡', '120.502658', '24.035267', 'Xiushui', 1);
INSERT INTO `provinces`
VALUES (712727, '花坛乡', 712700, '花坛', 3, '04', '503', '中国,台湾,彰化县,花坛乡', '120.538403', '24.029399', 'Huatan', 1);
INSERT INTO `provinces`
VALUES (712728, '芬园乡', 712700, '芬园', 3, '04', '502', '中国,台湾,彰化县,芬园乡', '120.629024', '24.013658', 'Fenyuan', 1);
INSERT INTO `provinces`
VALUES (712729, '员林镇', 712700, '员林', 3, '04', '510', '中国,台湾,彰化县,员林镇', '120.574625', '23.958999', 'Yuanlin', 1);
INSERT INTO `provinces`
VALUES (712730, '溪湖镇', 712700, '溪湖', 3, '04', '514', '中国,台湾,彰化县,溪湖镇', '120.479144', '23.962315', 'Xihu', 1);
INSERT INTO `provinces`
VALUES (712731, '田中镇', 712700, '田中', 3, '04', '520', '中国,台湾,彰化县,田中镇', '120.580629', '23.861718', 'Tianzhong', 1);
INSERT INTO `provinces`
VALUES (712732, '大村乡', 712700, '大村', 3, '04', '515', '中国,台湾,彰化县,大村乡', '120.540713', '23.993726', 'Dacun', 1);
INSERT INTO `provinces`
VALUES (712733, '埔盐乡', 712700, '埔盐', 3, '04', '516', '中国,台湾,彰化县,埔盐乡', '120.464044', '24.000346', 'Puyan', 1);
INSERT INTO `provinces`
VALUES (712734, '埔心乡', 712700, '埔心', 3, '04', '513', '中国,台湾,彰化县,埔心乡', '120.543568', '23.953019', 'Puxin', 1);
INSERT INTO `provinces`
VALUES (712735, '永靖乡', 712700, '永靖', 3, '04', '512', '中国,台湾,彰化县,永靖乡', '120.547775', '23.924703', 'Yongjing', 1);
INSERT INTO `provinces`
VALUES (712736, '社头乡', 712700, '社头', 3, '04', '511', '中国,台湾,彰化县,社头乡', '120.582681', '23.896686', 'Shetou', 1);
INSERT INTO `provinces`
VALUES (712737, '二水乡', 712700, '二水', 3, '04', '530', '中国,台湾,彰化县,二水乡', '120.618788', '23.806995', 'Ershui', 1);
INSERT INTO `provinces`
VALUES (712738, '北斗镇', 712700, '北斗', 3, '04', '521', '中国,台湾,彰化县,北斗镇', '120.520449', '23.870911', 'Beidou', 1);
INSERT INTO `provinces`
VALUES (712739, '二林镇', 712700, '二林', 3, '04', '526', '中国,台湾,彰化县,二林镇', '120.374468', '23.899751', 'Erlin', 1);
INSERT INTO `provinces`
VALUES (712740, '田尾乡', 712700, '田尾', 3, '04', '522', '中国,台湾,彰化县,田尾乡', '120.524717', '23.890735', 'Tianwei', 1);
INSERT INTO `provinces`
VALUES (712741, '埤头乡', 712700, '埤头', 3, '04', '523', '中国,台湾,彰化县,埤头乡', '120.462599', '23.891324', 'Pitou', 1);
INSERT INTO `provinces`
VALUES (712742, '芳苑乡', 712700, '芳苑', 3, '04', '528', '中国,台湾,彰化县,芳苑乡', '120.320329', '23.924222', 'Fangyuan', 1);
INSERT INTO `provinces`
VALUES (712743, '大城乡', 712700, '大城', 3, '04', '527', '中国,台湾,彰化县,大城乡', '120.320934', '23.852382', 'Dacheng', 1);
INSERT INTO `provinces`
VALUES (712744, '竹塘乡', 712700, '竹塘', 3, '04', '525', '中国,台湾,彰化县,竹塘乡', '120.427499', '23.860112', 'Zhutang', 1);
INSERT INTO `provinces`
VALUES (712745, '溪州乡', 712700, '溪州', 3, '04', '524', '中国,台湾,彰化县,溪州乡', '120.498706', '23.851229', 'Xizhou', 1);
INSERT INTO `provinces`
VALUES (712800, '南投县', 710000, '南投', 2, '049', '5', '中国,台湾,南投县', '120.830000', '23.830000', 'Nantou', 1);
INSERT INTO `provinces`
VALUES (712801, '南投市', 712800, '南投市', 3, '049', '540', '中国,台湾,南投县,南投市', '120.683706', '23.909956', 'Nantoushi', 1);
INSERT INTO `provinces`
VALUES (712821, '埔里镇', 712800, '埔里', 3, '049', '545', '中国,台湾,南投县,埔里镇', '120.964648', '23.964789', 'Puli', 1);
INSERT INTO `provinces`
VALUES (712822, '草屯镇', 712800, '草屯', 3, '049', '542', '中国,台湾,南投县,草屯镇', '120.680343', '23.973947', 'Caotun', 1);
INSERT INTO `provinces`
VALUES (712823, '竹山镇', 712800, '竹山', 3, '049', '557', '中国,台湾,南投县,竹山镇', '120.672007', '23.757655', 'Zhushan', 1);
INSERT INTO `provinces`
VALUES (712824, '集集镇', 712800, '集集', 3, '049', '552', '中国,台湾,南投县,集集镇', '120.783673', '23.829013', 'Jiji', 1);
INSERT INTO `provinces`
VALUES (712825, '名间乡', 712800, '名间', 3, '049', '551', '中国,台湾,南投县,名间乡', '120.702797', '23.838427', 'Mingjian', 1);
INSERT INTO `provinces`
VALUES (712826, '鹿谷乡', 712800, '鹿谷', 3, '049', '558', '中国,台湾,南投县,鹿谷乡', '120.752796', '23.744471', 'Lugu', 1);
INSERT INTO `provinces`
VALUES (712827, '中寮乡', 712800, '中寮', 3, '049', '541', '中国,台湾,南投县,中寮乡', '120.766654', '23.878935', 'Zhongliao', 1);
INSERT INTO `provinces`
VALUES (712828, '鱼池乡', 712800, '鱼池', 3, '049', '555', '中国,台湾,南投县,鱼池乡', '120.936060', '23.896356', 'Yuchi', 1);
INSERT INTO `provinces`
VALUES (712829, '国姓乡', 712800, '国姓', 3, '049', '544', '中国,台湾,南投县,国姓乡', '120.858541', '24.042298', 'Guoxing', 1);
INSERT INTO `provinces`
VALUES (712830, '水里乡', 712800, '水里', 3, '049', '553', '中国,台湾,南投县,水里乡', '120.855912', '23.812086', 'Shuili', 1);
INSERT INTO `provinces`
VALUES (712831, '信义乡', 712800, '信义', 3, '049', '556', '中国,台湾,南投县,信义乡', '120.855257', '23.699922', 'Xinyi', 1);
INSERT INTO `provinces`
VALUES (712832, '仁爱乡', 712800, '仁爱', 3, '049', '546', '中国,台湾,南投县,仁爱乡', '121.133543', '24.024429', 'Renai', 1);
INSERT INTO `provinces`
VALUES (712900, '云林县', 710000, '云林', 2, '05', '6', '中国,台湾,云林县', '120.250000', '23.750000', 'Yunlin', 1);
INSERT INTO `provinces`
VALUES (712901, '斗六市', 712900, '斗六', 3, '05', '640', '中国,台湾,云林县,斗六市', '120.527360', '23.697651', 'Douliu', 1);
INSERT INTO `provinces`
VALUES (712921, '斗南镇', 712900, '斗南', 3, '05', '630', '中国,台湾,云林县,斗南镇', '120.479075', '23.679731', 'Dounan', 1);
INSERT INTO `provinces`
VALUES (712922, '虎尾镇', 712900, '虎尾', 3, '05', '632', '中国,台湾,云林县,虎尾镇', '120.445339', '23.708182', 'Huwei', 1);
INSERT INTO `provinces`
VALUES (712923, '西螺镇', 712900, '西螺', 3, '05', '648', '中国,台湾,云林县,西螺镇', '120.466010', '23.797984', 'Xiluo', 1);
INSERT INTO `provinces`
VALUES (712924, '土库镇', 712900, '土库', 3, '05', '633', '中国,台湾,云林县,土库镇', '120.392572', '23.677822', 'Tuku', 1);
INSERT INTO `provinces`
VALUES (712925, '北港镇', 712900, '北港', 3, '05', '651', '中国,台湾,云林县,北港镇', '120.302393', '23.575525', 'Beigang', 1);
INSERT INTO `provinces`
VALUES (712926, '古坑乡', 712900, '古坑', 3, '05', '646', '中国,台湾,云林县,古坑乡', '120.562043', '23.642568', 'Gukeng', 1);
INSERT INTO `provinces`
VALUES (712927, '大埤乡', 712900, '大埤', 3, '05', '631', '中国,台湾,云林县,大埤乡', '120.430516', '23.645908', 'Dapi', 1);
INSERT INTO `provinces`
VALUES (712928, '莿桐乡', 712900, '莿桐', 3, '05', '647', '中国,台湾,云林县,莿桐乡', '120.502374', '23.760784', 'Citong', 1);
INSERT INTO `provinces`
VALUES (712929, '林内乡', 712900, '林内', 3, '05', '643', '中国,台湾,云林县,林内乡', '120.611365', '23.758712', 'Linna', 1);
INSERT INTO `provinces`
VALUES (712930, '二仑乡', 712900, '二仑', 3, '05', '649', '中国,台湾,云林县,二仑乡', '120.415077', '23.771273', 'Erlun', 1);
INSERT INTO `provinces`
VALUES (712931, '仑背乡', 712900, '仑背', 3, '05', '637', '中国,台湾,云林县,仑背乡', '120.353895', '23.758840', 'Lunbei', 1);
INSERT INTO `provinces`
VALUES (712932, '麦寮乡', 712900, '麦寮', 3, '05', '638', '中国,台湾,云林县,麦寮乡', '120.252043', '23.753841', 'Mailiao', 1);
INSERT INTO `provinces`
VALUES (712933, '东势乡', 712900, '东势', 3, '05', '635', '中国,台湾,云林县,东势乡', '120.252672', '23.674679', 'Dongshi', 1);
INSERT INTO `provinces`
VALUES (712934, '褒忠乡', 712900, '褒忠', 3, '05', '634', '中国,台湾,云林县,褒忠乡', '120.310488', '23.694245', 'Baozhong', 1);
INSERT INTO `provinces`
VALUES (712935, '台西乡', 712900, '台西', 3, '05', '636', '中国,台湾,云林县,台西乡', '120.196141', '23.702819', 'Taixi', 1);
INSERT INTO `provinces`
VALUES (712936, '元长乡', 712900, '元长', 3, '05', '655', '中国,台湾,云林县,元长乡', '120.315124', '23.649458', 'Yuanchang', 1);
INSERT INTO `provinces`
VALUES (712937, '四湖乡', 712900, '四湖', 3, '05', '654', '中国,台湾,云林县,四湖乡', '120.126741', '23.637740', 'Sihu', 1);
INSERT INTO `provinces`
VALUES (712938, '口湖乡', 712900, '口湖', 3, '05', '653', '中国,台湾,云林县,口湖乡', '120.185370', '23.582406', 'Kouhu', 1);
INSERT INTO `provinces`
VALUES (712939, '水林乡', 712900, '水林', 3, '05', '652', '中国,台湾,云林县,水林乡', '120.245948', '23.572634', 'Shuilin', 1);
INSERT INTO `provinces`
VALUES (713000, '嘉义县', 710000, '嘉义', 2, '05', '6', '中国,台湾,嘉义县', '120.300000', '23.500000', 'Chiayi', 1);
INSERT INTO `provinces`
VALUES (713001, '太保市', 713000, '太保', 3, '05', '612', '中国,台湾,嘉义县,太保市', '120.332876', '23.459647', 'Taibao', 1);
INSERT INTO `provinces`
VALUES (713002, '朴子市', 713000, '朴子', 3, '05', '613', '中国,台湾,嘉义县,朴子市', '120.247014', '23.464961', 'Puzi', 1);
INSERT INTO `provinces`
VALUES (713023, '布袋镇', 713000, '布袋', 3, '05', '625', '中国,台湾,嘉义县,布袋镇', '120.166936', '23.377979', 'Budai', 1);
INSERT INTO `provinces`
VALUES (713024, '大林镇', 713000, '大林', 3, '05', '622', '中国,台湾,嘉义县,大林镇', '120.471336', '23.603815', 'Dalin', 1);
INSERT INTO `provinces`
VALUES (713025, '民雄乡', 713000, '民雄', 3, '05', '621', '中国,台湾,嘉义县,民雄乡', '120.428577', '23.551456', 'Minxiong', 1);
INSERT INTO `provinces`
VALUES (713026, '溪口乡', 713000, '溪口', 3, '05', '623', '中国,台湾,嘉义县,溪口乡', '120.393822', '23.602223', 'Xikou', 1);
INSERT INTO `provinces`
VALUES (713027, '新港乡', 713000, '新港', 3, '05', '616', '中国,台湾,嘉义县,新港乡', '120.347647', '23.551806', 'Xingang', 1);
INSERT INTO `provinces`
VALUES (713028, '六脚乡', 713000, '六脚', 3, '05', '615', '中国,台湾,嘉义县,六脚乡', '120.291083', '23.493942', 'Liujiao', 1);
INSERT INTO `provinces`
VALUES (713029, '东石乡', 713000, '东石', 3, '05', '614', '中国,台湾,嘉义县,东石乡', '120.153822', '23.459235', 'Dongshi', 1);
INSERT INTO `provinces`
VALUES (713030, '义竹乡', 713000, '义竹', 3, '05', '624', '中国,台湾,嘉义县,义竹乡', '120.243423', '23.336277', 'Yizhu', 1);
INSERT INTO `provinces`
VALUES (713031, '鹿草乡', 713000, '鹿草', 3, '05', '611', '中国,台湾,嘉义县,鹿草乡', '120.308370', '23.410784', 'Lucao', 1);
INSERT INTO `provinces`
VALUES (713032, '水上乡', 713000, '水上', 3, '05', '608', '中国,台湾,嘉义县,水上乡', '120.397936', '23.428104', 'Shuishang', 1);
INSERT INTO `provinces`
VALUES (713033, '中埔乡', 713000, '中埔', 3, '05', '606', '中国,台湾,嘉义县,中埔乡', '120.522948', '23.425148', 'Zhongpu', 1);
INSERT INTO `provinces`
VALUES (713034, '竹崎乡', 713000, '竹崎', 3, '05', '604', '中国,台湾,嘉义县,竹崎乡', '120.551466', '23.523184', 'Zhuqi', 1);
INSERT INTO `provinces`
VALUES (713035, '梅山乡', 713000, '梅山', 3, '05', '603', '中国,台湾,嘉义县,梅山乡', '120.557192', '23.584915', 'Meishan', 1);
INSERT INTO `provinces`
VALUES (713036, '番路乡', 713000, '番路', 3, '05', '602', '中国,台湾,嘉义县,番路乡', '120.555043', '23.465222', 'Fanlu', 1);
INSERT INTO `provinces`
VALUES (713037, '大埔乡', 713000, '大埔', 3, '05', '607', '中国,台湾,嘉义县,大埔乡', '120.593795', '23.296715', 'Dapu', 1);
INSERT INTO `provinces`
VALUES (713038, '阿里山乡', 713000, '阿里山', 3, '05', '605', '中国,台湾,嘉义县,阿里山乡', '120.732520', '23.467950', 'Alishan', 1);
INSERT INTO `provinces`
VALUES (713300, '屏东县', 710000, '屏东', 2, '08', '9', '中国,台湾,屏东县', '120.487928', '22.682802', 'Pingtung', 1);
INSERT INTO `provinces`
VALUES (713301, '屏东市', 713300, '屏东', 3, '08', '900', '中国,台湾,屏东县,屏东市', '120.488465', '22.669723', 'Pingdong', 1);
INSERT INTO `provinces`
VALUES (713321, '潮州镇', 713300, '潮州', 3, '08', '920', '中国,台湾,屏东县,潮州镇', '120.542854', '22.550536', 'Chaozhou', 1);
INSERT INTO `provinces`
VALUES (713322, '东港镇', 713300, '东港', 3, '08', '928', '中国,台湾,屏东县,东港镇', '120.454489', '22.466626', 'Donggang', 1);
INSERT INTO `provinces`
VALUES (713323, '恒春镇', 713300, '恒春', 3, '08', '946', '中国,台湾,屏东县,恒春镇', '120.745451', '22.002373', 'Hengchun', 1);
INSERT INTO `provinces`
VALUES (713324, '万丹乡', 713300, '万丹', 3, '08', '913', '中国,台湾,屏东县,万丹乡', '120.484533', '22.589839', 'Wandan', 1);
INSERT INTO `provinces`
VALUES (713325, '长治乡', 713300, '长治', 3, '08', '908', '中国,台湾,屏东县,长治乡', '120.527614', '22.677062', 'Changzhi', 1);
INSERT INTO `provinces`
VALUES (713326, '麟洛乡', 713300, '麟洛', 3, '08', '909', '中国,台湾,屏东县,麟洛乡', '120.527283', '22.650604', 'Linluo', 1);
INSERT INTO `provinces`
VALUES (713327, '九如乡', 713300, '九如', 3, '08', '904', '中国,台湾,屏东县,九如乡', '120.490142', '22.739778', 'Jiuru', 1);
INSERT INTO `provinces`
VALUES (713328, '里港乡', 713300, '里港', 3, '08', '905', '中国,台湾,屏东县,里港乡', '120.494490', '22.779220', 'Ligang', 1);
INSERT INTO `provinces`
VALUES (713329, '盐埔乡', 713300, '盐埔', 3, '08', '907', '中国,台湾,屏东县,盐埔乡', '120.572849', '22.754783', 'Yanpu', 1);
INSERT INTO `provinces`
VALUES (713330, '高树乡', 713300, '高树', 3, '08', '906', '中国,台湾,屏东县,高树乡', '120.600214', '22.826789', 'Gaoshu', 1);
INSERT INTO `provinces`
VALUES (713331, '万峦乡', 713300, '万峦', 3, '08', '923', '中国,台湾,屏东县,万峦乡', '120.566477', '22.571965', 'Wanluan', 1);
INSERT INTO `provinces`
VALUES (713332, '内埔乡', 713300, '内埔', 3, '08', '912', '中国,台湾,屏东县,内埔乡', '120.566865', '22.611967', 'Napu', 1);
INSERT INTO `provinces`
VALUES (713333, '竹田乡', 713300, '竹田', 3, '08', '911', '中国,台湾,屏东县,竹田乡', '120.544038', '22.584678', 'Zhutian', 1);
INSERT INTO `provinces`
VALUES (713334, '新埤乡', 713300, '新埤', 3, '08', '925', '中国,台湾,屏东县,新埤乡', '120.549546', '22.469976', 'Xinpi', 1);
INSERT INTO `provinces`
VALUES (713335, '枋寮乡', 713300, '枋寮', 3, '08', '940', '中国,台湾,屏东县,枋寮乡', '120.593438', '22.365560', 'Fangliao', 1);
INSERT INTO `provinces`
VALUES (713336, '新园乡', 713300, '新园', 3, '08', '932', '中国,台湾,屏东县,新园乡', '120.461739', '22.543952', 'Xinyuan', 1);
INSERT INTO `provinces`
VALUES (713337, '崁顶乡', 713300, '崁顶', 3, '08', '924', '中国,台湾,屏东县,崁顶乡', '120.514571', '22.514795', 'Kanding', 1);
INSERT INTO `provinces`
VALUES (713338, '林边乡', 713300, '林边', 3, '08', '927', '中国,台湾,屏东县,林边乡', '120.515091', '22.434015', 'Linbian', 1);
INSERT INTO `provinces`
VALUES (713339, '南州乡', 713300, '南州', 3, '08', '926', '中国,台湾,屏东县,南州乡', '120.509808', '22.490192', 'Nanzhou', 1);
INSERT INTO `provinces`
VALUES (713340, '佳冬乡', 713300, '佳冬', 3, '08', '931', '中国,台湾,屏东县,佳冬乡', '120.551544', '22.417653', 'Jiadong', 1);
INSERT INTO `provinces`
VALUES (713341, '琉球乡', 713300, '琉球', 3, '08', '929', '中国,台湾,屏东县,琉球乡', '120.369020', '22.342366', 'Liuqiu', 1);
INSERT INTO `provinces`
VALUES (713342, '车城乡', 713300, '车城', 3, '08', '944', '中国,台湾,屏东县,车城乡', '120.710979', '22.072077', 'Checheng', 1);
INSERT INTO `provinces`
VALUES (713343, '满州乡', 713300, '满州', 3, '08', '947', '中国,台湾,屏东县,满州乡', '120.838843', '22.020853', 'Manzhou', 1);
INSERT INTO `provinces`
VALUES (713344, '枋山乡', 713300, '枋山', 3, '08', '941', '中国,台湾,屏东县,枋山乡', '120.656356', '22.260338', 'Fangshan', 1);
INSERT INTO `provinces`
VALUES (713345, '三地门乡', 713300, '三地门', 3, '08', '901', '中国,台湾,屏东县,三地门乡', '120.654486', '22.713877', 'Sandimen', 1);
INSERT INTO `provinces`
VALUES (713346, '雾台乡', 713300, '雾台', 3, '08', '902', '中国,台湾,屏东县,雾台乡', '120.732318', '22.744877', 'Wutai', 1);
INSERT INTO `provinces`
VALUES (713347, '玛家乡', 713300, '玛家', 3, '08', '903', '中国,台湾,屏东县,玛家乡', '120.644130', '22.706718', 'Majia', 1);
INSERT INTO `provinces`
VALUES (713348, '泰武乡', 713300, '泰武', 3, '08', '921', '中国,台湾,屏东县,泰武乡', '120.632856', '22.591819', 'Taiwu', 1);
INSERT INTO `provinces`
VALUES (713349, '来义乡', 713300, '来义', 3, '08', '922', '中国,台湾,屏东县,来义乡', '120.633601', '22.525866', 'Laiyi', 1);
INSERT INTO `provinces`
VALUES (713350, '春日乡', 713300, '春日', 3, '08', '942', '中国,台湾,屏东县,春日乡', '120.628793', '22.370672', 'Chunri', 1);
INSERT INTO `provinces`
VALUES (713351, '狮子乡', 713300, '狮子', 3, '08', '943', '中国,台湾,屏东县,狮子乡', '120.704617', '22.201917', 'Shizi', 1);
INSERT INTO `provinces`
VALUES (713352, '牡丹乡', 713300, '牡丹', 3, '08', '945', '中国,台湾,屏东县,牡丹乡', '120.770108', '22.125687', 'Mudan', 1);
INSERT INTO `provinces`
VALUES (713400, '台东县', 710000, '台东', 2, '089', '9', '中国,台湾,台东县', '120.916000', '23.000000', 'Taitung', 1);
INSERT INTO `provinces`
VALUES (713401, '台东市', 713400, '台东', 3, '089', '950', '中国,台湾,台东县,台东市', '121.145654', '22.756045', 'Taidong', 1);
INSERT INTO `provinces`
VALUES (713421, '成功镇', 713400, '成功', 3, '089', '961', '中国,台湾,台东县,成功镇', '121.379571', '23.100223', 'Chenggong', 1);
INSERT INTO `provinces`
VALUES (713422, '关山镇', 713400, '关山', 3, '089', '956', '中国,台湾,台东县,关山镇', '121.163134', '23.047450', 'Guanshan', 1);
INSERT INTO `provinces`
VALUES (713423, '卑南乡', 713400, '卑南', 3, '089', '954', '中国,台湾,台东县,卑南乡', '121.083503', '22.786039', 'Beinan', 1);
INSERT INTO `provinces`
VALUES (713424, '鹿野乡', 713400, '鹿野', 3, '089', '955', '中国,台湾,台东县,鹿野乡', '121.135982', '22.913951', 'Luye', 1);
INSERT INTO `provinces`
VALUES (713425, '池上乡', 713400, '池上', 3, '089', '958', '中国,台湾,台东县,池上乡', '121.215139', '23.122393', 'Chishang', 1);
INSERT INTO `provinces`
VALUES (713426, '东河乡', 713400, '东河', 3, '089', '959', '中国,台湾,台东县,东河乡', '121.300334', '22.969934', 'Donghe', 1);
INSERT INTO `provinces`
VALUES (713427, '长滨乡', 713400, '长滨', 3, '089', '962', '中国,台湾,台东县,长滨乡', '121.451522', '23.315041', 'Changbin', 1);
INSERT INTO `provinces`
VALUES (713428, '太麻里乡', 713400, '太麻里', 3, '089', '963', '中国,台湾,台东县,太麻里乡', '121.007394', '22.615383', 'Taimali', 1);
INSERT INTO `provinces`
VALUES (713429, '大武乡', 713400, '大武', 3, '089', '965', '中国,台湾,台东县,大武乡', '120.889938', '22.339919', 'Dawu', 1);
INSERT INTO `provinces`
VALUES (713430, '绿岛乡', 713400, '绿岛', 3, '089', '951', '中国,台湾,台东县,绿岛乡', '121.492596', '22.661676', 'Lvdao', 1);
INSERT INTO `provinces`
VALUES (713431, '海端乡', 713400, '海端', 3, '089', '957', '中国,台湾,台东县,海端乡', '121.172008', '23.101074', 'Haiduan', 1);
INSERT INTO `provinces`
VALUES (713432, '延平乡', 713400, '延平', 3, '089', '953', '中国,台湾,台东县,延平乡', '121.084499', '22.902358', 'Yanping', 1);
INSERT INTO `provinces`
VALUES (713433, '金峰乡', 713400, '金峰', 3, '089', '964', '中国,台湾,台东县,金峰乡', '120.971292', '22.595511', 'Jinfeng', 1);
INSERT INTO `provinces`
VALUES (713434, '达仁乡', 713400, '达仁', 3, '089', '966', '中国,台湾,台东县,达仁乡', '120.884131', '22.294869', 'Daren', 1);
INSERT INTO `provinces`
VALUES (713435, '兰屿乡', 713400, '兰屿', 3, '089', '952', '中国,台湾,台东县,兰屿乡', '121.532473', '22.056736', 'Lanyu', 1);
INSERT INTO `provinces`
VALUES (713500, '花莲县', 710000, '花莲', 2, '03', '9', '中国,台湾,花莲县', '121.300000', '23.830000', 'Hualien', 1);
INSERT INTO `provinces`
VALUES (713501, '花莲市', 713500, '花莲', 3, '03', '970', '中国,台湾,花莲县,花莲市', '121.606810', '23.982074', 'Hualian', 1);
INSERT INTO `provinces`
VALUES (713521, '凤林镇', 713500, '凤林', 3, '03', '975', '中国,台湾,花莲县,凤林镇', '121.451687', '23.744648', 'Fenglin', 1);
INSERT INTO `provinces`
VALUES (713522, '玉里镇', 713500, '玉里', 3, '03', '981', '中国,台湾,花莲县,玉里镇', '121.316445', '23.336509', 'Yuli', 1);
INSERT INTO `provinces`
VALUES (713523, '新城乡', 713500, '新城', 3, '03', '971', '中国,台湾,花莲县,新城乡', '121.640512', '24.128133', 'Xincheng', 1);
INSERT INTO `provinces`
VALUES (713524, '吉安乡', 713500, '吉安', 3, '03', '973', '中国,台湾,花莲县,吉安乡', '121.568005', '23.961635', 'Ji\'an', 1);
INSERT INTO `provinces`
VALUES (713525, '寿丰乡', 713500, '寿丰', 3, '03', '974', '中国,台湾,花莲县,寿丰乡', '121.508955', '23.870680', 'Shoufeng', 1);
INSERT INTO `provinces`
VALUES (713526, '光复乡', 713500, '光复', 3, '03', '976', '中国,台湾,花莲县,光复乡', '121.423496', '23.669084', 'Guangfu', 1);
INSERT INTO `provinces`
VALUES (713527, '丰滨乡', 713500, '丰滨', 3, '03', '977', '中国,台湾,花莲县,丰滨乡', '121.518639', '23.597080', 'Fengbin', 1);
INSERT INTO `provinces`
VALUES (713528, '瑞穗乡', 713500, '瑞穗', 3, '03', '978', '中国,台湾,花莲县,瑞穗乡', '121.375992', '23.496817', 'Ruisui', 1);
INSERT INTO `provinces`
VALUES (713529, '富里乡', 713500, '富里', 3, '03', '983', '中国,台湾,花莲县,富里乡', '121.250124', '23.179984', 'Fuli', 1);
INSERT INTO `provinces`
VALUES (713530, '秀林乡', 713500, '秀林', 3, '03', '972', '中国,台湾,花莲县,秀林乡', '121.620381', '24.116642', 'Xiulin', 1);
INSERT INTO `provinces`
VALUES (713531, '万荣乡', 713500, '万荣', 3, '03', '979', '中国,台湾,花莲县,万荣乡', '121.407493', '23.715346', 'Wanrong', 1);
INSERT INTO `provinces`
VALUES (713532, '卓溪乡', 713500, '卓溪', 3, '03', '982', '中国,台湾,花莲县,卓溪乡', '121.303422', '23.346369', 'Zhuoxi', 1);
INSERT INTO `provinces`
VALUES (713600, '澎湖县', 710000, '澎湖', 2, '06', '8', '中国,台湾,澎湖县', '119.566417', '23.569733', 'Penghu', 1);
INSERT INTO `provinces`
VALUES (713601, '马公市', 713600, '马公', 3, '06', '880', '中国,台湾,澎湖县,马公市', '119.566499', '23.565845', 'Magong', 1);
INSERT INTO `provinces`
VALUES (713621, '湖西乡', 713600, '湖西', 3, '06', '885', '中国,台湾,澎湖县,湖西乡', '119.659666', '23.583358', 'Huxi', 1);
INSERT INTO `provinces`
VALUES (713622, '白沙乡', 713600, '白沙', 3, '06', '884', '中国,台湾,澎湖县,白沙乡', '119.597919', '23.666060', 'Baisha', 1);
INSERT INTO `provinces`
VALUES (713623, '西屿乡', 713600, '西屿', 3, '06', '881', '中国,台湾,澎湖县,西屿乡', '119.506974', '23.600836', 'Xiyu', 1);
INSERT INTO `provinces`
VALUES (713624, '望安乡', 713600, '望安', 3, '06', '882', '中国,台湾,澎湖县,望安乡', '119.500538', '23.357531', 'Wang\'an', 1);
INSERT INTO `provinces`
VALUES (713625, '七美乡', 713600, '七美', 3, '06', '883', '中国,台湾,澎湖县,七美乡', '119.423929', '23.206018', 'Qimei', 1);
INSERT INTO `provinces`
VALUES (713700, '金门县', 710000, '金门', 2, '082', '8', '中国,台湾,金门县', '118.317089', '24.432706', 'Jinmen', 1);
INSERT INTO `provinces`
VALUES (713701, '金城镇', 713700, '金城', 3, '082', '893', '中国,台湾,金门县,金城镇', '118.316667', '24.416667', 'Jincheng', 1);
INSERT INTO `provinces`
VALUES (713702, '金湖镇', 713700, '金湖', 3, '082', '891', '中国,台湾,金门县,金湖镇', '118.419743', '24.438633', 'Jinhu', 1);
INSERT INTO `provinces`
VALUES (713703, '金沙镇', 713700, '金沙', 3, '082', '890', '中国,台湾,金门县,金沙镇', '118.427993', '24.481109', 'Jinsha', 1);
INSERT INTO `provinces`
VALUES (713704, '金宁乡', 713700, '金宁', 3, '082', '892', '中国,台湾,金门县,金宁乡', '118.334506', '24.45672', 'Jinning', 1);
INSERT INTO `provinces`
VALUES (713705, '烈屿乡', 713700, '烈屿', 3, '082', '894', '中国,台湾,金门县,烈屿乡', '118.247255', '24.433102', 'Lieyu', 1);
INSERT INTO `provinces`
VALUES (713706, '乌丘乡', 713700, '乌丘', 3, '082', '896', '中国,台湾,金门县,乌丘乡', '118.319578', '24.435038', 'Wuqiu', 1);
INSERT INTO `provinces`
VALUES (713800, '连江县', 710000, '连江', 2, '0836', '2', '中国,台湾,连江县', '119.539704', '26.197364', 'Lienchiang', 1);
INSERT INTO `provinces`
VALUES (713801, '南竿乡', 713800, '南竿', 3, '0836', '209', '中国,台湾,连江县,南竿乡', '119.944267', '26.144035', 'Nangan', 1);
INSERT INTO `provinces`
VALUES (713802, '北竿乡', 713800, '北竿', 3, '0836', '210', '中国,台湾,连江县,北竿乡', '120.000572', '26.221983', 'Beigan', 1);
INSERT INTO `provinces`
VALUES (713803, '莒光乡', 713800, '莒光', 3, '0836', '211', '中国,台湾,连江县,莒光乡', '119.940405', '25.976256', 'Juguang', 1);
INSERT INTO `provinces`
VALUES (713804, '东引乡', 713800, '东引', 3, '0836', '212', '中国,台湾,连江县,东引乡', '120.493955', '26.366164', 'Dongyin', 1);
INSERT INTO `provinces`
VALUES (810000, '香港特别行政区', 100000, '香港', 1, '', '', '中国,香港特别行政区', '114.173355', '22.320048', 'Hong Kong', 1);
INSERT INTO `provinces`
VALUES (810100, '香港岛', 810000, '香港岛', 2, '0085', '999077', '中国,香港特别行政区,香港岛', '114.177314', '22.266416',
        'Hong Kong Island', 1);
INSERT INTO `provinces`
VALUES (810101, '中西区', 810100, '中西区', 3, '0085', '999077', '中国,香港特别行政区,香港岛,中西区', '114.154374', '22.281981',
        'Central and Western District', 1);
INSERT INTO `provinces`
VALUES (810102, '湾仔区', 810100, '湾仔区', 3, '0085', '999077', '中国,香港特别行政区,香港岛,湾仔区', '114.182915', '22.276389',
        'Wan Chai District', 1);
INSERT INTO `provinces`
VALUES (810103, '东区', 810100, '东区', 3, '0085', '999077', '中国,香港特别行政区,香港岛,东区', '114.255993', '22.262755',
        'Eastern District', 1);
INSERT INTO `provinces`
VALUES (810104, '南区', 810100, '南区', 3, '0085', '999077', '中国,香港特别行政区,香港岛,南区', '114.174134', '22.24676',
        'Southern District', 1);
INSERT INTO `provinces`
VALUES (810200, '九龙', 810000, '九龙', 2, '0085', '999077', '中国,香港特别行政区,九龙', '114.17495', '22.327115', 'Kowloon', 1);
INSERT INTO `provinces`
VALUES (810201, '油尖旺区', 810200, '油尖旺', 3, '0085', '999077', '中国,香港特别行政区,九龙,油尖旺区', '114.173332', '22.311704',
        'Yau Tsim Mong', 1);
INSERT INTO `provinces`
VALUES (810202, '深水埗区', 810200, '深水埗', 3, '0085', '999077', '中国,香港特别行政区,九龙,深水埗区', '114.16721', '22.328171',
        'Sham Shui Po', 1);
INSERT INTO `provinces`
VALUES (810203, '九龙城区', 810200, '九龙城', 3, '0085', '999077', '中国,香港特别行政区,九龙,九龙城区', '114.195053', '22.32673',
        'Jiulongcheng', 1);
INSERT INTO `provinces`
VALUES (810204, '黄大仙区', 810200, '黄大仙', 3, '0085', '999077', '中国,香港特别行政区,九龙,黄大仙区', '114.19924', '22.336313',
        'Wong Tai Sin', 1);
INSERT INTO `provinces`
VALUES (810205, '观塘区', 810200, '观塘', 3, '0085', '999077', '中国,香港特别行政区,九龙,观塘区', '114.231268', '22.30943', 'Kwun Tong',
        1);
INSERT INTO `provinces`
VALUES (810300, '新界', 810000, '新界', 2, '0085', '999077', '中国,香港特别行政区,新界', '114.202408', '22.341766', 'New Territories',
        1);
INSERT INTO `provinces`
VALUES (810301, '荃湾区', 810300, '荃湾', 3, '0085', '999077', '中国,香港特别行政区,新界,荃湾区', '114.122952', '22.370973', 'Tsuen Wan',
        1);
INSERT INTO `provinces`
VALUES (810302, '屯门区', 810300, '屯门', 3, '0085', '999077', '中国,香港特别行政区,新界,屯门区', '113.977416', '22.391047', 'Tuen Mun',
        1);
INSERT INTO `provinces`
VALUES (810303, '元朗区', 810300, '元朗', 3, '0085', '999077', '中国,香港特别行政区,新界,元朗区', '114.039796', '22.443342', 'Yuen Long',
        1);
INSERT INTO `provinces`
VALUES (810304, '北区', 810300, '北区', 3, '0085', '999077', '中国,香港特别行政区,新界,北区', '114.148959', '22.494086',
        'North District', 1);
INSERT INTO `provinces`
VALUES (810305, '大埔区', 810300, '大埔', 3, '0085', '999077', '中国,香港特别行政区,新界,大埔区', '114.171743', '22.445653', 'Tai Po', 1);
INSERT INTO `provinces`
VALUES (810306, '西贡区', 810300, '西贡', 3, '0085', '999077', '中国,香港特别行政区,新界,西贡区', '114.27854', '22.37944', 'Sai Kung', 1);
INSERT INTO `provinces`
VALUES (810307, '沙田区', 810300, '沙田', 3, '0085', '999077', '中国,香港特别行政区,新界,沙田区', '114.191941', '22.379294', 'Sha Tin', 1);
INSERT INTO `provinces`
VALUES (810308, '葵青区', 810300, '葵青', 3, '0085', '999077', '中国,香港特别行政区,新界,葵青区', '114.13932', '22.363877', 'Kwai Tsing',
        1);
INSERT INTO `provinces`
VALUES (810309, '离岛区', 810300, '离岛', 3, '0085', '999077', '中国,香港特别行政区,新界,离岛区', '113.945842', '22.281508',
        'Outlying Islands', 1);
INSERT INTO `provinces`
VALUES (820000, '澳门特别行政区', 100000, '澳门', 1, '', '', '中国,澳门特别行政区', '113.54909', '22.198951', 'Macau', 1);
INSERT INTO `provinces`
VALUES (820100, '澳门半岛', 820000, '澳门半岛', 2, '0085', '999078', '中国,澳门特别行政区,澳门半岛', '113.549134', '22.198751',
        'MacauPeninsula', 1);
INSERT INTO `provinces`
VALUES (820101, '花地玛堂区', 820100, '花地玛堂区', 3, '0085', '999078', '中国,澳门特别行政区,澳门半岛,花地玛堂区', '113.552284', '22.208067',
        'Nossa Senhora de Fatima', 1);
INSERT INTO `provinces`
VALUES (820102, '圣安多尼堂区', 820100, '圣安多尼堂区', 3, '0085', '999078', '中国,澳门特别行政区,澳门半岛,圣安多尼堂区', '113.564301', '22.12381',
        'Santo Antonio', 1);
INSERT INTO `provinces`
VALUES (820103, '大堂区', 820100, '大堂', 3, '0085', '999078', '中国,澳门特别行政区,澳门半岛,大堂区', '113.552971', '22.188359', 'Sé', 1);
INSERT INTO `provinces`
VALUES (820104, '望德堂区', 820100, '望德堂区', 3, '0085', '999078', '中国,澳门特别行政区,澳门半岛,望德堂区', '113.550568', '22.194081',
        'Sao Lazaro', 1);
INSERT INTO `provinces`
VALUES (820105, '风顺堂区', 820100, '风顺堂区', 3, '0085', '999078', '中国,澳门特别行政区,澳门半岛,风顺堂区', '113.541928', '22.187368',
        'Sao Lourenco', 1);
INSERT INTO `provinces`
VALUES (820200, '氹仔岛', 820000, '氹仔岛', 2, '0085', '999078', '中国,澳门特别行政区,氹仔岛', '113.577669', '22.156838', 'Taipa', 1);
INSERT INTO `provinces`
VALUES (820201, '嘉模堂区', 820200, '嘉模堂区', 3, '0085', '999078', '中国,澳门特别行政区,氹仔岛,嘉模堂区', '113.565303', '22.149029',
        'Our Lady Of Carmel\'s Parish', 1);
INSERT INTO `provinces`
VALUES (820300, '路环岛', 820000, '路环岛', 2, '0085', '999078', '中国,澳门特别行政区,路环岛', '113.564857', '22.116226', 'Coloane', 1);
INSERT INTO `provinces`
VALUES (820301, '圣方济各堂区', 820300, '圣方济各堂区', 3, '0085', '999078', '中国,澳门特别行政区,路环岛,圣方济各堂区', '113.559954', '22.123486',
        'St Francis Xavier\'s Parish', 1);
INSERT INTO `provinces`
VALUES (900000, '钓鱼岛', 100000, '钓鱼岛', 1, '', '', '中国,钓鱼岛', '123.478088', '25.742385', 'DiaoyuDao', 1);

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log`
(
    `branch_id`     bigint                                                  NOT NULL COMMENT 'branch transaction id',
    `xid`           varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'global transaction id',
    `context`       varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'undo_log context,such as serialization',
    `rollback_info` longblob                                                NOT NULL COMMENT 'rollback info',
    `log_status`    int                                                     NOT NULL COMMENT '0:normal status,1:defense status',
    `log_created`   datetime(6)                                             NOT NULL COMMENT 'create datetime',
    `log_modified`  datetime(6)                                             NOT NULL COMMENT 'modify datetime',
    UNIQUE INDEX `ux_undo_log` (`xid`, `branch_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = 'AT transaction mode undo table'
  ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
