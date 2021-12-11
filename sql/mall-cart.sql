/*
 Navicat Premium Data Transfer

 Source Server         : MySQL80
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : mall-cart

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 11/12/2021 10:09:56
*/

CREATE DATABASE IF NOT EXISTS `mall-cart` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE `mall-cart`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mall_cart
-- ----------------------------
DROP TABLE IF EXISTS `mall_cart`;
CREATE TABLE `mall_cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `check` tinyint NOT NULL DEFAULT 1 COMMENT '是否选中【0：false。1：true】',
  `spu_id` bigint NOT NULL COMMENT 'spuId',
  `sku_id` bigint NOT NULL COMMENT 'skuId',
  `default_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `sale_attr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '销售属性',
  `sku_price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `buy_num` int NOT NULL DEFAULT 1 COMMENT '购买数量',
  `total_sku_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '购物车总价',
  `add_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
