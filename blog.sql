/*
 Navicat Premium Data Transfer

 Source Server         : blog.an0nymou5.com
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001

 Date: 15/01/2021 16:32:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for data_friend
-- ----------------------------
DROP TABLE IF EXISTS `data_friend`;
CREATE TABLE `data_friend`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `site` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '网站',
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所有者',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '网址',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '颜色',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态 0待审核 1已通过 2已拒绝',
  `createtime` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of data_friend
-- ----------------------------
INSERT INTO `data_friend` VALUES (8, '非正常人类研究中心', 'An0nymou5', 'http://blog.an0nymou5.com', '一个人的喃喃自语', 'https://s3.ax1x.com/2021/01/15/s0toFg.jpg', '97d3d6', 1, 1609207910);

-- ----------------------------
-- Table structure for data_news_category
-- ----------------------------
DROP TABLE IF EXISTS `data_news_category`;
CREATE TABLE `data_news_category`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类说明',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '标签状态(1使用,0禁用)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_news_mark_status`(`status`) USING BTREE,
  INDEX `idx_data_news_mark_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-文章-分类' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_news_category
-- ----------------------------
INSERT INTO `data_news_category` VALUES (1, '测试分类', '', 0, 1, 0, '2020-12-29 02:21:11');

-- ----------------------------
-- Table structure for data_news_item
-- ----------------------------
DROP TABLE IF EXISTS `data_news_item`;
CREATE TABLE `data_news_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章标题',
  `mark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章标签',
  `category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章分类',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章封面',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注说明',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容',
  `num_like` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章点赞数',
  `num_read` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章阅读数',
  `num_collect` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章收藏数',
  `num_comment` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章评论数',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '置顶 0否 1是',
  `praise` tinyint(1) NOT NULL DEFAULT 1 COMMENT '赞赏 0关闭 1开启',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '文章状态(1使用,0禁用)',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_news_item_code`(`code`) USING BTREE,
  INDEX `idx_data_news_item_status`(`status`) USING BTREE,
  INDEX `idx_data_news_item_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-文章-内容' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_news_item
-- ----------------------------
INSERT INTO `data_news_item` VALUES (1, 'A7091797270085', '不出意外的话，未来几十年我都在', ',1,', ',1,', 'http://resource.an0nymou5.com/blog/b0/daaf680361c2d35c41e6810bd950a1.jpg', '所以别再问我在不在了！我还能死在你前面吗？！', '<p>发了句&ldquo;在吗&rdquo;之后半天不说话的人，你妈买菜必涨价，你爸炒菜必糊锅，你爷下棋必被指点，你弟上厕所裤绳必死结，你哥玩斗地主必被春天，你奶跳广场舞必被抢c位，你玩跑得快3456没有7</p>', 0, 82, 0, 0, 0, 0, 0, 1, 0, '2020-12-29 02:25:39', '2021-01-13 17:54:03');

-- ----------------------------
-- Table structure for data_news_mark
-- ----------------------------
DROP TABLE IF EXISTS `data_news_mark`;
CREATE TABLE `data_news_mark`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签说明',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '标签状态(1使用,0禁用)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_news_mark_status`(`status`) USING BTREE,
  INDEX `idx_data_news_mark_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-文章-标签' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_news_mark
-- ----------------------------
INSERT INTO `data_news_mark` VALUES (1, '测试标签', '', 0, 1, 0, '2020-12-29 02:22:02');

-- ----------------------------
-- Table structure for data_news_relation
-- ----------------------------
DROP TABLE IF EXISTS `data_news_relation`;
CREATE TABLE `data_news_relation`  (
  `news_id` bigint(20) NULL DEFAULT 0 COMMENT '文章id',
  `type` tinyint(4) NULL DEFAULT 0 COMMENT '关系类型 详见枚举类',
  `object_id` bigint(20) NULL DEFAULT 0 COMMENT '对象id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-文章-关系' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_news_relation
-- ----------------------------

-- ----------------------------
-- Table structure for data_news_x_collect
-- ----------------------------
DROP TABLE IF EXISTS `data_news_x_collect`;
CREATE TABLE `data_news_x_collect`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户UID',
  `type` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '记录类型(1收藏,2点赞,3历史)',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章编号',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_news_x_collect_mid`(`uid`) USING BTREE,
  INDEX `idx_data_news_x_collect_type`(`type`) USING BTREE,
  INDEX `idx_data_news_x_collect_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-文章-标记' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_news_x_collect
-- ----------------------------

-- ----------------------------
-- Table structure for data_news_x_comment
-- ----------------------------
DROP TABLE IF EXISTS `data_news_x_comment`;
CREATE TABLE `data_news_x_comment`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户UID',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章编号',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '评论内容',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_news_x_comment_mid`(`uid`) USING BTREE,
  INDEX `idx_data_news_x_comment_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-文章-评论' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_news_x_comment
-- ----------------------------

-- ----------------------------
-- Table structure for data_payment
-- ----------------------------
DROP TABLE IF EXISTS `data_payment`;
CREATE TABLE `data_payment`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付类型',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付名称',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '支付参数',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付说明',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '支付状态(1使用,0禁用)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_payment_type`(`type`) USING BTREE,
  INDEX `idx_data_payment_status`(`status`) USING BTREE,
  INDEX `idx_data_payment_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-支付-通道' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_payment
-- ----------------------------

-- ----------------------------
-- Table structure for data_payment_item
-- ----------------------------
DROP TABLE IF EXISTS `data_payment_item`;
CREATE TABLE `data_payment_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单单号',
  `order_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单描述',
  `order_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '订单金额',
  `payment_id` bigint(20) NULL DEFAULT 0 COMMENT '支付编号',
  `payment_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付通道',
  `payment_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付单号',
  `payment_status` tinyint(1) NULL DEFAULT 0 COMMENT '支付状态',
  `payment_amount` decimal(20, 2) NULL DEFAULT NULL COMMENT '支付金额',
  `payment_datatime` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_payment_item_order_no`(`order_no`) USING BTREE,
  INDEX `idx_data_payment_item_pament_id`(`payment_id`) USING BTREE,
  INDEX `idx_data_payment_item_payment_type`(`payment_type`) USING BTREE,
  INDEX `idx_data_payment_item_payment_status`(`payment_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-支付-记录' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_payment_item
-- ----------------------------

-- ----------------------------
-- Table structure for data_picture_category
-- ----------------------------
DROP TABLE IF EXISTS `data_picture_category`;
CREATE TABLE `data_picture_category`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类说明',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '标签状态(1使用,0禁用)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-图片-分类' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_picture_category
-- ----------------------------
INSERT INTO `data_picture_category` VALUES (1, '轮播背景', '', 0, 1, 0, '2020-12-31 10:26:05');

-- ----------------------------
-- Table structure for data_picture_item
-- ----------------------------
DROP TABLE IF EXISTS `data_picture_item`;
CREATE TABLE `data_picture_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片标题',
  `category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片分类',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片地址',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '图片状态(1使用,0禁用)',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 151 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-图片-内容' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_picture_item
-- ----------------------------
INSERT INTO `data_picture_item` VALUES (4, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061152547794.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (5, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061153029064.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (6, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061153101554.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (7, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061153201332.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (8, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061154166502.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (9, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061154255998.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (10, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061154391613.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (11, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061154505620.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (12, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061155046957.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (13, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061155167762.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (14, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061155258584.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (15, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061155325407.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (16, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061155398940.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (17, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061155473497.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (18, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061155544844.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (19, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061156061915.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (20, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061156147604.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (21, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061156222738.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (22, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061156414074.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (23, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061156511336.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (24, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030051240.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (25, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030069881.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (26, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030073314.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (27, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030099679.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (28, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030119091.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (29, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030127121.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (30, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030132998.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (31, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030142253.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (32, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030151474.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (33, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030169873.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (34, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708081030176980.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (35, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711121115478376.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (36, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711270938484832.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (37, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201805161100492166.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (38, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201805161100493111.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (39, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201808121517226338.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (40, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201808121517235962.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (41, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809161227055350.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (42, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809161227118860.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (43, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809161227167963.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (44, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809161227363335.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (45, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810141820249816.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (46, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811041536369559.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (47, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111640598139.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (48, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111640599573.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (49, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111641008043.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (50, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201812091616176836.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (51, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201901131737425584.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (52, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201901131737458350.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (53, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061202385648.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (54, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061202449012.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (55, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061202505567.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (56, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203033626.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (57, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203093319.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (58, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203166692.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (59, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203248239.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (60, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203311419.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (61, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203383853.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (62, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203465514.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (63, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061203533906.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (64, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061204015982.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (65, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061207313810.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (66, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061207414223.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (67, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201706061207496485.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (68, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708040924418080.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (69, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708040924426303.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (70, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708150858572780.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (71, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708150858583375.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (72, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708150858585757.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (73, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708150858596128.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (74, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201708150859008911.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (75, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201710190906232858.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (76, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201710190906242802.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (77, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201710190906247052.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (78, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201710261748103360.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (79, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201710261748105039.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (80, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201710261748128248.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (81, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711141153159230.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (82, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711141153189504.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (83, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711141153203280.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (84, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711141153239025.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (85, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711141153265681.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (86, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711141153325692.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (87, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711301110411808.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (88, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201711301110416499.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (89, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201712151041008957.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (90, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801121709036667.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (91, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801121709048182.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (92, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801121709056553.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (93, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801121709057243.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (94, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801121709061531.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (95, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801121709072519.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (96, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801181052241016.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (97, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801181052251036.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (98, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801181052256128.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (99, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801181052262405.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (100, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201801181052279242.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (101, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201805220911111538.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (102, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201805220911122509.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (103, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201806011418192217.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (104, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201806011418204427.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (105, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201806011418213896.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (106, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201806011419585686.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (107, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201806011419594829.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (108, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807021201141166.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (109, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171228594706.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (110, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171229006427.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (111, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171229011689.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (112, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171229022695.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (113, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171229044030.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (114, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171229054766.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (115, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171229087782.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (116, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807171229108510.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (117, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201807181109142831.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (118, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201808071128234175.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (119, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201808071128234421.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (120, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201808081226154883.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (121, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201808081226167999.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (122, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201808081226179628.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (123, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122501071.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (124, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122504035.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (125, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122515132.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (126, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122517457.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (127, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122524554.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (128, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122527309.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (129, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122533408.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (130, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122535513.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (131, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201809271122538480.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (132, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810100937007131.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (133, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810100937011230.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (134, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810100937015718.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (135, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810100937027984.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (136, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810100937028635.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (137, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810141143221440.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (138, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810170921262517.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (139, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810170921277402.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (140, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810170921279796.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (141, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810181202023989.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (142, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810181202025398.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (143, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201810181202041469.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (144, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811011414517975.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (145, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811011414524471.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (146, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111641481744.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (147, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111641492231.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (148, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111641497934.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (149, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111641501826.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');
INSERT INTO `data_picture_item` VALUES (150, '', ',1,', 'http://resource.an0nymou5.com/blog/background/201811111641505329.jpg', 0, 1, 0, '2020-12-31 10:50:55', '2020-12-31 10:50:55');

-- ----------------------------
-- Table structure for data_picture_relation
-- ----------------------------
DROP TABLE IF EXISTS `data_picture_relation`;
CREATE TABLE `data_picture_relation`  (
  `picture_id` bigint(20) NULL DEFAULT 0 COMMENT '图片id',
  `category_id` bigint(20) NULL DEFAULT 0 COMMENT '分类id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-图片-关系' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_picture_relation
-- ----------------------------
INSERT INTO `data_picture_relation` VALUES (4, 1);
INSERT INTO `data_picture_relation` VALUES (5, 1);
INSERT INTO `data_picture_relation` VALUES (6, 1);
INSERT INTO `data_picture_relation` VALUES (7, 1);
INSERT INTO `data_picture_relation` VALUES (8, 1);
INSERT INTO `data_picture_relation` VALUES (9, 1);
INSERT INTO `data_picture_relation` VALUES (10, 1);
INSERT INTO `data_picture_relation` VALUES (11, 1);
INSERT INTO `data_picture_relation` VALUES (12, 1);
INSERT INTO `data_picture_relation` VALUES (13, 1);
INSERT INTO `data_picture_relation` VALUES (14, 1);
INSERT INTO `data_picture_relation` VALUES (15, 1);
INSERT INTO `data_picture_relation` VALUES (16, 1);
INSERT INTO `data_picture_relation` VALUES (17, 1);
INSERT INTO `data_picture_relation` VALUES (18, 1);
INSERT INTO `data_picture_relation` VALUES (19, 1);
INSERT INTO `data_picture_relation` VALUES (20, 1);
INSERT INTO `data_picture_relation` VALUES (21, 1);
INSERT INTO `data_picture_relation` VALUES (22, 1);
INSERT INTO `data_picture_relation` VALUES (23, 1);
INSERT INTO `data_picture_relation` VALUES (24, 1);
INSERT INTO `data_picture_relation` VALUES (25, 1);
INSERT INTO `data_picture_relation` VALUES (26, 1);
INSERT INTO `data_picture_relation` VALUES (27, 1);
INSERT INTO `data_picture_relation` VALUES (28, 1);
INSERT INTO `data_picture_relation` VALUES (29, 1);
INSERT INTO `data_picture_relation` VALUES (30, 1);
INSERT INTO `data_picture_relation` VALUES (31, 1);
INSERT INTO `data_picture_relation` VALUES (32, 1);
INSERT INTO `data_picture_relation` VALUES (33, 1);
INSERT INTO `data_picture_relation` VALUES (34, 1);
INSERT INTO `data_picture_relation` VALUES (35, 1);
INSERT INTO `data_picture_relation` VALUES (36, 1);
INSERT INTO `data_picture_relation` VALUES (37, 1);
INSERT INTO `data_picture_relation` VALUES (38, 1);
INSERT INTO `data_picture_relation` VALUES (39, 1);
INSERT INTO `data_picture_relation` VALUES (40, 1);
INSERT INTO `data_picture_relation` VALUES (41, 1);
INSERT INTO `data_picture_relation` VALUES (42, 1);
INSERT INTO `data_picture_relation` VALUES (43, 1);
INSERT INTO `data_picture_relation` VALUES (44, 1);
INSERT INTO `data_picture_relation` VALUES (45, 1);
INSERT INTO `data_picture_relation` VALUES (46, 1);
INSERT INTO `data_picture_relation` VALUES (47, 1);
INSERT INTO `data_picture_relation` VALUES (48, 1);
INSERT INTO `data_picture_relation` VALUES (49, 1);
INSERT INTO `data_picture_relation` VALUES (50, 1);
INSERT INTO `data_picture_relation` VALUES (51, 1);
INSERT INTO `data_picture_relation` VALUES (52, 1);
INSERT INTO `data_picture_relation` VALUES (53, 1);
INSERT INTO `data_picture_relation` VALUES (54, 1);
INSERT INTO `data_picture_relation` VALUES (55, 1);
INSERT INTO `data_picture_relation` VALUES (56, 1);
INSERT INTO `data_picture_relation` VALUES (57, 1);
INSERT INTO `data_picture_relation` VALUES (58, 1);
INSERT INTO `data_picture_relation` VALUES (59, 1);
INSERT INTO `data_picture_relation` VALUES (60, 1);
INSERT INTO `data_picture_relation` VALUES (61, 1);
INSERT INTO `data_picture_relation` VALUES (62, 1);
INSERT INTO `data_picture_relation` VALUES (63, 1);
INSERT INTO `data_picture_relation` VALUES (64, 1);
INSERT INTO `data_picture_relation` VALUES (65, 1);
INSERT INTO `data_picture_relation` VALUES (66, 1);
INSERT INTO `data_picture_relation` VALUES (67, 1);
INSERT INTO `data_picture_relation` VALUES (68, 1);
INSERT INTO `data_picture_relation` VALUES (69, 1);
INSERT INTO `data_picture_relation` VALUES (70, 1);
INSERT INTO `data_picture_relation` VALUES (71, 1);
INSERT INTO `data_picture_relation` VALUES (72, 1);
INSERT INTO `data_picture_relation` VALUES (73, 1);
INSERT INTO `data_picture_relation` VALUES (74, 1);
INSERT INTO `data_picture_relation` VALUES (75, 1);
INSERT INTO `data_picture_relation` VALUES (76, 1);
INSERT INTO `data_picture_relation` VALUES (77, 1);
INSERT INTO `data_picture_relation` VALUES (78, 1);
INSERT INTO `data_picture_relation` VALUES (79, 1);
INSERT INTO `data_picture_relation` VALUES (80, 1);
INSERT INTO `data_picture_relation` VALUES (81, 1);
INSERT INTO `data_picture_relation` VALUES (82, 1);
INSERT INTO `data_picture_relation` VALUES (83, 1);
INSERT INTO `data_picture_relation` VALUES (84, 1);
INSERT INTO `data_picture_relation` VALUES (85, 1);
INSERT INTO `data_picture_relation` VALUES (86, 1);
INSERT INTO `data_picture_relation` VALUES (87, 1);
INSERT INTO `data_picture_relation` VALUES (88, 1);
INSERT INTO `data_picture_relation` VALUES (89, 1);
INSERT INTO `data_picture_relation` VALUES (90, 1);
INSERT INTO `data_picture_relation` VALUES (91, 1);
INSERT INTO `data_picture_relation` VALUES (92, 1);
INSERT INTO `data_picture_relation` VALUES (93, 1);
INSERT INTO `data_picture_relation` VALUES (94, 1);
INSERT INTO `data_picture_relation` VALUES (95, 1);
INSERT INTO `data_picture_relation` VALUES (96, 1);
INSERT INTO `data_picture_relation` VALUES (97, 1);
INSERT INTO `data_picture_relation` VALUES (98, 1);
INSERT INTO `data_picture_relation` VALUES (99, 1);
INSERT INTO `data_picture_relation` VALUES (100, 1);
INSERT INTO `data_picture_relation` VALUES (101, 1);
INSERT INTO `data_picture_relation` VALUES (102, 1);
INSERT INTO `data_picture_relation` VALUES (103, 1);
INSERT INTO `data_picture_relation` VALUES (104, 1);
INSERT INTO `data_picture_relation` VALUES (105, 1);
INSERT INTO `data_picture_relation` VALUES (106, 1);
INSERT INTO `data_picture_relation` VALUES (107, 1);
INSERT INTO `data_picture_relation` VALUES (108, 1);
INSERT INTO `data_picture_relation` VALUES (109, 1);
INSERT INTO `data_picture_relation` VALUES (110, 1);
INSERT INTO `data_picture_relation` VALUES (111, 1);
INSERT INTO `data_picture_relation` VALUES (112, 1);
INSERT INTO `data_picture_relation` VALUES (113, 1);
INSERT INTO `data_picture_relation` VALUES (114, 1);
INSERT INTO `data_picture_relation` VALUES (115, 1);
INSERT INTO `data_picture_relation` VALUES (116, 1);
INSERT INTO `data_picture_relation` VALUES (117, 1);
INSERT INTO `data_picture_relation` VALUES (118, 1);
INSERT INTO `data_picture_relation` VALUES (119, 1);
INSERT INTO `data_picture_relation` VALUES (120, 1);
INSERT INTO `data_picture_relation` VALUES (121, 1);
INSERT INTO `data_picture_relation` VALUES (122, 1);
INSERT INTO `data_picture_relation` VALUES (123, 1);
INSERT INTO `data_picture_relation` VALUES (124, 1);
INSERT INTO `data_picture_relation` VALUES (125, 1);
INSERT INTO `data_picture_relation` VALUES (126, 1);
INSERT INTO `data_picture_relation` VALUES (127, 1);
INSERT INTO `data_picture_relation` VALUES (128, 1);
INSERT INTO `data_picture_relation` VALUES (129, 1);
INSERT INTO `data_picture_relation` VALUES (130, 1);
INSERT INTO `data_picture_relation` VALUES (131, 1);
INSERT INTO `data_picture_relation` VALUES (132, 1);
INSERT INTO `data_picture_relation` VALUES (133, 1);
INSERT INTO `data_picture_relation` VALUES (134, 1);
INSERT INTO `data_picture_relation` VALUES (135, 1);
INSERT INTO `data_picture_relation` VALUES (136, 1);
INSERT INTO `data_picture_relation` VALUES (137, 1);
INSERT INTO `data_picture_relation` VALUES (138, 1);
INSERT INTO `data_picture_relation` VALUES (139, 1);
INSERT INTO `data_picture_relation` VALUES (140, 1);
INSERT INTO `data_picture_relation` VALUES (141, 1);
INSERT INTO `data_picture_relation` VALUES (142, 1);
INSERT INTO `data_picture_relation` VALUES (143, 1);
INSERT INTO `data_picture_relation` VALUES (144, 1);
INSERT INTO `data_picture_relation` VALUES (145, 1);
INSERT INTO `data_picture_relation` VALUES (146, 1);
INSERT INTO `data_picture_relation` VALUES (147, 1);
INSERT INTO `data_picture_relation` VALUES (148, 1);
INSERT INTO `data_picture_relation` VALUES (149, 1);
INSERT INTO `data_picture_relation` VALUES (150, 1);

-- ----------------------------
-- Table structure for data_user
-- ----------------------------
DROP TABLE IF EXISTS `data_user`;
CREATE TABLE `data_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '邀请者MID',
  `openid1` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '小程序OPENID',
  `openid2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '服务号OPENID',
  `unionid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号UnionID',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户手机',
  `headimg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户姓名',
  `nickname` varchar(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录密码',
  `region_province` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '所在省份',
  `region_city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '所在城市',
  `region_area` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '所在区域',
  `base_age` bigint(20) NULL DEFAULT 0 COMMENT '用户年龄',
  `base_sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户性别',
  `base_height` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户身高',
  `base_weight` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户体重',
  `base_birthday` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户生日',
  `coin_total` bigint(20) NULL DEFAULT 0 COMMENT '金币数量',
  `coin_used` bigint(20) NULL DEFAULT 0 COMMENT '金币已用',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '用户状态(1正常,0已拉黑)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_user_status`(`status`) USING BTREE,
  INDEX `idx_data_user_deleted`(`deleted`) USING BTREE,
  INDEX `idx_data_user_openid1`(`openid1`) USING BTREE,
  INDEX `idx_data_user_openid2`(`openid2`) USING BTREE,
  INDEX `idx_data_user_unionid`(`unionid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-用户-记录' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_user
-- ----------------------------

-- ----------------------------
-- Table structure for data_user_address
-- ----------------------------
DROP TABLE IF EXISTS `data_user_address`;
CREATE TABLE `data_user_address`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户UID',
  `type` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '地址类型(0普通,1默认)',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地址编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '收货姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '收货手机',
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地址-省份',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地址-城市',
  `area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地址-区域',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地址-详情',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_user_address_mid`(`uid`) USING BTREE,
  INDEX `idx_data_user_address_type`(`type`) USING BTREE,
  INDEX `idx_data_user_address_code`(`code`) USING BTREE,
  INDEX `idx_data_user_address_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-用户-地址' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_user_address
-- ----------------------------

-- ----------------------------
-- Table structure for data_user_coin_item
-- ----------------------------
DROP TABLE IF EXISTS `data_user_coin_item`;
CREATE TABLE `data_user_coin_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户UID',
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '记录编号',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '记录类型',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '记录名称',
  `number` bigint(20) NULL DEFAULT 0 COMMENT '奖励数量',
  `date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '记录日期',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_user_coin_mid`(`uid`) USING BTREE,
  INDEX `idx_data_user_coin_type`(`type`) USING BTREE,
  INDEX `idx_data_user_coin_name`(`name`) USING BTREE,
  INDEX `idx_data_user_coin_date`(`date`) USING BTREE,
  INDEX `idx_data_user_coin_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据-用户-金币-获得' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_user_coin_item
-- ----------------------------

-- ----------------------------
-- Table structure for data_user_coin_used
-- ----------------------------
DROP TABLE IF EXISTS `data_user_coin_used`;
CREATE TABLE `data_user_coin_used`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户UID',
  `from` bigint(20) NULL DEFAULT 0 COMMENT '来自MID',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '记录类型',
  `target` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '目标ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '记录名称',
  `number` bigint(20) NULL DEFAULT 0 COMMENT '奖励数量',
  `date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '记录日期',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_user_coin_used_mid`(`uid`) USING BTREE,
  INDEX `idx_data_user_coin_used_type`(`type`) USING BTREE,
  INDEX `idx_data_user_coin_used_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据-用户-金币-消费' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_user_coin_used
-- ----------------------------

-- ----------------------------
-- Table structure for data_user_message
-- ----------------------------
DROP TABLE IF EXISTS `data_user_message`;
CREATE TABLE `data_user_message`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '短信类型',
  `msgid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '消息编号',
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '目标手机',
  `region` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '国家编号',
  `result` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回结果',
  `content` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '短信内容',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '短信状态(0失败,1成功)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_user_message_type`(`type`) USING BTREE,
  INDEX `idx_data_user_message_status`(`status`) USING BTREE,
  INDEX `idx_data_user_message_phone`(`phone`) USING BTREE,
  INDEX `idx_data_user_message_msgid`(`msgid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统-用户-短信' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_user_message
-- ----------------------------

-- ----------------------------
-- Table structure for data_user_token
-- ----------------------------
DROP TABLE IF EXISTS `data_user_token`;
CREATE TABLE `data_user_token`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NULL DEFAULT 0 COMMENT '用户UID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '授权类型',
  `time` bigint(20) NULL DEFAULT 0 COMMENT '有效时间',
  `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '授权令牌',
  `tokenv` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '授权验证',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_user_token_type`(`type`) USING BTREE,
  INDEX `idx_data_user_token_time`(`time`) USING BTREE,
  INDEX `idx_data_user_token_token`(`token`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据-用户-认证' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of data_user_token
-- ----------------------------

-- ----------------------------
-- Table structure for shop_goods
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods`;
CREATE TABLE `shop_goods`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cate` bigint(20) NULL DEFAULT 0 COMMENT '商品分类',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品编号',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品名称',
  `mark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品标签',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品封面',
  `slider` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '轮播图片',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品描述',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品详情',
  `data_specs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品规格',
  `data_items` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品规格',
  `truck_tcode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '运费模板',
  `stock_total` bigint(20) NULL DEFAULT 0 COMMENT '库存统计',
  `stock_sales` bigint(20) NULL DEFAULT 0 COMMENT '销售统计',
  `stock_virtual` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '虚拟销量',
  `price_selling` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '商品销售价格',
  `price_market` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '商品市场价格',
  `num_read` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章阅读数',
  `num_collect` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章收藏数',
  `num_comment` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章评论数',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1使用,0禁用)',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_goods_code`(`code`) USING BTREE,
  INDEX `idx_shop_goods_cate`(`cate`) USING BTREE,
  INDEX `idx_shop_goods_status`(`status`) USING BTREE,
  INDEX `idx_shop_goods_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-商品-内容' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_goods
-- ----------------------------

-- ----------------------------
-- Table structure for shop_goods_cate
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_cate`;
CREATE TABLE `shop_goods_cate`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NULL DEFAULT 0 COMMENT '上级分类',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类名称',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类图标',
  `remark` varchar(999) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类描述',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '使用状态',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_goods_cate_sort`(`sort`) USING BTREE,
  INDEX `idx_shop_goods_cate_status`(`status`) USING BTREE,
  INDEX `idx_shop_goods_cate_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-商品-分类' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_goods_cate
-- ----------------------------

-- ----------------------------
-- Table structure for shop_goods_item
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_item`;
CREATE TABLE `shop_goods_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `goods_sku` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品SKU',
  `goods_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品编号',
  `goods_spec` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品规格',
  `stock_sales` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '销售数量',
  `stock_total` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '商品库存',
  `price_selling` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '销售价格',
  `price_market` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '市场价格',
  `number_virtual` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '虚拟销量',
  `number_express` bigint(20) UNSIGNED NULL DEFAULT 1 COMMENT '计件数量',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_store_goods_list_id`(`goods_code`) USING BTREE,
  INDEX `index_store_goods_list_spec`(`goods_spec`) USING BTREE,
  INDEX `index_store_goods_list_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城-商品-规格' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_goods_item
-- ----------------------------

-- ----------------------------
-- Table structure for shop_goods_mark
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_mark`;
CREATE TABLE `shop_goods_mark`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签名称',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签描述',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '标签状态(1使用,0禁用)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_goods_mark_sort`(`sort`) USING BTREE,
  INDEX `idx_shop_goods_mark_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-商品-标签' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_goods_mark
-- ----------------------------

-- ----------------------------
-- Table structure for shop_goods_stock
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_stock`;
CREATE TABLE `shop_goods_stock`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `batch_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作批量',
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品编号',
  `goods_spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品规格',
  `goods_stock` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '入库数量',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '数据状态(1使用,0禁用)',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_news_item_status`(`status`) USING BTREE,
  INDEX `idx_data_news_item_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-商品-库存' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_goods_stock
-- ----------------------------

-- ----------------------------
-- Table structure for shop_order
-- ----------------------------
DROP TABLE IF EXISTS `shop_order`;
CREATE TABLE `shop_order`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户编号',
  `from` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '推荐用户',
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `amount_total` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '支付总金额',
  `amount_goods` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '商品总金额',
  `amount_reduct` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '随机减免金额',
  `amount_express` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '快递费用金额',
  `amount_discount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '策略优惠金额',
  `payment_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实际支付平台',
  `payment_code` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实际支付单号',
  `payment_status` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '实际支付状态',
  `payment_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '实际支付金额',
  `payment_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付结果描述',
  `payment_datetime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付到账时间',
  `cancel_status` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '订单取消状态',
  `cancel_remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单取消描述',
  `cancel_datetime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单取消时间',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '订单状态(0已取消,1预订单,2待支付,3待发货,4待签收,5已完成)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_order_mid`(`uid`) USING BTREE,
  INDEX `idx_shop_order_from`(`from`) USING BTREE,
  INDEX `idx_shop_order_status`(`status`) USING BTREE,
  INDEX `idx_shop_order_deleted`(`deleted`) USING BTREE,
  INDEX `idx_shop_order_orderno`(`order_no`) USING BTREE,
  INDEX `idx_shop_order_cancel_status`(`cancel_status`) USING BTREE,
  INDEX `idx_shop_order_payment_status`(`payment_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-订单-内容' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_order
-- ----------------------------

-- ----------------------------
-- Table structure for shop_order_item
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_item`;
CREATE TABLE `shop_order_item`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户编号',
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单单号',
  `goods_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品名称',
  `goods_cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品图片',
  `goods_sku` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品SKU',
  `goods_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品编号',
  `goods_spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '商品规格',
  `price_market` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '市场单价',
  `price_selling` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '销售单价',
  `total_market` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '市场总价',
  `total_selling` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '销售总价',
  `truck_count` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '快递计费基数',
  `truck_tcode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递邮费模板',
  `stock_sales` bigint(20) UNSIGNED NULL DEFAULT 1 COMMENT '购买商品数量',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1使用,0禁用)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_order_item_status`(`status`) USING BTREE,
  INDEX `idx_shop_order_item_deleted`(`deleted`) USING BTREE,
  INDEX `idx_shop_order_item_order_no`(`order_no`) USING BTREE,
  INDEX `idx_shop_order_item_goods_sku`(`goods_sku`) USING BTREE,
  INDEX `idx_shop_order_item_goods_code`(`goods_code`) USING BTREE,
  INDEX `idx_shop_order_item_goods_spec`(`goods_spec`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-订单-商品' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for shop_order_send
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_send`;
CREATE TABLE `shop_order_send`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '用户编号',
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单订单',
  `address_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送地址编号',
  `address_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送收货人姓名',
  `address_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送收货人手机',
  `address_province` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送地址的省份',
  `address_city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送地址的城市',
  `address_area` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送地址的区域',
  `address_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送的详细地址',
  `address_datetime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '地址确认时间',
  `template_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送模板编号',
  `template_count` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '快递计费基数',
  `template_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配送计算描述',
  `template_amount` decimal(20, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '配送计算金额',
  `company_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递公司编码',
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递公司名称',
  `send_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递运送单号',
  `send_remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递发送备注',
  `send_datetime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '快递发送时间',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '商品状态(1使用,0禁用)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_order_send_mid`(`uid`) USING BTREE,
  INDEX `idx_shop_order_send_status`(`status`) USING BTREE,
  INDEX `idx_shop_order_send_deleted`(`deleted`) USING BTREE,
  INDEX `idx_shop_order_send_order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-订单-配送' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_order_send
-- ----------------------------

-- ----------------------------
-- Table structure for shop_order_service
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_service`;
CREATE TABLE `shop_order_service`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `send_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章标题',
  `mark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章标签',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章封面',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注说明',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容',
  `num_like` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章点赞数',
  `num_read` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章阅读数',
  `num_collect` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章收藏数',
  `num_comment` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '文章评论数',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '记录状态(1使用,0禁用)',
  `deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除状态(0未删,1已删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_data_news_item_status`(`status`) USING BTREE,
  INDEX `idx_data_news_item_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-订单-售后' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_order_service
-- ----------------------------

-- ----------------------------
-- Table structure for shop_truck_company
-- ----------------------------
DROP TABLE IF EXISTS `shop_truck_company`;
CREATE TABLE `shop_truck_company`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '快递公司名称',
  `code_1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '快递公司代码',
  `code_2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '百度快递100代码',
  `code_3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '官方快递100代码',
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '快递公司描述',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0.无效,1.有效)',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(1已删除,0未删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_truck_company_code1`(`code_1`) USING BTREE,
  INDEX `idx_shop_truck_company_code2`(`code_2`) USING BTREE,
  INDEX `idx_shop_truck_company_code3`(`code_3`) USING BTREE,
  INDEX `idx_shop_truck_company_status`(`status`) USING BTREE,
  INDEX `idx_shop_truck_company_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城-快递-公司' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_truck_company
-- ----------------------------

-- ----------------------------
-- Table structure for shop_truck_region
-- ----------------------------
DROP TABLE IF EXISTS `shop_truck_region`;
CREATE TABLE `shop_truck_region`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '上级PID',
  `first` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '首字母',
  `short` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '区域简称',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '区域名称',
  `level` tinyint(4) NULL DEFAULT 0 COMMENT '区域层级',
  `pinyin` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '区域拼音',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '区域邮编',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '使用状态',
  `lng` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '所在经度',
  `lat` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '所在纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_shop_truck_region_pid`(`pid`) USING BTREE,
  INDEX `idx_shop_truck_region_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4019 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城-快递-区域' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_truck_region
-- ----------------------------

-- ----------------------------
-- Table structure for shop_truck_template
-- ----------------------------
DROP TABLE IF EXISTS `shop_truck_template`;
CREATE TABLE `shop_truck_template`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模板编号',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模板名称',
  `normal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '默认规则',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '模板规则',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '模板状态',
  `deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城-快递-模板' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of shop_truck_template
-- ----------------------------

-- ----------------------------
-- Table structure for system_auth
-- ----------------------------
DROP TABLE IF EXISTS `system_auth`;
CREATE TABLE `system_auth`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限名称',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注说明',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '权限状态(1使用,0禁用)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_system_auth_title`(`title`) USING BTREE,
  INDEX `idx_system_auth_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-权限' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_auth
-- ----------------------------

-- ----------------------------
-- Table structure for system_auth_node
-- ----------------------------
DROP TABLE IF EXISTS `system_auth_node`;
CREATE TABLE `system_auth_node`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `auth` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '角色',
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '节点',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_system_auth_auth`(`auth`) USING BTREE,
  INDEX `idx_system_auth_node`(`node`(191)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-授权' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_auth_node
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '分类',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置名',
  `value` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置值',
  INDEX `idx_system_config_type`(`type`) USING BTREE,
  INDEX `idx_system_config_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-配置' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('base', 'app_name', 'XXadmin');
INSERT INTO `system_config` VALUES ('base', 'app_version', 'vX');
INSERT INTO `system_config` VALUES ('base', 'beian', '');
INSERT INTO `system_config` VALUES ('base', 'miitbeian', '');
INSERT INTO `system_config` VALUES ('base', 'site_copy', '');
INSERT INTO `system_config` VALUES ('base', 'site_icon', '');
INSERT INTO `system_config` VALUES ('base', 'site_main_title', '');
INSERT INTO `system_config` VALUES ('base', 'site_name', '');
INSERT INTO `system_config` VALUES ('base', 'site_sub_title', '');
INSERT INTO `system_config` VALUES ('base', 'xpath', 'admin');
INSERT INTO `system_config` VALUES ('storage', 'allow_exts', 'doc,gif,icon,jpg,mp3,mp4,p12,pem,png,rar,xls,xlsx');
INSERT INTO `system_config` VALUES ('storage', 'link_type', 'none+compress');
INSERT INTO `system_config` VALUES ('storage', 'local_http_domain', '');
INSERT INTO `system_config` VALUES ('storage', 'local_http_protocol', 'follow');
INSERT INTO `system_config` VALUES ('storage', 'qiniu_access_key', '');
INSERT INTO `system_config` VALUES ('storage', 'qiniu_bucket', '');
INSERT INTO `system_config` VALUES ('storage', 'qiniu_http_domain', '');
INSERT INTO `system_config` VALUES ('storage', 'qiniu_http_protocol', 'http');
INSERT INTO `system_config` VALUES ('storage', 'qiniu_region', '');
INSERT INTO `system_config` VALUES ('storage', 'qiniu_secret_key', '');
INSERT INTO `system_config` VALUES ('storage', 'type', 'local');
INSERT INTO `system_config` VALUES ('wechat', 'thr_appid', '');
INSERT INTO `system_config` VALUES ('wechat', 'thr_appkey', '');
INSERT INTO `system_config` VALUES ('wechat', 'type', 'thr');

-- ----------------------------
-- Table structure for system_data
-- ----------------------------
DROP TABLE IF EXISTS `system_data`;
CREATE TABLE `system_data`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置名',
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配置值',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_system_data_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-数据' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_data
-- ----------------------------

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '上级ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `node` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '节点代码',
  `url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接节点',
  `params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '_self' COMMENT '打开方式',
  `sort` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '排序权重',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0:禁用,1:启用)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_system_menu_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-菜单' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `system_menu` VALUES (2, 0, '系统管理', '', '', '#', '', '_self', 100, 1, '2018-09-05 18:04:52');
INSERT INTO `system_menu` VALUES (3, 4, '系统菜单管理', 'layui-icon layui-icon-layouts', '', 'admin/menu/index', '', '_self', 1, 1, '2018-09-05 18:05:26');
INSERT INTO `system_menu` VALUES (4, 2, '系统配置', '', '', '#', '', '_self', 20, 1, '2018-09-05 18:07:17');
INSERT INTO `system_menu` VALUES (5, 12, '系统用户管理', 'layui-icon layui-icon-username', '', 'admin/user/index', '', '_self', 1, 1, '2018-09-06 11:10:42');
INSERT INTO `system_menu` VALUES (7, 12, '访问权限管理', 'layui-icon layui-icon-vercode', '', 'admin/auth/index', '', '_self', 2, 1, '2018-09-06 15:17:14');
INSERT INTO `system_menu` VALUES (11, 4, '系统参数配置', 'layui-icon layui-icon-set', '', 'admin/config/index', '', '_self', 4, 1, '2018-09-06 16:43:47');
INSERT INTO `system_menu` VALUES (12, 2, '权限管理', '', '', '#', '', '_self', 10, 1, '2018-09-06 18:01:31');
INSERT INTO `system_menu` VALUES (27, 4, '系统任务管理', 'layui-icon layui-icon-log', '', 'admin/queue/index', '', '_self', 3, 0, '2018-11-29 11:13:34');
INSERT INTO `system_menu` VALUES (49, 4, '系统日志管理', 'layui-icon layui-icon-form', '', 'admin/oplog/index', '', '_self', 2, 1, '2019-02-18 12:56:56');
INSERT INTO `system_menu` VALUES (56, 0, '微信管理', '', '', '#', '', '_self', 200, 0, '2019-12-09 11:00:37');
INSERT INTO `system_menu` VALUES (57, 56, '微信管理', '', '', '#', '', '_self', 0, 0, '2019-12-09 13:56:58');
INSERT INTO `system_menu` VALUES (58, 57, '微信接口配置', 'layui-icon layui-icon-set', '', 'wechat/config/options', '', '_self', 0, 0, '2019-12-09 13:57:28');
INSERT INTO `system_menu` VALUES (59, 57, '微信支付配置', 'layui-icon layui-icon-rmb', '', 'wechat/config/payment', '', '_self', 0, 0, '2019-12-09 13:58:42');
INSERT INTO `system_menu` VALUES (60, 56, '微信定制', '', '', '#', '', '_self', 0, 0, '2019-12-09 18:35:16');
INSERT INTO `system_menu` VALUES (61, 60, '微信粉丝管理', 'layui-icon layui-icon-username', '', 'wechat/fans/index', '', '_self', 0, 0, '2019-12-09 18:35:37');
INSERT INTO `system_menu` VALUES (62, 60, '微信图文管理', 'layui-icon layui-icon-template-1', '', 'wechat/news/index', '', '_self', 0, 0, '2019-12-09 18:43:51');
INSERT INTO `system_menu` VALUES (63, 60, '微信菜单配置', 'layui-icon layui-icon-cellphone', '', 'wechat/menu/index', '', '_self', 0, 0, '2019-12-09 22:49:28');
INSERT INTO `system_menu` VALUES (64, 60, '回复规则管理', 'layui-icon layui-icon-engine', '', 'wechat/keys/index', '', '_self', 0, 0, '2019-12-14 14:09:04');
INSERT INTO `system_menu` VALUES (65, 60, '关注回复配置', 'layui-icon layui-icon-senior', '', 'wechat/keys/subscribe', '', '_self', 0, 0, '2019-12-14 14:10:31');
INSERT INTO `system_menu` VALUES (66, 60, '默认回复配置', 'layui-icon layui-icon-util', '', 'wechat/keys/defaults', '', '_self', 0, 0, '2019-12-14 14:11:18');
INSERT INTO `system_menu` VALUES (67, 0, '控制台', '', '', '#', '', '_self', 300, 1, '2020-07-13 06:51:46');
INSERT INTO `system_menu` VALUES (68, 67, '数据管理（接口案例）', '', '', '#', '', '_self', 0, 1, '2020-07-13 06:51:54');
INSERT INTO `system_menu` VALUES (69, 68, '文章标签管理', 'layui-icon layui-icon-note', '', 'data/news_mark/index', '', '_self', 998, 1, '2020-07-13 06:52:09');
INSERT INTO `system_menu` VALUES (70, 68, '文章内容管理', 'layui-icon layui-icon-template', '', 'data/news_item/index', '', '_self', 997, 1, '2020-07-13 06:52:26');
INSERT INTO `system_menu` VALUES (71, 68, '图片管理', 'layui-icon layui-icon-carousel', '', 'data/picture_item/index', '', '_self', 995, 1, '2020-07-14 01:17:02');
INSERT INTO `system_menu` VALUES (73, 67, '商城管理（开发中）', '', '', '#', '', '_self', 0, 0, '2020-09-08 02:51:30');
INSERT INTO `system_menu` VALUES (74, 73, '商品分类管理', 'layui-icon layui-icon-app', 'data/shop_goods_cate/index', 'data/shop_goods_cate/index', '', '_self', 80, 0, '2020-09-08 02:51:49');
INSERT INTO `system_menu` VALUES (75, 73, '商品标签管理', 'layui-icon layui-icon-form', 'data/shop_goods_mark/index', 'data/shop_goods_mark/index', '', '_self', 70, 0, '2020-09-08 03:35:58');
INSERT INTO `system_menu` VALUES (76, 73, '商品数据管理', 'layui-icon layui-icon-star', 'data/shop_goods/index', 'data/shop_goods/index', '', '_self', 90, 0, '2020-09-08 07:13:19');
INSERT INTO `system_menu` VALUES (77, 73, '会员用户管理', 'layui-icon layui-icon-user', 'data/user/index', 'data/user/index', '', '_self', 100, 0, '2020-09-10 01:48:02');
INSERT INTO `system_menu` VALUES (78, 73, '订单数据管理', 'layui-icon layui-icon-template-1', 'data/shop_order/index', 'data/shop_order/index', '', '_self', 60, 0, '2020-09-10 01:48:41');
INSERT INTO `system_menu` VALUES (79, 73, '订单发货管理', 'layui-icon layui-icon-transfer', 'data/shop_order_send/index', 'data/shop_order_send/index', '', '_self', 50, 0, '2020-09-10 01:50:12');
INSERT INTO `system_menu` VALUES (80, 73, '售后申请管理', 'layui-icon layui-icon-diamond', 'data/shop_order_service/index', 'data/shop_order_service/index', '', '_self', 40, 0, '2020-09-10 01:53:16');
INSERT INTO `system_menu` VALUES (81, 73, '快递公司管理', 'layui-icon layui-icon-website', 'data/shop_truck_company/index', 'data/shop_truck_company/index', '', '_self', 0, 0, '2020-09-15 08:47:46');
INSERT INTO `system_menu` VALUES (82, 73, '邮费模板管理', 'layui-icon layui-icon-template-1', 'data/shop_truck_template/index', 'data/shop_truck_template/index', '', '_self', 0, 0, '2020-09-15 09:14:46');
INSERT INTO `system_menu` VALUES (83, 73, '配送区域管理', 'layui-icon layui-icon-location', 'data/shop_truck_template/region', 'data/shop_truck_template/region', '', '_self', 0, 0, '2020-09-17 09:13:35');
INSERT INTO `system_menu` VALUES (84, 68, '微信小程序配置', 'layui-icon layui-icon-set', 'data/config/wxapp', 'data/config/wxapp', '', '_self', 5, 0, '2020-09-21 16:34:08');
INSERT INTO `system_menu` VALUES (85, 68, '会员服务协议', 'layui-icon layui-icon-template-1', 'data/config/agreement', 'data/config/agreement', '', '_self', 30, 0, '2020-09-22 16:00:10');
INSERT INTO `system_menu` VALUES (86, 68, '关于我们描述', 'layui-icon layui-icon-app', 'data/config/about', 'data/config/about', '', '_self', 40, 0, '2020-09-22 16:12:44');
INSERT INTO `system_menu` VALUES (87, 68, '支付通道管理', 'layui-icon layui-icon-set-sm', 'data/payment/index', 'data/payment/index', '', '_self', 6, 0, '2020-12-12 09:08:09');
INSERT INTO `system_menu` VALUES (88, 68, '文章分类管理', 'fa fa-tasks', '', 'data/news_category/index', '', '_self', 999, 1, '2020-12-22 10:49:16');
INSERT INTO `system_menu` VALUES (89, 68, '友情链接管理', 'fa fa-users', '', 'data/friend/index', '', '_self', 994, 1, '2020-12-28 10:04:44');
INSERT INTO `system_menu` VALUES (90, 68, '图片分类管理', 'layui-icon layui-icon-picture', '', 'data/picture_category/index', '', '_self', 996, 1, '2020-12-29 17:02:27');

-- ----------------------------
-- Table structure for system_oplog
-- ----------------------------
DROP TABLE IF EXISTS `system_oplog`;
CREATE TABLE `system_oplog`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `geoip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `action` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作行为名称',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作内容描述',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `create_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-日志' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_oplog
-- ----------------------------
INSERT INTO `system_oplog` VALUES (36, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-28 11:43:14');
INSERT INTO `system_oplog` VALUES (37, 'admin/config/storage', '127.0.0.1', '系统配置管理', '修改系统存储参数', 'admin', '2020-12-28 11:43:46');
INSERT INTO `system_oplog` VALUES (38, 'admin/api.plugs/debug', '127.0.0.1', '系统运维管理', '由开发模式切换为产品模式', 'admin', '2020-12-28 11:43:51');
INSERT INTO `system_oplog` VALUES (39, 'admin/api.plugs/clearconfig', '127.0.0.1', '系统运维管理', '清理系统参数配置成功', 'admin', '2020-12-28 11:44:02');
INSERT INTO `system_oplog` VALUES (40, 'admin/config/system', '127.0.0.1', '系统配置管理', '修改系统参数成功', 'admin', '2020-12-28 11:46:24');
INSERT INTO `system_oplog` VALUES (41, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '禁用系统菜单[86]成功', 'admin', '2020-12-28 11:47:29');
INSERT INTO `system_oplog` VALUES (42, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '禁用系统菜单[85]成功', 'admin', '2020-12-28 11:47:35');
INSERT INTO `system_oplog` VALUES (43, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '禁用系统菜单[87]成功', 'admin', '2020-12-28 11:47:39');
INSERT INTO `system_oplog` VALUES (44, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '禁用系统菜单[84]成功', 'admin', '2020-12-28 11:47:44');
INSERT INTO `system_oplog` VALUES (45, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '禁用系统菜单[73,77,76,74,75,78,79,80,81,82,83]成功', 'admin', '2020-12-28 11:47:58');
INSERT INTO `system_oplog` VALUES (46, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '禁用系统菜单[56,57,58,59,60,61,62,63,64,65,66]成功', 'admin', '2020-12-28 11:48:16');
INSERT INTO `system_oplog` VALUES (47, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '禁用系统菜单[27]成功', 'admin', '2020-12-28 11:48:39');
INSERT INTO `system_oplog` VALUES (48, 'admin/user/edit', '127.0.0.1', '系统用户管理', '修改系统用户[10000]成功', 'admin', '2020-12-28 11:50:01');
INSERT INTO `system_oplog` VALUES (49, 'admin/login/index', '111.194.48.153', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-29 01:09:43');
INSERT INTO `system_oplog` VALUES (50, 'admin/user/pass', '111.194.48.153', '系统用户管理', '修改用户[10000]密码成功', 'admin', '2020-12-29 01:09:54');
INSERT INTO `system_oplog` VALUES (51, 'admin/user/pass', '111.194.48.153', '系统用户管理', '修改用户[10000]密码成功', 'admin', '2020-12-29 01:10:55');
INSERT INTO `system_oplog` VALUES (52, 'admin/login/index', '111.194.48.153', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-29 01:11:09');
INSERT INTO `system_oplog` VALUES (53, 'admin/user/edit', '111.194.48.153', '系统用户管理', '修改系统用户[10000]成功', 'admin', '2020-12-29 01:14:28');
INSERT INTO `system_oplog` VALUES (54, 'admin/api.plugs/debug', '111.194.48.153', '系统运维管理', '由开发模式切换为产品模式', 'admin', '2020-12-29 01:15:48');
INSERT INTO `system_oplog` VALUES (55, 'admin/config/storage', '111.194.48.153', '系统配置管理', '修改系统存储参数', 'admin', '2020-12-29 01:17:18');
INSERT INTO `system_oplog` VALUES (56, 'admin/api.plugs/clearconfig', '111.194.48.153', '系统运维管理', '清理系统参数配置成功', 'admin', '2020-12-29 01:17:25');
INSERT INTO `system_oplog` VALUES (57, 'admin/config/system', '111.194.48.153', '系统配置管理', '修改系统参数成功', 'admin', '2020-12-29 01:23:56');
INSERT INTO `system_oplog` VALUES (58, 'admin/user/edit', '111.194.48.153', '系统用户管理', '修改系统用户[10000]成功', 'admin', '2020-12-29 01:26:19');
INSERT INTO `system_oplog` VALUES (59, 'admin/login/index', '111.194.48.153', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-29 02:19:47');
INSERT INTO `system_oplog` VALUES (60, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-29 09:38:25');
INSERT INTO `system_oplog` VALUES (61, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-29 16:50:33');
INSERT INTO `system_oplog` VALUES (62, 'admin/menu/add', '103.216.43.5', '系统菜单管理', '添加系统菜单[90]成功', 'admin', '2020-12-29 17:00:10');
INSERT INTO `system_oplog` VALUES (63, 'admin/api.plugs/debug', '103.216.43.5', '系统运维管理', '由产品模式切换为开发模式', 'admin', '2020-12-29 17:01:04');
INSERT INTO `system_oplog` VALUES (64, 'admin/login/index', '111.194.48.153', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-29 20:38:36');
INSERT INTO `system_oplog` VALUES (65, 'admin/login/index', '111.194.48.153', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-29 20:40:04');
INSERT INTO `system_oplog` VALUES (66, 'admin/menu/edit', '111.194.48.153', '系统菜单管理', '修改系统菜单[90]成功', 'admin', '2020-12-29 20:42:31');
INSERT INTO `system_oplog` VALUES (67, 'admin/menu/edit', '111.194.48.153', '系统菜单管理', '修改系统菜单[71]成功', 'admin', '2020-12-29 20:42:51');
INSERT INTO `system_oplog` VALUES (68, 'admin/menu/edit', '111.194.48.153', '系统菜单管理', '修改系统菜单[71]成功', 'admin', '2020-12-29 20:42:59');
INSERT INTO `system_oplog` VALUES (69, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-30 10:15:27');
INSERT INTO `system_oplog` VALUES (70, 'admin/login/index', '106.121.187.167', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-30 18:48:30');
INSERT INTO `system_oplog` VALUES (71, 'admin/api.plugs/clearconfig', '106.121.187.167', '系统运维管理', '清理系统参数配置成功', 'admin', '2020-12-30 18:48:48');
INSERT INTO `system_oplog` VALUES (72, 'admin/config/system', '106.121.187.167', '系统配置管理', '修改系统参数成功', 'admin', '2020-12-30 18:49:17');
INSERT INTO `system_oplog` VALUES (73, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-31 09:57:40');
INSERT INTO `system_oplog` VALUES (74, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2020-12-31 16:24:52');
INSERT INTO `system_oplog` VALUES (75, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-04 18:16:17');
INSERT INTO `system_oplog` VALUES (76, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-04 18:22:16');
INSERT INTO `system_oplog` VALUES (77, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-05 09:23:25');
INSERT INTO `system_oplog` VALUES (78, 'admin/api.plugs/debug', '103.216.43.5', '系统运维管理', '由开发模式切换为产品模式', 'admin', '2021-01-05 16:49:45');
INSERT INTO `system_oplog` VALUES (79, 'admin/config/system', '103.216.43.5', '系统配置管理', '修改系统参数成功', 'admin', '2021-01-05 16:54:30');
INSERT INTO `system_oplog` VALUES (80, 'admin/config/system', '103.216.43.5', '系统配置管理', '修改系统参数成功', 'admin', '2021-01-05 16:56:34');
INSERT INTO `system_oplog` VALUES (81, 'admin/login/index', '106.121.67.70', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-06 08:36:19');
INSERT INTO `system_oplog` VALUES (82, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-06 11:09:54');
INSERT INTO `system_oplog` VALUES (83, 'admin/config/system', '103.216.43.5', '系统配置管理', '修改系统参数成功', 'admin', '2021-01-06 11:10:07');
INSERT INTO `system_oplog` VALUES (84, 'admin/config/system', '103.216.43.5', '系统配置管理', '修改系统参数成功', 'admin', '2021-01-06 11:10:35');
INSERT INTO `system_oplog` VALUES (85, 'admin/config/system', '103.216.43.5', '系统配置管理', '修改系统参数成功', 'admin', '2021-01-06 11:11:05');
INSERT INTO `system_oplog` VALUES (86, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-06 11:13:01');
INSERT INTO `system_oplog` VALUES (87, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-06 15:34:13');
INSERT INTO `system_oplog` VALUES (88, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-08 10:35:52');
INSERT INTO `system_oplog` VALUES (89, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-08 16:06:48');
INSERT INTO `system_oplog` VALUES (90, 'admin/login/index', '103.216.43.5', '系统用户登录', '登录系统后台成功', 'admin', '2021-01-13 17:51:54');
INSERT INTO `system_oplog` VALUES (91, 'admin/api.plugs/debug', '103.216.43.5', '系统运维管理', '由产品模式切换为开发模式', 'admin', '2021-01-13 17:51:58');
INSERT INTO `system_oplog` VALUES (92, 'admin/api.plugs/debug', '103.216.43.5', '系统运维管理', '由开发模式切换为产品模式', 'admin', '2021-01-13 17:52:18');
INSERT INTO `system_oplog` VALUES (93, 'admin/api.plugs/debug', '103.216.43.5', '系统运维管理', '由产品模式切换为开发模式', 'admin', '2021-01-13 17:57:27');
INSERT INTO `system_oplog` VALUES (94, 'admin/api.plugs/debug', '103.216.43.5', '系统运维管理', '由开发模式切换为产品模式', 'admin', '2021-01-13 17:58:59');

-- ----------------------------
-- Table structure for system_queue
-- ----------------------------
DROP TABLE IF EXISTS `system_queue`;
CREATE TABLE `system_queue`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务编号',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `command` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '执行指令',
  `exec_pid` bigint(20) NULL DEFAULT 0 COMMENT '执行进程',
  `exec_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '执行参数',
  `exec_time` bigint(20) NULL DEFAULT 0 COMMENT '执行时间',
  `exec_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '执行描述',
  `enter_time` decimal(20, 4) NULL DEFAULT 0.0000 COMMENT '开始时间',
  `outer_time` decimal(20, 4) NULL DEFAULT 0.0000 COMMENT '结束时间',
  `loops_time` bigint(20) NULL DEFAULT 0 COMMENT '循环时间',
  `attempts` bigint(20) NULL DEFAULT 0 COMMENT '执行次数',
  `rscript` tinyint(1) NULL DEFAULT 1 COMMENT '任务类型(0单例,1多例)',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '任务状态(1新任务,2处理中,3成功,4失败)',
  `create_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_system_queue_code`(`code`) USING BTREE,
  INDEX `idx_system_queue_title`(`title`) USING BTREE,
  INDEX `idx_system_queue_status`(`status`) USING BTREE,
  INDEX `idx_system_queue_rscript`(`rscript`) USING BTREE,
  INDEX `idx_system_queue_create_at`(`create_at`) USING BTREE,
  INDEX `idx_system_queue_exec_time`(`exec_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-任务' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_queue
-- ----------------------------

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `headimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `authorize` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限授权',
  `contact_qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系QQ',
  `contact_mail` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系邮箱',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系手机',
  `login_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地址',
  `login_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录时间',
  `login_num` bigint(20) NULL DEFAULT 0 COMMENT '登录次数',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注说明',
  `extra` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '附加信息',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态(0禁用,1启用)',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '排序权重',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除(1删除,0未删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_system_user_username`(`username`) USING BTREE,
  INDEX `idx_system_user_deleted`(`is_deleted`) USING BTREE,
  INDEX `idx_system_user_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-用户' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES (10000, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'an0nymou5', 'https://s3.ax1x.com/2021/01/15/s0toFg.jpg', ',,', '123456', '123456@qq.com', '13012345678', '127.0.0.1', '2021-01-13 17:51:54', 71, '一个没有感情的酒精容器。', '{\"github\":\"https:\\/\\/github.com\\/LazyShiro\",\"music\":\"https:\\/\\/music.163.com\\/#\\/user\\/home?id=299958456\",\"weibo\":\"https:\\/\\/weibo.com\\/834723015\"}', 1, 0, 0, '2015-11-13 15:14:22');

-- ----------------------------
-- Table structure for wechat_fans
-- ----------------------------
DROP TABLE IF EXISTS `wechat_fans`;
CREATE TABLE `wechat_fans`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '粉丝unionid',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '粉丝openid',
  `tagid_list` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '粉丝标签id',
  `is_black` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '是否为黑名单状态',
  `subscribe` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '关注状态(0未关注,1已关注)',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `sex` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '用户性别(1男性,2女性,0未知)',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户所在国家',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户所在省份',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户所在城市',
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户的语言(zh_CN)',
  `headimgurl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像',
  `subscribe_time` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '关注时间',
  `subscribe_at` datetime(0) NULL DEFAULT NULL COMMENT '关注时间',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `subscribe_scene` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扫码关注场景',
  `qr_scene` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维码场景值',
  `qr_scene_str` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维码场景内容',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_fans_openid`(`openid`) USING BTREE,
  INDEX `index_wechat_fans_unionid`(`unionid`) USING BTREE,
  INDEX `index_wechat_fans_subscribe`(`subscribe`) USING BTREE,
  INDEX `index_wechat_fans_isblack`(`is_black`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-粉丝' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of wechat_fans
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_fans_tags
-- ----------------------------
DROP TABLE IF EXISTS `wechat_fans_tags`;
CREATE TABLE `wechat_fans_tags`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `name` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  `count` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '总数',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建日期',
  INDEX `index_wechat_fans_tags_id`(`id`) USING BTREE,
  INDEX `index_wechat_fans_tags_appid`(`appid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-标签' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of wechat_fans_tags
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_keys
-- ----------------------------
DROP TABLE IF EXISTS `wechat_keys`;
CREATE TABLE `wechat_keys`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型(text,image,news)',
  `keys` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文本内容',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片链接',
  `voice_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '语音链接',
  `music_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐标题',
  `music_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐链接',
  `music_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图片',
  `music_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐描述',
  `video_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频标题',
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频URL',
  `video_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频描述',
  `news_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '图文ID',
  `sort` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '排序字段',
  `status` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '状态(0禁用,1启用)',
  `create_by` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_keys_appid`(`appid`) USING BTREE,
  INDEX `index_wechat_keys_type`(`type`) USING BTREE,
  INDEX `index_wechat_keys_keys`(`keys`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-规则' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of wechat_keys
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_media
-- ----------------------------
DROP TABLE IF EXISTS `wechat_media`;
CREATE TABLE `wechat_media`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号ID',
  `md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件md5',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '媒体类型',
  `media_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '本地文件链接',
  `media_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '远程图片链接',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_media_appid`(`appid`) USING BTREE,
  INDEX `index_wechat_media_md5`(`md5`) USING BTREE,
  INDEX `index_wechat_media_type`(`type`) USING BTREE,
  INDEX `index_wechat_media_media_id`(`media_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-素材' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of wechat_media
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_news
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news`;
CREATE TABLE `wechat_news`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材外网URL',
  `article_id` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关联图文ID(用英文逗号做分割)',
  `is_deleted` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '删除状态(0未删除,1已删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_wechat_news_artcle_id`(`article_id`) USING BTREE,
  INDEX `index_wechat_news_media_id`(`media_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-图文' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of wechat_news
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_news_article
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news_article`;
CREATE TABLE `wechat_news_article`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '素材标题',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材显示URL',
  `show_cover_pic` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '显示封面(0不显示,1显示)',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章作者',
  `digest` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '摘要内容',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图文内容',
  `content_source_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '原文地址',
  `read_num` bigint(20) UNSIGNED NULL DEFAULT 0 COMMENT '阅读数量',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-文章' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of wechat_news_article
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
