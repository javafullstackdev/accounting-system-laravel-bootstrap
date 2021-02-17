/*
 Navicat MySQL Data Transfer

 Source Server         : DB
 Source Server Type    : MySQL
 Source Server Version : 100137
 Source Host           : localhost:3306
 Source Schema         : accsys

 Target Server Type    : MySQL
 Target Server Version : 100137
 File Encoding         : 65001

 Date: 19/02/2019 21:36:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bank
-- ----------------------------
INSERT INTO `bank` VALUES (3, 8, 'Beijing Bank', NULL, '2019-02-11 21:45:37', '2019-02-11 21:45:37');

-- ----------------------------
-- Table structure for barcodes
-- ----------------------------
DROP TABLE IF EXISTS `barcodes`;
CREATE TABLE `barcodes`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `width` double(8, 2) NULL DEFAULT NULL,
  `height` double(8, 2) NULL DEFAULT NULL,
  `paper_width` double(8, 2) NULL DEFAULT NULL,
  `paper_height` double(8, 2) NULL DEFAULT NULL,
  `top_margin` double(8, 2) NULL DEFAULT NULL,
  `left_margin` double(8, 2) NULL DEFAULT NULL,
  `row_distance` double(8, 2) NULL DEFAULT NULL,
  `col_distance` double(8, 2) NULL DEFAULT NULL,
  `stickers_in_one_row` int(11) NULL DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) NULL DEFAULT NULL,
  `business_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `barcodes_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `barcodes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of barcodes
-- ----------------------------
INSERT INTO `barcodes` VALUES (1, '20 Labels per Sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 4\" x 1\"\\r\\nLabels per sheet: 20', 3.75, 1.00, 8.50, 11.00, 0.50, 0.50, 0.00, 0.16, 2, 0, 0, 20, NULL, '2017-12-18 08:43:44', '2017-12-18 08:43:44');
INSERT INTO `barcodes` VALUES (2, '30 Labels per sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 2.625\" x 1\"\\r\\nLabels per sheet: 30', 2.62, 1.00, 8.50, 11.00, 0.50, 0.22, 0.00, 0.14, 3, 0, 0, 30, NULL, '2017-12-18 08:34:39', '2017-12-18 08:40:40');
INSERT INTO `barcodes` VALUES (3, '32 Labels per sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 2\" x 1.25\"\\r\\nLabels per sheet: 32', 2.00, 1.25, 8.50, 11.00, 0.50, 0.25, 0.00, 0.00, 4, 0, 0, 32, NULL, '2017-12-18 08:25:40', '2017-12-18 08:25:40');
INSERT INTO `barcodes` VALUES (4, '40 Labels per sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 2\" x 1\"\\r\\nLabels per sheet: 40', 2.00, 1.00, 8.50, 11.00, 0.50, 0.25, 0.00, 0.00, 4, 0, 0, 40, NULL, '2017-12-18 08:28:40', '2017-12-18 08:28:40');
INSERT INTO `barcodes` VALUES (5, '50 Labels per Sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 1.5\" x 1\"\\r\\nLabels per sheet: 50', 1.50, 1.00, 8.50, 11.00, 0.50, 0.50, 0.00, 0.00, 5, 0, 0, 50, NULL, '2017-12-18 08:21:10', '2017-12-18 08:21:10');
INSERT INTO `barcodes` VALUES (6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm\\r\\nGap: 3.18mm', 1.25, 1.00, 1.25, 0.00, 0.12, 0.00, 0.12, 0.00, 1, 0, 1, NULL, NULL, '2017-12-18 08:21:10', '2017-12-18 08:21:10');

-- ----------------------------
-- Table structure for bookings
-- ----------------------------
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) UNSIGNED NOT NULL,
  `waiter_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `table_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `correspondent_id` int(11) NULL DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `booking_start` datetime(0) NOT NULL,
  `booking_end` datetime(0) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `booking_status` enum('booked','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bookings_contact_id_foreign`(`contact_id`) USING BTREE,
  INDEX `bookings_business_id_foreign`(`business_id`) USING BTREE,
  INDEX `bookings_created_by_foreign`(`created_by`) USING BTREE,
  CONSTRAINT `bookings_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bookings_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bookings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for brands
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `brands_business_id_foreign`(`business_id`) USING BTREE,
  INDEX `brands_created_by_foreign`(`created_by`) USING BTREE,
  CONSTRAINT `brands_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `brands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (1, 1, 'Levis', NULL, 1, NULL, '2018-01-03 23:49:47', '2018-01-03 23:49:47');
INSERT INTO `brands` VALUES (2, 1, 'Espirit', NULL, 1, NULL, '2018-01-03 23:49:58', '2018-01-03 23:49:58');
INSERT INTO `brands` VALUES (3, 1, 'U.S. Polo Assn.', NULL, 1, NULL, '2018-01-03 23:50:26', '2018-01-03 23:50:26');
INSERT INTO `brands` VALUES (4, 1, 'Nike', NULL, 1, NULL, '2018-01-03 23:50:34', '2018-01-03 23:50:34');
INSERT INTO `brands` VALUES (5, 1, 'Puma', NULL, 1, NULL, '2018-01-03 23:50:40', '2018-01-03 23:50:40');
INSERT INTO `brands` VALUES (6, 1, 'Adidas', NULL, 1, NULL, '2018-01-03 23:50:46', '2018-01-03 23:50:46');
INSERT INTO `brands` VALUES (7, 1, 'Samsung', NULL, 1, NULL, '2018-01-06 08:10:14', '2018-01-06 08:10:14');
INSERT INTO `brands` VALUES (8, 1, 'Apple', NULL, 1, NULL, '2018-01-06 08:10:23', '2018-01-06 08:10:23');
INSERT INTO `brands` VALUES (9, 1, 'Acer', NULL, 1, NULL, '2018-01-06 08:33:37', '2018-01-06 08:33:37');
INSERT INTO `brands` VALUES (10, 1, 'Bowflex', NULL, 1, NULL, '2018-01-06 08:45:31', '2018-01-06 08:45:31');
INSERT INTO `brands` VALUES (11, 1, 'Oreo', NULL, 1, NULL, '2018-01-06 09:05:00', '2018-01-06 09:05:00');
INSERT INTO `brands` VALUES (12, 1, 'Sharewood', NULL, 1, NULL, '2018-01-06 09:10:52', '2018-01-06 09:10:52');
INSERT INTO `brands` VALUES (13, 1, 'Barilla', NULL, 1, NULL, '2018-01-06 09:14:59', '2018-01-06 09:14:59');
INSERT INTO `brands` VALUES (14, 1, 'Lipton', NULL, 1, NULL, '2018-01-06 09:18:12', '2018-01-06 09:18:12');
INSERT INTO `brands` VALUES (15, 2, 'Acino', NULL, 4, NULL, '2018-04-10 10:44:44', '2018-04-10 10:44:44');
INSERT INTO `brands` VALUES (16, 2, 'Cipla', NULL, 4, NULL, '2018-04-10 10:45:04', '2018-04-10 10:45:04');
INSERT INTO `brands` VALUES (17, 2, 'BAYER', NULL, 4, NULL, '2018-04-10 10:45:32', '2018-04-10 10:45:32');
INSERT INTO `brands` VALUES (18, 3, 'Samsung', NULL, 5, NULL, '2018-04-10 13:27:28', '2018-04-10 13:27:28');
INSERT INTO `brands` VALUES (19, 3, 'LG', NULL, 5, NULL, '2018-04-10 13:27:35', '2018-04-10 13:27:35');
INSERT INTO `brands` VALUES (20, 3, 'Apple', NULL, 5, NULL, '2018-04-10 13:27:42', '2018-04-10 13:27:42');
INSERT INTO `brands` VALUES (21, 3, 'Sony', NULL, 5, NULL, '2018-04-10 13:27:49', '2018-04-10 13:27:49');
INSERT INTO `brands` VALUES (22, 3, 'Panasonic', NULL, 5, NULL, '2018-04-10 13:27:57', '2018-04-10 13:27:57');
INSERT INTO `brands` VALUES (23, 3, 'HP', NULL, 5, NULL, '2018-04-10 13:37:21', '2018-04-10 13:37:21');
INSERT INTO `brands` VALUES (24, 1, 'Roche', NULL, 1, NULL, '2019-01-31 01:29:31', '2019-01-31 01:29:31');

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `start_date` date NULL DEFAULT NULL,
  `tax_number_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tax_label_1` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tax_number_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tax_label_2` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `default_sales_tax` int(10) UNSIGNED NULL DEFAULT NULL,
  `default_profit_percent` double(5, 2) NOT NULL DEFAULT 0.00,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `time_zone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `fy_start_month` tinyint(4) NOT NULL DEFAULT 1,
  `accounting_method` enum('fifo','lifo','avco') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fifo',
  `default_sales_discount` decimal(20, 2) NULL DEFAULT NULL,
  `sell_price_tax` enum('includes','excludes') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'includes',
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sku_prefix` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `enable_product_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `expiry_type` enum('add_expiry','add_manufacturing') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'add_expiry',
  `on_product_expiry` enum('keep_selling','stop_selling','auto_delete') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'keep_selling',
  `stop_selling_before` int(11) NOT NULL COMMENT 'Stop selling expied item n days before expiry',
  `enable_tooltip` tinyint(1) NOT NULL DEFAULT 1,
  `purchase_in_diff_currency` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Allow purchase to be in different currency then the business currency',
  `purchase_currency_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `p_exchange_rate` decimal(20, 3) NOT NULL DEFAULT 1.000,
  `transaction_edit_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `stock_expiry_alert_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `keyboard_shortcuts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `pos_settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `enable_brand` tinyint(1) NOT NULL DEFAULT 1,
  `enable_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_sub_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_price_tax` tinyint(1) NOT NULL DEFAULT 1,
  `enable_purchase_status` tinyint(1) NULL DEFAULT 1,
  `enable_lot_number` tinyint(1) NOT NULL DEFAULT 0,
  `default_unit` int(11) NULL DEFAULT NULL,
  `enable_racks` tinyint(1) NOT NULL DEFAULT 0,
  `enable_row` tinyint(1) NOT NULL DEFAULT 0,
  `enable_position` tinyint(1) NOT NULL DEFAULT 0,
  `enable_editing_product_from_purchase` tinyint(1) NOT NULL DEFAULT 1,
  `sales_cmsn_agnt` enum('logged_in_user','user','cmsn_agnt') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `item_addition_method` tinyint(1) NOT NULL DEFAULT 1,
  `enable_inline_tax` tinyint(1) NOT NULL DEFAULT 1,
  `currency_symbol_placement` enum('before','after') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'before',
  `enabled_modules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `date_format` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'm/d/Y',
  `time_format` enum('12','24') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '24',
  `ref_no_prefixes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `theme_color` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_by` int(11) NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `business_owner_id_foreign`(`owner_id`) USING BTREE,
  INDEX `business_currency_id_foreign`(`currency_id`) USING BTREE,
  INDEX `business_default_sales_tax_foreign`(`default_sales_tax`) USING BTREE,
  CONSTRAINT `business_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `business_default_sales_tax_foreign` FOREIGN KEY (`default_sales_tax`) REFERENCES `tax_rates` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `business_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of business
-- ----------------------------
INSERT INTO `business` VALUES (1, 'MY BUSINESS', 124, '2018-01-01', '3412569900', 'GSTIN', NULL, NULL, NULL, 0.00, 1, 'America/Phoenix', 1, 'fifo', 10.00, 'includes', 'k6mrRWdrpWiKaey3FNQQKxc1mklAuq6gXKGjMI7m.ico', 'AS', 1, 'add_expiry', 'stop_selling', 0, 1, 0, NULL, 1.000, 21, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_discount\":0,\"disable_order_tax\":0}', 1, 1, 0, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', 'null', 'm/d/Y', '12', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', 'purple', NULL, 1, '2018-01-04 04:45:19', '2019-02-08 21:57:25');
INSERT INTO `business` VALUES (2, 'Awesome Pharmacy', 2, '2018-04-10', '3412569900', 'VAT', NULL, NULL, NULL, 25.00, 4, 'America/Chicago', 1, 'fifo', NULL, 'includes', NULL, 'AP', 1, 'add_manufacturing', 'stop_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 1, 1, 1, 0, 4, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2018-04-10 10:42:40', '2018-04-10 12:51:38');
INSERT INTO `business` VALUES (3, 'Ultimate Electronics', 2, '2018-04-10', '12548555003', 'GST', NULL, NULL, NULL, 25.00, 5, 'America/Chicago', 1, 'fifo', NULL, 'includes', NULL, 'AE', 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 1, 1, 1, 0, 5, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2018-04-10 13:16:15', '2018-04-10 14:23:35');
INSERT INTO `business` VALUES (4, 'Awesome Services', 124, NULL, '3412569900', 'GST', NULL, NULL, NULL, 25.00, 6, 'America/Chicago', 1, 'fifo', NULL, 'includes', NULL, 'AS', 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 0, 1, 0, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2018-04-10 14:50:42', '2018-04-10 14:53:40');
INSERT INTO `business` VALUES (5, 'Awesome Restaurant', 2, '2018-07-12', '4578220005', 'IGST', '4593220009', 'SGST', NULL, 25.00, 7, 'America/Chicago', 1, 'fifo', NULL, 'includes', NULL, 'AR', 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_discount\":0,\"disable_order_tax\":0}', 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', '[\"tables\",\"modifiers\",\"service_staff\",\"kitchen\"]', 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2018-07-13 19:12:11', '2018-08-03 03:11:56');
INSERT INTO `business` VALUES (6, 'cxcxd', 53, '2018-08-01', NULL, NULL, NULL, NULL, NULL, 25.00, 10, 'Asia/Kolkata', 1, 'fifo', NULL, 'includes', NULL, NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\"}', NULL, NULL, 1, '2018-08-06 22:45:34', '2018-08-06 22:45:34');
INSERT INTO `business` VALUES (7, 'Wonderful', 124, '2019-02-01', NULL, NULL, NULL, NULL, NULL, 25.00, 12, 'Asia/Kolkata', 1, 'fifo', NULL, 'includes', NULL, NULL, 1, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 0, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2019-02-09 10:37:35', '2019-02-09 10:43:45');
INSERT INTO `business` VALUES (8, 'Awesome', 124, '2019-02-01', NULL, NULL, NULL, NULL, NULL, 0.00, 13, 'Asia/Kolkata', 1, 'fifo', NULL, 'includes', 'Ofw1UQB2KPsXV8X1NA74dO7Zt5ybri7nEHoJzBTa.png', NULL, 1, 'add_manufacturing', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 0, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2019-02-10 02:01:52', '2019-02-19 08:11:30');
INSERT INTO `business` VALUES (12, 'asdf', 124, '2019-02-15', NULL, NULL, NULL, NULL, NULL, 25.00, 17, 'Asia/Kolkata', 1, 'fifo', NULL, 'includes', NULL, NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `business` VALUES (13, 'zxcv', 16, NULL, NULL, NULL, NULL, NULL, NULL, 25.00, 18, 'Asia/Kolkata', 1, 'fifo', NULL, 'includes', NULL, NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `business` VALUES (14, 'zxcvqwe', 13, NULL, NULL, NULL, NULL, NULL, NULL, 25.00, 19, 'Asia/Kolkata', 1, 'fifo', NULL, 'includes', NULL, NULL, 1, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 1, '2019-02-15 10:24:03', '2019-02-15 13:53:20');

-- ----------------------------
-- Table structure for business_locations
-- ----------------------------
DROP TABLE IF EXISTS `business_locations`;
CREATE TABLE `business_locations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `invoice_scheme_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `invoice_layout_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `print_receipt_on_invoice` tinyint(1) NULL DEFAULT 1,
  `receipt_printer_type` enum('browser','printer') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'browser',
  `printer_id` int(11) NULL DEFAULT NULL,
  `mobile` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alternate_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `website` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `custom_field1` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `custom_field2` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `custom_field3` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `custom_field4` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `business_locations_business_id_index`(`business_id`) USING BTREE,
  INDEX `business_locations_invoice_scheme_id_foreign`(`invoice_scheme_id`) USING BTREE,
  INDEX `business_locations_invoice_layout_id_foreign`(`invoice_layout_id`) USING BTREE,
  CONSTRAINT `business_locations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `business_locations_invoice_layout_id_foreign` FOREIGN KEY (`invoice_layout_id`) REFERENCES `invoice_layouts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `business_locations_invoice_scheme_id_foreign` FOREIGN KEY (`invoice_scheme_id`) REFERENCES `invoice_schemes` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of business_locations
-- ----------------------------
INSERT INTO `business_locations` VALUES (1, 1, NULL, 'Awesome Shop', 'Linking Street', 'USA', 'Arizona', 'Phoenix', '85001', 1, 1, 1, 'browser', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-04 04:45:20', '2019-01-27 02:36:58');
INSERT INTO `business_locations` VALUES (2, 2, NULL, 'Awesome Pharmacy', 'Linking Street', 'USA', 'Arizona', 'Phoenix', '492001', 2, 2, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 10:42:40', '2018-04-10 10:42:40');
INSERT INTO `business_locations` VALUES (3, 3, NULL, 'Ultimate Electronics', 'Linking Street', 'USA', 'Arizona', 'Phoenix', '492001', 3, 3, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 13:16:16', '2018-04-10 13:16:16');
INSERT INTO `business_locations` VALUES (4, 4, NULL, 'Awesome Services', 'Linking Street', 'USA', 'Arizona', 'Phoenix', '282001', 4, 4, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 14:50:43', '2018-04-10 14:50:43');
INSERT INTO `business_locations` VALUES (5, 5, NULL, 'Awesome Restaurant', 'Linking Street', 'USA', 'Arizona', 'Phoenix', '85001', 5, 5, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2018-07-13 13:42:11', '2018-07-13 13:42:11');
INSERT INTO `business_locations` VALUES (6, 6, '0001', 'cxcxd', 'wqw', 'India', 'odisha', 'kbj', '77039', 6, 6, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-06 22:45:35', '2018-08-06 22:45:35');
INSERT INTO `business_locations` VALUES (7, 1, 'BL0001', 'New Location', NULL, 'wer', 'wer', 'New York', 'we', 1, 1, 1, 'browser', NULL, NULL, NULL, NULL, NULL, 'asdf', 'asdfsdf', 'asdfsd', 'werqwer', NULL, '2019-01-17 07:21:44', '2019-01-27 03:22:04');
INSERT INTO `business_locations` VALUES (8, 7, 'BL0001', 'Wonderful', 'Jilin, Yanji', 'China', 'Jilin', 'Yanji', '136200', 7, 7, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-09 10:37:36', '2019-02-09 10:37:36');
INSERT INTO `business_locations` VALUES (9, 8, 'BL0001', 'Awesome', 'Jilin Yanji', 'China', 'Jilin', 'Yanji', '136200', 8, 8, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-10 02:01:52', '2019-02-10 02:01:52');
INSERT INTO `business_locations` VALUES (10, 8, NULL, 'Well', NULL, NULL, NULL, 'Jilin State', NULL, NULL, NULL, 1, 'browser', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-12 13:47:50', '2019-02-18 20:38:35');
INSERT INTO `business_locations` VALUES (15, 12, 'BL0001', 'asdf', 'Yanji, Jilin, China', 'China', 'Jilin', 'Yanji', '136200', 12, 13, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `business_locations` VALUES (16, 13, 'BL0001', 'zxcv', 'asdfas', 'asd', 'asd', 'asdfasdfasdf', '123', 13, 14, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `business_locations` VALUES (17, 14, 'BL0001', 'zxcvqwe', 'asdfasd', 'sdfasdf', 'asd', 'asdfasdfasdf', '32', 14, 15, 1, 'browser', NULL, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-15 10:24:03', '2019-02-15 11:30:01');

-- ----------------------------
-- Table structure for cash_register_transactions
-- ----------------------------
DROP TABLE IF EXISTS `cash_register_transactions`;
CREATE TABLE `cash_register_transactions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cash_register_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `pay_method` enum('cash','card','cheque','bank_transfer','custom_pay_1','custom_pay_2','custom_pay_3','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` enum('debit','credit') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` enum('initial','sell','transfer','refund') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cash_register_transactions_cash_register_id_foreign`(`cash_register_id`) USING BTREE,
  CONSTRAINT `cash_register_transactions_cash_register_id_foreign` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_registers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cash_register_transactions
-- ----------------------------
INSERT INTO `cash_register_transactions` VALUES (1, 1, 0.00, 'cash', 'credit', 'initial', NULL, '2018-07-13 10:09:34', '2018-07-13 10:09:34');
INSERT INTO `cash_register_transactions` VALUES (2, 1, 42.50, 'cash', 'credit', 'sell', 41, '2018-07-13 10:14:40', '2018-07-13 10:14:40');
INSERT INTO `cash_register_transactions` VALUES (3, 1, 0.00, 'cash', 'credit', 'sell', 41, '2018-07-13 10:14:40', '2018-07-13 10:14:40');
INSERT INTO `cash_register_transactions` VALUES (4, 1, 77.50, 'cash', 'credit', 'sell', 42, '2018-07-13 10:15:29', '2018-07-13 10:15:29');
INSERT INTO `cash_register_transactions` VALUES (5, 1, 0.00, 'cash', 'credit', 'sell', 42, '2018-07-13 10:15:29', '2018-07-13 10:15:29');
INSERT INTO `cash_register_transactions` VALUES (6, 1, 33.75, 'cash', 'credit', 'sell', 43, '2018-07-13 10:16:04', '2018-07-13 10:16:04');
INSERT INTO `cash_register_transactions` VALUES (7, 1, 0.00, 'cash', 'credit', 'sell', 43, '2018-07-13 10:16:04', '2018-07-13 10:16:04');
INSERT INTO `cash_register_transactions` VALUES (8, 1, 71.25, 'cash', 'credit', 'sell', 44, '2018-07-13 10:16:36', '2018-07-13 10:16:36');
INSERT INTO `cash_register_transactions` VALUES (9, 1, 0.00, 'cash', 'credit', 'sell', 44, '2018-07-13 10:16:36', '2018-07-13 10:16:36');
INSERT INTO `cash_register_transactions` VALUES (10, 2, 0.00, 'cash', 'credit', 'initial', NULL, '2018-08-06 00:22:12', '2018-08-06 00:22:12');
INSERT INTO `cash_register_transactions` VALUES (11, 2, 112.50, 'cash', 'credit', 'sell', 46, '2018-08-08 07:03:35', '2018-08-08 07:03:35');
INSERT INTO `cash_register_transactions` VALUES (12, 2, 0.00, 'cash', 'credit', 'sell', 46, '2018-08-08 07:03:35', '2018-08-08 07:03:35');
INSERT INTO `cash_register_transactions` VALUES (13, 3, 123.00, 'cash', 'credit', 'initial', NULL, '2019-02-15 10:55:54', '2019-02-15 10:55:54');
INSERT INTO `cash_register_transactions` VALUES (14, 4, 1000.00, 'cash', 'credit', 'initial', NULL, '2019-02-19 18:35:57', '2019-02-19 18:35:57');

-- ----------------------------
-- Table structure for cash_registers
-- ----------------------------
DROP TABLE IF EXISTS `cash_registers`;
CREATE TABLE `cash_registers`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `status` enum('close','open') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `closed_at` datetime(0) NULL DEFAULT NULL,
  `closing_amount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `total_card_slips` int(11) NOT NULL DEFAULT 0,
  `total_cheques` int(11) NOT NULL DEFAULT 0,
  `closing_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cash_registers_business_id_foreign`(`business_id`) USING BTREE,
  INDEX `cash_registers_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `cash_registers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cash_registers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cash_registers
-- ----------------------------
INSERT INTO `cash_registers` VALUES (1, 5, 7, 'open', NULL, 0.00, 0, 0, NULL, '2018-07-13 10:09:34', '2018-07-13 10:09:34');
INSERT INTO `cash_registers` VALUES (2, 1, 1, 'open', NULL, 0.00, 0, 0, NULL, '2018-08-06 00:22:12', '2018-08-06 00:22:12');
INSERT INTO `cash_registers` VALUES (3, 14, 19, 'open', NULL, 0.00, 0, 0, NULL, '2019-02-15 10:55:54', '2019-02-15 10:55:54');
INSERT INTO `cash_registers` VALUES (4, 8, 13, 'open', NULL, 0.00, 0, 0, NULL, '2019-02-19 18:35:57', '2019-02-19 18:35:57');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `short_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `categories_business_id_foreign`(`business_id`) USING BTREE,
  INDEX `categories_created_by_foreign`(`created_by`) USING BTREE,
  CONSTRAINT `categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Men\'s', 1, NULL, 0, 1, NULL, '2018-01-03 23:36:34', '2018-01-03 23:36:34');
INSERT INTO `categories` VALUES (2, 'Women\'s', 1, NULL, 0, 1, NULL, '2018-01-03 23:36:46', '2018-01-03 23:36:46');
INSERT INTO `categories` VALUES (3, 'Accessories', 1, NULL, 0, 1, NULL, '2018-01-03 23:37:03', '2018-01-03 23:37:03');
INSERT INTO `categories` VALUES (4, 'Jeans', 1, NULL, 1, 1, NULL, '2018-01-03 23:37:34', '2018-01-03 23:37:34');
INSERT INTO `categories` VALUES (5, 'Shirts', 1, NULL, 1, 1, NULL, '2018-01-03 23:38:18', '2018-01-03 23:38:18');
INSERT INTO `categories` VALUES (6, 'Belts', 1, NULL, 3, 1, NULL, '2018-01-03 23:38:41', '2018-01-03 23:38:41');
INSERT INTO `categories` VALUES (8, 'Shoes', 1, NULL, 3, 1, NULL, '2018-01-03 23:39:04', '2018-01-03 23:39:04');
INSERT INTO `categories` VALUES (10, 'Sandal', 1, NULL, 3, 1, NULL, '2018-01-03 23:39:23', '2018-01-03 23:39:23');
INSERT INTO `categories` VALUES (11, 'Wallets', 1, NULL, 3, 1, NULL, '2018-01-04 01:35:50', '2018-01-04 01:35:50');
INSERT INTO `categories` VALUES (12, 'Electronics', 1, NULL, 0, 1, NULL, '2018-01-06 07:54:34', '2018-01-06 07:54:34');
INSERT INTO `categories` VALUES (13, 'Cell Phones', 1, NULL, 12, 1, NULL, '2018-01-06 07:54:57', '2018-01-06 07:54:57');
INSERT INTO `categories` VALUES (14, 'Computers', 1, NULL, 12, 1, NULL, '2018-01-06 07:55:55', '2018-01-06 07:55:55');
INSERT INTO `categories` VALUES (15, 'Sports', 1, NULL, 0, 1, NULL, '2018-01-06 07:57:33', '2018-01-06 07:57:33');
INSERT INTO `categories` VALUES (16, 'Athletic Clothing', 1, NULL, 15, 1, NULL, '2018-01-06 07:58:40', '2018-01-06 07:58:40');
INSERT INTO `categories` VALUES (17, 'Exercise & Fitness', 1, NULL, 15, 1, NULL, '2018-01-06 07:59:19', '2018-01-06 07:59:19');
INSERT INTO `categories` VALUES (18, 'Books', 1, NULL, 0, 1, NULL, '2018-01-06 07:59:59', '2018-01-06 07:59:59');
INSERT INTO `categories` VALUES (19, 'Autobiography', 1, NULL, 18, 1, NULL, '2018-01-06 08:00:16', '2018-01-06 08:00:16');
INSERT INTO `categories` VALUES (20, 'Children\'s books', 1, NULL, 18, 1, NULL, '2018-01-06 08:00:58', '2018-01-06 08:00:58');
INSERT INTO `categories` VALUES (21, 'Food & Grocery', 1, NULL, 0, 1, NULL, '2018-01-06 08:01:35', '2018-01-06 08:01:35');
INSERT INTO `categories` VALUES (22, 'Capsule', 2, NULL, 0, 4, NULL, '2018-04-10 10:49:58', '2018-04-10 10:50:54');
INSERT INTO `categories` VALUES (23, 'Bandages', 2, NULL, 0, 4, NULL, '2018-04-10 10:50:48', '2018-04-10 10:50:48');
INSERT INTO `categories` VALUES (24, 'Cream', 2, NULL, 0, 4, NULL, '2018-04-10 10:51:23', '2018-04-10 10:51:23');
INSERT INTO `categories` VALUES (25, 'Drops', 2, NULL, 0, 4, NULL, '2018-04-10 10:51:31', '2018-04-10 10:51:31');
INSERT INTO `categories` VALUES (26, 'Gel', 2, NULL, 0, 4, NULL, '2018-04-10 10:51:57', '2018-04-10 10:51:57');
INSERT INTO `categories` VALUES (27, 'Bottle', 2, NULL, 0, 4, NULL, '2018-04-10 10:52:30', '2018-04-10 10:52:30');
INSERT INTO `categories` VALUES (28, 'Mobile Phones', 3, NULL, 0, 5, NULL, '2018-04-10 13:29:49', '2018-04-10 13:29:49');
INSERT INTO `categories` VALUES (29, 'Tablets', 3, NULL, 0, 5, NULL, '2018-04-10 13:30:02', '2018-04-10 13:30:02');
INSERT INTO `categories` VALUES (30, 'Laptops', 3, NULL, 0, 5, NULL, '2018-04-10 13:30:09', '2018-04-10 13:30:09');
INSERT INTO `categories` VALUES (31, 'TVs', 3, NULL, 0, 5, NULL, '2018-04-10 13:30:15', '2018-04-10 13:30:15');
INSERT INTO `categories` VALUES (32, 'Cameras', 3, NULL, 0, 5, NULL, '2018-04-10 13:30:29', '2018-04-10 13:30:29');
INSERT INTO `categories` VALUES (33, 'Accessories', 3, NULL, 0, 5, NULL, '2018-04-10 13:30:57', '2018-04-10 13:30:57');
INSERT INTO `categories` VALUES (34, 'Car Services', 4, NULL, 0, 6, NULL, '2018-04-10 14:55:33', '2018-04-10 15:00:10');
INSERT INTO `categories` VALUES (35, 'Hair Styling', 4, NULL, 0, 6, NULL, '2018-04-10 14:58:32', '2018-04-10 14:59:18');
INSERT INTO `categories` VALUES (36, 'Plumbing', 4, NULL, 0, 6, NULL, '2018-04-10 15:00:41', '2018-04-10 15:00:41');
INSERT INTO `categories` VALUES (37, 'Bodycare', 4, NULL, 0, 6, NULL, '2018-04-10 15:00:52', '2018-04-10 15:00:52');
INSERT INTO `categories` VALUES (38, 'Spa', 4, NULL, 0, 6, NULL, '2018-04-10 15:01:01', '2018-04-10 15:01:01');
INSERT INTO `categories` VALUES (39, 'Starter', 5, NULL, 0, 7, NULL, '2018-07-13 03:19:08', '2018-07-13 03:19:08');
INSERT INTO `categories` VALUES (40, 'Main Menu', 5, NULL, 0, 7, NULL, '2018-07-13 03:19:24', '2018-07-13 03:19:24');
INSERT INTO `categories` VALUES (41, 'Salad', 5, NULL, 0, 7, NULL, '2018-07-13 03:20:15', '2018-07-13 03:20:15');
INSERT INTO `categories` VALUES (42, 'Pizza', 5, NULL, 0, 7, NULL, '2018-07-13 03:20:29', '2018-07-13 03:20:29');
INSERT INTO `categories` VALUES (43, 'Desserts', 5, NULL, 0, 7, NULL, '2018-07-13 03:20:40', '2018-07-13 03:20:40');
INSERT INTO `categories` VALUES (44, 'Drinks', 5, NULL, 0, 7, NULL, '2018-07-13 03:20:54', '2018-07-13 03:20:54');
INSERT INTO `categories` VALUES (45, 'Bakery and Snacks', 5, NULL, 0, 7, NULL, '2018-07-13 04:28:40', '2018-07-13 04:28:40');
INSERT INTO `categories` VALUES (46, 'C111', 1, NULL, 0, 1, NULL, '2019-01-31 01:30:57', '2019-01-31 01:30:57');

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` enum('supplier','customer','both') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_business_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contact_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contact_person` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tax_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `landmark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mobile` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `landline` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `alternate_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pay_term_number` int(11) NULL DEFAULT NULL,
  `pay_term_type` enum('days','months') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `credit_limit` decimal(20, 2) NULL DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `customer_group_id` int(11) NULL DEFAULT NULL,
  `custom_field1` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `custom_field2` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `custom_field3` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `custom_field4` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `opening_balance` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `contacts_business_id_foreign`(`business_id`) USING BTREE,
  INDEX `contacts_created_by_foreign`(`created_by`) USING BTREE,
  CONSTRAINT `contacts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `contacts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of contacts
-- ----------------------------
INSERT INTO `contacts` VALUES (1, 1, 'customer', 'My Business', 'Walk-In Customer', NULL, 'CO0005', NULL, NULL, 'Phoenix', 'Arizona', 'USA', 'Linking Street', '(378) 400-1234', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-03 23:15:20', '2019-01-19 16:00:11', 552);
INSERT INTO `contacts` VALUES (2, 1, 'supplier', 'Alpha Clothings', 'Michael', NULL, 'CO0001', NULL, '4590091535', 'Phoenix', 'Arizona', 'USA', 'Linking Street', '(378) 400-1234', NULL, NULL, 15, 'days', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-03 23:29:38', '2019-01-19 11:33:17', 300);
INSERT INTO `contacts` VALUES (3, 1, 'supplier', 'Manhattan Clothing Ltd.', 'Philip', NULL, 'CO0003', NULL, '54869310093', 'Phoenix', 'Arizona', 'USA', 'Linking Street', '(378) 400-1234', NULL, NULL, 15, 'days', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-03 23:30:55', '2018-06-12 00:51:36', 0);
INSERT INTO `contacts` VALUES (4, 1, 'supplier', 'harry', 'Harry', NULL, 'CO0006', NULL, NULL, 'Phoenix', 'Arizona', 'USA', 'Linking Street', '(378) 400-1234', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-03 23:31:40', '2019-01-18 07:04:00', 0);
INSERT INTO `contacts` VALUES (5, 1, 'supplier', 'Digital Ocean', 'Mike McCubbin', NULL, 'CN0004', NULL, '52965489001', 'Phoenix', 'Arizona', 'USA', 'Linking Street', '(378) 400-1234', NULL, NULL, 30, 'days', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-06 09:23:22', '2018-06-12 00:51:47', 0);
INSERT INTO `contacts` VALUES (6, 1, 'supplier', 'Univer Suppliers', 'Jackson Hill', NULL, 'CO0002', NULL, '5459000655', 'Phoenix', 'Arizona', 'USA', 'Linking Street', '(378) 400-1234', NULL, NULL, 45, 'days', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-06 09:25:09', '2018-06-12 00:51:18', 0);
INSERT INTO `contacts` VALUES (7, 2, 'customer', NULL, 'Walk-In Customer', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 10:42:40', '2018-04-10 10:42:40', 0);
INSERT INTO `contacts` VALUES (8, 2, 'supplier', 'Jones Pharma', 'Micheal Larson', NULL, '522500003', NULL, NULL, 'Phoenix', 'Arizona', 'USA', NULL, '(378) 400-1234', NULL, NULL, 30, 'days', NULL, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 12:32:52', '2018-04-10 12:32:52', 0);
INSERT INTO `contacts` VALUES (9, 2, 'supplier', 'Axolotl Biologix', 'Phillip Jenner', NULL, '4585220005', NULL, NULL, 'Phoenix', 'Arizona', 'USA', NULL, '(378) 400-1234', NULL, NULL, 30, 'days', NULL, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 12:34:20', '2018-04-10 12:34:20', 0);
INSERT INTO `contacts` VALUES (10, 3, 'customer', NULL, 'Walk-In Customer', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 13:16:16', '2018-04-10 13:16:16', 0);
INSERT INTO `contacts` VALUES (11, 3, 'supplier', 'Digital Ocean', 'Micheal Krick', NULL, '12500079', NULL, NULL, 'Phoenix', 'Arizona', 'USA', NULL, '(378) 400-1234', NULL, NULL, 30, 'days', NULL, 5, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 14:06:21', '2018-04-10 14:06:21', 0);
INSERT INTO `contacts` VALUES (12, 3, 'supplier', 'Neon Electronics', 'Samuel Williams', NULL, '525800083', NULL, NULL, 'Phoenix', 'Arizona', 'USA', NULL, '(378) 400-1234', NULL, NULL, 30, 'days', NULL, 5, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 14:08:33', '2018-04-10 14:08:33', 0);
INSERT INTO `contacts` VALUES (13, 4, 'customer', NULL, 'Walk-In Customer', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 6, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 14:50:43', '2018-04-10 14:50:43', 0);
INSERT INTO `contacts` VALUES (14, 5, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, '', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-07-13 19:12:11', '2018-07-13 19:12:11', 0);
INSERT INTO `contacts` VALUES (15, 5, 'supplier', 'Perfect Bakers', 'Thomas Willson', 'thomas@example.com', 'CO0002', NULL, '45781005', '', NULL, NULL, NULL, '87850009358', NULL, NULL, 10, 'months', NULL, 7, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2018-07-13 10:03:50', '2018-07-13 10:03:50', 0);
INSERT INTO `contacts` VALUES (16, 1, 'supplier', 'test', 'test', NULL, 'test', NULL, 'test', '', NULL, NULL, NULL, '173002834', NULL, NULL, 10, 'months', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-15 05:39:57', '2018-08-06 10:05:47', '2019-01-15 05:39:57', 0);
INSERT INTO `contacts` VALUES (17, 6, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, '', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 10, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-06 22:45:35', '2018-08-06 22:45:35', 0);
INSERT INTO `contacts` VALUES (18, 1, 'supplier', NULL, 'asdf', NULL, NULL, NULL, NULL, 'yanji', NULL, NULL, NULL, '8617122', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-15 04:13:35', '2019-01-14 01:14:49', '2019-01-15 04:13:35', 0);
INSERT INTO `contacts` VALUES (19, 1, 'supplier', 'asdf', 'asdf', NULL, NULL, NULL, NULL, 'asdf', NULL, NULL, NULL, '8617122', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-14 01:16:19', '2019-01-18 07:04:30', 123);
INSERT INTO `contacts` VALUES (20, 1, 'supplier', 'new business', 'asdfasdfas', NULL, NULL, NULL, NULL, 'sfasdfasdf', NULL, NULL, NULL, '13123123', NULL, NULL, 1, 'months', NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-14 01:27:24', '2019-01-17 21:15:10', 123123123);
INSERT INTO `contacts` VALUES (21, 1, 'customer', NULL, 'asdfasdfa', NULL, NULL, 'asdfasdf', NULL, 'asdfasdfasdf', NULL, NULL, NULL, '13123123', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-15 04:12:42', '2019-01-14 03:28:11', '2019-01-15 04:12:42', 0);
INSERT INTO `contacts` VALUES (22, 1, 'customer', NULL, 'asdfasf', NULL, NULL, NULL, NULL, 'asf', NULL, NULL, NULL, '123123132', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-14 09:09:26', '2019-01-14 08:31:57', '2019-01-14 09:09:26', 0);
INSERT INTO `contacts` VALUES (23, 1, 'customer', NULL, 'New Customer', NULL, NULL, NULL, NULL, 'Yanji', NULL, NULL, NULL, '13123123', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-17 21:52:41', '2019-01-18 10:16:38', 0);
INSERT INTO `contacts` VALUES (24, 1, 'supplier', 'asdfasdf', 'sdfsdf', NULL, NULL, NULL, NULL, 'asdfasdfasdf', NULL, NULL, NULL, '13123123', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-18 21:50:23', '2019-01-19 09:31:58', 0);
INSERT INTO `contacts` VALUES (25, 1, 'supplier', 'asdfasdf', 'asdfasdfasdf', NULL, NULL, NULL, NULL, 'asds', NULL, NULL, NULL, '13123123', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 01:52:35', '2019-01-19 09:35:14', 100);
INSERT INTO `contacts` VALUES (26, 1, 'customer', NULL, 'New Customer 2', NULL, NULL, NULL, NULL, 'Iraq', NULL, NULL, NULL, '123412341', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 14:57:01', '2019-02-02 03:01:36', 111);
INSERT INTO `contacts` VALUES (27, 1, 'customer', NULL, '', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-20 03:32:40', '2019-01-20 03:32:20', '2019-01-20 03:32:40', 0);
INSERT INTO `contacts` VALUES (28, 1, 'customer', NULL, '', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-20 03:32:37', '2019-01-20 03:32:22', '2019-01-20 03:32:37', 0);
INSERT INTO `contacts` VALUES (29, 1, 'customer', NULL, '', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-20 03:33:45', '2019-01-20 03:33:03', '2019-01-20 03:33:45', 0);
INSERT INTO `contacts` VALUES (30, 1, 'customer', NULL, '', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, '2019-01-20 03:33:42', '2019-01-20 03:33:04', '2019-01-20 03:33:42', 0);
INSERT INTO `contacts` VALUES (31, 1, 'customer', NULL, 'Rega Lab', NULL, NULL, 'Kawa', NULL, 'Slemani', NULL, NULL, NULL, '7701501500', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-31 01:53:08', '2019-01-31 01:53:08', 14000);
INSERT INTO `contacts` VALUES (32, 1, 'customer', NULL, 'test customer', NULL, NULL, NULL, NULL, 'Yanji Xi', NULL, NULL, NULL, '1235412351234', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 02:45:16', '2019-02-02 02:45:16', 1234);
INSERT INTO `contacts` VALUES (33, 1, 'customer', NULL, 'test customer', NULL, NULL, NULL, NULL, 'Jilin Yanji', NULL, NULL, NULL, '2341234', NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-07 20:53:19', '2019-02-07 20:53:19', 12314);
INSERT INTO `contacts` VALUES (34, 7, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-09 10:37:36', '2019-02-09 10:37:36', 0);
INSERT INTO `contacts` VALUES (35, 7, 'supplier', 'First Business', 'Harry', NULL, NULL, NULL, NULL, 'Beijing', NULL, NULL, NULL, '12351234123', NULL, NULL, NULL, NULL, NULL, 12, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-09 11:16:07', '2019-02-09 11:16:07', 1000);
INSERT INTO `contacts` VALUES (36, 8, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-10 02:01:52', '2019-02-10 02:01:52', 0);
INSERT INTO `contacts` VALUES (37, 8, 'supplier', 'First Business', 'Harry', NULL, NULL, NULL, NULL, 'Yanji', NULL, NULL, NULL, '1234151', NULL, NULL, NULL, NULL, NULL, 13, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-10 05:38:30', '2019-02-10 05:38:30', 1000);
INSERT INTO `contacts` VALUES (38, 8, 'customer', NULL, 'My customer', NULL, NULL, NULL, NULL, 'Yanji', NULL, NULL, NULL, '123124123', NULL, NULL, NULL, NULL, NULL, 13, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-14 14:52:55', '2019-02-19 07:55:21', 1000);
INSERT INTO `contacts` VALUES (42, 12, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 17, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-15 09:32:09', '2019-02-15 09:32:09', 0);
INSERT INTO `contacts` VALUES (43, 13, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 18, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-15 10:11:28', '2019-02-15 10:11:28', 0);
INSERT INTO `contacts` VALUES (44, 14, 'both', 'asdf', '12', NULL, NULL, NULL, NULL, 'ad', NULL, NULL, NULL, '12312', NULL, NULL, NULL, NULL, NULL, 19, 0, NULL, NULL, NULL, NULL, NULL, '2019-02-15 13:52:32', '2019-02-15 11:01:14', '2019-02-15 13:52:32', 0);
INSERT INTO `contacts` VALUES (45, 14, 'customer', NULL, 'zxcv', NULL, NULL, NULL, NULL, 'ascv', NULL, NULL, NULL, '12132', NULL, NULL, NULL, NULL, NULL, 19, 0, NULL, NULL, NULL, NULL, NULL, '2019-02-15 11:03:31', '2019-02-15 11:03:11', '2019-02-15 11:03:31', 0);
INSERT INTO `contacts` VALUES (46, 14, 'customer', NULL, 'asdf', NULL, NULL, NULL, NULL, 'asdf', NULL, NULL, NULL, 'asdf', NULL, NULL, NULL, NULL, NULL, 19, 0, NULL, NULL, NULL, NULL, NULL, '2019-02-15 11:15:10', '2019-02-15 11:15:05', '2019-02-15 11:15:10', 0);
INSERT INTO `contacts` VALUES (47, 14, 'customer', NULL, 'new customer', NULL, NULL, NULL, NULL, 'sadfasdf', NULL, NULL, NULL, '123142121', NULL, NULL, NULL, NULL, NULL, 19, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-16 13:28:43', '2019-02-16 13:28:43', 0);
INSERT INTO `contacts` VALUES (48, 8, 'supplier', 'new business', 'new supplier', NULL, NULL, NULL, NULL, 'Beijing', NULL, NULL, NULL, '3412531', NULL, NULL, NULL, NULL, NULL, 13, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 08:11:26', '2019-02-19 08:11:26', 0);

-- ----------------------------
-- Table structure for currencies
-- ----------------------------
DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thousand_separator` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `decimal_separator` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `currency_rate` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 137 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of currencies
-- ----------------------------
INSERT INTO `currencies` VALUES (2, 'America', 'Dollars', 'USD', '$', ',', '.', NULL, '2019-01-31 03:12:24', 0.00);
INSERT INTO `currencies` VALUES (3, 'Afghanistan', 'Afghanis', 'AF', '؋', ',', '.', NULL, '2019-01-29 20:26:29', 0.00);
INSERT INTO `currencies` VALUES (4, 'Argentina', 'Pesos', 'ARS', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (5, 'Aruba', 'Guilders', 'AWG', 'ƒ', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (6, 'Australia', 'Dollars', 'AUD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (7, 'Azerbaijan', 'New Manats', 'AZ', 'ман', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (8, 'Bahamas', 'Dollars', 'BSD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (9, 'Barbados', 'Dollars', 'BBD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (10, 'Belarus', 'Rubles', 'BYR', 'p.', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (11, 'Belgium', 'Euro', 'EUR', '€', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (12, 'Beliz', 'Dollars', 'BZD', 'BZ$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (13, 'Bermuda', 'Dollars', 'BMD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (14, 'Bolivia', 'Bolivianos', 'BOB', '$b', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (15, 'Bosnia and Herzegovina', 'Convertible Marka', 'BAM', 'KM', ',', '.', NULL, '2019-01-29 20:26:40', 0.00);
INSERT INTO `currencies` VALUES (16, 'Botswana', 'Pula\'s', 'BWP', 'P', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (17, 'Bulgaria', 'Leva', 'BG', 'лв', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (18, 'Brazil', 'Reais', 'BRL', 'R$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (19, 'Britain [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (20, 'Brunei Darussalam', 'Dollars', 'BND', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (21, 'Cambodia', 'Riels', 'KHR', '៛', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (22, 'Canada', 'Dollars', 'CAD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (23, 'Cayman Islands', 'Dollars', 'KYD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (24, 'Chile', 'Pesos', 'CLP', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (25, 'China', 'Yuan Renminbi', 'CNY', '¥', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (26, 'Colombia', 'Pesos', 'COP', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (27, 'Costa Rica', 'Colón', 'CRC', '₡', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (28, 'Croatia', 'Kuna', 'HRK', 'kn', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (29, 'Cuba', 'Pesos', 'CUP', '₱', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (30, 'Cyprus', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (31, 'Czech Republic', 'Koruny', 'CZK', 'Kč', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (32, 'Denmark', 'Kroner', 'DKK', 'kr', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (33, 'Dominican Republic', 'Pesos', 'DOP ', 'RD$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (34, 'East Caribbean', 'Dollars', 'XCD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (35, 'Egypt', 'Pounds', 'EGP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (36, 'El Salvador', 'Colones', 'SVC', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (37, 'England [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (38, 'Euro', 'Euro', 'EUR', '€', '.', ',', NULL, '2019-01-25 11:29:23', 0.70);
INSERT INTO `currencies` VALUES (39, 'Falkland Islands', 'Pounds', 'FKP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (40, 'Fiji', 'Dollars', 'FJD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (41, 'France', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (42, 'Ghana', 'Cedis', 'GHC', '¢', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (43, 'Gibraltar', 'Pounds', 'GIP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (44, 'Greece', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (45, 'Guatemala', 'Quetzales', 'GTQ', 'Q', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (46, 'Guernsey', 'Pounds', 'GGP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (47, 'Guyana', 'Dollars', 'GYD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (48, 'Holland [Netherlands]', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (49, 'Honduras', 'Lempiras', 'HNL', 'L', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (50, 'Hong Kong', 'Dollars', 'HKD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (51, 'Hungary', 'Forint', 'HUF', 'Ft', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (52, 'Iceland', 'Kronur', 'ISK', 'kr', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (53, 'India', 'Rupees', 'INR', '₹', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (54, 'Indonesia', 'Rupiahs', 'IDR', 'Rp', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (55, 'Iran', 'Rials', 'IRR', '﷼', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (56, 'Ireland', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (57, 'Isle of Man', 'Pounds', 'IMP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (58, 'Israel', 'New Shekels', 'ILS', '₪', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (59, 'Italy', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (60, 'Jamaica', 'Dollars', 'JMD', 'J$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (61, 'Japan', 'Yen', 'JPY', '¥', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (62, 'Jersey', 'Pounds', 'JEP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (63, 'Kazakhstan', 'Tenge', 'KZT', 'лв', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (64, 'Korea [North]', 'Won', 'KPW', '₩', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (65, 'Korea [South]', 'Won', 'KRW', '₩', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (66, 'Kyrgyzstan', 'Soms', 'KGS', 'лв', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (67, 'Laos', 'Kips', 'LAK', '₭', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (68, 'Latvia', 'Lati', 'LVL', 'Ls', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (69, 'Lebanon', 'Pounds', 'LBP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (70, 'Liberia', 'Dollars', 'LRD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (71, 'Liechtenstein', 'Switzerland Francs', 'CHF', 'CHF', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (72, 'Lithuania', 'Litai', 'LTL', 'Lt', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (73, 'Luxembourg', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (74, 'Macedonia', 'Denars', 'MKD', 'ден', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (75, 'Malaysia', 'Ringgits', 'MYR', 'RM', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (76, 'Malta', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (77, 'Mauritius', 'Rupees', 'MUR', '₨', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (78, 'Mexico', 'Pesos', 'MX', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (79, 'Mongolia', 'Tugriks', 'MNT', '₮', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (80, 'Mozambique', 'Meticais', 'MZ', 'MT', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (81, 'Namibia', 'Dollars', 'NAD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (82, 'Nepal', 'Rupees', 'NPR', '₨', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (83, 'Netherlands Antilles', 'Guilders', 'ANG', 'ƒ', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (84, 'Netherlands', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (85, 'New Zealand', 'Dollars', 'NZD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (86, 'Nicaragua', 'Cordobas', 'NIO', 'C$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (87, 'Nigeria', 'Nairas', 'NG', '₦', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (88, 'North Korea', 'Won', 'KPW', '₩', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (89, 'Norway', 'Krone', 'NOK', 'kr', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (90, 'Oman', 'Rials', 'OMR', '﷼', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (91, 'Pakistan', 'Rupees', 'PKR', '₨', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (92, 'Panama', 'Balboa', 'PAB', 'B/.', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (93, 'Paraguay', 'Guarani', 'PYG', 'Gs', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (94, 'Peru', 'Nuevos Soles', 'PE', 'S/.', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (95, 'Philippines', 'Pesos', 'PHP', 'Php', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (96, 'Poland', 'Zlotych', 'PL', 'zł', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (97, 'Qatar', 'Rials', 'QAR', '﷼', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (98, 'Romania', 'New Lei', 'RO', 'lei', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (99, 'Russia', 'Rubles', 'RUB', 'руб', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (100, 'Saint Helena', 'Pounds', 'SHP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (101, 'Saudi Arabia', 'Riyals', 'SAR', '﷼', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (102, 'Serbia', 'Dinars', 'RSD', 'Дин.', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (103, 'Seychelles', 'Rupees', 'SCR', '₨', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (104, 'Singapore', 'Dollars', 'SGD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (105, 'Slovenia', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (106, 'Solomon Islands', 'Dollars', 'SBD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (107, 'Somalia', 'Shillings', 'SOS', 'S', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (108, 'South Africa', 'Rand', 'ZAR', 'R', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (109, 'South Korea', 'Won', 'KRW', '₩', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (110, 'Spain', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (111, 'Sri Lanka', 'Rupees', 'LKR', '₨', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (112, 'Sweden', 'Kronor', 'SEK', 'kr', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (113, 'Switzerland', 'Francs', 'CHF', 'CHF', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (114, 'Suriname', 'Dollars', 'SRD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (115, 'Syria', 'Pounds', 'SYP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (116, 'Taiwan', 'New Dollars', 'TWD', 'NT$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (117, 'Thailand', 'Baht', 'THB', '฿', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (118, 'Trinidad and Tobago', 'Dollars', 'TTD', 'TT$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (119, 'Turkey', 'Lira', 'TRY', 'TL', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (120, 'Turkey', 'Liras', 'TRL', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (121, 'Tuvalu', 'Dollars', 'TVD', '$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (122, 'Ukraine', 'Hryvnia', 'UAH', '₴', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (123, 'United Kingdom', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (124, 'USA', 'Dollars', 'USD', '$', ',', '.', NULL, NULL, 1.00);
INSERT INTO `currencies` VALUES (125, 'Uruguay', 'Pesos', 'UYU', '$U', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (126, 'Uzbekistan', 'Sums', 'UZS', 'лв', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (127, 'Vatican City', 'Euro', 'EUR', '€', '.', ',', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (128, 'Venezuela', 'Bolivares Fuertes', 'VEF', 'Bs', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (129, 'Vietnam', 'Dong', 'VND', '₫', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (130, 'Yemen', 'Rials', 'YER', '﷼', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (131, 'Zimbabwe', 'Zimbabwe Dollars', 'ZWD', 'Z$', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (132, 'Iraq', 'Iraqi dinar', 'IQD', 'د.ع', ',', '.', NULL, '2019-01-31 03:13:58', 1400.00);
INSERT INTO `currencies` VALUES (133, 'Kenya', 'Kenyan shilling', 'KES', 'KSh', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (134, 'Bangladesh', 'Taka', 'BDT', '৳', ',', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (135, 'Algerie', 'Algerian dinar', 'DZD', 'د.ج', ' ', '.', NULL, NULL, 0.00);
INSERT INTO `currencies` VALUES (136, 'United Arab Emirates', 'United Arab Emirates dirham', 'AED', 'د.إ', ',', '.', NULL, NULL, 0.00);

-- ----------------------------
-- Table structure for customer_groups
-- ----------------------------
DROP TABLE IF EXISTS `customer_groups`;
CREATE TABLE `customer_groups`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(5, 2) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_groups_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `customer_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for expense_categories
-- ----------------------------
DROP TABLE IF EXISTS `expense_categories`;
CREATE TABLE `expense_categories`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `expense_categories_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `expense_categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of expense_categories
-- ----------------------------
INSERT INTO `expense_categories` VALUES (1, 'Electricity', 1, '123', NULL, '2019-01-19 09:28:39', '2019-01-19 09:28:39');
INSERT INTO `expense_categories` VALUES (2, 'Water', 1, NULL, NULL, '2019-01-19 09:28:48', '2019-01-19 09:28:48');
INSERT INTO `expense_categories` VALUES (3, 'Electricity', 8, '111', NULL, '2019-02-19 08:31:10', '2019-02-19 08:31:10');

-- ----------------------------
-- Table structure for group_sub_taxes
-- ----------------------------
DROP TABLE IF EXISTS `group_sub_taxes`;
CREATE TABLE `group_sub_taxes`  (
  `group_tax_id` int(10) UNSIGNED NOT NULL,
  `tax_id` int(10) UNSIGNED NOT NULL,
  INDEX `group_sub_taxes_group_tax_id_foreign`(`group_tax_id`) USING BTREE,
  INDEX `group_sub_taxes_tax_id_foreign`(`tax_id`) USING BTREE,
  CONSTRAINT `group_sub_taxes_group_tax_id_foreign` FOREIGN KEY (`group_tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `group_sub_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of group_sub_taxes
-- ----------------------------
INSERT INTO `group_sub_taxes` VALUES (4, 2);
INSERT INTO `group_sub_taxes` VALUES (4, 3);

-- ----------------------------
-- Table structure for invoice_layouts
-- ----------------------------
DROP TABLE IF EXISTS `invoice_layouts`;
CREATE TABLE `invoice_layouts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `header_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `invoice_no_prefix` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `quotation_no_prefix` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `invoice_heading` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_heading_line1` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_heading_line2` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_heading_line3` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_heading_line4` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_heading_line5` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `invoice_heading_not_paid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `invoice_heading_paid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `quotation_heading` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_total_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `discount_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tax_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `total_due_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `paid_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `show_client_id` tinyint(1) NOT NULL DEFAULT 0,
  `client_id_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `client_tax_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `show_time` tinyint(1) NOT NULL DEFAULT 1,
  `show_brand` tinyint(1) NOT NULL DEFAULT 0,
  `show_sku` tinyint(1) NOT NULL DEFAULT 1,
  `show_cat_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `show_lot` tinyint(1) NOT NULL DEFAULT 0,
  `show_sale_description` tinyint(1) NOT NULL DEFAULT 0,
  `sales_person_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `show_sales_person` tinyint(1) NOT NULL DEFAULT 0,
  `table_product_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `table_qty_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `table_unit_price_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `table_subtotal_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cat_code_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `show_logo` tinyint(1) NOT NULL DEFAULT 0,
  `show_business_name` tinyint(1) NOT NULL DEFAULT 0,
  `show_location_name` tinyint(1) NOT NULL DEFAULT 1,
  `show_landmark` tinyint(1) NOT NULL DEFAULT 1,
  `show_city` tinyint(1) NOT NULL DEFAULT 1,
  `show_state` tinyint(1) NOT NULL DEFAULT 1,
  `show_zip_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_country` tinyint(1) NOT NULL DEFAULT 1,
  `show_mobile_number` tinyint(1) NOT NULL DEFAULT 1,
  `show_alternate_number` tinyint(1) NOT NULL DEFAULT 0,
  `show_email` tinyint(1) NOT NULL DEFAULT 0,
  `show_tax_1` tinyint(1) NOT NULL DEFAULT 1,
  `show_tax_2` tinyint(1) NOT NULL DEFAULT 0,
  `show_barcode` tinyint(1) NOT NULL DEFAULT 0,
  `show_payments` tinyint(1) NOT NULL DEFAULT 0,
  `show_customer` tinyint(1) NOT NULL DEFAULT 0,
  `customer_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `highlight_color` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `footer_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `module_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `business_id` int(10) UNSIGNED NOT NULL,
  `design` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'classic',
  `cn_heading` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'cn = credit note',
  `cn_no_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cn_amount_label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `invoice_layouts_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `invoice_layouts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of invoice_layouts
-- ----------------------------
INSERT INTO `invoice_layouts` VALUES (1, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 1, 'classic', NULL, NULL, NULL, '2018-04-04 02:05:32', '2018-04-04 02:05:32');
INSERT INTO `invoice_layouts` VALUES (2, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 2, 'classic', NULL, NULL, NULL, '2018-04-10 10:42:40', '2018-04-10 10:42:40');
INSERT INTO `invoice_layouts` VALUES (3, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 3, 'classic', NULL, NULL, NULL, '2018-04-10 13:16:16', '2018-04-10 13:16:16');
INSERT INTO `invoice_layouts` VALUES (4, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 4, 'classic', NULL, NULL, NULL, '2018-04-10 14:50:43', '2018-04-10 14:50:43');
INSERT INTO `invoice_layouts` VALUES (5, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 5, 'classic', NULL, NULL, NULL, '2018-07-13 19:12:11', '2018-07-13 19:12:11');
INSERT INTO `invoice_layouts` VALUES (6, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 6, 'classic', NULL, NULL, NULL, '2018-08-06 22:45:35', '2018-08-06 22:45:35');
INSERT INTO `invoice_layouts` VALUES (7, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 7, 'classic', NULL, NULL, NULL, '2019-02-09 10:37:36', '2019-02-09 10:37:36');
INSERT INTO `invoice_layouts` VALUES (8, 'Default', NULL, 'Invoice No.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 0, 0, 0, 0, 1, 0, 0, 'Sales Person', 0, 'Product', 'Quantity', 'Unit Price', 'Line Total', NULL, 'WccY7G6FScUkscPRUXQ3AtbFMtqrYtD8YjzkxvR1.png', 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 'Customer', '#000000', '<p>&copy;Accounting System</p>', NULL, 1, 8, 'classic', 'Sell Return', 'Ref No.', 'Total Amount', '2019-02-10 02:01:52', '2019-02-14 17:24:43');
INSERT INTO `invoice_layouts` VALUES (9, 'Custom', NULL, 'Invoice No.', 'Quotation No.', 'Invoice', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Quotation', 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 0, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', 'HSN', 'af207pTq5VzlACTen9pwwYBoGW2UX7ys8OzlVR6Q.png', 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 'Customer', '#216548', NULL, NULL, 0, 8, 'classic', 'Credit Note', 'Ref. No.', 'Credit Amount', '2019-02-14 17:58:39', '2019-02-14 17:58:39');
INSERT INTO `invoice_layouts` VALUES (13, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 12, 'classic', NULL, NULL, NULL, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `invoice_layouts` VALUES (14, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 13, 'classic', NULL, NULL, NULL, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `invoice_layouts` VALUES (15, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', 1, 0, 1, 1, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 14, 'classic', NULL, NULL, NULL, '2019-02-15 10:24:03', '2019-02-15 10:24:03');

-- ----------------------------
-- Table structure for invoice_schemes
-- ----------------------------
DROP TABLE IF EXISTS `invoice_schemes`;
CREATE TABLE `invoice_schemes`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheme_type` enum('blank','year') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_number` int(11) NULL DEFAULT NULL,
  `invoice_count` int(11) NOT NULL DEFAULT 0,
  `total_digits` int(11) NULL DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `invoice_schemes_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `invoice_schemes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of invoice_schemes
-- ----------------------------
INSERT INTO `invoice_schemes` VALUES (1, 1, 'Default', 'blank', 'AS', 1, 32, 4, 1, '2018-01-04 04:45:20', '2019-02-08 20:28:52');
INSERT INTO `invoice_schemes` VALUES (2, 2, 'Default', 'blank', 'AP', 1, 3, 4, 1, '2018-04-10 10:42:40', '2018-04-10 12:56:12');
INSERT INTO `invoice_schemes` VALUES (3, 3, 'Default', 'blank', 'AE', 1, 5, 4, 1, '2018-04-10 13:16:16', '2018-04-10 14:24:16');
INSERT INTO `invoice_schemes` VALUES (4, 4, 'Default', 'blank', '', 1, 8, 4, 1, '2018-04-10 14:50:43', '2018-04-10 15:38:49');
INSERT INTO `invoice_schemes` VALUES (5, 5, 'Default', 'blank', '', 1, 4, 4, 1, '2018-07-13 13:42:11', '2018-07-13 04:46:36');
INSERT INTO `invoice_schemes` VALUES (6, 6, 'Default', 'blank', '', 1, 0, 4, 1, '2018-08-06 22:45:35', '2018-08-06 22:45:35');
INSERT INTO `invoice_schemes` VALUES (7, 7, 'Default', 'blank', '', 1, 0, 4, 1, '2019-02-09 10:37:36', '2019-02-09 10:37:36');
INSERT INTO `invoice_schemes` VALUES (8, 8, 'Default', 'blank', '', 1, 23, 4, 1, '2019-02-10 02:01:52', '2019-02-19 08:12:33');
INSERT INTO `invoice_schemes` VALUES (12, 12, 'Default', 'blank', '', 1, 0, 4, 1, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `invoice_schemes` VALUES (13, 13, 'Default', 'blank', '', 1, 0, 4, 1, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `invoice_schemes` VALUES (14, 14, 'Default', 'blank', '', 1, 0, 4, 1, '2019-02-15 10:24:03', '2019-02-15 10:24:03');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 129 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2017_07_05_071953_create_currencies_table', 1);
INSERT INTO `migrations` VALUES (4, '2017_07_05_073658_create_business_table', 1);
INSERT INTO `migrations` VALUES (5, '2017_07_22_075923_add_business_id_users_table', 1);
INSERT INTO `migrations` VALUES (6, '2017_07_23_113209_create_brands_table', 1);
INSERT INTO `migrations` VALUES (7, '2017_07_26_083429_create_permission_tables', 1);
INSERT INTO `migrations` VALUES (8, '2017_07_26_110000_create_tax_rates_table', 1);
INSERT INTO `migrations` VALUES (9, '2017_07_26_122313_create_units_table', 1);
INSERT INTO `migrations` VALUES (10, '2017_07_27_075706_create_contacts_table', 1);
INSERT INTO `migrations` VALUES (11, '2017_08_04_071038_create_categories_table', 1);
INSERT INTO `migrations` VALUES (12, '2017_08_08_115903_create_products_table', 1);
INSERT INTO `migrations` VALUES (13, '2017_08_09_061616_create_variation_templates_table', 1);
INSERT INTO `migrations` VALUES (14, '2017_08_09_061638_create_variation_value_templates_table', 1);
INSERT INTO `migrations` VALUES (15, '2017_08_10_061146_create_product_variations_table', 1);
INSERT INTO `migrations` VALUES (16, '2017_08_10_061216_create_variations_table', 1);
INSERT INTO `migrations` VALUES (17, '2017_08_19_054827_create_transactions_table', 1);
INSERT INTO `migrations` VALUES (18, '2017_08_31_073533_create_purchase_lines_table', 1);
INSERT INTO `migrations` VALUES (19, '2017_10_15_064638_create_transaction_payments_table', 1);
INSERT INTO `migrations` VALUES (20, '2017_10_31_065621_add_default_sales_tax_to_business_table', 1);
INSERT INTO `migrations` VALUES (21, '2017_11_20_051930_create_table_group_sub_taxes', 1);
INSERT INTO `migrations` VALUES (22, '2017_11_20_063603_create_transaction_sell_lines', 1);
INSERT INTO `migrations` VALUES (23, '2017_11_21_064540_create_barcodes_table', 1);
INSERT INTO `migrations` VALUES (24, '2017_11_23_181237_create_invoice_schemes_table', 1);
INSERT INTO `migrations` VALUES (25, '2017_12_25_122822_create_business_locations_table', 1);
INSERT INTO `migrations` VALUES (26, '2017_12_25_160253_add_location_id_to_transactions_table', 1);
INSERT INTO `migrations` VALUES (27, '2017_12_25_163227_create_variation_location_details_table', 1);
INSERT INTO `migrations` VALUES (28, '2018_01_04_115627_create_sessions_table', 1);
INSERT INTO `migrations` VALUES (29, '2018_01_05_112817_create_invoice_layouts_table', 1);
INSERT INTO `migrations` VALUES (30, '2018_01_06_112303_add_invoice_scheme_id_and_invoice_layout_id_to_business_locations', 1);
INSERT INTO `migrations` VALUES (31, '2018_01_08_104124_create_expense_categories_table', 1);
INSERT INTO `migrations` VALUES (32, '2018_01_08_123327_modify_transactions_table_for_expenses', 1);
INSERT INTO `migrations` VALUES (33, '2018_01_09_111005_modify_payment_status_in_transactions_table', 1);
INSERT INTO `migrations` VALUES (34, '2018_01_09_111109_add_paid_on_column_to_transaction_payments_table', 1);
INSERT INTO `migrations` VALUES (35, '2018_01_25_172439_add_printer_related_fields_to_business_locations_table', 1);
INSERT INTO `migrations` VALUES (36, '2018_01_27_184322_create_printers_table', 1);
INSERT INTO `migrations` VALUES (37, '2018_01_30_181442_create_cash_registers_table', 1);
INSERT INTO `migrations` VALUES (38, '2018_01_31_125836_create_cash_register_transactions_table', 1);
INSERT INTO `migrations` VALUES (39, '2018_02_07_173326_modify_business_table', 1);
INSERT INTO `migrations` VALUES (40, '2018_02_08_105425_add_enable_product_expiry_column_to_business_table', 1);
INSERT INTO `migrations` VALUES (41, '2018_02_08_111027_add_expiry_period_and_expiry_period_type_columns_to_products_table', 1);
INSERT INTO `migrations` VALUES (42, '2018_02_08_131118_add_mfg_date_and_exp_date_purchase_lines_table', 1);
INSERT INTO `migrations` VALUES (43, '2018_02_08_155348_add_exchange_rate_to_transactions_table', 1);
INSERT INTO `migrations` VALUES (44, '2018_02_09_124945_modify_transaction_payments_table_for_contact_payments', 1);
INSERT INTO `migrations` VALUES (45, '2018_02_12_113640_create_transaction_sell_lines_purchase_lines_table', 1);
INSERT INTO `migrations` VALUES (46, '2018_02_12_114605_add_quantity_sold_in_purchase_lines_table', 1);
INSERT INTO `migrations` VALUES (47, '2018_02_13_183323_alter_decimal_fields_size', 1);
INSERT INTO `migrations` VALUES (48, '2018_02_14_161928_add_transaction_edit_days_to_business_table', 1);
INSERT INTO `migrations` VALUES (49, '2018_02_15_161032_add_document_column_to_transactions_table', 1);
INSERT INTO `migrations` VALUES (50, '2018_02_17_124709_add_more_options_to_invoice_layouts', 1);
INSERT INTO `migrations` VALUES (51, '2018_02_19_111517_add_keyboard_shortcut_column_to_business_table', 1);
INSERT INTO `migrations` VALUES (52, '2018_02_19_121537_stock_adjustment_move_to_transaction_table', 1);
INSERT INTO `migrations` VALUES (53, '2018_02_20_165505_add_is_direct_sale_column_to_transactions_table', 1);
INSERT INTO `migrations` VALUES (54, '2018_02_21_105329_create_system_table', 1);
INSERT INTO `migrations` VALUES (55, '2018_02_23_100549_version_1_2', 1);
INSERT INTO `migrations` VALUES (56, '2018_02_23_125648_add_enable_editing_sp_from_purchase_column_to_business_table', 1);
INSERT INTO `migrations` VALUES (57, '2018_02_26_103612_add_sales_commission_agent_column_to_business_table', 1);
INSERT INTO `migrations` VALUES (58, '2018_02_26_130519_modify_users_table_for_sales_cmmsn_agnt', 1);
INSERT INTO `migrations` VALUES (59, '2018_02_26_134500_add_commission_agent_to_transactions_table', 1);
INSERT INTO `migrations` VALUES (60, '2018_02_27_121422_add_item_addition_method_to_business_table', 1);
INSERT INTO `migrations` VALUES (61, '2018_02_27_170232_modify_transactions_table_for_stock_transfer', 1);
INSERT INTO `migrations` VALUES (62, '2018_03_05_153510_add_enable_inline_tax_column_to_business_table', 1);
INSERT INTO `migrations` VALUES (63, '2018_03_06_210206_modify_product_barcode_types', 1);
INSERT INTO `migrations` VALUES (64, '2018_03_13_181541_add_expiry_type_to_business_table', 1);
INSERT INTO `migrations` VALUES (65, '2018_03_16_113446_product_expiry_setting_for_business', 1);
INSERT INTO `migrations` VALUES (66, '2018_03_19_113601_add_business_settings_options', 1);
INSERT INTO `migrations` VALUES (67, '2018_03_26_125334_add_pos_settings_to_business_table', 1);
INSERT INTO `migrations` VALUES (68, '2018_03_26_165350_create_customer_groups_table', 1);
INSERT INTO `migrations` VALUES (69, '2018_03_27_122720_customer_group_related_changes_in_tables', 1);
INSERT INTO `migrations` VALUES (70, '2018_03_29_110138_change_tax_field_to_nullable_in_business_table', 1);
INSERT INTO `migrations` VALUES (71, '2018_03_29_115502_add_changes_for_sr_number_in_products_and_sale_lines_table', 1);
INSERT INTO `migrations` VALUES (72, '2018_03_29_134340_add_inline_discount_fields_in_purchase_lines', 1);
INSERT INTO `migrations` VALUES (73, '2018_03_31_140921_update_transactions_table_exchange_rate', 1);
INSERT INTO `migrations` VALUES (74, '2018_04_03_103037_add_contact_id_to_contacts_table', 1);
INSERT INTO `migrations` VALUES (75, '2018_04_03_122709_add_changes_to_invoice_layouts_table', 1);
INSERT INTO `migrations` VALUES (76, '2018_04_09_135320_change_exchage_rate_size_in_business_table', 1);
INSERT INTO `migrations` VALUES (77, '2018_04_17_123122_add_lot_number_to_business', 1);
INSERT INTO `migrations` VALUES (78, '2018_04_17_160845_add_product_racks_table', 1);
INSERT INTO `migrations` VALUES (79, '2018_04_20_182015_create_res_tables_table', 1);
INSERT INTO `migrations` VALUES (80, '2018_04_24_105246_restaurant_fields_in_transaction_table', 1);
INSERT INTO `migrations` VALUES (81, '2018_04_24_114149_add_enabled_modules_business_table', 1);
INSERT INTO `migrations` VALUES (82, '2018_04_24_133704_add_modules_fields_in_invoice_layout_table', 1);
INSERT INTO `migrations` VALUES (83, '2018_04_27_132653_quotation_related_change', 1);
INSERT INTO `migrations` VALUES (84, '2018_05_02_104439_add_date_format_and_time_format_to_business', 1);
INSERT INTO `migrations` VALUES (85, '2018_05_02_111939_add_sell_return_to_transaction_payments', 1);
INSERT INTO `migrations` VALUES (86, '2018_05_14_114027_add_rows_positions_for_products', 1);
INSERT INTO `migrations` VALUES (87, '2018_05_14_125223_add_weight_to_products_table', 1);
INSERT INTO `migrations` VALUES (88, '2018_05_14_164754_add_opening_stock_permission', 1);
INSERT INTO `migrations` VALUES (89, '2018_05_15_134729_add_design_to_invoice_layouts', 1);
INSERT INTO `migrations` VALUES (90, '2018_05_16_183307_add_tax_fields_invoice_layout', 1);
INSERT INTO `migrations` VALUES (91, '2018_05_18_191956_add_sell_return_to_transaction_table', 1);
INSERT INTO `migrations` VALUES (92, '2018_05_21_131349_add_custom_fileds_to_contacts_table', 1);
INSERT INTO `migrations` VALUES (93, '2018_05_21_131607_invoice_layout_fields_for_sell_return', 1);
INSERT INTO `migrations` VALUES (94, '2018_05_21_131949_add_custom_fileds_and_website_to_business_locations_table', 1);
INSERT INTO `migrations` VALUES (95, '2018_05_22_123527_create_reference_counts_table', 1);
INSERT INTO `migrations` VALUES (96, '2018_05_22_154540_add_ref_no_prefixes_column_to_business_table', 1);
INSERT INTO `migrations` VALUES (97, '2018_05_24_132620_add_ref_no_column_to_transaction_payments_table', 1);
INSERT INTO `migrations` VALUES (98, '2018_05_24_161026_add_location_id_column_to_business_location_table', 1);
INSERT INTO `migrations` VALUES (99, '2018_05_25_180603_create_modifiers_related_table', 1);
INSERT INTO `migrations` VALUES (100, '2018_05_29_121714_add_purchase_line_id_to_stock_adjustment_line_table', 1);
INSERT INTO `migrations` VALUES (101, '2018_05_31_114645_add_res_order_status_column_to_transactions_table', 1);
INSERT INTO `migrations` VALUES (102, '2018_06_05_103530_rename_purchase_line_id_in_stock_adjustment_lines_table', 1);
INSERT INTO `migrations` VALUES (103, '2018_06_05_111905_modify_products_table_for_modifiers', 1);
INSERT INTO `migrations` VALUES (104, '2018_06_06_110524_add_parent_sell_line_id_column_to_transaction_sell_lines_table', 1);
INSERT INTO `migrations` VALUES (105, '2018_06_07_152443_add_is_service_staff_to_roles_table', 1);
INSERT INTO `migrations` VALUES (106, '2018_06_07_182258_add_image_field_to_products_table', 1);
INSERT INTO `migrations` VALUES (107, '2018_06_13_133705_create_bookings_table', 1);
INSERT INTO `migrations` VALUES (108, '2018_06_15_173636_add_email_column_to_contacts_table', 1);
INSERT INTO `migrations` VALUES (109, '2018_06_27_182835_add_superadmin_related_fields_business', 1);
INSERT INTO `migrations` VALUES (110, '2018_06_27_185405_create_packages_table', 1);
INSERT INTO `migrations` VALUES (111, '2018_06_28_182803_create_subscriptions_table', 1);
INSERT INTO `migrations` VALUES (112, '2018_07_10_101913_add_custom_fields_to_products_table', 1);
INSERT INTO `migrations` VALUES (113, '2018_07_17_103434_add_sales_person_name_label_to_invoice_layouts_table', 1);
INSERT INTO `migrations` VALUES (114, '2018_07_17_120612_change_all_quantity_field_type_to_decimal', 1);
INSERT INTO `migrations` VALUES (115, '2018_07_17_163920_add_theme_skin_color_column_to_business_table', 1);
INSERT INTO `migrations` VALUES (116, '2018_07_17_182021_add_rows_to_system_table', 1);
INSERT INTO `migrations` VALUES (117, '2018_07_19_131721_add_options_to_packages_table', 1);
INSERT INTO `migrations` VALUES (118, '2018_07_24_152720_create_payment_accounts_table', 1);
INSERT INTO `migrations` VALUES (119, '2018_07_24_160319_add_lot_no_line_id_to_transaction_sell_lines_table', 1);
INSERT INTO `migrations` VALUES (120, '2018_07_25_110004_add_show_expiry_and_show_lot_colums_to_invoice_layouts_table', 1);
INSERT INTO `migrations` VALUES (121, '2018_07_25_172004_add_discount_columns_to_transaction_sell_lines_table', 1);
INSERT INTO `migrations` VALUES (122, '2018_07_26_124720_change_design_column_type_in_invoice_layouts_table', 1);
INSERT INTO `migrations` VALUES (123, '2018_07_26_170424_add_unit_price_before_discount_column_to_transaction_sell_line_table', 1);
INSERT INTO `migrations` VALUES (124, '2018_07_28_103614_add_credit_limit_column_to_contacts_table', 1);
INSERT INTO `migrations` VALUES (125, '2018_07_18_104802_add_column_to_product_table', 2);
INSERT INTO `migrations` VALUES (126, '2018_08_04_115904_add_delivery_status_to_transactions_table', 2);
INSERT INTO `migrations` VALUES (127, '2018_08_08_110755_add_new_payment_methods_to_transaction_payments_table', 2);
INSERT INTO `migrations` VALUES (128, '2018_08_08_122225_modify_cash_register_transactions_table_for_new_payment_methods', 2);

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions`  (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_id`, `model_type`) USING BTREE,
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles`  (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_id`, `model_type`) USING BTREE,
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES (1, 1, 'App\\User');
INSERT INTO `model_has_roles` VALUES (1, 3, 'App\\User');
INSERT INTO `model_has_roles` VALUES (1, 9, 'App\\User');
INSERT INTO `model_has_roles` VALUES (2, 2, 'App\\User');
INSERT INTO `model_has_roles` VALUES (3, 4, 'App\\User');
INSERT INTO `model_has_roles` VALUES (5, 5, 'App\\User');
INSERT INTO `model_has_roles` VALUES (7, 6, 'App\\User');
INSERT INTO `model_has_roles` VALUES (9, 7, 'App\\User');
INSERT INTO `model_has_roles` VALUES (11, 8, 'App\\User');
INSERT INTO `model_has_roles` VALUES (12, 10, 'App\\User');
INSERT INTO `model_has_roles` VALUES (14, 12, 'App\\User');
INSERT INTO `model_has_roles` VALUES (16, 13, 'App\\User');
INSERT INTO `model_has_roles` VALUES (24, 17, 'App\\User');
INSERT INTO `model_has_roles` VALUES (26, 18, 'App\\User');
INSERT INTO `model_has_roles` VALUES (28, 19, 'App\\User');

-- ----------------------------
-- Table structure for packages
-- ----------------------------
DROP TABLE IF EXISTS `packages`;
CREATE TABLE `packages`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_count` int(11) NOT NULL COMMENT 'No. of Business Locations, 0 = infinite option.',
  `user_count` int(11) NOT NULL,
  `product_count` int(11) NOT NULL,
  `bookings` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable bookings',
  `kitchen` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable kitchen',
  `order_screen` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable order_screen',
  `tables` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable tables',
  `invoice_count` int(11) NOT NULL,
  `interval` enum('days','months','years') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval_count` int(11) NOT NULL,
  `trial_days` int(11) NOT NULL,
  `price` decimal(20, 4) NOT NULL,
  `created_by` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of packages
-- ----------------------------
INSERT INTO `packages` VALUES (1, 'Starter - Free', 'Give it a test drive...', 1, 2, 30, 0, 0, 0, 0, 30, 'months', 1, 10, 0.0000, 1, 0, 1, NULL, '2018-08-01 22:36:32', '2018-08-01 22:40:49');
INSERT INTO `packages` VALUES (2, 'Regular', 'For Small Shops', 2, 4, 1000, 0, 0, 0, 0, 800, 'months', 1, 10, 199.9900, 1, 1, 1, NULL, '2018-08-01 22:37:50', '2018-08-01 22:42:30');
INSERT INTO `packages` VALUES (3, 'Unlimited', 'For Large Business', 0, 0, 0, 0, 0, 0, 0, 0, 'months', 1, 10, 599.9900, 1, 1, 1, NULL, '2018-08-01 22:43:37', '2018-08-01 22:43:50');
INSERT INTO `packages` VALUES (4, 'Business', 'For Small & Growing Shops...', 10, 10, 15000, 0, 0, 0, 0, 1000, 'months', 1, 10, 259.9900, 1, 5, 0, NULL, '2018-08-01 22:46:14', '2018-08-01 22:46:14');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for payment_accounts
-- ----------------------------
DROP TABLE IF EXISTS `payment_accounts`;
CREATE TABLE `payment_accounts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_by` int(11) NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'profit_loss_report.view', 'web', '2018-08-03 01:17:25', NULL);
INSERT INTO `permissions` VALUES (2, 'direct_sell.access', 'web', '2018-08-03 01:17:25', NULL);
INSERT INTO `permissions` VALUES (3, 'product.opening_stock', 'web', '2018-08-03 01:18:17', '2018-08-03 01:18:17');
INSERT INTO `permissions` VALUES (4, 'crud_all_bookings', 'web', '2018-08-03 01:18:40', '2018-08-03 01:18:40');
INSERT INTO `permissions` VALUES (5, 'crud_own_bookings', 'web', '2018-08-03 01:18:40', '2018-08-03 01:18:40');
INSERT INTO `permissions` VALUES (6, 'user.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (7, 'user.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (8, 'user.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (9, 'user.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (10, 'supplier.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (11, 'supplier.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (12, 'supplier.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (13, 'supplier.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (14, 'customer.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (15, 'customer.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (16, 'customer.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (17, 'customer.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (18, 'product.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (19, 'product.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (20, 'product.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (21, 'product.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (22, 'purchase.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (23, 'purchase.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (24, 'purchase.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (25, 'purchase.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (26, 'sell.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (27, 'sell.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (28, 'sell.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (29, 'sell.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (30, 'purchase_n_sell_report.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (31, 'contacts_report.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (32, 'stock_report.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (33, 'tax_report.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (34, 'trending_product_report.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (35, 'register_report.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (36, 'sales_representative.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (37, 'expense_report.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (38, 'business_settings.access', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (39, 'barcode_settings.access', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (40, 'invoice_settings.access', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (41, 'brand.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (42, 'brand.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (43, 'brand.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (44, 'brand.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (45, 'tax_rate.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (46, 'tax_rate.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (47, 'tax_rate.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (48, 'tax_rate.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (49, 'unit.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (50, 'unit.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (51, 'unit.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (52, 'unit.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (53, 'category.view', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (54, 'category.create', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (55, 'category.update', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (56, 'category.delete', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (57, 'expense.access', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (58, 'access_all_locations', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (59, 'dashboard.data', 'web', '2018-08-03 01:19:19', NULL);
INSERT INTO `permissions` VALUES (60, 'location.1', 'web', '2018-08-03 01:19:27', NULL);
INSERT INTO `permissions` VALUES (61, 'location.2', 'web', '2018-08-03 01:19:28', NULL);
INSERT INTO `permissions` VALUES (62, 'location.3', 'web', '2018-08-03 01:19:28', NULL);
INSERT INTO `permissions` VALUES (63, 'location.4', 'web', '2018-08-03 01:19:29', NULL);
INSERT INTO `permissions` VALUES (64, 'location.5', 'web', '2018-08-03 01:19:30', NULL);
INSERT INTO `permissions` VALUES (65, 'location.6', 'web', '2018-08-06 22:45:35', '2018-08-06 22:45:35');
INSERT INTO `permissions` VALUES (66, 'location.7', 'web', '2019-01-17 07:21:44', '2019-01-17 07:21:44');
INSERT INTO `permissions` VALUES (67, 'location.12', 'web', '2019-01-27 02:18:35', '2019-01-27 02:18:35');
INSERT INTO `permissions` VALUES (68, 'location.13', 'web', '2019-01-27 02:33:29', '2019-01-27 02:33:29');
INSERT INTO `permissions` VALUES (69, 'location.14', 'web', '2019-01-27 02:36:24', '2019-01-27 02:36:24');
INSERT INTO `permissions` VALUES (70, 'location.8', 'web', '2019-02-09 10:37:36', '2019-02-09 10:37:36');
INSERT INTO `permissions` VALUES (71, 'location.9', 'web', '2019-02-10 02:01:52', '2019-02-10 02:01:52');
INSERT INTO `permissions` VALUES (72, 'location.10', 'web', '2019-02-12 13:47:50', '2019-02-12 13:47:50');
INSERT INTO `permissions` VALUES (73, 'location.11', 'web', '2019-02-15 09:26:10', '2019-02-15 09:26:10');
INSERT INTO `permissions` VALUES (74, 'location.15', 'web', '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `permissions` VALUES (75, 'location.16', 'web', '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `permissions` VALUES (76, 'location.17', 'web', '2019-02-15 10:24:03', '2019-02-15 10:24:03');

-- ----------------------------
-- Table structure for printers
-- ----------------------------
DROP TABLE IF EXISTS `printers`;
CREATE TABLE `printers`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection_type` enum('network','windows','linux') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `capability_profile` enum('default','simple','SP2000','TEP-200M','P822D') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `char_per_line` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ip_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `port` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `path` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `printers_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `printers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for product_racks
-- ----------------------------
DROP TABLE IF EXISTS `product_racks`;
CREATE TABLE `product_racks`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `rack` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `row` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `position` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of product_racks
-- ----------------------------
INSERT INTO `product_racks` VALUES (1, 1, 1, 1, NULL, NULL, NULL, '2019-01-19 08:54:09', '2019-01-19 08:55:57');
INSERT INTO `product_racks` VALUES (2, 1, 7, 1, NULL, NULL, NULL, '2019-01-19 08:54:09', '2019-01-19 08:55:57');

-- ----------------------------
-- Table structure for product_variations
-- ----------------------------
DROP TABLE IF EXISTS `product_variations`;
CREATE TABLE `product_variations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `is_dummy` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_variations_name_index`(`name`) USING BTREE,
  INDEX `product_variations_product_id_index`(`product_id`) USING BTREE,
  CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 139 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of product_variations
-- ----------------------------
INSERT INTO `product_variations` VALUES (1, 'DUMMY', 1, 1, '2018-01-03 23:59:08', '2018-01-03 23:59:08');
INSERT INTO `product_variations` VALUES (2, 'Waist Size', 2, 0, '2018-01-04 00:00:35', '2018-01-06 07:44:12');
INSERT INTO `product_variations` VALUES (3, 'Size', 3, 0, '2018-01-04 01:21:52', '2018-01-06 07:43:48');
INSERT INTO `product_variations` VALUES (4, 'Size', 4, 0, '2018-01-04 01:24:34', '2018-01-06 07:49:36');
INSERT INTO `product_variations` VALUES (8, 'Size', 8, 0, '2018-01-04 01:40:10', '2018-01-06 07:48:46');
INSERT INTO `product_variations` VALUES (10, 'Size', 10, 0, '2018-01-04 01:43:02', '2018-01-06 07:49:20');
INSERT INTO `product_variations` VALUES (11, 'DUMMY', 11, 1, '2018-01-04 01:44:35', '2018-01-04 01:44:35');
INSERT INTO `product_variations` VALUES (12, 'DUMMY', 12, 1, '2018-01-04 01:45:50', '2018-01-04 01:45:50');
INSERT INTO `product_variations` VALUES (13, 'Size', 13, 0, '2018-01-04 01:47:59', '2018-01-06 07:44:48');
INSERT INTO `product_variations` VALUES (14, 'Color', 14, 0, '2018-01-06 08:12:19', '2018-01-06 08:12:19');
INSERT INTO `product_variations` VALUES (15, 'Internal Memory', 14, 0, '2018-01-06 08:14:14', '2018-01-06 08:14:14');
INSERT INTO `product_variations` VALUES (16, 'Color', 15, 0, '2018-01-06 08:19:51', '2018-01-06 08:19:51');
INSERT INTO `product_variations` VALUES (17, 'Internal Memory', 15, 0, '2018-01-06 08:19:51', '2018-01-06 08:19:51');
INSERT INTO `product_variations` VALUES (18, 'Color', 16, 0, '2018-01-06 08:24:48', '2018-01-06 08:24:48');
INSERT INTO `product_variations` VALUES (19, 'Color', 17, 0, '2018-01-06 08:35:01', '2018-01-06 08:35:01');
INSERT INTO `product_variations` VALUES (20, 'Storage', 18, 0, '2018-01-06 08:37:30', '2018-01-06 08:37:30');
INSERT INTO `product_variations` VALUES (21, 'DUMMY', 19, 1, '2018-01-06 08:40:28', '2018-01-06 08:40:28');
INSERT INTO `product_variations` VALUES (22, 'Color', 20, 0, '2018-01-06 08:43:00', '2018-01-06 08:43:00');
INSERT INTO `product_variations` VALUES (23, 'DUMMY', 21, 1, '2018-01-06 08:46:35', '2018-01-06 08:46:35');
INSERT INTO `product_variations` VALUES (24, 'DUMMY', 22, 1, '2018-01-06 08:55:09', '2018-01-06 08:55:09');
INSERT INTO `product_variations` VALUES (25, 'DUMMY', 23, 1, '2018-01-06 08:56:27', '2018-01-06 08:56:27');
INSERT INTO `product_variations` VALUES (26, 'DUMMY', 24, 1, '2018-01-06 09:01:22', '2018-01-06 09:01:22');
INSERT INTO `product_variations` VALUES (27, 'DUMMY', 25, 1, '2018-01-06 09:02:23', '2018-01-06 09:02:23');
INSERT INTO `product_variations` VALUES (28, 'DUMMY', 26, 1, '2018-01-06 09:05:51', '2018-01-06 09:05:51');
INSERT INTO `product_variations` VALUES (29, 'DUMMY', 27, 1, '2018-01-06 09:13:16', '2018-01-06 09:13:16');
INSERT INTO `product_variations` VALUES (30, 'DUMMY', 28, 1, '2018-01-06 09:15:47', '2018-01-06 09:15:47');
INSERT INTO `product_variations` VALUES (31, 'DUMMY', 29, 1, '2018-01-06 09:16:53', '2018-01-06 09:16:53');
INSERT INTO `product_variations` VALUES (32, 'DUMMY', 30, 1, '2018-01-06 09:18:59', '2018-01-06 09:18:59');
INSERT INTO `product_variations` VALUES (33, 'DUMMY', 31, 1, '2018-04-10 12:36:29', '2018-04-10 12:36:29');
INSERT INTO `product_variations` VALUES (34, 'DUMMY', 32, 1, '2018-04-10 12:37:52', '2018-04-10 12:37:52');
INSERT INTO `product_variations` VALUES (35, 'DUMMY', 33, 1, '2018-04-10 12:39:45', '2018-04-10 12:39:45');
INSERT INTO `product_variations` VALUES (36, 'DUMMY', 34, 1, '2018-04-10 12:40:59', '2018-04-10 12:40:59');
INSERT INTO `product_variations` VALUES (37, 'DUMMY', 35, 1, '2018-04-10 12:42:53', '2018-04-10 12:42:53');
INSERT INTO `product_variations` VALUES (38, 'DUMMY', 36, 1, '2018-04-10 12:44:18', '2018-04-10 12:44:18');
INSERT INTO `product_variations` VALUES (39, 'DUMMY', 37, 1, '2018-04-10 13:01:29', '2018-04-10 13:01:29');
INSERT INTO `product_variations` VALUES (40, 'DUMMY', 38, 1, '2018-04-10 13:02:35', '2018-04-10 13:02:35');
INSERT INTO `product_variations` VALUES (41, 'DUMMY', 39, 1, '2018-04-10 13:03:26', '2018-04-10 13:03:26');
INSERT INTO `product_variations` VALUES (42, 'DUMMY', 40, 1, '2018-04-10 13:04:32', '2018-04-10 13:04:32');
INSERT INTO `product_variations` VALUES (43, 'DUMMY', 41, 1, '2018-04-10 13:38:27', '2018-04-10 13:38:27');
INSERT INTO `product_variations` VALUES (44, 'DUMMY', 42, 1, '2018-04-10 13:45:52', '2018-04-10 13:45:52');
INSERT INTO `product_variations` VALUES (45, 'DUMMY', 43, 1, '2018-04-10 13:48:01', '2018-04-10 13:48:01');
INSERT INTO `product_variations` VALUES (46, 'DUMMY', 44, 1, '2018-04-10 13:49:10', '2018-04-10 13:49:10');
INSERT INTO `product_variations` VALUES (47, 'DUMMY', 45, 1, '2018-04-10 13:50:22', '2018-04-10 13:50:22');
INSERT INTO `product_variations` VALUES (48, 'DUMMY', 46, 1, '2018-04-10 13:52:04', '2018-04-10 13:52:04');
INSERT INTO `product_variations` VALUES (49, 'DUMMY', 47, 1, '2018-04-10 13:53:45', '2018-04-10 13:53:45');
INSERT INTO `product_variations` VALUES (50, 'DUMMY', 48, 1, '2018-04-10 13:54:42', '2018-04-10 13:54:42');
INSERT INTO `product_variations` VALUES (51, 'DUMMY', 49, 1, '2018-04-10 13:55:55', '2018-04-10 13:55:55');
INSERT INTO `product_variations` VALUES (52, 'DUMMY', 50, 1, '2018-04-10 14:04:32', '2018-04-10 14:04:32');
INSERT INTO `product_variations` VALUES (53, 'DUMMY', 51, 1, '2018-04-10 15:04:57', '2018-04-10 15:04:57');
INSERT INTO `product_variations` VALUES (54, 'DUMMY', 52, 1, '2018-04-10 15:05:55', '2018-04-10 15:05:55');
INSERT INTO `product_variations` VALUES (55, 'DUMMY', 53, 1, '2018-04-10 15:09:15', '2018-04-10 15:09:15');
INSERT INTO `product_variations` VALUES (56, 'DUMMY', 54, 1, '2018-04-10 15:24:16', '2018-04-10 15:24:16');
INSERT INTO `product_variations` VALUES (57, 'DUMMY', 55, 1, '2018-04-10 15:26:18', '2018-04-10 15:26:18');
INSERT INTO `product_variations` VALUES (58, 'DUMMY', 56, 1, '2018-04-10 15:31:59', '2018-04-10 15:31:59');
INSERT INTO `product_variations` VALUES (59, 'DUMMY', 57, 1, '2018-04-10 15:33:01', '2018-04-10 15:33:01');
INSERT INTO `product_variations` VALUES (60, 'DUMMY', 58, 1, '2018-04-10 15:33:37', '2018-04-10 15:33:37');
INSERT INTO `product_variations` VALUES (61, 'DUMMY', 59, 1, '2018-04-10 15:36:45', '2018-04-10 15:36:45');
INSERT INTO `product_variations` VALUES (62, 'DUMMY', 60, 1, '2018-04-10 15:37:08', '2018-04-10 15:37:08');
INSERT INTO `product_variations` VALUES (63, 'DUMMY', 61, 1, '2018-04-10 15:37:08', '2018-04-10 15:37:08');
INSERT INTO `product_variations` VALUES (64, 'DUMMY', 62, 1, '2018-04-10 15:37:08', '2018-04-10 15:37:08');
INSERT INTO `product_variations` VALUES (65, 'DUMMY', 63, 1, '2018-04-10 15:37:08', '2018-04-10 15:37:08');
INSERT INTO `product_variations` VALUES (66, 'DUMMY', 64, 1, '2018-04-10 15:37:08', '2018-04-10 15:37:08');
INSERT INTO `product_variations` VALUES (67, 'DUMMY', 65, 1, '2018-04-10 15:37:08', '2018-04-10 15:37:08');
INSERT INTO `product_variations` VALUES (68, 'DUMMY', 66, 1, '2018-07-13 03:30:31', '2018-07-13 03:30:31');
INSERT INTO `product_variations` VALUES (69, 'DUMMY', 67, 1, '2018-07-13 03:34:47', '2018-07-13 03:34:47');
INSERT INTO `product_variations` VALUES (70, 'DUMMY', 68, 1, '2018-07-13 03:38:55', '2018-07-13 03:38:55');
INSERT INTO `product_variations` VALUES (71, 'DUMMY', 69, 1, '2018-07-13 03:45:51', '2018-07-13 03:45:51');
INSERT INTO `product_variations` VALUES (72, 'DUMMY', 70, 1, '2018-07-13 03:57:37', '2018-07-13 03:57:37');
INSERT INTO `product_variations` VALUES (73, 'DUMMY', 71, 1, '2018-07-13 04:00:41', '2018-07-13 04:00:41');
INSERT INTO `product_variations` VALUES (74, 'DUMMY', 72, 1, '2018-07-13 04:05:03', '2018-07-13 04:05:03');
INSERT INTO `product_variations` VALUES (75, 'DUMMY', 73, 1, '2018-07-13 04:07:29', '2018-07-13 04:07:29');
INSERT INTO `product_variations` VALUES (76, 'DUMMY', 74, 1, '2018-07-13 04:10:44', '2018-07-13 04:10:44');
INSERT INTO `product_variations` VALUES (77, 'DUMMY', 75, 1, '2018-07-13 04:13:09', '2018-07-13 04:13:09');
INSERT INTO `product_variations` VALUES (78, 'DUMMY', 76, 1, '2018-07-13 04:18:33', '2018-07-13 04:18:33');
INSERT INTO `product_variations` VALUES (79, 'DUMMY', 77, 1, '2018-07-13 04:24:22', '2018-07-13 04:24:22');
INSERT INTO `product_variations` VALUES (80, 'DUMMY', 78, 0, '2018-07-16 10:28:04', '2018-07-16 10:28:04');
INSERT INTO `product_variations` VALUES (81, 'DUMMY', 79, 0, '2018-07-16 10:35:37', '2018-07-16 10:35:37');
INSERT INTO `product_variations` VALUES (82, 'DUMMY', 80, 1, '2018-08-08 06:59:03', '2018-08-08 06:59:03');
INSERT INTO `product_variations` VALUES (83, 'DUMMY', 81, 1, '2018-08-13 01:40:39', '2018-08-13 01:40:39');
INSERT INTO `product_variations` VALUES (84, 'DUMMY', 82, 1, '2018-08-13 01:41:16', '2018-08-13 01:41:16');
INSERT INTO `product_variations` VALUES (85, 'DUMMY', 83, 1, '2018-08-13 01:41:48', '2018-08-13 01:41:48');
INSERT INTO `product_variations` VALUES (86, 'DUMMY', 86, 1, '2019-01-16 09:07:49', '2019-01-16 09:07:49');
INSERT INTO `product_variations` VALUES (87, 'DUMMY', 87, 1, '2019-01-16 09:14:25', '2019-01-16 09:14:25');
INSERT INTO `product_variations` VALUES (88, 'DUMMY', 88, 1, '2019-01-16 09:18:57', '2019-01-16 09:18:57');
INSERT INTO `product_variations` VALUES (89, 'DUMMY', 90, 1, '2019-01-17 02:00:04', '2019-01-17 02:00:04');
INSERT INTO `product_variations` VALUES (90, 'DUMMY', 91, 1, '2019-01-17 02:08:38', '2019-01-17 02:08:38');
INSERT INTO `product_variations` VALUES (91, 'DUMMY', 92, 1, '2019-01-17 02:28:09', '2019-01-17 02:28:09');
INSERT INTO `product_variations` VALUES (92, 'DUMMY', 93, 1, '2019-01-17 02:28:39', '2019-01-17 02:28:39');
INSERT INTO `product_variations` VALUES (93, 'DUMMY', 94, 1, '2019-01-19 05:31:33', '2019-01-19 05:31:33');
INSERT INTO `product_variations` VALUES (94, 'DUMMY', 95, 1, '2019-01-19 08:13:35', '2019-01-19 08:13:35');
INSERT INTO `product_variations` VALUES (95, 'DUMMY', 96, 1, '2019-01-19 15:38:00', '2019-01-19 15:38:00');
INSERT INTO `product_variations` VALUES (96, 'Size (Shoes)', 97, 0, '2019-01-25 11:49:04', '2019-01-25 11:49:04');
INSERT INTO `product_variations` VALUES (100, 'DUMMY', 101, 1, '2019-01-28 05:32:45', '2019-01-28 05:32:45');
INSERT INTO `product_variations` VALUES (102, 'DUMMY', 103, 1, '2019-01-28 05:58:43', '2019-01-28 05:58:43');
INSERT INTO `product_variations` VALUES (103, 'DUMMY', 104, 1, '2019-01-28 06:12:45', '2019-01-28 06:12:45');
INSERT INTO `product_variations` VALUES (105, 'DUMMY', 106, 1, '2019-01-28 20:11:37', '2019-01-28 20:11:37');
INSERT INTO `product_variations` VALUES (106, 'DUMMY', 107, 1, '2019-01-28 20:12:07', '2019-01-28 20:12:07');
INSERT INTO `product_variations` VALUES (110, 'DUMMY', 111, 1, '2019-01-31 01:34:00', '2019-01-31 01:34:00');
INSERT INTO `product_variations` VALUES (111, 'DUMMY', 112, 1, '2019-02-02 03:21:33', '2019-02-02 03:21:33');
INSERT INTO `product_variations` VALUES (114, 'DUMMY', 115, 1, '2019-02-02 04:33:43', '2019-02-02 04:33:43');
INSERT INTO `product_variations` VALUES (118, 'DUMMY', 119, 1, '2019-02-02 07:55:02', '2019-02-02 07:55:02');
INSERT INTO `product_variations` VALUES (124, 'DUMMY', 125, 1, '2019-02-02 07:58:26', '2019-02-02 07:58:26');
INSERT INTO `product_variations` VALUES (125, 'DUMMY', 126, 1, '2019-02-08 21:57:03', '2019-02-08 21:57:03');
INSERT INTO `product_variations` VALUES (126, 'DUMMY', 127, 1, '2019-02-10 05:37:09', '2019-02-10 05:37:09');
INSERT INTO `product_variations` VALUES (127, 'DUMMY', 128, 1, '2019-02-12 19:13:18', '2019-02-12 19:13:18');
INSERT INTO `product_variations` VALUES (128, 'DUMMY', 129, 1, '2019-02-13 15:13:35', '2019-02-13 15:13:35');
INSERT INTO `product_variations` VALUES (129, 'DUMMY', 130, 1, '2019-02-13 23:03:28', '2019-02-13 23:03:28');
INSERT INTO `product_variations` VALUES (130, 'DUMMY', 131, 1, '2019-02-14 00:00:55', '2019-02-14 00:00:55');
INSERT INTO `product_variations` VALUES (131, 'DUMMY', 132, 1, '2019-02-14 12:19:46', '2019-02-14 12:19:46');
INSERT INTO `product_variations` VALUES (132, 'DUMMY', 133, 1, '2019-02-14 12:20:37', '2019-02-14 12:20:37');
INSERT INTO `product_variations` VALUES (134, 'DUMMY', 135, 1, '2019-02-15 09:24:38', '2019-02-15 09:24:38');
INSERT INTO `product_variations` VALUES (135, 'DUMMY', 136, 1, '2019-02-15 15:56:46', '2019-02-15 15:56:46');
INSERT INTO `product_variations` VALUES (136, 'DUMMY', 137, 1, '2019-02-16 14:06:25', '2019-02-16 14:06:25');
INSERT INTO `product_variations` VALUES (137, 'DUMMY', 138, 1, '2019-02-19 08:07:46', '2019-02-19 08:07:46');
INSERT INTO `product_variations` VALUES (138, 'DUMMY', 139, 1, '2019-02-19 08:15:38', '2019-02-19 08:15:38');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `ref_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('single','variable','modifier') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `unit_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `brand_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `category_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `sub_category_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `tax` int(10) UNSIGNED NULL DEFAULT NULL,
  `tax_type` enum('inclusive','exclusive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `enable_stock` tinyint(1) NULL DEFAULT 0,
  `alert_quantity` int(11) NULL DEFAULT NULL,
  `sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `barcode_type` enum('C39','C128','EAN13','EAN8','UPCA','UPCE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'C128',
  `expiry_period` decimal(4, 2) NULL DEFAULT NULL,
  `expiry_period_type` enum('days','months') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `enable_sr_no` tinyint(1) NULL DEFAULT 0,
  `weight` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `product_custom_field1` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `product_custom_field2` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `product_custom_field3` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `product_custom_field4` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `supplier_id` int(11) NULL DEFAULT NULL,
  `currency` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `products_brand_id_foreign`(`brand_id`) USING BTREE,
  INDEX `products_category_id_foreign`(`category_id`) USING BTREE,
  INDEX `products_sub_category_id_foreign`(`sub_category_id`) USING BTREE,
  INDEX `products_tax_foreign`(`tax`) USING BTREE,
  INDEX `products_name_index`(`name`) USING BTREE,
  INDEX `products_business_id_index`(`business_id`) USING BTREE,
  INDEX `products_unit_id_index`(`unit_id`) USING BTREE,
  INDEX `products_created_by_index`(`created_by`) USING BTREE,
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_tax_foreign` FOREIGN KEY (`tax`) REFERENCES `tax_rates` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 140 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Men\'s Reverse Fleece Crew', 1, '1234567', 'single', 1, 1, 1, 5, NULL, 'exclusive', 1, 5, 'AS0001', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728059_fleece_crew.jpg', 1, '2018-01-03 23:59:08', '2019-01-19 15:35:12');
INSERT INTO `products` VALUES (2, 'Levis Men\'s Slimmy Fit Jeans', 1, '34124', 'variable', 1, 1, 1, 4, 1, 'exclusive', 1, 10, 'AS0002', 'C128', 99.99, 'days', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727964_levis_jeans.jpg', 1, '2018-01-04 00:00:35', '2019-01-27 08:42:32');
INSERT INTO `products` VALUES (3, 'Men\'s Cozy Hoodie Sweater', 1, '14231231', 'variable', 1, 2, 1, 5, 1, 'exclusive', 1, 10, 'AS0003', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728035_cozy_sweater.jpg', 1, '2018-01-04 01:21:52', '2019-01-19 11:39:09');
INSERT INTO `products` VALUES (4, 'Puma Brown Sneaker', 1, '0', 'variable', 1, 5, 3, 8, 1, 'exclusive', 1, 5, 'AS0004', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728147_puma_brown_sneaker.jpg', 1, '2018-01-04 01:24:33', '2018-06-11 10:12:27');
INSERT INTO `products` VALUES (8, 'Nike Fashion Sneaker', 1, '0', 'variable', 1, 4, 3, 8, 1, 'exclusive', 1, 10, 'AS0008', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728076_nike_sneaker.jpg', 1, '2018-01-04 01:40:10', '2018-06-11 10:11:16');
INSERT INTO `products` VALUES (10, 'NIKE Men\'s Running Shoe', 1, '0', 'variable', 1, 4, 3, 8, 1, 'exclusive', 1, 10, 'AS0010', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728095_nike_running_shoe.jpg', 1, '2018-01-04 01:43:02', '2018-06-11 10:11:35');
INSERT INTO `products` VALUES (11, 'U.S. Polo Men\'s Leather Belt', 1, '0', 'single', 1, 3, 3, 6, 1, 'exclusive', 1, 15, 'AS0011', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727768_belt.jpg', 1, '2018-01-04 01:44:35', '2018-06-11 10:06:08');
INSERT INTO `products` VALUES (12, 'Unisex Brown Leather Wallet', 1, '0', 'single', 1, 1, 3, 11, 1, 'exclusive', 1, 10, 'AS0012', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727750_unisex_brown_wallet.jpg', 1, '2018-01-04 01:45:50', '2018-06-11 10:05:50');
INSERT INTO `products` VALUES (13, 'Men Full sleeve T Shirt', 1, '0', 'variable', 1, 2, 1, 5, 1, 'exclusive', 1, 15, 'AS0013', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728019_mens_tshirt.jpg', 1, '2018-01-04 01:47:59', '2018-06-11 10:10:19');
INSERT INTO `products` VALUES (14, 'Samsung Galaxy S8', 1, '0', 'variable', 1, 7, 12, 13, 1, 'exclusive', 1, 100, 'AS0014', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728193_s8.jpg', 1, '2018-01-06 08:12:19', '2018-06-11 10:13:13');
INSERT INTO `products` VALUES (15, 'Apple iPhone 8', 1, '0', 'variable', 1, 8, 12, 13, 1, 'exclusive', 1, 100, 'AS0015', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727817_iphone8.jpg', 1, '2018-01-06 08:19:51', '2018-06-11 10:06:57');
INSERT INTO `products` VALUES (16, 'Samsung Galaxy J7 Pro', 1, '0', 'variable', 1, 7, 12, 13, NULL, 'exclusive', 1, 100, 'AS0016', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728178_j7_pro.jpg', 1, '2018-01-06 08:24:48', '2018-06-11 10:12:58');
INSERT INTO `products` VALUES (17, 'Acer Aspire E 15', 1, '0', 'variable', 1, 9, 12, 14, NULL, 'exclusive', 1, 70, 'AS0017', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727793_acerE15.jpg', 1, '2018-01-06 08:35:01', '2019-01-19 07:59:51');
INSERT INTO `products` VALUES (18, 'Apple MacBook Air', 1, '0', 'variable', 1, 8, 12, 14, NULL, 'exclusive', 1, 30, 'AS0018', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727849_macbookair.jpg', 1, '2018-01-06 08:37:30', '2018-06-11 10:07:29');
INSERT INTO `products` VALUES (19, 'Cushion Crew Socks', 1, '0', 'single', 1, 4, 15, 16, NULL, 'exclusive', 1, 100, 'AS0019', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727903_socks.jpg', 1, '2018-01-06 08:40:28', '2018-06-11 10:08:23');
INSERT INTO `products` VALUES (20, 'Sports Tights Pants', 1, '0', 'variable', 1, 6, 15, 16, 1, 'exclusive', 1, 60, 'AS0020', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728250_sports_pant.jpg', 1, '2018-01-06 08:43:00', '2018-06-11 10:14:10');
INSERT INTO `products` VALUES (21, 'Pair Of Dumbbells', 1, '0', 'single', 1, 10, 15, 17, NULL, 'exclusive', 1, 45, 'AS0021', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728133_pair_of_dumbell.jpg', 1, '2018-01-06 08:46:35', '2018-06-11 10:12:13');
INSERT INTO `products` VALUES (22, 'Diary of a Wimpy Kid', 1, '0', 'single', 1, NULL, 18, 20, 1, 'exclusive', 1, 20, 'AS0022', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727917_diary_of_whimp_kid.jpeg', 1, '2018-01-06 08:55:09', '2018-06-11 10:08:37');
INSERT INTO `products` VALUES (23, 'Sneezy the Snowman', 1, '0', 'single', 1, NULL, 18, 20, NULL, 'exclusive', 1, 20, 'AS0023', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728231_sneezy.jpg', 1, '2018-01-06 08:56:27', '2018-06-11 10:13:51');
INSERT INTO `products` VALUES (24, 'Etched in Sand Autobiography', 1, '0', 'single', 1, NULL, 18, 19, 1, 'exclusive', 1, 30, 'AS0024', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727933_etched_in_stone.jpg', 1, '2018-01-06 09:01:22', '2018-06-11 10:08:53');
INSERT INTO `products` VALUES (25, 'Five Presidents', 1, '0', 'single', 1, NULL, 18, 19, NULL, 'exclusive', 1, 30, 'AS0025', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727949_five_pesident.jpg', 1, '2018-01-06 09:02:22', '2018-06-11 10:09:09');
INSERT INTO `products` VALUES (26, 'Oreo Cookies', 1, '0', 'single', 2, 11, 21, NULL, NULL, 'exclusive', 1, 500, 'AS0026', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728111_oreo.jpg', 1, '2018-01-06 09:05:51', '2018-06-11 10:11:51');
INSERT INTO `products` VALUES (27, 'Butter Cookies', 1, '0', 'single', 2, 12, 21, NULL, 1, 'exclusive', 1, 100, 'AS0027', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727881_butter_cookies.jpg', 1, '2018-01-06 09:13:16', '2018-06-11 10:08:01');
INSERT INTO `products` VALUES (28, 'Barilla Pasta', 1, '0', 'single', 2, 13, 21, NULL, 1, 'exclusive', 1, 50, 'AS0028', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727865_barilla_pasta.jpeg', 1, '2018-01-06 09:15:47', '2018-06-11 10:07:45');
INSERT INTO `products` VALUES (29, 'Thin Spaghetti', 1, '0', 'single', 2, 13, 21, NULL, NULL, 'exclusive', 1, 100, 'AS0029', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528728274_thin_spegatti.jpg', 1, '2018-01-06 09:16:53', '2018-06-11 10:14:34');
INSERT INTO `products` VALUES (30, 'Lipton Black Tea Bags', 1, '0', 'single', 2, 14, 21, NULL, 1, 'exclusive', 1, 50, 'AS0030', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528727999_lipton_tea.jpg', 1, '2018-01-06 09:18:59', '2018-06-11 10:09:59');
INSERT INTO `products` VALUES (31, 'Dolocare 1g paracetol', 2, '0', 'single', 4, 16, 27, NULL, NULL, 'exclusive', 1, 50, 'AP0031', 'C128', 24.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 12:36:29', '2018-04-10 12:36:29');
INSERT INTO `products` VALUES (32, 'Lexin 500mg capsule', 2, '0', 'single', 4, 16, 22, NULL, NULL, 'exclusive', 1, 30, 'AP0032', 'C128', 24.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 12:37:52', '2018-04-10 12:37:52');
INSERT INTO `products` VALUES (33, 'Oflen-75', 2, '0', 'single', 4, 15, 22, NULL, NULL, 'exclusive', 1, 30, 'AP0033', 'C128', 36.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 12:39:45', '2018-04-10 12:39:45');
INSERT INTO `products` VALUES (34, 'Cistiben Forte', 2, '0', 'single', 4, 16, 22, NULL, NULL, 'exclusive', 1, 25, 'AP0034', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 12:40:59', '2018-04-10 12:40:59');
INSERT INTO `products` VALUES (35, 'Disflatyl drop 30ml', 2, '0', 'single', 4, 17, 25, NULL, NULL, 'exclusive', 1, 20, 'AP0035', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 12:42:53', '2018-04-10 12:42:53');
INSERT INTO `products` VALUES (36, 'Mycoheal 40', 2, '0', 'single', 4, 17, 26, NULL, NULL, 'exclusive', 1, 30, 'AP0036', 'C128', 6.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 12:44:18', '2018-04-10 12:44:18');
INSERT INTO `products` VALUES (37, 'Laboxyl', 2, '0', 'single', 4, 16, 24, NULL, NULL, 'exclusive', 1, 20, 'AP0037', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 13:01:29', '2018-04-10 13:01:29');
INSERT INTO `products` VALUES (38, 'Fertilex plus men', 2, '0', 'single', 4, 15, 22, NULL, NULL, 'exclusive', 1, 30, 'AP0038', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 13:02:35', '2018-04-10 13:02:35');
INSERT INTO `products` VALUES (39, 'vitamin E AIWA', 2, '0', 'single', 4, 15, 22, NULL, NULL, 'exclusive', 1, 20, 'AP0039', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 13:03:26', '2018-04-10 13:03:26');
INSERT INTO `products` VALUES (40, 'Glycerol 4g', 2, '0', 'single', 4, 16, 22, NULL, NULL, 'exclusive', 1, 20, 'AP0040', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 4, '2018-04-10 13:04:32', '2018-04-10 13:04:49');
INSERT INTO `products` VALUES (41, 'HP 15-AY020TU', 3, '0', 'single', 5, 23, 30, NULL, NULL, 'inclusive', 1, 10, 'AE0041', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:38:27', '2018-04-10 13:38:27');
INSERT INTO `products` VALUES (42, 'HP Pavilion 15-AU624TX', 3, '0', 'single', 5, 23, NULL, NULL, NULL, 'exclusive', 1, 10, 'AE0042', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:45:52', '2018-04-10 14:21:21');
INSERT INTO `products` VALUES (43, 'iPhone 6s plus', 3, '0', 'single', 5, 20, 28, NULL, NULL, 'exclusive', 1, 20, 'AE0043', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:48:01', '2018-04-10 13:48:01');
INSERT INTO `products` VALUES (44, 'Samsung J7 Pro', 3, '0', 'single', 5, 18, 28, NULL, NULL, 'exclusive', 1, 20, 'AE0044', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:49:10', '2018-04-10 13:49:10');
INSERT INTO `products` VALUES (45, 'Samsung Galaxy S7 Edge', 3, '0', 'single', 5, 18, 28, NULL, NULL, 'exclusive', 1, 20, 'AE0045', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:50:21', '2018-04-10 13:50:21');
INSERT INTO `products` VALUES (46, 'LG G6 64 GB', 3, '0', 'single', 5, 19, 28, NULL, NULL, 'exclusive', 1, 10, 'AE0046', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:52:04', '2018-04-10 13:52:04');
INSERT INTO `products` VALUES (47, 'Panasonic TH-58D300DX', 3, '0', 'single', 5, 22, 31, NULL, NULL, 'exclusive', 1, 20, 'AE0047', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:53:45', '2018-04-10 13:53:45');
INSERT INTO `products` VALUES (48, 'Samsung 50MU6100', 3, '0', 'single', 5, 18, NULL, NULL, NULL, 'exclusive', 1, 7, 'AE0048', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:54:42', '2018-04-10 14:22:07');
INSERT INTO `products` VALUES (49, 'LG 55E7T', 3, '0', 'single', 5, 19, 31, NULL, NULL, 'exclusive', 1, 5, 'AE0049', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 13:55:55', '2018-04-10 13:55:55');
INSERT INTO `products` VALUES (50, 'SONY ILCE-6000L/B', 3, '0', 'single', 5, 21, NULL, NULL, NULL, 'exclusive', 1, 10, 'AE0050', 'C128', NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 5, '2018-04-10 14:04:32', '2018-04-10 14:04:32');
INSERT INTO `products` VALUES (51, 'Oil and filter change', 4, '0', 'single', 6, NULL, 34, NULL, NULL, 'exclusive', 0, 0, 'AS0051', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:04:57', '2018-04-10 15:04:57');
INSERT INTO `products` VALUES (52, 'Removal of wheels and brakes checked', 4, '0', 'single', 6, NULL, 34, NULL, NULL, 'exclusive', 0, 0, 'AS0052', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:05:55', '2018-04-10 15:05:55');
INSERT INTO `products` VALUES (53, 'Full body wash', 4, '0', 'single', 6, NULL, 34, NULL, NULL, 'exclusive', 0, 0, 'AS0053', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:09:15', '2018-04-10 15:09:15');
INSERT INTO `products` VALUES (54, 'Hair Cut', 4, '0', 'single', 6, NULL, 35, NULL, NULL, 'exclusive', 0, 0, 'AS0054', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:24:16', '2018-04-10 15:24:16');
INSERT INTO `products` VALUES (55, 'Wash And Blow Dry', 4, '0', 'single', 6, NULL, 35, NULL, NULL, 'exclusive', 0, 0, 'AS0055', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:26:18', '2018-04-10 15:26:18');
INSERT INTO `products` VALUES (56, 'Thai massage', 4, '0', 'single', 6, NULL, 38, NULL, NULL, 'exclusive', 0, 0, 'AS0056', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:31:59', '2018-04-10 15:31:59');
INSERT INTO `products` VALUES (57, 'Toilet Repair', 4, '0', 'single', 6, NULL, 36, NULL, NULL, 'exclusive', 0, 0, 'AS0057', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:33:01', '2018-04-10 15:33:01');
INSERT INTO `products` VALUES (58, 'Sewer Repair', 4, '0', 'single', 6, NULL, 36, NULL, NULL, 'exclusive', 0, 0, 'AS0058', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:33:37', '2018-04-10 15:33:37');
INSERT INTO `products` VALUES (59, 'Refrigerator Repair', 4, '0', 'single', 6, NULL, NULL, NULL, NULL, 'exclusive', 0, 0, 'AS0059', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:36:45', '2018-04-10 15:36:45');
INSERT INTO `products` VALUES (60, 'AC Repair', 4, '0', 'single', 6, NULL, NULL, NULL, NULL, 'exclusive', 0, 0, 'AS0060', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 6, '2018-04-10 15:37:08', '2018-04-10 15:37:08');
INSERT INTO `products` VALUES (61, 'Red Wine', 1, '0', 'single', 1, NULL, 21, NULL, NULL, 'exclusive', 1, 10, 'AS0061', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528779460_wine.jpg', 1, '2018-06-12 00:27:41', '2018-06-12 00:27:41');
INSERT INTO `products` VALUES (62, 'Pinot Noir Red Wine', 1, '0', 'single', 1, NULL, NULL, NULL, NULL, 'exclusive', 1, 10, 'AS0062', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528779737_wine2.jpg', 1, '2018-06-12 00:32:17', '2018-06-12 00:32:17');
INSERT INTO `products` VALUES (63, 'Banana', 1, '0', 'single', 1, NULL, NULL, NULL, NULL, 'exclusive', 1, 100, 'AS0063', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528780092_banana.jpg', 1, '2018-06-12 00:38:12', '2018-06-12 00:38:12');
INSERT INTO `products` VALUES (64, 'Apple - Fuji', 1, '0', 'single', 1, NULL, 21, NULL, NULL, 'exclusive', 1, 50, 'AS0064', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528780234_apples.jpg', 1, '2018-06-12 00:40:34', '2018-06-12 00:40:34');
INSERT INTO `products` VALUES (65, 'Organic Egg', 1, '0', 'single', 1, NULL, 21, NULL, NULL, 'exclusive', 1, 10, 'AS0065', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1528780470_eggs.jpg', 1, '2018-06-12 00:44:00', '2018-06-12 00:44:30');
INSERT INTO `products` VALUES (66, 'Honey Roast Chicken', 5, '0', 'single', 7, NULL, 39, NULL, NULL, 'exclusive', 0, 0, 'AR0066', 'C128', NULL, NULL, 0, '300 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531481431_honey-roast-chicken.jpg', 7, '2018-07-13 09:00:31', '2018-07-13 09:00:31');
INSERT INTO `products` VALUES (67, 'Mushroom and Herb Filled Tomatoes', 5, '0', 'single', 7, NULL, 39, NULL, NULL, 'exclusive', 0, 0, 'AR0067', 'C128', NULL, NULL, 0, '150 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531481687_tomtoes-with-mushroom_med.jpg', 7, '2018-07-13 09:04:47', '2018-07-13 09:04:47');
INSERT INTO `products` VALUES (68, 'Pasta Carbonara', 5, '0', 'single', 7, NULL, 40, NULL, NULL, 'exclusive', 0, 0, 'AR0068', 'C128', NULL, NULL, 0, '180 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531481935_pasta.jpg', 7, '2018-07-13 09:08:55', '2018-07-13 09:08:55');
INSERT INTO `products` VALUES (69, 'Chicken Doner Pita with Hummus', 5, '0', 'single', 7, NULL, 40, NULL, NULL, 'exclusive', 0, 0, 'AR0069', 'C128', NULL, NULL, 0, '180 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531482350_pita.jpg', 7, '2018-07-13 09:15:50', '2018-07-13 09:15:51');
INSERT INTO `products` VALUES (70, 'Falafal Doner Salad', 5, '0', 'single', 7, NULL, 41, NULL, NULL, 'exclusive', 0, 0, 'AR0070', 'C128', NULL, NULL, 0, '200 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531483057_salad-doner.jpg', 7, '2018-07-13 09:27:37', '2018-07-13 09:27:37');
INSERT INTO `products` VALUES (71, 'Lamb Doner Salad', 5, '0', 'single', 7, NULL, 41, NULL, NULL, 'exclusive', 0, 0, 'AR0071', 'C128', NULL, NULL, 0, '220 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531483241_lamb-salad.jpg', 7, '2018-07-13 09:30:41', '2018-07-13 09:30:41');
INSERT INTO `products` VALUES (72, 'Chicago-Style Pan Pizza', 5, '0', 'single', 7, NULL, 42, NULL, NULL, 'exclusive', 0, 0, 'AR0072', 'C128', NULL, NULL, 0, '190 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531483502_pizza1.jpg', 7, '2018-07-13 09:35:02', '2018-07-13 09:35:03');
INSERT INTO `products` VALUES (73, 'Pizza Margherita', 5, '0', 'single', 7, NULL, 42, NULL, NULL, 'exclusive', 0, 0, 'AR0073', 'C128', NULL, NULL, 0, '200 gm', NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531483649_margherita-pizza.jpg', 7, '2018-07-13 09:37:29', '2018-07-13 09:37:29');
INSERT INTO `products` VALUES (74, 'Blueberry-Ginger Mojito', 5, '0', 'single', 7, NULL, 44, NULL, NULL, 'exclusive', 0, 0, 'AR0074', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531483843_mojito.jpg', 7, '2018-07-13 09:40:43', '2018-07-13 09:40:44');
INSERT INTO `products` VALUES (75, 'Chocolate Brownie', 5, '0', 'single', 7, NULL, 43, NULL, NULL, 'exclusive', 0, 0, 'AR0075', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531483989_Chocolate-Brownies.jpg', 7, '2018-07-13 09:43:09', '2018-07-13 09:43:09');
INSERT INTO `products` VALUES (76, 'Pepsi Soft Drink', 5, '0', 'single', 7, NULL, 44, NULL, NULL, 'exclusive', 1, 50, 'AR0076', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531484313_pepsi.jpg', 7, '2018-07-13 09:48:33', '2018-07-13 09:48:33');
INSERT INTO `products` VALUES (77, 'Brown Bread', 5, '0', 'single', 8, NULL, 45, NULL, NULL, 'exclusive', 1, 50, 'AR0077', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1531484661_brown-bread.jpg', 7, '2018-07-13 09:54:21', '2018-07-13 09:58:56');
INSERT INTO `products` VALUES (78, 'Toppings', 5, '0', 'modifier', NULL, NULL, NULL, NULL, NULL, 'inclusive', 0, 0, 'AR0078', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 7, '2018-07-16 10:28:04', '2018-07-16 10:28:04');
INSERT INTO `products` VALUES (79, 'Extra', 5, '0', 'modifier', NULL, NULL, NULL, NULL, NULL, 'inclusive', 0, 0, 'AR0079', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 7, '2018-07-16 10:35:37', '2018-07-16 10:35:37');
INSERT INTO `products` VALUES (80, 'with supplier', 1, '0', 'single', 1, 1, 1, 4, NULL, 'exclusive', 1, 1, 'with supplier', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, 2, '', 0.00, NULL, 1, '2018-08-08 06:59:02', '2018-08-08 06:59:02');
INSERT INTO `products` VALUES (81, 'P1 package', 1, '0', 'single', 2, 1, 2, NULL, NULL, 'exclusive', 1, 1, 'P1 package', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2018-08-13 01:40:38', '2018-08-13 01:40:38');
INSERT INTO `products` VALUES (82, 'P2 package', 1, '0', 'single', 1, 1, 1, 4, NULL, 'exclusive', 1, 1, 'P2 package', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2018-08-13 01:41:16', '2018-08-13 01:41:16');
INSERT INTO `products` VALUES (83, 'P3 package', 1, '0', 'single', 1, 1, 1, 4, NULL, 'exclusive', 1, 1, 'P3 package', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2018-08-13 01:41:48', '2018-08-13 01:41:48');
INSERT INTO `products` VALUES (84, '', 1, '0', NULL, NULL, NULL, NULL, NULL, NULL, 'inclusive', 0, 0, 'AS0084', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-13 06:49:55', '2019-01-13 06:49:55');
INSERT INTO `products` VALUES (85, '', 1, '0', NULL, NULL, NULL, NULL, NULL, NULL, 'inclusive', 0, 0, 'AS0085', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-13 06:50:04', '2019-01-13 06:50:04');
INSERT INTO `products` VALUES (86, 'MY BUSINESS', 1, '', 'single', 2, NULL, NULL, NULL, NULL, 'exclusive', 1, 0, 'AS0086', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-16 09:07:48', '2019-01-16 09:07:48');
INSERT INTO `products` VALUES (87, 'test', 1, '', 'single', 1, 2, NULL, NULL, NULL, 'exclusive', 1, 12, 'AS0087', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-16 09:14:24', '2019-01-16 09:14:24');
INSERT INTO `products` VALUES (88, 'test', 1, '', 'single', 1, 2, NULL, NULL, NULL, 'exclusive', 1, 0, 'AS0088', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-16 09:18:57', '2019-01-16 09:18:57');
INSERT INTO `products` VALUES (89, 'vbn', 1, '', NULL, 1, NULL, 2, NULL, NULL, NULL, 0, NULL, 'AS0089', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-16 22:06:00', '2019-01-16 22:06:00');
INSERT INTO `products` VALUES (90, 'New Product', 1, '', 'single', 2, NULL, 12, NULL, 2, 'inclusive', 1, 10, 'AS0090', 'EAN8', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-17 02:00:04', '2019-01-17 02:00:04');
INSERT INTO `products` VALUES (91, 'New 2', 1, '23412351234', 'single', 3, 2, 2, NULL, 4, 'inclusive', 1, 133, NULL, 'EAN8', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-17 02:08:38', '2019-01-17 02:08:38');
INSERT INTO `products` VALUES (92, 'MY BUSINESS 2', 1, '24123414', 'single', 2, 1, 3, 10, 1, 'inclusive', 1, 123, ' ', 'EAN8', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-17 02:28:09', '2019-01-17 02:28:09');
INSERT INTO `products` VALUES (93, 'MY BUSINESS 2', 1, '24123414', 'single', 2, 1, 3, 10, 1, 'inclusive', 1, 123, ' ', 'EAN8', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-17 02:28:39', '2019-01-17 02:28:39');
INSERT INTO `products` VALUES (94, 'MY BUSINESS 2', 1, '', 'single', 2, 2, 2, NULL, NULL, 'exclusive', 1, 231, 'asdfasdf', 'C128', 1.00, 'days', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-19 05:31:33', '2019-01-19 05:31:33');
INSERT INTO `products` VALUES (95, 'Sin product', 1, '', 'single', 2, NULL, NULL, NULL, NULL, 'exclusive', 1, 10, 'AS0095', 'C128', 1.00, 'days', 1, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-19 08:13:35', '2019-01-19 08:13:35');
INSERT INTO `products` VALUES (96, 'asdfsd', 1, '234e23', 'single', NULL, 2, 2, NULL, NULL, 'inclusive', 0, 0, ' ', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-19 15:37:59', '2019-01-19 15:37:59');
INSERT INTO `products` VALUES (97, 'asdfasdfasdf', 1, '1231241213231', 'variable', NULL, NULL, NULL, NULL, NULL, 'exclusive', 0, 0, ' ', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-25 11:49:04', '2019-01-25 11:49:04');
INSERT INTO `products` VALUES (101, 'Test product', 1, 'sdfwer1231412', 'single', NULL, 1, 12, NULL, NULL, 'exclusive', 1, 123, 'AS0101', 'C128', 99.99, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-28 05:32:45', '2019-01-28 05:32:45');
INSERT INTO `products` VALUES (103, 'Test Product 2', 1, '12ef123e12', 'single', NULL, 4, 3, NULL, NULL, 'exclusive', 1, 123123, ' ', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-28 05:58:43', '2019-01-28 05:58:43');
INSERT INTO `products` VALUES (104, 'Awesome Shop', 1, 'sdfgsd', 'single', NULL, 2, 2, NULL, NULL, 'exclusive', 1, 2131, 'AS0104', 'C128', 99.99, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-28 06:12:45', '2019-01-28 06:12:45');
INSERT INTO `products` VALUES (106, '123', 1, '123', 'single', NULL, 3, 3, NULL, NULL, 'exclusive', 1, 123, 'AS0106', 'C128', 99.99, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-28 20:11:37', '2019-01-28 20:11:37');
INSERT INTO `products` VALUES (107, '123123', 1, '123123', 'single', NULL, 3, 3, NULL, NULL, 'exclusive', 1, 123, 'AS0107', 'C128', 99.99, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-28 20:12:07', '2019-01-28 20:12:07');
INSERT INTO `products` VALUES (111, 'A1c-3', 1, '7702162251', 'single', NULL, 24, 46, NULL, NULL, 'exclusive', 1, 5, ' ', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-01-31 01:33:59', '2019-02-02 06:43:06');
INSERT INTO `products` VALUES (112, 'test purchase product', 1, '123123123123', 'single', NULL, 5, 2, NULL, NULL, 'exclusive', 1, 123, 'AS0112', 'C128', 1.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-02-02 03:21:33', '2019-02-02 03:21:33');
INSERT INTO `products` VALUES (115, 'pur purchase', 1, '1111111111', 'single', NULL, 3, 12, NULL, NULL, 'exclusive', 1, 11, 'AS0115', 'C128', 11.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-02-02 04:33:43', '2019-02-02 04:33:43');
INSERT INTO `products` VALUES (119, 'Feb', 1, 'feb', 'single', NULL, 2, 12, NULL, NULL, 'exclusive', 1, 1, ' ', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-02-02 07:55:02', '2019-02-02 07:55:02');
INSERT INTO `products` VALUES (125, 'Febrary', 1, 'feb', 'single', NULL, 4, 12, NULL, NULL, 'exclusive', 1, 1, ' ', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-02-02 07:58:26', '2019-02-02 08:03:40');
INSERT INTO `products` VALUES (126, 'test inv transfer', 1, 'test inv transfer', 'single', NULL, 2, 2, NULL, NULL, 'exclusive', 1, 10, 'AS0126', 'C128', 1.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 1, '2019-02-08 21:57:03', '2019-02-08 21:57:03');
INSERT INTO `products` VALUES (127, 'First Product', 8, '123412351234', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 1, ' ', 'C128', 13.00, 'days', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, '1550544529_favicon.ico', 13, '2019-02-10 05:37:09', '2019-02-19 08:18:49');
INSERT INTO `products` VALUES (128, 'A1c-3', 8, '123457987', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 10, '0128', 'C128', 1.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-12 19:13:18', '2019-02-12 19:13:18');
INSERT INTO `products` VALUES (129, 'test', 8, '23ef23ef', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 9, ' ', 'C128', 12.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-13 15:13:35', '2019-02-13 15:13:35');
INSERT INTO `products` VALUES (130, 'test product', 8, 'asdfasdf', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 12, '0130', 'C128', 2.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-13 23:03:28', '2019-02-13 23:03:28');
INSERT INTO `products` VALUES (131, 'asdfas', 8, 'xvaf', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 12, ' ', 'C128', 1.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-14 00:00:55', '2019-02-14 00:00:55');
INSERT INTO `products` VALUES (132, '1', 8, 'asdfsaf', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 1, ' ', 'C128', 2.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-14 12:19:46', '2019-02-14 12:19:46');
INSERT INTO `products` VALUES (133, 'asdf', 8, 'asdfasdf', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2, ' ', 'C128', 3.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-14 12:20:37', '2019-02-14 12:21:19');
INSERT INTO `products` VALUES (135, '321321', 8, '12141213', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 1, ' ', 'C128', 1.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-15 09:24:38', '2019-02-15 09:24:38');
INSERT INTO `products` VALUES (136, '1111', 8, '1111', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 11, ' ', 'C128', 11.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-15 15:56:46', '2019-02-18 20:22:42');
INSERT INTO `products` VALUES (137, 'Harry', 8, 'asdfa', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 0, ' ', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-16 14:06:25', '2019-02-16 14:06:25');
INSERT INTO `products` VALUES (138, 'stock product', 8, '12341231', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 0, '0138', 'C128', 1.00, 'months', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-19 08:07:46', '2019-02-19 08:14:06');
INSERT INTO `products` VALUES (139, '123r', 8, 'asdvxcv', 'single', NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 0, ' ', 'C128', 1.00, 'days', 0, NULL, NULL, NULL, NULL, NULL, NULL, '', 0.00, NULL, 13, '2019-02-19 08:15:38', '2019-02-19 08:16:19');

-- ----------------------------
-- Table structure for purchase_lines
-- ----------------------------
DROP TABLE IF EXISTS `purchase_lines`;
CREATE TABLE `purchase_lines`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(20, 2) NOT NULL,
  `pp_without_discount` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT 'Purchase price before inline discounts',
  `discount_percent` decimal(5, 2) NOT NULL DEFAULT 0.00 COMMENT 'Inline discount percentage',
  `purchase_price` decimal(20, 2) NULL DEFAULT NULL,
  `purchase_price_inc_tax` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `item_tax` decimal(20, 2) NULL DEFAULT NULL,
  `tax_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `quantity_sold` decimal(20, 2) NULL DEFAULT 0.00,
  `quantity_adjusted` decimal(20, 2) NULL DEFAULT 0.00,
  `mfg_date` date NULL DEFAULT NULL,
  `exp_date` date NULL DEFAULT NULL,
  `lot_number` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `purchase_lines_transaction_id_foreign`(`transaction_id`) USING BTREE,
  INDEX `purchase_lines_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `purchase_lines_variation_id_foreign`(`variation_id`) USING BTREE,
  INDEX `purchase_lines_tax_id_foreign`(`tax_id`) USING BTREE,
  CONSTRAINT `purchase_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `purchase_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `purchase_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `purchase_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 180 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of purchase_lines
-- ----------------------------
INSERT INTO `purchase_lines` VALUES (1, 1, 2, 2, 100.00, 70.00, 0.00, 70.00, 77.00, 7.00, 1, 50.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:27:11', '2018-06-13 14:09:08');
INSERT INTO `purchase_lines` VALUES (2, 1, 2, 3, 150.00, 70.00, 0.00, 70.00, 77.00, 7.00, 1, 60.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:27:11', '2018-06-13 14:09:08');
INSERT INTO `purchase_lines` VALUES (3, 1, 2, 4, 150.00, 70.00, 0.00, 70.00, 77.00, 7.00, 1, 2.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:27:11', '2018-08-08 07:55:05');
INSERT INTO `purchase_lines` VALUES (4, 1, 2, 5, 150.00, 72.00, 0.00, 72.00, 79.20, 7.20, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:27:11', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (5, 1, 2, 6, 100.00, 72.00, 0.00, 72.00, 79.20, 7.20, 1, 1.00, 1.00, NULL, NULL, NULL, '2018-01-06 09:27:11', '2019-01-19 04:37:42');
INSERT INTO `purchase_lines` VALUES (6, 2, 14, 47, 100.00, 700.00, 0.00, 700.00, 770.00, 70.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:28:10', '2018-08-13 02:02:01');
INSERT INTO `purchase_lines` VALUES (7, 3, 28, 71, 500.00, 10.00, 0.00, 10.00, 11.00, 1.00, 1, 30.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:32:22', '2018-06-13 14:09:08');
INSERT INTO `purchase_lines` VALUES (8, 4, 21, 64, 200.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 61.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:33:12', '2019-01-19 03:37:43');
INSERT INTO `purchase_lines` VALUES (9, 5, 27, 70, 500.00, 20.00, 0.00, 20.00, 22.00, 2.00, 1, 30.00, 0.00, NULL, NULL, NULL, '2018-01-06 09:35:26', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (10, 11, 34, 77, 50.00, 6.00, 0.00, 6.00, 6.00, 0.00, NULL, 48.00, 0.00, '2018-04-10', '2019-08-02', NULL, '2018-04-10 12:48:16', '2019-02-18 19:52:43');
INSERT INTO `purchase_lines` VALUES (11, 12, 32, 75, 100.00, 12.00, 0.00, 12.00, 12.00, 0.00, NULL, 100.00, 0.00, '2018-04-12', '2019-02-02', NULL, '2018-04-10 12:49:40', '2019-01-31 02:30:50');
INSERT INTO `purchase_lines` VALUES (12, 13, 36, 79, 150.00, 9.00, 0.00, 9.00, 9.00, 0.00, NULL, 149.00, 0.00, '2018-03-30', '2019-08-02', NULL, '2018-04-10 12:50:41', '2019-02-18 19:52:43');
INSERT INTO `purchase_lines` VALUES (13, 14, 33, 76, 180.00, 12.00, 0.00, 12.00, 12.00, 0.00, NULL, 27.00, 0.00, '2018-04-10', '2018-07-31', NULL, '2018-04-10 12:51:38', '2018-06-13 14:09:08');
INSERT INTO `purchase_lines` VALUES (14, 18, 46, 89, 30.00, 321.00, 0.00, 321.00, 321.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-04-10 14:09:54', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (15, 19, 41, 84, 40.00, 500.00, 0.00, 500.00, 500.00, 0.00, NULL, 26.00, 0.00, NULL, NULL, NULL, '2018-04-10 14:10:51', '2018-06-13 14:09:09');
INSERT INTO `purchase_lines` VALUES (16, 20, 45, 88, 45.00, 300.00, 0.00, 300.00, 300.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-04-10 14:11:45', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (17, 21, 44, 87, 100.00, 195.00, 0.00, 195.00, 195.00, 0.00, NULL, 20.00, 0.00, NULL, NULL, NULL, '2018-04-10 14:12:34', '2018-06-13 14:09:09');
INSERT INTO `purchase_lines` VALUES (18, 22, 43, 86, 30.00, 400.00, 0.00, 400.00, 400.00, 0.00, NULL, 5.00, 0.00, NULL, NULL, NULL, '2018-04-10 14:13:12', '2018-06-13 14:09:09');
INSERT INTO `purchase_lines` VALUES (19, 27, 42, 85, 50.00, 520.00, 0.00, 520.00, 520.00, 0.00, NULL, 20.00, 0.00, NULL, NULL, NULL, '2018-04-10 14:23:36', '2018-06-13 14:09:09');
INSERT INTO `purchase_lines` VALUES (20, 37, 61, 104, 20.00, 34.00, 0.00, 34.00, 34.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-11 19:17:07', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (21, 37, 64, 107, 200.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-11 19:17:07', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (22, 37, 63, 106, 200.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-11 19:17:07', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (23, 37, 65, 108, 50.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-11 19:17:07', '2018-06-13 14:09:07');
INSERT INTO `purchase_lines` VALUES (24, 38, 17, 57, 30.00, 350.00, 0.00, 350.00, 350.00, 0.00, NULL, 13.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2019-02-02 05:00:26');
INSERT INTO `purchase_lines` VALUES (25, 38, 17, 58, 50.00, 350.00, 0.00, 350.00, 350.00, 0.00, NULL, 17.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2019-02-07 11:08:44');
INSERT INTO `purchase_lines` VALUES (26, 38, 64, 107, 100.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (27, 38, 15, 49, 30.00, 950.00, 0.00, 950.00, 1045.00, 95.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (28, 38, 15, 50, 20.00, 950.00, 0.00, 950.00, 1045.00, 95.00, 1, 0.00, 10.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2019-01-19 04:37:42');
INSERT INTO `purchase_lines` VALUES (29, 38, 15, 51, 30.00, 950.00, 0.00, 950.00, 1045.00, 95.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (30, 38, 15, 52, 20.00, 950.00, 0.00, 950.00, 1045.00, 95.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (31, 38, 15, 53, 40.00, 1010.00, 0.00, 1010.00, 1111.00, 101.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (32, 38, 18, 59, 20.00, 1350.00, 0.00, 1350.00, 1350.00, 0.00, NULL, 1.00, 2.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2019-02-08 20:28:52');
INSERT INTO `purchase_lines` VALUES (33, 38, 18, 60, 20.00, 1450.00, 0.00, 1450.00, 1450.00, 0.00, NULL, 0.00, 10.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2019-01-19 15:43:43');
INSERT INTO `purchase_lines` VALUES (34, 38, 63, 106, 100.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (35, 38, 19, 61, 30.00, 8.00, 0.00, 8.00, 8.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (36, 38, 22, 65, 10.00, 8.00, 0.00, 8.00, 8.80, 0.80, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (37, 38, 24, 67, 10.00, 8.00, 0.00, 8.00, 8.80, 0.80, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (38, 38, 25, 68, 20.00, 15.00, 0.00, 15.00, 15.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `purchase_lines` VALUES (39, 39, 77, 120, 100.00, 3.00, 0.00, 3.00, 3.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-07-13 10:04:45', '2018-07-13 10:04:45');
INSERT INTO `purchase_lines` VALUES (40, 39, 76, 119, 200.00, 8.00, 0.00, 8.00, 8.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-07-13 10:04:45', '2018-07-13 10:04:45');
INSERT INTO `purchase_lines` VALUES (41, 40, 76, 119, 100.00, 8.00, 0.00, 8.00, 8.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2018-07-13 10:08:24', '2018-07-13 10:08:24');
INSERT INTO `purchase_lines` VALUES (42, 45, 80, 128, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 1.00, 0.00, NULL, NULL, NULL, '2018-08-08 07:03:01', '2018-08-08 07:03:35');
INSERT INTO `purchase_lines` VALUES (43, 48, 2, 2, 1.00, 70.00, 0.00, 70.00, 77.00, 7.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-08-13 01:48:41', '2018-08-13 02:00:43');
INSERT INTO `purchase_lines` VALUES (44, 49, 2, 2, 1.00, 70.00, 0.00, 70.00, 77.00, 7.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-08-13 01:50:06', '2018-08-13 01:50:06');
INSERT INTO `purchase_lines` VALUES (45, 50, 2, 2, 1.00, 70.00, 0.00, 70.00, 77.00, 7.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-08-13 01:50:47', '2018-08-13 01:50:47');
INSERT INTO `purchase_lines` VALUES (46, 51, 28, 71, 1.00, 10.00, 0.00, 10.00, 11.00, 1.00, 1, 0.00, 0.00, NULL, NULL, NULL, '2018-08-13 01:51:29', '2018-08-13 01:51:29');
INSERT INTO `purchase_lines` VALUES (47, 57, 86, 132, 12.00, 12312.00, 0.00, 12312.00, 12312.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-16 09:09:37', '2019-01-16 09:09:37');
INSERT INTO `purchase_lines` VALUES (48, 57, 86, 132, 1.00, 12312.00, 0.00, 12312.00, 12312.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-16 09:09:37', '2019-01-16 09:09:37');
INSERT INTO `purchase_lines` VALUES (49, 57, 86, 132, 2.00, 12312.00, 0.00, 12312.00, 12312.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-16 09:09:37', '2019-01-16 09:09:37');
INSERT INTO `purchase_lines` VALUES (50, 58, 88, 134, 12.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-16 09:19:06', '2019-01-16 09:19:06');
INSERT INTO `purchase_lines` VALUES (51, 59, 90, 135, 10.00, 100.00, 0.00, 100.00, 110.00, 10.00, 2, 0.00, 0.00, NULL, NULL, NULL, '2019-01-17 02:00:28', '2019-01-17 02:00:28');
INSERT INTO `purchase_lines` VALUES (52, 60, 91, 136, 2.00, 10.00, 0.00, 10.00, 11.80, 1.80, 4, 0.00, 0.00, NULL, NULL, NULL, '2019-01-17 02:08:48', '2019-01-17 02:40:38');
INSERT INTO `purchase_lines` VALUES (53, 61, 63, 106, 1.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-17 02:39:06', '2019-01-17 02:39:06');
INSERT INTO `purchase_lines` VALUES (54, 64, 17, 57, 12.00, 350.00, 0.00, 350.00, 350.00, 0.00, NULL, 1.00, 0.00, NULL, NULL, NULL, '2019-01-17 21:17:47', '2019-02-06 20:12:04');
INSERT INTO `purchase_lines` VALUES (55, 75, 2, 5, 1.00, 72.00, 0.00, 72.00, 79.20, 7.20, 1, 0.00, 0.00, NULL, NULL, NULL, '2019-01-18 21:54:11', '2019-01-18 21:54:11');
INSERT INTO `purchase_lines` VALUES (56, 64, 94, 139, 1.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, '1969-12-31', '2019-01-16', NULL, '2019-01-19 05:31:55', '2019-01-19 11:03:03');
INSERT INTO `purchase_lines` VALUES (57, 64, 95, 140, 1.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, 1.00, 0.00, '1969-12-31', '2019-01-31', NULL, '2019-01-19 08:14:18', '2019-01-28 20:36:59');
INSERT INTO `purchase_lines` VALUES (59, 85, 18, 59, 2.00, 1000.00, 0.00, 1000.00, 1000.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-19 13:27:04', '2019-01-19 13:44:05');
INSERT INTO `purchase_lines` VALUES (60, 86, 18, 59, 1.00, 1000.00, 0.00, 1000.00, 1000.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-19 13:42:59', '2019-01-19 13:42:59');
INSERT INTO `purchase_lines` VALUES (61, 86, 18, 60, 1.00, 1000.00, 0.00, 1000.00, 1000.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-19 13:42:59', '2019-01-19 13:42:59');
INSERT INTO `purchase_lines` VALUES (62, 88, 18, 59, 2.00, 1350.00, 0.00, 1350.00, 1350.00, 0.00, NULL, 2.00, 0.00, NULL, NULL, NULL, '2019-01-19 15:49:17', '2019-01-19 16:01:23');
INSERT INTO `purchase_lines` VALUES (63, 90, 21, 64, 1.00, 12.50, 0.00, 12.50, 12.50, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-25 12:46:51', '2019-01-25 12:46:51');
INSERT INTO `purchase_lines` VALUES (64, 91, 15, 52, 20.00, 950.00, 0.00, 950.00, 950.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-26 23:29:26', '2019-01-26 23:29:26');
INSERT INTO `purchase_lines` VALUES (65, 91, 64, 107, 5.00, 10.00, 0.00, 10.00, 10.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-26 23:29:26', '2019-01-26 23:29:26');
INSERT INTO `purchase_lines` VALUES (66, 92, 17, 57, 1.00, 350.00, 0.00, 350.00, 350.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-27 07:44:28', '2019-01-27 19:09:08');
INSERT INTO `purchase_lines` VALUES (67, 92, 1, 1, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-27 19:09:08', '2019-01-27 19:09:08');
INSERT INTO `purchase_lines` VALUES (68, 92, 2, 2, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 1.00, 0.00, NULL, '2019-01-30', NULL, '2019-01-27 19:09:08', '2019-01-28 20:36:59');
INSERT INTO `purchase_lines` VALUES (69, 93, 17, 57, 1.00, 350.00, 0.00, 350.00, 350.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-27 22:14:00', '2019-01-27 22:14:00');
INSERT INTO `purchase_lines` VALUES (70, 93, 2, 6, 1.00, 102.86, 0.00, 102.86, 102.86, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-27 22:14:00', '2019-01-27 22:14:00');
INSERT INTO `purchase_lines` VALUES (71, 94, 2, 2, 1.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, '1969-12-31', '2022-04-20', NULL, '2019-01-27 22:15:07', '2019-02-18 18:56:12');
INSERT INTO `purchase_lines` VALUES (72, 95, 2, 2, 22.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-01-30', NULL, '2019-01-28 00:18:06', '2019-01-28 00:18:06');
INSERT INTO `purchase_lines` VALUES (73, 94, 2, 2, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 1.00, '1969-12-31', '2019-01-30', NULL, '2019-01-28 05:09:12', '2019-01-31 03:36:19');
INSERT INTO `purchase_lines` VALUES (74, 98, 101, 145, 123.00, 999.00, 0.00, 999.00, 999.00, 0.00, NULL, 123.00, 0.00, NULL, '2019-01-30', NULL, '2019-01-28 05:47:28', '2019-01-28 20:36:59');
INSERT INTO `purchase_lines` VALUES (75, 99, 101, 145, 123.00, 999.00, 0.00, 999.00, 999.00, 0.00, NULL, 123.00, 0.00, NULL, '2019-01-30', NULL, '2019-01-28 05:47:29', '2019-01-28 20:36:59');
INSERT INTO `purchase_lines` VALUES (76, 100, 103, 146, 111.00, 999.00, 0.00, 999.00, 999.00, 0.00, NULL, 101.00, 0.00, NULL, '2019-01-31', NULL, '2019-01-28 05:58:56', '2019-02-08 20:42:21');
INSERT INTO `purchase_lines` VALUES (77, 101, 103, 146, 111.00, 999.00, 0.00, 999.00, 999.00, 0.00, NULL, 111.00, 0.00, NULL, '2019-01-30', NULL, '2019-01-28 05:58:56', '2019-01-28 20:36:59');
INSERT INTO `purchase_lines` VALUES (78, 102, 88, 134, 123124123.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-28 06:13:49', '2019-01-28 06:13:49');
INSERT INTO `purchase_lines` VALUES (79, 102, 90, 135, 124125412.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-28 06:13:49', '2019-01-28 06:13:49');
INSERT INTO `purchase_lines` VALUES (80, 102, 3, 9, 12312.00, 190.00, 0.00, 190.00, 190.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-28 06:13:49', '2019-01-28 06:13:49');
INSERT INTO `purchase_lines` VALUES (81, 103, 107, 149, 123123123.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 123122402.00, 0.00, NULL, NULL, NULL, '2019-01-28 20:20:13', '2019-02-02 03:09:29');
INSERT INTO `purchase_lines` VALUES (82, 104, 107, 149, 1.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-28 20:23:20', '2019-01-28 20:23:20');
INSERT INTO `purchase_lines` VALUES (83, 104, 101, 145, 1.00, 999.00, 0.00, 999.00, 999.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-01-31', NULL, '2019-01-28 20:23:20', '2019-01-28 20:23:20');
INSERT INTO `purchase_lines` VALUES (84, 107, 107, 149, 10.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 7.00, 3.00, '1969-12-31', '2019-02-01', NULL, '2019-01-29 23:03:39', '2019-02-07 21:05:57');
INSERT INTO `purchase_lines` VALUES (85, 108, 107, 149, 10.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-29 23:08:35', '2019-01-29 23:08:35');
INSERT INTO `purchase_lines` VALUES (86, 109, 107, 149, 10000000000000.00, 199.00, 0.00, 199.00, 199.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-01-30 11:50:27', '2019-01-30 11:50:27');
INSERT INTO `purchase_lines` VALUES (87, 110, 111, 150, 10.00, 165.00, 0.00, 165.00, 165.00, 0.00, NULL, 9.00, 0.00, '1969-12-31', '2019-12-31', NULL, '2019-01-31 01:45:45', '2019-02-18 19:14:08');
INSERT INTO `purchase_lines` VALUES (88, 115, 111, 150, 3.00, 0.00, 0.00, 165.00, 165.00, 0.00, NULL, 3.00, 0.00, NULL, NULL, NULL, '2019-01-31 02:30:50', '2019-02-02 07:17:23');
INSERT INTO `purchase_lines` VALUES (89, 120, 112, 151, 13.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, -7.00, 0.00, NULL, '2019-02-08', NULL, '2019-02-02 03:21:55', '2019-02-08 20:42:38');
INSERT INTO `purchase_lines` VALUES (90, 123, 115, 152, 20.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 20.00, 0.00, NULL, '2019-02-08', NULL, '2019-02-02 04:34:06', '2019-02-07 11:08:44');
INSERT INTO `purchase_lines` VALUES (91, 128, 111, 150, 10.00, 165.00, 0.00, 165.00, 165.00, 0.00, NULL, 6.00, 0.00, NULL, '2019-02-14', NULL, '2019-02-02 06:43:27', '2019-02-18 19:55:04');
INSERT INTO `purchase_lines` VALUES (92, 129, 111, 150, 10.00, 165.00, 0.00, 165.00, 165.00, 0.00, NULL, 8.00, 0.00, NULL, '2019-02-22', NULL, '2019-02-02 06:43:27', '2019-02-18 19:55:04');
INSERT INTO `purchase_lines` VALUES (93, 130, 111, 150, 1213.00, 165.00, 0.00, 165.00, 165.00, 0.00, NULL, 307.00, 0.00, '1969-12-31', '2019-02-14', NULL, '2019-02-02 06:47:11', '2019-02-08 21:58:15');
INSERT INTO `purchase_lines` VALUES (97, 138, 111, 150, 5.00, 0.00, 0.00, 165.00, 165.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-02 06:54:35', '2019-02-18 19:14:08');
INSERT INTO `purchase_lines` VALUES (98, 140, 111, 150, 1.00, 0.00, 0.00, 165.00, 165.00, 0.00, NULL, 1.00, 0.00, NULL, NULL, NULL, '2019-02-02 06:56:37', '2019-02-02 07:17:23');
INSERT INTO `purchase_lines` VALUES (99, 146, 103, 146, 100.00, 999.00, 0.00, 999.00, 999.00, 0.00, NULL, 100.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-02 07:18:57', '2019-02-07 11:08:44');
INSERT INTO `purchase_lines` VALUES (100, 148, 103, 146, 50.00, 0.00, 0.00, 999.00, 999.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `purchase_lines` VALUES (102, 151, 125, 154, 100.00, 900.00, 0.00, 900.00, 900.00, 0.00, NULL, 69.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-02 07:59:09', '2019-02-07 11:08:44');
INSERT INTO `purchase_lines` VALUES (103, 153, 125, 154, 50.00, 0.00, 0.00, 900.00, 900.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `purchase_lines` VALUES (104, 155, 125, 154, 10.00, 900.00, 0.00, 900.00, 900.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-02 08:03:57', '2019-02-02 08:03:57');
INSERT INTO `purchase_lines` VALUES (105, 156, 125, 154, 10.00, 900.00, 0.00, 900.00, 900.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-02 08:03:57', '2019-02-02 08:03:57');
INSERT INTO `purchase_lines` VALUES (106, 159, 111, 150, 30.00, 210.00, 0.00, 210.00, 210.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-07 20:01:56', '2019-02-07 20:01:56');
INSERT INTO `purchase_lines` VALUES (107, 159, 17, 58, 1.00, 437.50, 0.00, 437.50, 437.50, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-07 20:01:56', '2019-02-07 20:01:56');
INSERT INTO `purchase_lines` VALUES (108, 160, 111, 150, 3.00, 210.00, 0.00, 210.00, 210.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-07 20:07:17', '2019-02-07 20:07:17');
INSERT INTO `purchase_lines` VALUES (109, 164, 111, 150, 1.00, 165.00, 0.00, 165.00, 165.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-08 20:32:46', '2019-02-08 20:32:46');
INSERT INTO `purchase_lines` VALUES (110, 166, 111, 150, 100.00, 0.00, 0.00, 165.00, 165.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `purchase_lines` VALUES (111, 168, 111, 150, 200.00, 0.00, 0.00, 165.00, 165.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-12-31', NULL, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `purchase_lines` VALUES (112, 169, 126, 155, 15.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-08 21:57:25', '2019-02-08 21:57:25');
INSERT INTO `purchase_lines` VALUES (113, 171, 126, 155, 7.00, 0.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `purchase_lines` VALUES (114, 174, 127, 156, 15.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 14.00, 0.00, NULL, NULL, NULL, '2019-02-10 05:39:00', '2019-02-18 22:54:25');
INSERT INTO `purchase_lines` VALUES (115, 175, 127, 156, 12.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 12.00, 0.00, NULL, '2019-02-26', NULL, '2019-02-10 20:37:51', '2019-02-12 13:48:28');
INSERT INTO `purchase_lines` VALUES (116, 177, 127, 156, 3.00, 125.00, 0.00, 125.00, 125.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-11 22:46:02', '2019-02-11 22:46:02');
INSERT INTO `purchase_lines` VALUES (117, 192, 127, 156, 12.00, 0.00, 0.00, 125.00, 125.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 13:48:28', '2019-02-18 21:50:20');
INSERT INTO `purchase_lines` VALUES (118, 194, 127, 156, 5.00, 0.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 13:53:16', '2019-02-12 14:24:05');
INSERT INTO `purchase_lines` VALUES (119, 199, 127, 156, 3.00, 125.00, 0.00, 125.00, 125.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 15:03:09', '2019-02-12 15:03:09');
INSERT INTO `purchase_lines` VALUES (120, 200, 127, 156, 1.00, 125.00, 0.00, 125.00, 125.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 15:07:06', '2019-02-12 15:07:06');
INSERT INTO `purchase_lines` VALUES (121, 201, 127, 156, 1.00, 125.00, 0.00, 125.00, 125.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 15:21:54', '2019-02-12 15:21:54');
INSERT INTO `purchase_lines` VALUES (122, 202, 127, 156, 5.00, 125.00, 0.00, 125.00, 125.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 15:29:52', '2019-02-12 15:29:52');
INSERT INTO `purchase_lines` VALUES (123, 203, 127, 156, 5.00, 125.00, 0.00, 125.00, 125.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 15:31:50', '2019-02-12 15:31:50');
INSERT INTO `purchase_lines` VALUES (124, 204, 127, 156, 7.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 16:40:02', '2019-02-12 16:43:09');
INSERT INTO `purchase_lines` VALUES (126, 211, 128, 157, 15.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 13.00, 0.00, NULL, '2019-02-26', NULL, '2019-02-12 19:13:47', '2019-02-18 22:54:25');
INSERT INTO `purchase_lines` VALUES (127, 213, 128, 157, 5.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-12 19:32:26', '2019-02-12 19:32:26');
INSERT INTO `purchase_lines` VALUES (128, 216, 129, 158, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 1.00, 0.00, '1970-01-01', '2019-02-27', NULL, '2019-02-13 19:23:49', '2019-02-13 21:47:17');
INSERT INTO `purchase_lines` VALUES (129, 216, 128, 157, 1.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 1.00, 0.00, '1970-01-01', '2019-02-27', NULL, '2019-02-13 19:36:25', '2019-02-14 14:54:31');
INSERT INTO `purchase_lines` VALUES (130, 219, 130, 159, 15.00, 65.00, 0.00, 65.00, 65.00, 0.00, NULL, 13.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-13 23:04:08', '2019-02-15 14:06:53');
INSERT INTO `purchase_lines` VALUES (131, 221, 131, 160, 12.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 2.00, 0.00, NULL, '2019-02-22', NULL, '2019-02-14 00:01:13', '2019-02-18 22:54:25');
INSERT INTO `purchase_lines` VALUES (132, 222, 131, 160, 14.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-26', NULL, '2019-02-14 00:01:13', '2019-02-18 21:50:20');
INSERT INTO `purchase_lines` VALUES (133, 224, 131, 160, 2.00, 0.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-22', NULL, '2019-02-14 00:02:30', '2019-02-14 00:02:30');
INSERT INTO `purchase_lines` VALUES (134, 225, 130, 159, 1.00, 65.00, 0.00, 65.00, 65.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-14 00:05:25', '2019-02-14 00:05:25');
INSERT INTO `purchase_lines` VALUES (135, 226, 128, 157, 1.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-14 00:07:04', '2019-02-19 00:56:35');
INSERT INTO `purchase_lines` VALUES (136, 226, 129, 158, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 1.00, NULL, '2019-02-16', NULL, '2019-02-14 00:07:04', '2019-02-19 09:21:46');
INSERT INTO `purchase_lines` VALUES (137, 228, 128, 157, 1.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-14 10:36:37', '2019-02-14 10:36:37');
INSERT INTO `purchase_lines` VALUES (138, 229, 132, 161, 2.00, 12.00, 0.00, 12.00, 12.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-14 12:19:54', '2019-02-18 22:54:25');
INSERT INTO `purchase_lines` VALUES (139, 230, 132, 161, 12.00, 12.00, 0.00, 12.00, 12.00, 0.00, NULL, 0.00, 0.00, NULL, NULL, NULL, '2019-02-14 12:19:54', '2019-02-14 12:19:54');
INSERT INTO `purchase_lines` VALUES (140, 231, 133, 162, 12.00, 1.00, 0.00, 1.00, 1.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-14 12:21:00', '2019-02-18 22:54:25');
INSERT INTO `purchase_lines` VALUES (141, 232, 133, 162, 45.00, 1.00, 0.00, 1.00, 1.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-14 12:21:00', '2019-02-15 17:21:55');
INSERT INTO `purchase_lines` VALUES (142, 237, 128, 157, 1.00, 123.00, 0.00, 123.00, 123.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-27', NULL, '2019-02-14 14:11:31', '2019-02-14 14:11:31');
INSERT INTO `purchase_lines` VALUES (143, 242, 127, 156, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-21', NULL, '2019-02-14 15:48:48', '2019-02-14 15:48:48');
INSERT INTO `purchase_lines` VALUES (144, 242, 131, 160, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-14 15:48:48', '2019-02-14 15:48:48');
INSERT INTO `purchase_lines` VALUES (145, 242, 133, 162, 1.00, 1.00, 0.00, 1.00, 1.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-27', NULL, '2019-02-14 15:48:48', '2019-02-14 15:48:48');
INSERT INTO `purchase_lines` VALUES (147, 247, 130, 159, 12.00, 0.00, 0.00, 65.00, 65.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-15 14:06:53', '2019-02-15 14:06:53');
INSERT INTO `purchase_lines` VALUES (148, 248, 135, 164, 2.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 1.50, 0.00, NULL, '2019-02-22', NULL, '2019-02-15 14:30:15', '2019-02-18 12:09:05');
INSERT INTO `purchase_lines` VALUES (149, 248, 135, 164, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 1.00, 0.00, NULL, '2019-02-23', NULL, '2019-02-15 14:30:15', '2019-02-15 14:44:33');
INSERT INTO `purchase_lines` VALUES (150, 249, 135, 164, 1.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 1.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-15 14:34:03', '2019-02-15 14:44:33');
INSERT INTO `purchase_lines` VALUES (151, 252, 136, 165, 14.00, 111.00, 0.00, 111.00, 111.00, 0.00, NULL, 1.00, 0.00, '1970-01-01', '2019-02-21', NULL, '2019-02-15 15:57:23', '2019-02-19 18:37:23');
INSERT INTO `purchase_lines` VALUES (152, 267, 136, 165, 15.05, 111.00, 0.00, 111.00, 111.00, 0.00, NULL, 6.50, 0.00, '1970-01-01', '2019-02-28', NULL, '2019-02-17 22:48:55', '2019-02-19 01:20:33');
INSERT INTO `purchase_lines` VALUES (169, 291, 136, 165, 1.00, 0.00, 0.00, 111.00, 111.00, NULL, NULL, 0.00, 0.00, NULL, '2019-02-27', NULL, '2019-02-18 20:23:17', '2019-02-18 23:01:56');
INSERT INTO `purchase_lines` VALUES (170, 291, 136, 165, 1.00, 0.00, 0.00, 111.00, 111.00, NULL, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-18 20:23:17', '2019-02-18 20:23:17');
INSERT INTO `purchase_lines` VALUES (175, 299, 136, 165, 1.50, 0.00, 0.00, 111.00, 111.00, NULL, NULL, 0.00, 0.00, NULL, '2019-02-21', NULL, '2019-02-18 20:38:07', '2019-02-18 20:38:07');
INSERT INTO `purchase_lines` VALUES (179, 323, 138, 167, 15.00, 100.00, 0.00, 100.00, 100.00, 0.00, NULL, 0.00, 0.00, NULL, '2019-02-28', NULL, '2019-02-19 08:11:30', '2019-02-19 18:35:27');

-- ----------------------------
-- Table structure for reference_counts
-- ----------------------------
DROP TABLE IF EXISTS `reference_counts`;
CREATE TABLE `reference_counts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref_count` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of reference_counts
-- ----------------------------
INSERT INTO `reference_counts` VALUES (1, 'purchase', 28, 1, '2018-06-12 00:47:07', '2019-02-08 21:57:25');
INSERT INTO `reference_counts` VALUES (2, 'contacts', 42, 1, '2018-06-12 00:47:07', '2019-02-07 20:53:19');
INSERT INTO `reference_counts` VALUES (3, 'contacts', 2, 5, '2018-07-13 19:12:11', '2018-07-13 10:03:50');
INSERT INTO `reference_counts` VALUES (4, 'business_location', 1, 5, '2018-07-13 19:12:11', '2018-07-13 19:12:11');
INSERT INTO `reference_counts` VALUES (5, 'purchase', 2, 5, '2018-07-13 10:04:45', '2018-07-13 10:08:24');
INSERT INTO `reference_counts` VALUES (6, 'sell_payment', 4, 5, '2018-07-13 10:14:40', '2018-07-13 10:16:36');
INSERT INTO `reference_counts` VALUES (7, 'contacts', 1, 6, '2018-08-06 22:45:35', '2018-08-06 22:45:35');
INSERT INTO `reference_counts` VALUES (8, 'business_location', 1, 6, '2018-08-06 22:45:35', '2018-08-06 22:45:35');
INSERT INTO `reference_counts` VALUES (9, 'sell_payment', 40, 1, '2018-08-08 07:03:35', '2019-02-08 20:28:52');
INSERT INTO `reference_counts` VALUES (10, 'purchase_payment', 29, 1, '2018-08-13 01:48:41', '2019-02-08 20:32:46');
INSERT INTO `reference_counts` VALUES (11, 'expense', 4, 1, '2018-08-13 02:18:48', '2019-01-31 02:28:53');
INSERT INTO `reference_counts` VALUES (12, 'opening_balance', 18, 1, '2019-01-14 01:16:19', '2019-02-07 20:53:19');
INSERT INTO `reference_counts` VALUES (13, 'business_location', 8, 1, '2019-01-17 07:21:44', '2019-01-27 02:36:24');
INSERT INTO `reference_counts` VALUES (14, 'sell_return', 5, 1, '2019-01-18 21:54:10', '2019-02-07 20:07:17');
INSERT INTO `reference_counts` VALUES (15, 'stock_adjustment', 9, 1, '2019-01-19 04:36:25', '2019-02-07 21:05:57');
INSERT INTO `reference_counts` VALUES (16, 'stock_transfer', 10, 1, '2019-01-19 09:15:07', '2019-02-08 21:58:15');
INSERT INTO `reference_counts` VALUES (17, 'contacts', 2, 7, '2019-02-09 10:37:36', '2019-02-09 11:16:07');
INSERT INTO `reference_counts` VALUES (18, 'business_location', 1, 7, '2019-02-09 10:37:36', '2019-02-09 10:37:36');
INSERT INTO `reference_counts` VALUES (19, 'opening_balance', 1, 7, '2019-02-09 11:16:07', '2019-02-09 11:16:07');
INSERT INTO `reference_counts` VALUES (20, 'contacts', 4, 8, '2019-02-10 02:01:52', '2019-02-19 08:11:26');
INSERT INTO `reference_counts` VALUES (21, 'business_location', 3, 8, '2019-02-10 02:01:52', '2019-02-15 09:26:10');
INSERT INTO `reference_counts` VALUES (22, 'opening_balance', 2, 8, '2019-02-10 05:38:30', '2019-02-14 14:52:55');
INSERT INTO `reference_counts` VALUES (23, 'purchase', 12, 8, '2019-02-10 05:39:00', '2019-02-19 08:11:30');
INSERT INTO `reference_counts` VALUES (24, 'sell_return', 12, 8, '2019-02-11 22:46:02', '2019-02-14 15:48:48');
INSERT INTO `reference_counts` VALUES (25, 'stock_transfer', 17, 8, '2019-02-12 13:48:28', '2019-02-18 20:38:07');
INSERT INTO `reference_counts` VALUES (26, 'sell_payment', 12, 8, '2019-02-12 14:32:21', '2019-02-18 21:52:13');
INSERT INTO `reference_counts` VALUES (27, 'expense', 4, 8, '2019-02-12 16:51:41', '2019-02-19 08:31:26');
INSERT INTO `reference_counts` VALUES (28, 'purchase_payment', 6, 8, '2019-02-13 19:37:52', '2019-02-19 07:32:04');
INSERT INTO `reference_counts` VALUES (35, 'contacts', 1, 12, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `reference_counts` VALUES (36, 'business_location', 1, 12, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `reference_counts` VALUES (37, 'contacts', 1, 13, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `reference_counts` VALUES (38, 'business_location', 1, 13, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `reference_counts` VALUES (39, 'contacts', 5, 14, '2019-02-15 10:24:03', '2019-02-16 13:28:43');
INSERT INTO `reference_counts` VALUES (40, 'business_location', 1, 14, '2019-02-15 10:24:03', '2019-02-15 10:24:03');
INSERT INTO `reference_counts` VALUES (41, 'opening_balance', 1, 14, '2019-02-15 11:01:14', '2019-02-15 11:01:14');
INSERT INTO `reference_counts` VALUES (47, 'stock_adjustment', 14, 8, '2019-02-18 22:41:18', '2019-02-19 09:21:46');

-- ----------------------------
-- Table structure for regular_balances
-- ----------------------------
DROP TABLE IF EXISTS `regular_balances`;
CREATE TABLE `regular_balances`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `contact_id` int(10) NOT NULL,
  `amount` decimal(10, 2) NOT NULL,
  `created_by` int(11) NOT NULL,
  `receive_date` date NOT NULL,
  `additional_notes` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of regular_balances
-- ----------------------------
INSERT INTO `regular_balances` VALUES (1, 1, 1, 60.00, 1, '2019-01-08', NULL, '2019-01-19 03:10:51', NULL, '2019-01-19 04:17:59');
INSERT INTO `regular_balances` VALUES (2, 1, 23, 1000.00, 1, '2019-01-01', NULL, '2019-01-19 03:25:16', NULL, '2019-01-19 03:25:16');
INSERT INTO `regular_balances` VALUES (3, 1, 1, 50.00, 1, '2019-01-20', NULL, '2019-01-20 00:15:18', NULL, '2019-01-20 00:15:18');
INSERT INTO `regular_balances` VALUES (4, 1, 23, 0.00, 1, '2019-01-20', NULL, '2019-01-20 11:04:36', NULL, '2019-01-20 11:04:36');
INSERT INTO `regular_balances` VALUES (5, 1, 26, 20.00, 1, '2019-01-20', NULL, '2019-01-20 11:08:49', NULL, '2019-01-20 11:32:18');
INSERT INTO `regular_balances` VALUES (6, 1, 1, 0.00, 1, '2019-01-20', NULL, '2019-01-20 11:22:24', NULL, '2019-01-20 11:22:24');
INSERT INTO `regular_balances` VALUES (7, 1, 23, 10.30, 1, '2019-01-20', NULL, '2019-01-20 11:22:52', NULL, '2019-01-20 11:35:57');
INSERT INTO `regular_balances` VALUES (8, 1, 23, 0.03, 1, '2019-01-20', NULL, '2019-01-20 11:26:56', NULL, '2019-01-20 11:36:26');
INSERT INTO `regular_balances` VALUES (15, 1, 1, 500.00, 1, '2019-01-24', NULL, '2019-01-24 19:19:52', NULL, '2019-01-24 19:19:52');
INSERT INTO `regular_balances` VALUES (16, 1, 1, 500.00, 1, '2019-01-24', NULL, '2019-01-24 19:20:41', NULL, '2019-01-24 19:20:41');
INSERT INTO `regular_balances` VALUES (17, 1, 1, 100.00, 1, '2019-01-24', NULL, '2019-01-24 19:21:19', NULL, '2019-01-24 21:00:49');
INSERT INTO `regular_balances` VALUES (24, 1, 1, 12.00, 1, '2019-01-24', NULL, '2019-01-24 20:24:42', NULL, '2019-01-24 20:24:42');
INSERT INTO `regular_balances` VALUES (25, 1, 1, 24.00, 1, '2019-01-24', NULL, '2019-01-24 20:26:44', NULL, '2019-01-24 20:26:44');
INSERT INTO `regular_balances` VALUES (26, 1, 1, 2.00, 1, '2019-01-24', NULL, '2019-01-24 20:29:13', NULL, '2019-01-24 20:29:13');
INSERT INTO `regular_balances` VALUES (27, 1, 1, 2.00, 1, '2019-01-24', NULL, '2019-01-24 20:30:00', NULL, '2019-01-24 20:30:00');
INSERT INTO `regular_balances` VALUES (29, 1, 1, 15.23, 1, '2019-01-24', NULL, '2019-01-24 20:33:37', NULL, '2019-01-25 00:07:43');
INSERT INTO `regular_balances` VALUES (30, 1, 26, 123412.00, 1, '2019-01-25', NULL, '2019-01-25 12:09:49', NULL, '2019-01-25 12:09:49');
INSERT INTO `regular_balances` VALUES (31, 1, 1, 11231.00, 1, '2019-01-25', NULL, '2019-01-25 12:11:25', NULL, '2019-01-25 12:11:25');
INSERT INTO `regular_balances` VALUES (32, 1, 1, 300.00, 1, '2019-01-25', NULL, '2019-01-25 12:14:00', NULL, '2019-01-25 12:14:00');
INSERT INTO `regular_balances` VALUES (33, 8, 36, 150.00, 13, '2019-02-11', NULL, '2019-02-11 19:08:15', NULL, '2019-02-11 19:08:15');
INSERT INTO `regular_balances` VALUES (34, 8, 36, 100.00, 13, '2019-02-12', NULL, '2019-02-12 08:20:09', NULL, '2019-02-12 08:20:09');
INSERT INTO `regular_balances` VALUES (36, 8, 38, 100.00, 13, '2019-02-19', NULL, '2019-02-19 07:46:29', NULL, '2019-02-19 07:46:29');
INSERT INTO `regular_balances` VALUES (37, 8, 38, 200.00, 13, '2019-02-19', NULL, '2019-02-19 07:48:11', NULL, '2019-02-19 07:48:11');
INSERT INTO `regular_balances` VALUES (38, 8, 38, 150.00, 13, '2019-02-19', NULL, '2019-02-19 07:49:52', NULL, '2019-02-19 07:49:52');

-- ----------------------------
-- Table structure for res_product_modifier_sets
-- ----------------------------
DROP TABLE IF EXISTS `res_product_modifier_sets`;
CREATE TABLE `res_product_modifier_sets`  (
  `modifier_set_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL COMMENT 'Table use to store the modifier sets applicable for a product',
  INDEX `res_product_modifier_sets_modifier_set_id_foreign`(`modifier_set_id`) USING BTREE,
  CONSTRAINT `res_product_modifier_sets_modifier_set_id_foreign` FOREIGN KEY (`modifier_set_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of res_product_modifier_sets
-- ----------------------------
INSERT INTO `res_product_modifier_sets` VALUES (78, 72);
INSERT INTO `res_product_modifier_sets` VALUES (78, 73);
INSERT INTO `res_product_modifier_sets` VALUES (79, 73);
INSERT INTO `res_product_modifier_sets` VALUES (79, 69);
INSERT INTO `res_product_modifier_sets` VALUES (79, 72);
INSERT INTO `res_product_modifier_sets` VALUES (79, 75);
INSERT INTO `res_product_modifier_sets` VALUES (79, 68);

-- ----------------------------
-- Table structure for res_tables
-- ----------------------------
DROP TABLE IF EXISTS `res_tables`;
CREATE TABLE `res_tables`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `res_tables_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `res_tables_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of res_tables
-- ----------------------------
INSERT INTO `res_tables` VALUES (1, 5, 5, 'Table 1', NULL, 7, NULL, '2018-07-13 10:10:57', '2018-07-13 10:10:57');
INSERT INTO `res_tables` VALUES (2, 5, 5, 'Table 2', NULL, 7, NULL, '2018-07-13 10:11:04', '2018-07-13 10:11:04');
INSERT INTO `res_tables` VALUES (3, 5, 5, 'Table 3', NULL, 7, NULL, '2018-07-13 10:11:10', '2018-07-13 10:11:10');
INSERT INTO `res_tables` VALUES (4, 5, 5, 'Table 4', NULL, 7, NULL, '2018-07-13 10:11:17', '2018-07-13 10:11:17');

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions`  (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `role_has_permissions_role_id_foreign`(`role_id`) USING BTREE,
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
INSERT INTO `role_has_permissions` VALUES (26, 2);
INSERT INTO `role_has_permissions` VALUES (26, 4);
INSERT INTO `role_has_permissions` VALUES (26, 6);
INSERT INTO `role_has_permissions` VALUES (26, 8);
INSERT INTO `role_has_permissions` VALUES (26, 10);
INSERT INTO `role_has_permissions` VALUES (26, 13);
INSERT INTO `role_has_permissions` VALUES (26, 15);
INSERT INTO `role_has_permissions` VALUES (26, 17);
INSERT INTO `role_has_permissions` VALUES (26, 25);
INSERT INTO `role_has_permissions` VALUES (26, 27);
INSERT INTO `role_has_permissions` VALUES (26, 29);
INSERT INTO `role_has_permissions` VALUES (27, 2);
INSERT INTO `role_has_permissions` VALUES (27, 4);
INSERT INTO `role_has_permissions` VALUES (27, 6);
INSERT INTO `role_has_permissions` VALUES (27, 8);
INSERT INTO `role_has_permissions` VALUES (27, 10);
INSERT INTO `role_has_permissions` VALUES (27, 13);
INSERT INTO `role_has_permissions` VALUES (27, 15);
INSERT INTO `role_has_permissions` VALUES (27, 17);
INSERT INTO `role_has_permissions` VALUES (27, 25);
INSERT INTO `role_has_permissions` VALUES (27, 27);
INSERT INTO `role_has_permissions` VALUES (27, 29);
INSERT INTO `role_has_permissions` VALUES (28, 2);
INSERT INTO `role_has_permissions` VALUES (28, 4);
INSERT INTO `role_has_permissions` VALUES (28, 6);
INSERT INTO `role_has_permissions` VALUES (28, 8);
INSERT INTO `role_has_permissions` VALUES (28, 10);
INSERT INTO `role_has_permissions` VALUES (28, 13);
INSERT INTO `role_has_permissions` VALUES (28, 15);
INSERT INTO `role_has_permissions` VALUES (28, 17);
INSERT INTO `role_has_permissions` VALUES (28, 25);
INSERT INTO `role_has_permissions` VALUES (28, 27);
INSERT INTO `role_has_permissions` VALUES (28, 29);
INSERT INTO `role_has_permissions` VALUES (29, 2);
INSERT INTO `role_has_permissions` VALUES (29, 4);
INSERT INTO `role_has_permissions` VALUES (29, 6);
INSERT INTO `role_has_permissions` VALUES (29, 8);
INSERT INTO `role_has_permissions` VALUES (29, 10);
INSERT INTO `role_has_permissions` VALUES (29, 13);
INSERT INTO `role_has_permissions` VALUES (29, 15);
INSERT INTO `role_has_permissions` VALUES (29, 17);
INSERT INTO `role_has_permissions` VALUES (29, 25);
INSERT INTO `role_has_permissions` VALUES (29, 27);
INSERT INTO `role_has_permissions` VALUES (29, 29);
INSERT INTO `role_has_permissions` VALUES (58, 2);
INSERT INTO `role_has_permissions` VALUES (58, 4);
INSERT INTO `role_has_permissions` VALUES (58, 6);
INSERT INTO `role_has_permissions` VALUES (58, 8);
INSERT INTO `role_has_permissions` VALUES (58, 10);
INSERT INTO `role_has_permissions` VALUES (58, 11);
INSERT INTO `role_has_permissions` VALUES (58, 13);
INSERT INTO `role_has_permissions` VALUES (58, 15);
INSERT INTO `role_has_permissions` VALUES (58, 17);
INSERT INTO `role_has_permissions` VALUES (58, 25);
INSERT INTO `role_has_permissions` VALUES (58, 27);
INSERT INTO `role_has_permissions` VALUES (58, 29);
INSERT INTO `role_has_permissions` VALUES (59, 11);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_service_staff` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roles_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `roles_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Admin#1', 'web', 1, 1, 0, '2018-08-03 01:19:26', '2018-08-03 01:19:26');
INSERT INTO `roles` VALUES (2, 'Cashier#1', 'web', 1, 0, 0, '2018-08-03 01:19:26', '2018-08-03 01:19:26');
INSERT INTO `roles` VALUES (3, 'Admin#2', 'web', 2, 1, 0, '2018-08-03 01:19:27', '2018-08-03 01:19:27');
INSERT INTO `roles` VALUES (4, 'Cashier#2', 'web', 2, 0, 0, '2018-08-03 01:19:27', '2018-08-03 01:19:27');
INSERT INTO `roles` VALUES (5, 'Admin#3', 'web', 3, 0, 0, '2018-08-03 01:19:28', '2018-08-03 01:19:28');
INSERT INTO `roles` VALUES (6, 'Cashier#3', 'web', 3, 0, 0, '2018-08-03 01:19:28', '2018-08-03 01:19:28');
INSERT INTO `roles` VALUES (7, 'Admin#4', 'web', 4, 1, 0, '2018-08-03 01:19:28', '2018-08-03 01:19:28');
INSERT INTO `roles` VALUES (8, 'Cashier#4', 'web', 4, 0, 0, '2018-08-03 01:19:29', '2018-08-03 01:19:29');
INSERT INTO `roles` VALUES (9, 'Admin#5', 'web', 5, 1, 0, '2018-08-03 01:19:29', '2018-08-03 01:19:29');
INSERT INTO `roles` VALUES (10, 'Cashier#5', 'web', 5, 0, 0, '2018-08-03 01:19:29', '2018-08-03 01:19:29');
INSERT INTO `roles` VALUES (11, 'Waiter#5', 'web', 5, 0, 1, '2018-08-03 01:19:30', '2018-08-03 01:19:30');
INSERT INTO `roles` VALUES (12, 'Admin#6', 'web', 6, 1, 0, '2018-08-06 22:45:34', '2018-08-06 22:45:34');
INSERT INTO `roles` VALUES (13, 'Cashier#6', 'web', 6, 0, 0, '2018-08-06 22:45:34', '2018-08-06 22:45:34');
INSERT INTO `roles` VALUES (14, 'Admin#7', 'web', 7, 1, 0, '2019-02-09 10:37:35', '2019-02-09 10:37:35');
INSERT INTO `roles` VALUES (15, 'Cashier#7', 'web', 7, 0, 0, '2019-02-09 10:37:36', '2019-02-09 10:37:36');
INSERT INTO `roles` VALUES (16, 'Admin#8', 'web', 8, 1, 0, '2019-02-10 02:01:52', '2019-02-10 02:01:52');
INSERT INTO `roles` VALUES (17, 'Cashier#8', 'web', 8, 0, 0, '2019-02-10 02:01:52', '2019-02-10 02:01:52');
INSERT INTO `roles` VALUES (24, 'Admin#12', 'web', 12, 1, 0, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `roles` VALUES (25, 'Cashier#12', 'web', 12, 0, 0, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `roles` VALUES (26, 'Admin#13', 'web', 13, 1, 0, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `roles` VALUES (27, 'Cashier#13', 'web', 13, 0, 0, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `roles` VALUES (28, 'Admin#14', 'web', 14, 1, 0, '2019-02-15 10:24:03', '2019-02-15 10:24:03');
INSERT INTO `roles` VALUES (29, 'Cashier#14', 'web', 14, 0, 0, '2019-02-15 10:24:03', '2019-02-15 10:24:03');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE INDEX `sessions_id_unique`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for stock_adjustment_lines
-- ----------------------------
DROP TABLE IF EXISTS `stock_adjustment_lines`;
CREATE TABLE `stock_adjustment_lines`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(20, 4) NOT NULL,
  `unit_price` decimal(20, 2) NULL DEFAULT NULL COMMENT 'Last purchase unit price',
  `removed_purchase_line` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `stock_adjustment_lines_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `stock_adjustment_lines_variation_id_foreign`(`variation_id`) USING BTREE,
  INDEX `stock_adjustment_lines_transaction_id_index`(`transaction_id`) USING BTREE,
  CONSTRAINT `stock_adjustment_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `stock_adjustment_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `stock_adjustment_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of stock_adjustment_lines
-- ----------------------------
INSERT INTO `stock_adjustment_lines` VALUES (1, 77, 15, 50, 10.0000, 1500.00, NULL, '2019-01-19 04:37:42', '2019-01-19 04:37:42');
INSERT INTO `stock_adjustment_lines` VALUES (2, 77, 2, 6, 1.0000, 79.20, NULL, '2019-01-19 04:37:42', '2019-01-19 04:37:42');
INSERT INTO `stock_adjustment_lines` VALUES (3, 78, 18, 60, 0.0000, 1450.00, NULL, '2019-01-19 04:39:54', '2019-01-19 04:39:54');
INSERT INTO `stock_adjustment_lines` VALUES (4, 81, 15, 49, 10.0000, 1045.00, NULL, '2019-01-19 09:16:38', '2019-01-19 09:16:38');
INSERT INTO `stock_adjustment_lines` VALUES (5, 87, 18, 60, 10.0000, 500.00, NULL, '2019-01-19 15:43:43', '2019-01-19 15:43:43');
INSERT INTO `stock_adjustment_lines` VALUES (6, 87, 18, 59, 2.0000, 1231.00, NULL, '2019-01-19 15:43:43', '2019-01-19 15:43:43');
INSERT INTO `stock_adjustment_lines` VALUES (7, 116, 2, 2, 1.0000, 100.00, 73, '2019-01-31 03:36:19', '2019-01-31 03:36:19');
INSERT INTO `stock_adjustment_lines` VALUES (8, 162, 107, 149, 3.0000, 123.00, 84, '2019-02-07 21:05:57', '2019-02-07 21:05:57');
INSERT INTO `stock_adjustment_lines` VALUES (27, 326, 129, 158, 1.0000, 100.00, 136, '2019-02-19 09:21:46', '2019-02-19 09:21:46');

-- ----------------------------
-- Table structure for stock_adjustments_temp
-- ----------------------------
DROP TABLE IF EXISTS `stock_adjustments_temp`;
CREATE TABLE `stock_adjustments_temp`  (
  `id` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for subscriptions
-- ----------------------------
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `package_id` int(10) UNSIGNED NOT NULL,
  `start_date` date NULL DEFAULT NULL,
  `trial_end_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `package_price` decimal(20, 2) NOT NULL,
  `package_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_id` int(10) UNSIGNED NOT NULL,
  `paid_via` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `payment_transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('approved','waiting','declined') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'waiting',
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `subscriptions_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `subscriptions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of subscriptions
-- ----------------------------
INSERT INTO `subscriptions` VALUES (1, 1, 3, '2018-08-02', '2018-08-12', '2018-09-02', 599.99, '{\"location_count\":0,\"user_count\":0,\"product_count\":0,\"invoice_count\":0,\"name\":\"Unlimited\"}', 1, 'stripe', 'ch_1CuLdQAhokBpT93LVZNg2At6', 'approved', NULL, '2018-08-02 10:19:09', '2018-08-01 10:19:09');
INSERT INTO `subscriptions` VALUES (2, 2, 3, '2018-08-02', '2018-08-12', '2018-09-02', 599.99, '{\"location_count\":0,\"user_count\":0,\"product_count\":0,\"invoice_count\":0,\"name\":\"Unlimited\"}', 4, 'stripe', 'ch_1CuLggAhokBpT93LbaE29pMW', 'approved', NULL, '2018-08-01 12:22:31', '2018-08-01 12:22:31');
INSERT INTO `subscriptions` VALUES (3, 4, 3, '2018-08-02', '2018-08-12', '2018-09-02', 599.99, '{\"location_count\":0,\"user_count\":0,\"product_count\":0,\"invoice_count\":0,\"name\":\"Unlimited\"}', 6, 'stripe', 'ch_1CuLkoAhokBpT93LW0UAFC7N', 'approved', NULL, '2018-08-01 12:26:48', '2018-08-01 12:26:48');
INSERT INTO `subscriptions` VALUES (4, 3, 3, '2018-08-02', '2018-08-12', '2018-09-02', 599.99, '{\"location_count\":0,\"user_count\":0,\"product_count\":0,\"invoice_count\":0,\"name\":\"Unlimited\"}', 5, 'stripe', 'ch_1CuLljAhokBpT93LGozt93Wn', 'approved', NULL, '2018-08-01 12:27:44', '2018-08-01 12:27:44');
INSERT INTO `subscriptions` VALUES (5, 5, 3, '2018-08-02', '2018-08-12', '2018-09-02', 599.99, '{\"location_count\":0,\"user_count\":0,\"product_count\":0,\"invoice_count\":0,\"name\":\"Unlimited\"}', 7, 'stripe', 'ch_1CuLmXAhokBpT93LOUCvEIKD', 'approved', NULL, '2018-08-01 12:28:34', '2018-08-01 12:28:34');

-- ----------------------------
-- Table structure for system
-- ----------------------------
DROP TABLE IF EXISTS `system`;
CREATE TABLE `system`  (
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of system
-- ----------------------------
INSERT INTO `system` VALUES ('db_version', '2.6');
INSERT INTO `system` VALUES ('default_business_active_status', '1');
INSERT INTO `system` VALUES ('superadmin_version', '0.5');
INSERT INTO `system` VALUES ('app_currency_id', '2');
INSERT INTO `system` VALUES ('invoice_business_name', 'Ultimate POS');
INSERT INTO `system` VALUES ('invoice_business_landmark', 'Linking Street');
INSERT INTO `system` VALUES ('invoice_business_zip', '85001');
INSERT INTO `system` VALUES ('invoice_business_state', 'Arizona');
INSERT INTO `system` VALUES ('invoice_business_city', 'Phoenix');
INSERT INTO `system` VALUES ('invoice_business_country', 'USA');
INSERT INTO `system` VALUES ('email', 'thewebfosters@gmail.com');

-- ----------------------------
-- Table structure for tax_rates
-- ----------------------------
DROP TABLE IF EXISTS `tax_rates`;
CREATE TABLE `tax_rates`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(8, 2) NOT NULL,
  `is_tax_group` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tax_rates_business_id_foreign`(`business_id`) USING BTREE,
  INDEX `tax_rates_created_by_foreign`(`created_by`) USING BTREE,
  CONSTRAINT `tax_rates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tax_rates_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tax_rates
-- ----------------------------
INSERT INTO `tax_rates` VALUES (1, 1, 'VAT@10%', 10.00, 0, 1, NULL, '2018-01-04 05:10:07', '2018-01-04 05:10:07');
INSERT INTO `tax_rates` VALUES (2, 1, 'CGST@10%', 10.00, 0, 1, NULL, '2018-01-04 05:10:55', '2018-01-04 05:10:55');
INSERT INTO `tax_rates` VALUES (3, 1, 'SGST@8%', 8.00, 0, 1, NULL, '2018-01-04 05:11:13', '2018-01-04 05:11:13');
INSERT INTO `tax_rates` VALUES (4, 1, 'GST@18%', 18.00, 1, 1, NULL, '2018-01-04 05:12:19', '2018-01-04 05:12:19');

-- ----------------------------
-- Table structure for transaction_payments
-- ----------------------------
DROP TABLE IF EXISTS `transaction_payments`;
CREATE TABLE `transaction_payments`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `is_return` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Used during sales to return the change',
  `amount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `method` enum('cash','card','cheque','bank_transfer','custom_pay_1','custom_pay_2','custom_pay_3','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transaction_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_transaction_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_type` enum('visa','master') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_holder_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_month` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_year` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `card_security` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cheque_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_account_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `paid_on` datetime(0) NULL DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `payment_for` int(11) NULL DEFAULT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  `note` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `payment_ref_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transaction_payments_transaction_id_foreign`(`transaction_id`) USING BTREE,
  INDEX `transaction_payments_created_by_index`(`created_by`) USING BTREE,
  CONSTRAINT `transaction_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 156 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of transaction_payments
-- ----------------------------
INSERT INTO `transaction_payments` VALUES (1, 6, 0, 770.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-09 17:30:35', 1, NULL, NULL, NULL, NULL, '2018-01-06 04:06:11', '2018-01-06 04:06:11');
INSERT INTO `transaction_payments` VALUES (2, 7, 0, 825.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-09 17:30:35', 1, NULL, NULL, NULL, NULL, '2018-01-06 04:06:31', '2018-01-06 04:06:31');
INSERT INTO `transaction_payments` VALUES (3, 8, 0, 7700.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-09 17:30:35', 1, NULL, NULL, NULL, NULL, '2018-01-06 04:07:23', '2018-01-06 04:07:23');
INSERT INTO `transaction_payments` VALUES (4, 9, 0, 750.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-09 17:30:35', 1, NULL, NULL, NULL, NULL, '2018-01-06 04:07:45', '2018-01-06 04:07:45');
INSERT INTO `transaction_payments` VALUES (5, 10, 0, -50.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-09 19:16:24', 1, NULL, NULL, NULL, NULL, '2018-01-06 04:08:03', '2019-01-24 19:16:24');
INSERT INTO `transaction_payments` VALUES (6, 4, 0, 2000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-11 17:32:56', 1, NULL, NULL, 'Cash Payment', NULL, '2018-01-11 09:02:56', '2018-01-11 09:02:56');
INSERT INTO `transaction_payments` VALUES (7, 3, 0, 3000.00, 'bank_transfer', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, '502110000631', '2018-01-11 17:34:10', 1, NULL, NULL, '3000 Paid Via Bank Transfer', NULL, '2018-01-11 09:04:10', '2018-01-11 09:04:10');
INSERT INTO `transaction_payments` VALUES (8, 2, 0, 84700.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-11 17:34:36', 1, NULL, NULL, NULL, NULL, '2018-01-11 09:04:36', '2018-01-11 09:04:36');
INSERT INTO `transaction_payments` VALUES (9, 1, 0, 50000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-11 17:35:04', 1, NULL, NULL, NULL, NULL, '2018-01-11 09:05:04', '2018-01-11 09:05:04');
INSERT INTO `transaction_payments` VALUES (10, 1, 0, 5660.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-01-11 17:35:17', 1, NULL, NULL, NULL, NULL, '2018-01-11 09:05:17', '2018-01-11 09:05:17');
INSERT INTO `transaction_payments` VALUES (11, 11, 0, 300.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 15:48:47', 4, 8, NULL, NULL, NULL, '2018-04-10 12:48:47', '2018-04-10 12:48:47');
INSERT INTO `transaction_payments` VALUES (12, 12, 0, 1200.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 15:49:49', 4, 9, NULL, NULL, NULL, '2018-04-10 12:49:49', '2018-04-10 12:49:49');
INSERT INTO `transaction_payments` VALUES (13, 13, 0, 1350.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 15:50:55', 4, 9, NULL, NULL, NULL, '2018-04-10 12:50:55', '2018-04-10 12:50:55');
INSERT INTO `transaction_payments` VALUES (14, 14, 0, 1500.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 15:52:10', 4, 9, NULL, NULL, NULL, '2018-04-10 12:52:10', '2018-04-10 12:52:10');
INSERT INTO `transaction_payments` VALUES (15, 15, 0, 75.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 15:53:35', 4, 7, NULL, NULL, NULL, '2018-04-10 12:53:35', '2018-04-10 12:53:35');
INSERT INTO `transaction_payments` VALUES (16, 16, 0, 105.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 15:53:58', 4, 7, NULL, NULL, NULL, '2018-04-10 12:53:58', '2018-04-10 12:53:58');
INSERT INTO `transaction_payments` VALUES (17, 17, 0, 405.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 15:54:21', 4, 7, NULL, NULL, NULL, '2018-04-10 12:54:21', '2018-04-10 12:56:26');
INSERT INTO `transaction_payments` VALUES (18, 18, 0, 9630.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:10:02', 5, 11, NULL, NULL, NULL, '2018-04-10 14:10:02', '2018-04-10 14:10:02');
INSERT INTO `transaction_payments` VALUES (19, 19, 0, 20000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:10:58', 5, 12, NULL, NULL, NULL, '2018-04-10 14:10:58', '2018-04-10 14:10:58');
INSERT INTO `transaction_payments` VALUES (20, 20, 0, 13500.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:13:19', 5, 12, NULL, NULL, NULL, '2018-04-10 14:13:19', '2018-04-10 14:13:19');
INSERT INTO `transaction_payments` VALUES (21, 21, 0, 19500.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:13:24', 5, 12, NULL, NULL, NULL, '2018-04-10 14:13:24', '2018-04-10 14:13:24');
INSERT INTO `transaction_payments` VALUES (22, 22, 0, 5000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:13:35', 5, 11, NULL, NULL, NULL, '2018-04-10 14:13:35', '2018-04-10 14:13:35');
INSERT INTO `transaction_payments` VALUES (23, 23, 0, 2500.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:14:47', 5, 10, NULL, NULL, NULL, '2018-04-10 14:14:47', '2018-04-10 14:17:10');
INSERT INTO `transaction_payments` VALUES (24, 24, 0, 4875.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:15:06', 5, 10, NULL, NULL, NULL, '2018-04-10 14:15:06', '2018-04-10 14:16:43');
INSERT INTO `transaction_payments` VALUES (25, 25, 0, 625.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:16:02', 5, 10, NULL, NULL, NULL, '2018-04-10 14:16:02', '2018-04-10 14:16:02');
INSERT INTO `transaction_payments` VALUES (26, 26, 0, 15625.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:18:48', 5, 10, NULL, NULL, NULL, '2018-04-10 14:18:48', '2018-04-10 14:18:48');
INSERT INTO `transaction_payments` VALUES (27, 28, 0, 13000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 17:24:16', 5, 10, NULL, NULL, NULL, '2018-04-10 14:24:16', '2018-04-10 14:24:16');
INSERT INTO `transaction_payments` VALUES (28, 29, 0, 656.25, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:34:40', 6, 13, NULL, NULL, NULL, '2018-04-10 15:34:40', '2018-04-10 15:34:40');
INSERT INTO `transaction_payments` VALUES (29, 30, 0, 250.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:34:54', 6, 13, NULL, NULL, NULL, '2018-04-10 15:34:54', '2018-04-10 15:34:54');
INSERT INTO `transaction_payments` VALUES (30, 31, 0, 75.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:35:19', 6, 13, NULL, NULL, NULL, '2018-04-10 15:35:19', '2018-04-10 15:35:19');
INSERT INTO `transaction_payments` VALUES (31, 32, 0, 37.50, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:37:50', 6, 13, NULL, NULL, NULL, '2018-04-10 15:37:50', '2018-04-10 15:37:50');
INSERT INTO `transaction_payments` VALUES (32, 33, 0, 375.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:38:01', 6, 13, NULL, NULL, NULL, '2018-04-10 15:38:01', '2018-04-10 15:38:01');
INSERT INTO `transaction_payments` VALUES (33, 34, 0, 250.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:38:15', 6, 13, NULL, NULL, NULL, '2018-04-10 15:38:15', '2018-04-10 15:38:15');
INSERT INTO `transaction_payments` VALUES (34, 35, 0, 100.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:38:27', 6, 13, NULL, NULL, NULL, '2018-04-10 15:38:27', '2018-04-10 15:38:27');
INSERT INTO `transaction_payments` VALUES (35, 36, 0, 125.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-10 18:38:49', 6, 13, NULL, NULL, NULL, '2018-04-10 15:38:49', '2018-04-10 15:38:49');
INSERT INTO `transaction_payments` VALUES (36, 46, 0, -50.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-08 19:33:38', 1, 1, NULL, NULL, 'SP2018/0001', '2018-08-08 07:03:35', '2019-01-24 19:33:38');
INSERT INTO `transaction_payments` VALUES (37, NULL, 0, 100.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-09 07:26:47', 1, 1, NULL, NULL, 'SP2018/0002', '2018-08-09 09:56:48', '2018-08-09 09:56:48');
INSERT INTO `transaction_payments` VALUES (38, 47, 0, 100.00, 'cash', 'cash', NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-09 07:26:47', 1, 1, 37, NULL, 'SP2018/0003', '2018-08-09 09:56:48', '2018-08-09 09:56:48');
INSERT INTO `transaction_payments` VALUES (39, NULL, 0, 18.80, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-09 07:27:15', 1, 1, NULL, NULL, 'SP2018/0004', '2018-08-09 09:57:15', '2018-08-09 09:57:15');
INSERT INTO `transaction_payments` VALUES (40, 47, 0, -50.00, 'cash', 'cash', NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-09 19:19:28', 1, 1, 39, NULL, 'SP2018/0005', '2018-08-09 09:57:15', '2019-01-24 19:19:28');
INSERT INTO `transaction_payments` VALUES (41, 48, 0, 50.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-12 07:42:26', 1, 2, NULL, NULL, 'PP2018/0001', '2018-08-13 01:48:41', '2019-01-27 07:42:26');
INSERT INTO `transaction_payments` VALUES (42, 50, 0, 77.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-12 23:20:47', 1, 2, NULL, NULL, 'PP2018/0002', '2018-08-13 01:50:47', '2018-08-13 01:50:47');
INSERT INTO `transaction_payments` VALUES (43, 51, 0, 31.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2018-08-12 23:21:29', 1, 2, NULL, NULL, 'PP2018/0003', '2018-08-13 01:51:29', '2018-08-13 01:51:29');
INSERT INTO `transaction_payments` VALUES (44, 56, 0, 393.75, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-14 04:04:45', 1, 1, NULL, NULL, 'SP2019/0006', '2019-01-14 04:04:45', '2019-01-14 04:04:45');
INSERT INTO `transaction_payments` VALUES (45, 62, 0, 600.75, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-17 20:40:52', 1, 1, NULL, NULL, 'SP2019/0007', '2019-01-17 20:40:52', '2019-01-17 20:40:52');
INSERT INTO `transaction_payments` VALUES (46, 64, 0, 4609.00, 'bank_transfer', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, 'asf', '2019-01-17 21:17:47', 1, 20, NULL, NULL, 'PP2019/0004', '2019-01-17 21:17:47', '2019-01-17 21:17:47');
INSERT INTO `transaction_payments` VALUES (47, 62, 0, -150.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 19:15:58', 1, 1, NULL, NULL, 'SP2019/0008', '2019-01-19 09:59:57', '2019-01-24 19:15:58');
INSERT INTO `transaction_payments` VALUES (48, 84, 0, 10.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 12:50:25', 1, 23, NULL, NULL, 'SP2019/0009', '2019-01-19 12:50:25', '2019-01-19 12:50:25');
INSERT INTO `transaction_payments` VALUES (50, 84, 0, 12.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 12:55:50', 1, 23, NULL, NULL, 'SP2019/0011', '2019-01-19 12:55:50', '2019-01-19 12:55:50');
INSERT INTO `transaction_payments` VALUES (51, 85, 0, 1350.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 13:27:04', 1, 4, NULL, NULL, 'PP2019/0005', '2019-01-19 13:27:04', '2019-01-19 13:27:04');
INSERT INTO `transaction_payments` VALUES (53, 86, 0, 1000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 13:42:59', 1, 6, NULL, NULL, 'PP2019/0007', '2019-01-19 13:42:59', '2019-01-19 13:42:59');
INSERT INTO `transaction_payments` VALUES (54, 88, 0, 2700.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 15:49:17', 1, 4, NULL, NULL, 'PP2019/0008', '2019-01-19 15:49:17', '2019-01-19 15:49:17');
INSERT INTO `transaction_payments` VALUES (56, 37, 0, 600000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 08:31:30', 1, 6, NULL, NULL, 'PP2019/0009', '2019-01-24 08:31:30', '2019-01-24 08:31:30');
INSERT INTO `transaction_payments` VALUES (57, 84, 0, 600.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 08:32:37', 1, 23, NULL, NULL, 'SP2019/0013', '2019-01-24 08:32:38', '2019-01-24 08:32:38');
INSERT INTO `transaction_payments` VALUES (59, 84, 0, -50.00, 'other', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 09:40:12', 1, 23, NULL, NULL, 'SP2019/0015', '2019-01-24 09:40:12', '2019-01-24 09:40:12');
INSERT INTO `transaction_payments` VALUES (60, 84, 0, -1000000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 09:51:27', 1, 23, NULL, NULL, 'SP2019/0016', '2019-01-24 09:51:27', '2019-01-24 09:51:27');
INSERT INTO `transaction_payments` VALUES (61, 84, 0, 15000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 18:52:47', 1, 23, NULL, NULL, 'SP2019/0017', '2019-01-24 18:52:47', '2019-01-24 18:52:47');
INSERT INTO `transaction_payments` VALUES (62, 84, 0, 10000.00, 'other', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 18:53:15', 1, 23, NULL, NULL, 'SP2019/0018', '2019-01-24 18:53:16', '2019-01-24 18:53:16');
INSERT INTO `transaction_payments` VALUES (63, 56, 0, 465.03, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-24 19:10:11', '2019-01-24 19:10:11');
INSERT INTO `transaction_payments` VALUES (66, 10, 0, 462.50, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-24 19:19:51', '2019-01-24 19:19:51');
INSERT INTO `transaction_payments` VALUES (68, 62, 0, -31.30, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-24 19:19:52', '2019-01-24 19:19:52');
INSERT INTO `transaction_payments` VALUES (69, 47, 0, 31.30, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-24 19:20:41', '2019-01-24 19:20:41');
INSERT INTO `transaction_payments` VALUES (70, 62, 0, 281.30, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-24 19:20:41', '2019-01-24 19:20:41');
INSERT INTO `transaction_payments` VALUES (71, 46, 0, 600.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 19:23:48', 1, 1, NULL, NULL, 'SP2019/0019', '2019-01-24 19:23:48', '2019-01-24 19:23:48');
INSERT INTO `transaction_payments` VALUES (72, 76, 0, -1900.00, 'other', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-24 20:59:38', 1, NULL, NULL, NULL, NULL, '2019-01-24 20:33:37', '2019-01-24 21:03:22');
INSERT INTO `transaction_payments` VALUES (73, 76, 0, 9504.71, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-25 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-25 00:07:43', '2019-01-25 12:14:00');
INSERT INTO `transaction_payments` VALUES (74, 76, 0, 1907.27, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-25 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-25 12:11:25', '2019-01-25 12:11:25');
INSERT INTO `transaction_payments` VALUES (75, 84, 0, 986084.25, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-25 12:11:57', 1, 23, NULL, NULL, 'SP2019/0020', '2019-01-25 12:11:57', '2019-01-25 12:11:57');
INSERT INTO `transaction_payments` VALUES (76, 47, 0, 37.50, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-25 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-25 12:14:00', '2019-01-25 12:14:00');
INSERT INTO `transaction_payments` VALUES (77, 62, 0, 86.75, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-25 00:00:00', 1, NULL, NULL, NULL, NULL, '2019-01-25 12:14:00', '2019-01-25 12:14:00');
INSERT INTO `transaction_payments` VALUES (79, 91, 0, 100.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-26 23:29:26', 1, 3, NULL, NULL, 'PP2019/0011', '2019-01-26 23:29:26', '2019-01-26 23:29:26');
INSERT INTO `transaction_payments` VALUES (81, 93, 0, 452.86, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-27 22:14:00', 1, 3, NULL, NULL, 'PP2019/0013', '2019-01-27 22:14:00', '2019-01-27 22:14:00');
INSERT INTO `transaction_payments` VALUES (82, 94, 0, 100.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-27 22:15:07', 1, 6, NULL, NULL, 'PP2019/0014', '2019-01-27 22:15:07', '2019-01-27 22:15:07');
INSERT INTO `transaction_payments` VALUES (83, 95, 0, 2200.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 00:18:05', 1, 19, NULL, NULL, 'PP2019/0015', '2019-01-28 00:18:05', '2019-01-28 00:18:05');
INSERT INTO `transaction_payments` VALUES (84, 96, 0, 393.75, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 01:55:46', 1, 1, NULL, NULL, 'SP2019/0021', '2019-01-28 01:55:46', '2019-01-28 01:55:46');
INSERT INTO `transaction_payments` VALUES (85, 97, 0, 100.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 05:15:06', 1, 1, NULL, NULL, 'SP2019/0022', '2019-01-28 05:15:06', '2019-01-28 05:15:06');
INSERT INTO `transaction_payments` VALUES (88, 102, 0, 27559147609.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 06:13:49', 1, 3, NULL, NULL, 'PP2019/0018', '2019-01-28 06:13:49', '2019-01-28 06:13:49');
INSERT INTO `transaction_payments` VALUES (89, 103, 0, 15144144129.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 20:20:13', 1, 19, NULL, NULL, 'PP2019/0019', '2019-01-28 20:20:13', '2019-01-28 20:20:13');
INSERT INTO `transaction_payments` VALUES (91, 104, 0, 1122.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 20:23:20', 1, 2, NULL, NULL, 'PP2019/0021', '2019-01-28 20:23:20', '2019-01-28 20:23:20');
INSERT INTO `transaction_payments` VALUES (92, 105, 0, 13629716.10, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 20:25:57', 1, 1, NULL, NULL, 'SP2019/0023', '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_payments` VALUES (93, 106, 0, 13616100000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-28 20:36:59', 1, 1, NULL, NULL, 'SP2019/0024', '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_payments` VALUES (94, 107, 0, 1757.10, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-29 23:03:39', 1, 3, NULL, NULL, 'PP2019/0022', '2019-01-29 23:03:39', '2019-01-29 23:03:39');
INSERT INTO `transaction_payments` VALUES (95, 108, 0, 1757.10, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-29 23:08:35', 1, 4, NULL, NULL, 'PP2019/0023', '2019-01-29 23:08:35', '2019-01-29 23:08:35');
INSERT INTO `transaction_payments` VALUES (96, 112, 0, 1000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-31 02:11:47', 1, 1, NULL, NULL, 'SP2019/0025', '2019-01-31 02:08:07', '2019-01-31 02:11:47');
INSERT INTO `transaction_payments` VALUES (97, 119, 0, 2990.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 03:09:29', 1, 32, NULL, NULL, 'SP2019/0026', '2019-02-02 03:09:29', '2019-02-02 03:09:29');
INSERT INTO `transaction_payments` VALUES (98, 120, 0, 1300.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 03:21:55', 1, 6, NULL, NULL, 'PP2019/0024', '2019-02-02 03:21:55', '2019-02-02 03:21:55');
INSERT INTO `transaction_payments` VALUES (99, 121, 0, 1500.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 03:25:06', 1, 1, NULL, NULL, 'SP2019/0027', '2019-02-02 03:25:06', '2019-02-02 03:25:06');
INSERT INTO `transaction_payments` VALUES (100, 122, 0, 300.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 04:26:23', 1, 1, NULL, NULL, 'SP2019/0028', '2019-02-02 04:26:23', '2019-02-02 04:26:23');
INSERT INTO `transaction_payments` VALUES (101, 123, 0, 2000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 04:34:06', 1, 4, NULL, NULL, 'PP2019/0025', '2019-02-02 04:34:06', '2019-02-02 04:34:06');
INSERT INTO `transaction_payments` VALUES (102, 124, 0, 600.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 04:35:46', 1, 32, NULL, NULL, 'SP2019/0029', '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transaction_payments` VALUES (103, 125, 0, 5370.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 04:56:17', 1, 1, NULL, NULL, 'SP2019/0030', '2019-02-02 04:56:17', '2019-02-02 04:56:17');
INSERT INTO `transaction_payments` VALUES (104, 126, 0, 437.50, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 05:00:26', 1, 1, NULL, NULL, 'SP2019/0031', '2019-02-02 05:00:26', '2019-02-02 05:00:26');
INSERT INTO `transaction_payments` VALUES (105, 127, 0, 5250.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 06:41:42', 1, 1, NULL, NULL, 'SP2019/0032', '2019-02-02 06:41:42', '2019-02-02 06:41:42');
INSERT INTO `transaction_payments` VALUES (106, 130, 0, 200145.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 06:47:11', 1, 4, NULL, NULL, 'PP2019/0026', '2019-02-02 06:47:11', '2019-02-02 06:47:11');
INSERT INTO `transaction_payments` VALUES (107, 141, 0, 840.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 07:10:23', 1, 1, NULL, NULL, 'SP2019/0033', '2019-02-02 07:10:23', '2019-02-02 07:10:23');
INSERT INTO `transaction_payments` VALUES (109, 143, 0, 199.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 07:14:29', 1, 1, NULL, NULL, 'SP2019/0034', '2019-02-02 07:14:29', '2019-02-02 07:14:29');
INSERT INTO `transaction_payments` VALUES (110, 144, 0, 1890.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 07:15:52', 1, 1, NULL, NULL, 'SP2019/0035', '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_payments` VALUES (111, 145, 0, 756.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 07:17:23', 1, 1, NULL, NULL, 'SP2019/0036', '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_payments` VALUES (112, 146, 0, 99900.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 07:18:57', 1, 2, NULL, NULL, 'PP2019/0027', '2019-02-02 07:18:57', '2019-02-02 07:18:57');
INSERT INTO `transaction_payments` VALUES (113, 151, 0, 90000.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 07:59:09', 1, 3, NULL, NULL, 'PP2019/0028', '2019-02-02 07:59:09', '2019-02-02 07:59:09');
INSERT INTO `transaction_payments` VALUES (114, 154, 0, 20250.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-02 08:01:49', 1, 1, NULL, NULL, 'SP2019/0037', '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_payments` VALUES (115, 157, 0, 582.75, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-06 20:12:04', 1, 1, NULL, NULL, 'SP2019/0038', '2019-02-06 20:12:04', '2019-02-06 20:12:04');
INSERT INTO `transaction_payments` VALUES (116, 158, 0, 11812.50, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-07 11:08:44', 1, 1, NULL, NULL, 'SP2019/0039', '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_payments` VALUES (117, 163, 0, 1518.75, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-08 20:28:52', 1, 1, NULL, NULL, 'SP2019/0040', '2019-02-08 20:28:52', '2019-02-08 20:28:52');
INSERT INTO `transaction_payments` VALUES (118, 164, 0, 1165.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-08 20:32:46', 1, 3, NULL, NULL, 'PP2019/0029', '2019-02-08 20:32:46', '2019-02-08 20:32:46');
INSERT INTO `transaction_payments` VALUES (119, 176, 0, 150.00, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-11 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-11 19:08:15', '2019-02-11 19:08:15');
INSERT INTO `transaction_payments` VALUES (120, 176, 0, 100.00, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-12 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-12 08:20:09', '2019-02-12 08:20:09');
INSERT INTO `transaction_payments` VALUES (122, 212, 0, 1230.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-12 19:15:21', 13, 36, NULL, NULL, 'SP2019/0002', '2019-02-12 19:15:21', '2019-02-12 19:15:21');
INSERT INTO `transaction_payments` VALUES (124, 219, 0, 500.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-13 23:04:08', 13, 37, NULL, NULL, 'PP2019/0002', '2019-02-13 23:04:08', '2019-02-13 23:04:08');
INSERT INTO `transaction_payments` VALUES (125, 220, 0, 15.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-13 23:04:41', 13, 36, NULL, NULL, 'SP2019/0003', '2019-02-13 23:04:41', '2019-02-13 23:04:41');
INSERT INTO `transaction_payments` VALUES (133, 240, 0, 231.00, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-14 14:54:31', 13, 36, NULL, NULL, 'SP2019/0008', '2019-02-14 14:54:31', '2019-02-14 14:54:31');
INSERT INTO `transaction_payments` VALUES (141, 267, 0, 1670.55, 'cash', NULL, NULL, NULL, 'visa', NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 07:32:04', 13, 37, NULL, NULL, 'PP2019/0006', '2019-02-19 07:32:05', '2019-02-19 07:32:05');
INSERT INTO `transaction_payments` VALUES (142, 176, 0, 0.00, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:45:29');
INSERT INTO `transaction_payments` VALUES (143, 198, 0, -97.00, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:43:56');
INSERT INTO `transaction_payments` VALUES (144, 217, 0, -222.00, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:43:56');
INSERT INTO `transaction_payments` VALUES (145, 218, 0, -275.71, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:43:56');
INSERT INTO `transaction_payments` VALUES (146, 220, 0, -483.85, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:43:56');
INSERT INTO `transaction_payments` VALUES (147, 251, 0, -549.71, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:43:56');
INSERT INTO `transaction_payments` VALUES (148, 253, 0, -769.71, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:43:56');
INSERT INTO `transaction_payments` VALUES (149, 250, 0, -1001.71, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:43:56', '2019-02-19 07:43:56');
INSERT INTO `transaction_payments` VALUES (150, 240, 0, 97.42, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:46:29', '2019-02-19 07:46:29');
INSERT INTO `transaction_payments` VALUES (151, 262, 0, 2.58, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:46:29', '2019-02-19 07:46:29');
INSERT INTO `transaction_payments` VALUES (152, 268, 0, -108.42, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:46:29', '2019-02-19 07:46:29');
INSERT INTO `transaction_payments` VALUES (153, 262, 0, 108.42, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:48:11', '2019-02-19 07:48:11');
INSERT INTO `transaction_payments` VALUES (154, 268, 0, 91.58, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:48:11', '2019-02-19 07:48:11');
INSERT INTO `transaction_payments` VALUES (155, 268, 0, 150.00, 'other', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-19 00:00:00', 13, NULL, NULL, NULL, NULL, '2019-02-19 07:49:52', '2019-02-19 07:49:52');

-- ----------------------------
-- Table structure for transaction_sell_lines
-- ----------------------------
DROP TABLE IF EXISTS `transaction_sell_lines`;
CREATE TABLE `transaction_sell_lines`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `purchase_lines_id` int(11) UNSIGNED NOT NULL,
  `quantity` decimal(20, 4) NOT NULL,
  `unit_price_before_discount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `unit_price` decimal(20, 2) NULL DEFAULT NULL,
  `line_discount_type` enum('fixed','percentage') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `line_discount_amount` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `unit_price_inc_tax` decimal(20, 2) NULL DEFAULT NULL,
  `item_tax` decimal(20, 2) NULL DEFAULT NULL,
  `tax_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `lot_no_line_id` int(11) NULL DEFAULT NULL,
  `sell_line_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `parent_sell_line_id` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transaction_sell_lines_transaction_id_foreign`(`transaction_id`) USING BTREE,
  INDEX `transaction_sell_lines_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `transaction_sell_lines_variation_id_foreign`(`variation_id`) USING BTREE,
  INDEX `transaction_sell_lines_tax_id_foreign`(`tax_id`) USING BTREE,
  CONSTRAINT `transaction_sell_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transaction_sell_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transaction_sell_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transaction_sell_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 172 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of transaction_sell_lines
-- ----------------------------
INSERT INTO `transaction_sell_lines` VALUES (1, 6, 2, 3, 0, 10.0000, 70.00, 70.00, NULL, 0.00, 77.00, 7.00, 1, NULL, NULL, NULL, '2018-01-06 09:36:11', '2018-01-06 09:36:11');
INSERT INTO `transaction_sell_lines` VALUES (2, 7, 27, 70, 0, 30.0000, 25.00, 25.00, NULL, 0.00, 27.50, 2.50, 1, NULL, NULL, NULL, '2018-01-06 09:36:31', '2018-01-06 09:36:31');
INSERT INTO `transaction_sell_lines` VALUES (3, 8, 2, 3, 0, 50.0000, 70.00, 70.00, NULL, 0.00, 77.00, 7.00, 1, NULL, NULL, NULL, '2018-01-06 09:37:23', '2018-01-06 09:37:23');
INSERT INTO `transaction_sell_lines` VALUES (4, 8, 2, 2, 0, 50.0000, 70.00, 70.00, NULL, 0.00, 77.00, 7.00, 1, NULL, NULL, NULL, '2018-01-06 09:37:23', '2018-01-06 09:37:23');
INSERT INTO `transaction_sell_lines` VALUES (5, 9, 21, 64, 0, 60.0000, 12.50, 12.50, NULL, 0.00, 12.50, 0.00, NULL, NULL, NULL, NULL, '2018-01-06 09:37:45', '2018-01-06 09:37:45');
INSERT INTO `transaction_sell_lines` VALUES (6, 10, 28, 71, 0, 30.0000, 12.50, 12.50, NULL, 0.00, 13.75, 1.25, 1, NULL, NULL, NULL, '2018-01-06 09:38:03', '2018-01-06 09:38:03');
INSERT INTO `transaction_sell_lines` VALUES (7, 15, 34, 77, 0, 10.0000, 7.50, 7.50, NULL, 0.00, 7.50, 0.00, NULL, NULL, '', NULL, '2018-04-10 12:53:35', '2018-04-10 12:53:35');
INSERT INTO `transaction_sell_lines` VALUES (8, 16, 32, 75, 0, 7.0000, 15.00, 15.00, NULL, 0.00, 15.00, 0.00, NULL, NULL, '', NULL, '2018-04-10 12:53:58', '2018-04-10 12:53:58');
INSERT INTO `transaction_sell_lines` VALUES (9, 17, 33, 76, 0, 27.0000, 15.00, 15.00, NULL, 0.00, 15.00, 0.00, NULL, NULL, '', NULL, '2018-04-10 12:54:21', '2018-04-10 12:56:26');
INSERT INTO `transaction_sell_lines` VALUES (10, 23, 43, 86, 0, 5.0000, 500.00, 500.00, NULL, 0.00, 500.00, 0.00, NULL, NULL, 'IHN45822225007', NULL, '2018-04-10 14:14:47', '2018-04-10 14:17:10');
INSERT INTO `transaction_sell_lines` VALUES (11, 24, 44, 87, 0, 20.0000, 243.75, 243.75, NULL, 0.00, 243.75, 0.00, NULL, NULL, 'SMJ7558455524', NULL, '2018-04-10 14:15:06', '2018-04-10 14:16:43');
INSERT INTO `transaction_sell_lines` VALUES (12, 25, 41, 84, 0, 1.0000, 625.00, 625.00, NULL, 0.00, 625.00, 0.00, NULL, NULL, 'EXSD1225778855', NULL, '2018-04-10 14:16:02', '2018-04-10 14:16:02');
INSERT INTO `transaction_sell_lines` VALUES (13, 26, 41, 84, 0, 25.0000, 625.00, 625.00, NULL, 0.00, 625.00, 0.00, NULL, NULL, 'HP020555548444', NULL, '2018-04-10 14:18:48', '2018-04-10 14:18:48');
INSERT INTO `transaction_sell_lines` VALUES (14, 28, 42, 85, 0, 20.0000, 650.00, 650.00, NULL, 0.00, 650.00, 0.00, NULL, NULL, 'HP68400258F', NULL, '2018-04-10 14:24:16', '2018-04-10 14:24:16');
INSERT INTO `transaction_sell_lines` VALUES (15, 29, 53, 96, 0, 5.0000, 131.25, 131.25, NULL, 0.00, 131.25, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:34:40', '2018-04-10 15:34:40');
INSERT INTO `transaction_sell_lines` VALUES (16, 30, 51, 94, 0, 2.0000, 125.00, 125.00, NULL, 0.00, 125.00, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:34:54', '2018-04-10 15:34:54');
INSERT INTO `transaction_sell_lines` VALUES (17, 31, 57, 100, 0, 3.0000, 25.00, 25.00, NULL, 0.00, 25.00, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:35:19', '2018-04-10 15:35:19');
INSERT INTO `transaction_sell_lines` VALUES (18, 32, 60, 103, 0, 2.0000, 18.75, 18.75, NULL, 0.00, 18.75, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:37:50', '2018-04-10 15:37:50');
INSERT INTO `transaction_sell_lines` VALUES (19, 33, 56, 99, 0, 2.0000, 187.50, 187.50, NULL, 0.00, 187.50, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:38:01', '2018-04-10 15:38:01');
INSERT INTO `transaction_sell_lines` VALUES (20, 34, 54, 97, 0, 20.0000, 12.50, 12.50, NULL, 0.00, 12.50, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:38:15', '2018-04-10 15:38:15');
INSERT INTO `transaction_sell_lines` VALUES (21, 35, 55, 98, 0, 10.0000, 10.00, 10.00, NULL, 0.00, 10.00, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:38:27', '2018-04-10 15:38:27');
INSERT INTO `transaction_sell_lines` VALUES (22, 36, 57, 100, 0, 5.0000, 25.00, 25.00, NULL, 0.00, 25.00, 0.00, NULL, NULL, '', NULL, '2018-04-10 15:38:49', '2018-04-10 15:38:49');
INSERT INTO `transaction_sell_lines` VALUES (23, 41, 71, 114, 0, 2.0000, 21.25, 21.25, NULL, 0.00, 21.25, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:14:40', '2018-07-13 10:14:40');
INSERT INTO `transaction_sell_lines` VALUES (24, 42, 70, 113, 0, 2.0000, 15.00, 15.00, NULL, 0.00, 15.00, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:15:28', '2018-07-13 10:15:28');
INSERT INTO `transaction_sell_lines` VALUES (25, 42, 67, 110, 0, 2.0000, 10.00, 10.00, NULL, 0.00, 10.00, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:15:28', '2018-07-13 10:15:28');
INSERT INTO `transaction_sell_lines` VALUES (26, 42, 68, 111, 0, 2.0000, 13.75, 13.75, NULL, 0.00, 13.75, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:15:28', '2018-07-13 10:15:28');
INSERT INTO `transaction_sell_lines` VALUES (27, 43, 74, 117, 0, 1.0000, 8.75, 8.75, NULL, 0.00, 8.75, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:16:04', '2018-07-13 10:16:04');
INSERT INTO `transaction_sell_lines` VALUES (28, 43, 73, 116, 0, 1.0000, 25.00, 25.00, NULL, 0.00, 25.00, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:16:04', '2018-07-13 10:16:04');
INSERT INTO `transaction_sell_lines` VALUES (29, 44, 74, 117, 0, 3.0000, 8.75, 8.75, NULL, 0.00, 8.75, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:16:36', '2018-07-13 10:16:36');
INSERT INTO `transaction_sell_lines` VALUES (30, 44, 69, 112, 0, 3.0000, 15.00, 15.00, NULL, 0.00, 15.00, 0.00, NULL, NULL, '', NULL, '2018-07-13 10:16:36', '2018-07-13 10:16:36');
INSERT INTO `transaction_sell_lines` VALUES (31, 46, 80, 128, 0, 1.0000, 125.00, 125.00, 'fixed', 0.00, 125.00, 0.00, NULL, NULL, '', NULL, '2018-08-08 07:03:35', '2018-08-08 07:03:35');
INSERT INTO `transaction_sell_lines` VALUES (32, 47, 2, 4, 0, 2.0000, 60.00, 60.00, 'fixed', 0.00, 66.00, 6.00, 1, NULL, '', NULL, '2018-08-08 07:55:04', '2018-08-08 07:55:04');
INSERT INTO `transaction_sell_lines` VALUES (33, 56, 17, 57, 0, 2.0000, 437.50, 437.50, 'fixed', 0.00, 437.50, 0.00, NULL, NULL, '', NULL, '2019-01-14 04:04:45', '2019-01-17 20:37:11');
INSERT INTO `transaction_sell_lines` VALUES (34, 56, 2, 6, 0, 1.0000, 72.00, 72.00, 'fixed', 0.00, 79.20, 7.20, 1, NULL, '', NULL, '2019-01-17 20:36:37', '2019-01-17 20:37:11');
INSERT INTO `transaction_sell_lines` VALUES (36, 62, 17, 58, 0, 2.0000, 437.50, 437.50, 'fixed', 0.00, 437.50, 0.00, NULL, NULL, '', NULL, '2019-01-19 01:50:49', '2019-01-19 01:50:49');
INSERT INTO `transaction_sell_lines` VALUES (37, 76, 21, 64, 0, 1.0000, 12.50, 12.50, 'fixed', 0.00, 12.50, 0.00, NULL, NULL, '', NULL, '2019-01-19 03:37:43', '2019-01-20 10:34:03');
INSERT INTO `transaction_sell_lines` VALUES (39, 84, 15, 51, 0, 10.0000, 1187.50, 1187.50, 'fixed', 0.00, 1306.25, 118.75, 1, NULL, '', NULL, '2019-01-19 12:50:25', '2019-01-19 12:50:25');
INSERT INTO `transaction_sell_lines` VALUES (40, 89, 18, 59, 0, 2.0000, 1687.50, 1687.50, 'fixed', 0.00, 1687.50, 0.00, NULL, NULL, '', NULL, '2019-01-19 16:01:23', '2019-01-19 16:01:23');
INSERT INTO `transaction_sell_lines` VALUES (41, 96, 17, 57, 0, 1.0000, 437.50, 437.50, 'fixed', 0.00, 437.50, 0.00, NULL, NULL, '', NULL, '2019-01-28 01:55:46', '2019-01-28 01:55:46');
INSERT INTO `transaction_sell_lines` VALUES (42, 97, 17, 57, 0, 1.0000, 500.00, 500.00, 'fixed', 0.00, 100.00, 0.00, NULL, NULL, '', NULL, '2019-01-28 05:15:06', '2019-01-28 05:15:06');
INSERT INTO `transaction_sell_lines` VALUES (43, 105, 107, 149, 0, 123123.0000, 123.00, 123.00, 'fixed', 0.00, 123.00, 0.00, NULL, NULL, '', NULL, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines` VALUES (44, 106, 107, 149, 0, 123000000.0000, 123.00, 123.00, 'fixed', 0.00, 123.00, 0.00, NULL, NULL, '', NULL, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines` VALUES (45, 112, 111, 150, 0, 5.0000, 210.00, 210.00, 'fixed', 0.00, 210.00, 0.00, NULL, NULL, '', NULL, '2019-01-31 02:08:07', '2019-01-31 02:10:33');
INSERT INTO `transaction_sell_lines` VALUES (46, 114, 111, 150, 0, 3.0000, 165.00, 165.00, NULL, 0.00, 165.00, 0.00, NULL, NULL, '', NULL, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transaction_sell_lines` VALUES (47, 119, 107, 149, 0, 10.0000, 299.00, 299.00, 'fixed', 0.00, 299.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 03:09:29', '2019-02-02 03:09:29');
INSERT INTO `transaction_sell_lines` VALUES (48, 121, 112, 151, 0, 10.0000, 150.00, 150.00, 'fixed', 0.00, 150.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 03:25:06', '2019-02-02 03:26:48');
INSERT INTO `transaction_sell_lines` VALUES (49, 122, 112, 151, 0, 3.0000, 200.00, 200.00, 'fixed', 0.00, 200.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 04:26:23', '2019-02-02 04:27:08');
INSERT INTO `transaction_sell_lines` VALUES (50, 124, 115, 152, 0, 3.0000, 200.00, 200.00, 'fixed', 0.00, 200.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transaction_sell_lines` VALUES (51, 125, 17, 57, 0, 10.0000, 537.00, 537.00, 'fixed', 0.00, 537.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 04:56:17', '2019-02-02 04:56:17');
INSERT INTO `transaction_sell_lines` VALUES (52, 126, 17, 57, 0, 1.0000, 437.50, 437.50, 'fixed', 0.00, 437.50, 0.00, NULL, NULL, '', NULL, '2019-02-02 05:00:26', '2019-02-02 05:00:26');
INSERT INTO `transaction_sell_lines` VALUES (53, 127, 17, 58, 0, 12.0000, 437.50, 437.50, 'fixed', 0.00, 437.50, 0.00, NULL, NULL, '', NULL, '2019-02-02 06:41:42', '2019-02-02 06:41:42');
INSERT INTO `transaction_sell_lines` VALUES (57, 137, 111, 150, 0, 5.0000, 165.00, 165.00, NULL, 0.00, 165.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 06:54:35', '2019-02-02 06:54:35');
INSERT INTO `transaction_sell_lines` VALUES (58, 139, 111, 150, 0, 1.0000, 165.00, 165.00, NULL, 0.00, 165.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 06:56:37', '2019-02-02 06:56:37');
INSERT INTO `transaction_sell_lines` VALUES (59, 141, 111, 150, 0, 4.0000, 210.00, 210.00, 'fixed', 0.00, 210.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 07:10:23', '2019-02-02 07:10:23');
INSERT INTO `transaction_sell_lines` VALUES (61, 143, 107, 149, 0, 1.0000, 199.00, 199.00, 'fixed', 0.00, 199.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 07:14:29', '2019-02-02 07:14:29');
INSERT INTO `transaction_sell_lines` VALUES (62, 144, 111, 150, 0, 10.0000, 210.00, 210.00, 'fixed', 0.00, 210.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_sell_lines` VALUES (63, 145, 111, 150, 0, 4.0000, 210.00, 210.00, 'fixed', 0.00, 210.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines` VALUES (64, 147, 103, 146, 0, 50.0000, 999.00, 999.00, NULL, 0.00, 999.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines` VALUES (66, 152, 125, 154, 0, 50.0000, 900.00, 900.00, NULL, 0.00, 900.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines` VALUES (67, 154, 125, 154, 0, 25.0000, 900.00, 900.00, 'fixed', 0.00, 900.00, 0.00, NULL, NULL, '', NULL, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines` VALUES (68, 157, 111, 150, 0, 1.0000, 210.00, 210.00, 'fixed', 0.00, 210.00, 0.00, NULL, NULL, '', NULL, '2019-02-06 20:12:04', '2019-02-06 20:12:04');
INSERT INTO `transaction_sell_lines` VALUES (69, 157, 17, 57, 0, 1.0000, 437.50, 437.50, 'fixed', 0.00, 437.50, 0.00, NULL, NULL, '', NULL, '2019-02-06 20:12:04', '2019-02-06 20:12:04');
INSERT INTO `transaction_sell_lines` VALUES (70, 158, 111, 150, 0, 50.0000, 210.00, 210.00, 'fixed', 0.00, 210.00, 0.00, NULL, NULL, '', NULL, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines` VALUES (71, 158, 17, 58, 0, 3.0000, 437.50, 437.50, 'fixed', 0.00, 437.50, 0.00, NULL, NULL, '', NULL, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines` VALUES (72, 163, 18, 59, 0, 1.0000, 1687.50, 1687.50, 'fixed', 0.00, 1687.50, 0.00, NULL, NULL, '', NULL, '2019-02-08 20:28:52', '2019-02-08 20:28:52');
INSERT INTO `transaction_sell_lines` VALUES (73, 165, 111, 150, 0, 100.0000, 165.00, 165.00, NULL, 0.00, 165.00, 0.00, NULL, NULL, '', NULL, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines` VALUES (74, 167, 111, 150, 0, 200.0000, 165.00, 165.00, NULL, 0.00, 165.00, 0.00, NULL, NULL, '', NULL, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines` VALUES (75, 170, 126, 155, 0, 7.0000, 100.00, 100.00, NULL, 0.00, 100.00, 0.00, NULL, NULL, '', NULL, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines` VALUES (76, 176, 127, 156, 0, 5.0000, 125.00, 125.00, 'fixed', 0.00, 125.00, 0.00, NULL, NULL, '', NULL, '2019-02-11 15:29:40', '2019-02-11 15:29:40');
INSERT INTO `transaction_sell_lines` VALUES (77, 191, 127, 156, 0, 12.0000, 125.00, 125.00, NULL, 0.00, 125.00, 0.00, NULL, NULL, '', NULL, '2019-02-12 13:48:28', '2019-02-12 13:48:28');
INSERT INTO `transaction_sell_lines` VALUES (78, 193, 127, 156, 0, 5.0000, 100.00, 100.00, NULL, 0.00, 100.00, 0.00, NULL, NULL, '', NULL, '2019-02-12 13:53:16', '2019-02-12 13:53:16');
INSERT INTO `transaction_sell_lines` VALUES (81, 198, 127, 156, 0, 1.0000, 125.00, 125.00, 'fixed', 0.00, 125.00, 0.00, NULL, NULL, '', NULL, '2019-02-12 14:26:16', '2019-02-12 14:31:41');
INSERT INTO `transaction_sell_lines` VALUES (83, 212, 128, 157, 0, 10.0000, 123.00, 123.00, 'fixed', 0.00, 123.00, 0.00, NULL, NULL, '', NULL, '2019-02-12 19:14:30', '2019-02-12 19:14:30');
INSERT INTO `transaction_sell_lines` VALUES (84, 217, 128, 157, 0, 1.0000, 123.00, 123.00, 'fixed', 0.00, 175.71, 0.00, NULL, NULL, '', NULL, '2019-02-13 21:47:17', '2019-02-13 21:47:17');
INSERT INTO `transaction_sell_lines` VALUES (85, 217, 129, 158, 0, 1.0000, 1.00, 1.00, 'fixed', 0.00, 1.00, 0.00, NULL, NULL, '', NULL, '2019-02-13 21:47:17', '2019-02-13 21:47:17');
INSERT INTO `transaction_sell_lines` VALUES (86, 218, 128, 157, 0, 1.0000, 207.14, 207.14, 'fixed', 0.00, 207.14, 0.00, NULL, NULL, '', NULL, '2019-02-13 22:36:31', '2019-02-13 22:37:13');
INSERT INTO `transaction_sell_lines` VALUES (87, 218, 127, 156, 0, 1.0000, 1.00, 1.00, 'fixed', 0.00, 1.00, 0.00, NULL, NULL, '', NULL, '2019-02-13 22:36:31', '2019-02-13 22:37:13');
INSERT INTO `transaction_sell_lines` VALUES (88, 220, 130, 159, 0, 1.0000, 92.86, 92.86, 'fixed', 0.00, 92.86, 0.00, NULL, NULL, '', NULL, '2019-02-13 23:04:41', '2019-02-14 10:21:22');
INSERT INTO `transaction_sell_lines` VALUES (89, 223, 131, 160, 0, 2.0000, 100.00, 100.00, NULL, 0.00, 100.00, 0.00, NULL, NULL, '', NULL, '2019-02-14 00:02:30', '2019-02-14 00:02:30');
INSERT INTO `transaction_sell_lines` VALUES (120, 240, 128, 157, 0, 2.0000, 175.71, 175.71, 'fixed', 0.00, 175.71, 0.00, NULL, NULL, '', NULL, '2019-02-14 14:54:31', '2019-02-14 14:55:36');
INSERT INTO `transaction_sell_lines` VALUES (125, 246, 130, 159, 0, 12.0000, 65.00, 65.00, NULL, 0.00, 65.00, 0.00, NULL, NULL, '', NULL, '2019-02-15 14:06:53', '2019-02-15 14:06:53');
INSERT INTO `transaction_sell_lines` VALUES (126, 250, 135, 164, 0, 2.0000, 157.14, 157.14, 'fixed', 0.00, 157.14, 0.00, NULL, NULL, '', NULL, '2019-02-15 14:39:44', '2019-02-15 14:39:44');
INSERT INTO `transaction_sell_lines` VALUES (127, 251, 135, 164, 0, 2.0000, 110.00, 110.00, 'fixed', 0.00, 110.00, 0.00, NULL, NULL, '', NULL, '2019-02-15 14:44:33', '2019-02-15 14:44:33');
INSERT INTO `transaction_sell_lines` VALUES (128, 253, 136, 165, 0, 2.0000, 121.00, 121.00, 'fixed', 0.00, 121.00, 0.00, NULL, NULL, '', NULL, '2019-02-15 15:58:10', '2019-02-15 15:58:10');
INSERT INTO `transaction_sell_lines` VALUES (133, 262, 136, 165, 0, 1.0000, 111.00, 111.00, NULL, 0.00, 111.00, NULL, NULL, NULL, '', NULL, '2019-02-17 22:01:01', '2019-02-17 22:01:01');
INSERT INTO `transaction_sell_lines` VALUES (139, 268, 136, 165, 152, 2.5000, 111.00, 111.00, NULL, 0.00, 111.00, NULL, NULL, NULL, '', NULL, '2019-02-17 22:49:47', '2019-02-19 18:37:23');
INSERT INTO `transaction_sell_lines` VALUES (140, 268, 136, 165, 151, 1.0000, 111.00, 111.00, NULL, 0.00, 111.00, NULL, NULL, NULL, '', NULL, '2019-02-17 22:49:47', '2019-02-19 18:37:23');
INSERT INTO `transaction_sell_lines` VALUES (162, 290, 136, 165, 151, 1.0000, 111.00, 111.00, NULL, 0.00, 111.00, NULL, NULL, NULL, '', NULL, '2019-02-18 20:23:17', '2019-02-18 20:23:17');
INSERT INTO `transaction_sell_lines` VALUES (163, 290, 136, 165, 152, 1.0000, 111.00, 111.00, NULL, 0.00, 111.00, NULL, NULL, NULL, '', NULL, '2019-02-18 20:23:17', '2019-02-18 20:23:17');
INSERT INTO `transaction_sell_lines` VALUES (168, 298, 136, 165, 151, 1.5000, 111.00, 111.00, NULL, 0.00, 111.00, NULL, NULL, NULL, '', NULL, '2019-02-18 20:38:07', '2019-02-18 20:38:07');
INSERT INTO `transaction_sell_lines` VALUES (171, 324, 138, 167, 179, 12.0000, 111.00, 111.00, NULL, 0.00, 111.00, NULL, NULL, NULL, '', NULL, '2019-02-19 08:12:33', '2019-02-19 18:35:27');

-- ----------------------------
-- Table structure for transaction_sell_lines_purchase_lines
-- ----------------------------
DROP TABLE IF EXISTS `transaction_sell_lines_purchase_lines`;
CREATE TABLE `transaction_sell_lines_purchase_lines`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sell_line_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'id from transaction_sell_lines',
  `stock_adjustment_line_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'id from stock_adjustment_lines',
  `purchase_line_id` int(10) UNSIGNED NOT NULL COMMENT 'id from purchase_lines',
  `quantity` decimal(20, 4) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 271 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of transaction_sell_lines_purchase_lines
-- ----------------------------
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (1, 31, NULL, 42, 1.0000, '2018-08-08 07:03:35', '2018-08-08 07:03:35');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (2, 32, NULL, 3, 2.0000, '2018-08-08 07:55:05', '2018-08-08 07:55:05');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (3, 33, NULL, 24, 1.0000, '2019-01-14 04:04:46', '2019-01-14 04:04:46');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (5, 33, NULL, 24, 1.0000, '2019-01-17 20:36:37', '2019-01-17 20:36:37');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (6, 34, NULL, 5, 1.0000, '2019-01-17 20:36:37', '2019-01-17 20:36:37');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (8, 36, NULL, 25, 2.0000, '2019-01-19 01:50:50', '2019-01-19 01:50:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (9, 37, NULL, 8, 1.0000, '2019-01-19 03:37:43', '2019-01-19 03:37:43');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (10, NULL, 1, 28, 10.0000, '2019-01-19 04:37:42', '2019-01-19 04:37:42');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (11, NULL, 1, 28, 10.0000, '2019-01-19 04:37:42', '2019-01-19 04:37:42');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (12, NULL, 2, 5, 1.0000, '2019-01-19 04:37:42', '2019-01-19 04:37:42');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (13, NULL, 3, 33, 0.0000, '2019-01-19 04:39:54', '2019-01-19 04:39:54');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (14, 38, NULL, 12, 10.0000, '2019-01-19 09:15:07', '2019-01-19 09:15:07');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (15, NULL, 4, 58, 10.0000, '2019-01-19 09:16:38', '2019-01-19 09:16:38');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (16, 39, NULL, 12, 10.0000, '2019-01-19 12:50:25', '2019-01-19 12:50:25');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (17, NULL, 5, 33, 10.0000, '2019-01-19 15:43:43', '2019-01-19 15:43:43');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (18, NULL, 5, 33, 10.0000, '2019-01-19 15:43:43', '2019-01-19 15:43:43');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (19, NULL, 6, 32, 2.0000, '2019-01-19 15:43:43', '2019-01-19 15:43:43');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (20, 40, NULL, 62, 2.0000, '2019-01-19 16:01:23', '2019-01-19 16:01:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (21, 41, NULL, 12, 1.0000, '2019-01-28 01:55:46', '2019-01-28 01:55:46');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (22, 42, NULL, 12, 1.0000, '2019-01-28 05:15:06', '2019-01-28 05:15:06');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (23, 43, NULL, 12, 128.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (24, 43, NULL, 11, 93.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (25, 43, NULL, 10, 40.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (26, 43, NULL, 74, 123.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (27, 43, NULL, 75, 123.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (28, 43, NULL, 76, 111.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (29, 43, NULL, 77, 111.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (30, 43, NULL, 57, 1.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (31, 43, NULL, 68, 1.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (32, 43, NULL, 81, 122392.0000, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (33, 44, NULL, 12, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (34, 44, NULL, 11, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (35, 44, NULL, 10, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (36, 44, NULL, 74, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (37, 44, NULL, 75, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (39, 44, NULL, 77, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (40, 44, NULL, 57, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (41, 44, NULL, 68, 0.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (42, 44, NULL, 81, 123000000.0000, '2019-01-28 20:36:59', '2019-01-28 20:36:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (43, 45, NULL, 12, 0.0000, '2019-01-31 02:08:07', '2019-01-31 02:08:07');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (44, 45, NULL, 11, 0.0000, '2019-01-31 02:08:07', '2019-01-31 02:08:07');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (45, 45, NULL, 10, 0.0000, '2019-01-31 02:08:07', '2019-01-31 02:08:07');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (46, 45, NULL, 71, 1.0000, '2019-01-31 02:08:07', '2019-01-31 02:08:07');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (47, 45, NULL, 84, 4.0000, '2019-01-31 02:08:07', '2019-01-31 02:08:07');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (48, 46, NULL, 12, 0.0000, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (49, 46, NULL, 11, 0.0000, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (50, 46, NULL, 10, 0.0000, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (51, 46, NULL, 71, 0.0000, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (52, 46, NULL, 84, 3.0000, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (53, NULL, 7, 73, 1.0000, '2019-01-31 03:36:19', '2019-01-31 03:36:19');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (54, 47, NULL, 12, 0.0000, '2019-02-02 03:09:29', '2019-02-02 03:09:29');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (55, 47, NULL, 10, 0.0000, '2019-02-02 03:09:29', '2019-02-02 03:09:29');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (56, 47, NULL, 81, 10.0000, '2019-02-02 03:09:29', '2019-02-02 03:09:29');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (57, 48, NULL, 12, 0.0000, '2019-02-02 03:25:06', '2019-02-02 03:25:06');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (58, 48, NULL, 10, 0.0000, '2019-02-02 03:25:06', '2019-02-02 03:25:06');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (59, 48, NULL, 71, 0.0000, '2019-02-02 03:25:06', '2019-02-02 03:25:06');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (60, 48, NULL, 89, 10.0000, '2019-02-02 03:25:06', '2019-02-02 03:25:06');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (61, 49, NULL, 12, 0.0000, '2019-02-02 04:26:23', '2019-02-02 04:26:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (62, 49, NULL, 10, 0.0000, '2019-02-02 04:26:23', '2019-02-02 04:26:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (63, 49, NULL, 71, 0.0000, '2019-02-02 04:26:23', '2019-02-02 04:26:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (64, 49, NULL, 87, 0.0000, '2019-02-02 04:26:23', '2019-02-02 04:26:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (66, 50, NULL, 12, 0.0000, '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (67, 50, NULL, 10, 0.0000, '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (68, 50, NULL, 71, 0.0000, '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (69, 50, NULL, 87, 0.0000, '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (70, 50, NULL, 89, 3.0000, '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (71, 51, NULL, 12, 0.0000, '2019-02-02 04:56:17', '2019-02-02 04:56:17');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (72, 51, NULL, 10, 0.0000, '2019-02-02 04:56:17', '2019-02-02 04:56:17');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (73, 51, NULL, 24, 10.0000, '2019-02-02 04:56:17', '2019-02-02 04:56:17');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (74, 52, NULL, 12, 0.0000, '2019-02-02 05:00:26', '2019-02-02 05:00:26');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (75, 52, NULL, 10, 0.0000, '2019-02-02 05:00:26', '2019-02-02 05:00:26');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (76, 52, NULL, 24, 1.0000, '2019-02-02 05:00:26', '2019-02-02 05:00:26');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (77, 53, NULL, 12, 0.0000, '2019-02-02 06:41:42', '2019-02-02 06:41:42');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (78, 53, NULL, 10, 0.0000, '2019-02-02 06:41:42', '2019-02-02 06:41:42');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (79, 53, NULL, 25, 12.0000, '2019-02-02 06:41:42', '2019-02-02 06:41:42');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (80, 57, NULL, 12, 0.0000, '2019-02-02 06:54:35', '2019-02-02 06:54:35');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (81, 57, NULL, 10, 0.0000, '2019-02-02 06:54:35', '2019-02-02 06:54:35');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (83, 58, NULL, 12, 0.0000, '2019-02-02 06:56:37', '2019-02-02 06:56:37');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (84, 58, NULL, 10, 0.0000, '2019-02-02 06:56:37', '2019-02-02 06:56:37');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (85, 58, NULL, 91, 1.0000, '2019-02-02 06:56:37', '2019-02-02 06:56:37');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (86, 59, NULL, 12, 0.0000, '2019-02-02 07:10:23', '2019-02-02 07:10:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (87, 59, NULL, 10, 0.0000, '2019-02-02 07:10:23', '2019-02-02 07:10:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (88, 59, NULL, 91, 4.0000, '2019-02-02 07:10:23', '2019-02-02 07:10:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (89, 61, NULL, 12, 0.0000, '2019-02-02 07:14:29', '2019-02-02 07:14:29');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (90, 61, NULL, 10, 0.0000, '2019-02-02 07:14:29', '2019-02-02 07:14:29');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (91, 61, NULL, 91, 0.0000, '2019-02-02 07:14:29', '2019-02-02 07:14:29');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (92, 61, NULL, 92, 1.0000, '2019-02-02 07:14:29', '2019-02-02 07:14:29');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (93, 62, NULL, 12, 0.0000, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (94, 62, NULL, 10, 0.0000, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (95, 62, NULL, 91, 0.0000, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (96, 62, NULL, 92, 9.0000, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (97, 62, NULL, 71, 0.0000, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (98, 62, NULL, 88, 1.0000, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (99, 63, NULL, 12, 0.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (100, 63, NULL, 10, 0.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (101, 63, NULL, 91, 0.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (102, 63, NULL, 92, 0.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (103, 63, NULL, 71, 0.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (104, 63, NULL, 88, 2.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (105, 63, NULL, 87, 0.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (106, 63, NULL, 98, 1.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (107, 63, NULL, 89, 1.0000, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (108, 64, NULL, 12, 0.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (109, 64, NULL, 10, 0.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (110, 64, NULL, 91, 0.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (111, 64, NULL, 92, 0.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (112, 64, NULL, 71, 0.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (113, 64, NULL, 87, 0.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (114, 64, NULL, 89, 6.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (115, 64, NULL, 90, 20.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (116, 64, NULL, 99, 24.0000, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (117, 65, NULL, 12, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (118, 65, NULL, 10, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (119, 65, NULL, 91, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (120, 65, NULL, 92, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (121, 65, NULL, 71, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (122, 65, NULL, 87, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (123, 65, NULL, 89, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (124, 65, NULL, 90, 0.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (125, 65, NULL, 99, 20.0000, '2019-02-02 07:29:03', '2019-02-02 07:29:03');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (126, 66, NULL, 12, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (127, 66, NULL, 10, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (128, 66, NULL, 91, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (129, 66, NULL, 92, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (130, 66, NULL, 71, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (131, 66, NULL, 87, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (132, 66, NULL, 89, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (133, 66, NULL, 90, 0.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (134, 66, NULL, 99, 50.0000, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (135, 67, NULL, 12, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (136, 67, NULL, 10, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (137, 67, NULL, 91, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (138, 67, NULL, 92, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (139, 67, NULL, 71, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (140, 67, NULL, 87, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (141, 67, NULL, 89, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (142, 67, NULL, 90, 0.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (143, 67, NULL, 99, 6.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (144, 67, NULL, 102, 19.0000, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (145, 68, NULL, 12, 0.0000, '2019-02-06 20:12:04', '2019-02-06 20:12:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (156, 69, NULL, 54, 1.0000, '2019-02-06 20:12:04', '2019-02-06 20:12:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (157, 70, NULL, 12, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (158, 70, NULL, 10, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (159, 70, NULL, 91, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (160, 70, NULL, 92, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (161, 70, NULL, 71, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (162, 70, NULL, 87, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (163, 70, NULL, 89, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (164, 70, NULL, 90, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (165, 70, NULL, 99, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (166, 70, NULL, 102, 50.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (167, 71, NULL, 12, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (168, 71, NULL, 10, 0.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (169, 71, NULL, 25, 3.0000, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (170, NULL, 8, 84, 3.0000, '2019-02-07 21:05:57', '2019-02-07 21:05:57');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (171, 72, NULL, 12, 0.0000, '2019-02-08 20:28:52', '2019-02-08 20:28:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (172, 72, NULL, 10, 0.0000, '2019-02-08 20:28:52', '2019-02-08 20:28:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (173, 72, NULL, 32, 1.0000, '2019-02-08 20:28:52', '2019-02-08 20:28:52');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (174, 73, NULL, 12, 0.0000, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (175, 73, NULL, 10, 0.0000, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (176, 73, NULL, 92, 0.0000, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (177, 73, NULL, 91, 0.0000, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (178, 73, NULL, 71, 0.0000, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (179, 73, NULL, 87, 0.0000, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (180, 73, NULL, 93, 100.0000, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (181, 74, NULL, 12, 0.0000, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (182, 74, NULL, 10, 0.0000, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (183, 74, NULL, 91, 0.0000, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (184, 74, NULL, 92, 0.0000, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (185, 74, NULL, 71, 0.0000, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (186, 74, NULL, 87, 0.0000, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (187, 74, NULL, 93, 200.0000, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (188, 75, NULL, 12, 0.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (189, 75, NULL, 10, 0.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (190, 75, NULL, 92, 0.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (191, 75, NULL, 91, 0.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (192, 75, NULL, 71, 0.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (193, 75, NULL, 87, 0.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (194, 75, NULL, 93, 7.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (195, 76, NULL, 115, 5.0000, '2019-02-11 15:29:40', '2019-02-11 15:29:40');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (196, 77, NULL, 115, 7.0000, '2019-02-12 13:48:28', '2019-02-12 13:48:28');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (197, 77, NULL, 114, 5.0000, '2019-02-12 13:48:28', '2019-02-12 13:48:28');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (198, 78, NULL, 114, 5.0000, '2019-02-12 13:53:16', '2019-02-12 13:53:16');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (201, 81, NULL, 114, 1.0000, '2019-02-12 14:26:16', '2019-02-12 14:26:16');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (202, 82, NULL, 114, 2.0000, '2019-02-12 17:09:50', '2019-02-12 17:09:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (203, 83, NULL, 126, 10.0000, '2019-02-12 19:14:30', '2019-02-12 19:14:30');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (204, 84, NULL, 126, 1.0000, '2019-02-13 21:47:17', '2019-02-13 21:47:17');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (205, 85, NULL, 128, 1.0000, '2019-02-13 21:47:17', '2019-02-13 21:47:17');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (206, 86, NULL, 126, 1.0000, '2019-02-13 22:36:31', '2019-02-13 22:36:31');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (207, 87, NULL, 114, 1.0000, '2019-02-13 22:36:31', '2019-02-13 22:36:31');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (208, 88, NULL, 130, 1.0000, '2019-02-13 23:04:41', '2019-02-13 23:04:41');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (209, 89, NULL, 131, 2.0000, '2019-02-14 00:02:30', '2019-02-14 00:02:30');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (227, 120, NULL, 126, 1.0000, '2019-02-14 14:54:31', '2019-02-14 14:54:31');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (228, 120, NULL, 129, 1.0000, '2019-02-14 14:54:31', '2019-02-14 14:54:31');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (232, 125, NULL, 130, 12.0000, '2019-02-15 14:06:53', '2019-02-15 14:06:53');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (233, 126, NULL, 148, 2.0000, '2019-02-15 14:39:44', '2019-02-15 14:39:44');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (234, 127, NULL, 149, 1.0000, '2019-02-15 14:44:33', '2019-02-15 14:44:33');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (235, 127, NULL, 150, 1.0000, '2019-02-15 14:44:33', '2019-02-15 14:44:33');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (236, 128, NULL, 151, 2.0000, '2019-02-15 15:58:10', '2019-02-15 15:58:10');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (237, 133, NULL, 151, 1.0000, '2019-02-17 22:01:01', '2019-02-17 22:01:01');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (247, 146, NULL, 151, 1.0000, '2019-02-18 18:38:50', '2019-02-18 18:38:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (248, 147, NULL, 152, 1.0000, '2019-02-18 18:38:50', '2019-02-18 18:38:50');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (249, 148, NULL, 151, 1.0000, '2019-02-18 18:54:48', '2019-02-18 18:54:48');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (250, 149, NULL, 152, 1.0000, '2019-02-18 18:54:48', '2019-02-18 18:54:48');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (251, 150, NULL, 151, 1.0000, '2019-02-18 18:57:14', '2019-02-18 18:57:14');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (252, 151, NULL, 152, 1.0000, '2019-02-18 18:57:14', '2019-02-18 18:57:14');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (253, 152, NULL, 152, 1.0000, '2019-02-18 19:51:59', '2019-02-18 19:51:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (254, 153, NULL, 151, 1.0000, '2019-02-18 19:51:59', '2019-02-18 19:51:59');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (255, 154, NULL, 151, 1.0000, '2019-02-18 19:53:38', '2019-02-18 19:53:38');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (256, 155, NULL, 152, 1.0000, '2019-02-18 19:53:38', '2019-02-18 19:53:38');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (263, 162, NULL, 151, 1.0000, '2019-02-18 20:23:17', '2019-02-18 20:23:17');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (264, 163, NULL, 152, 1.0000, '2019-02-18 20:23:17', '2019-02-18 20:23:17');
INSERT INTO `transaction_sell_lines_purchase_lines` VALUES (267, 168, NULL, 151, 1.5000, '2019-02-18 20:38:07', '2019-02-18 20:38:07');

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `bank_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `res_table_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_waiter_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_order_status` enum('received','cooked','served') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` enum('purchase','sell','expense','stock_adjustment','sell_transfer','purchase_transfer','opening_stock','sell_return','opening_balance','regular_balance','bank_payment') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('received','pending','final','draft','quotation') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_quotation` tinyint(1) NOT NULL DEFAULT 0,
  `payment_status` enum('paid','due','partial') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `adjustment_type` enum('normal','abnormal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contact_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `customer_group_id` int(11) NULL DEFAULT NULL COMMENT 'used to add customer group while selling',
  `invoice_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ref_no` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transaction_date` datetime(0) NOT NULL,
  `total_before_tax` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `tax_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `tax_amount` decimal(20, 2) NULL DEFAULT 0.00,
  `discount_type` enum('fixed','percentage') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `discount_amount` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shipping_details` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shipping_charges` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `additional_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `staff_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `final_total` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `expense_category_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `expense_for` int(10) UNSIGNED NULL DEFAULT NULL,
  `commission_agent` int(11) NULL DEFAULT NULL,
  `document` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT 0,
  `exchange_rate` decimal(20, 3) NOT NULL DEFAULT 1.000,
  `total_amount_recovered` decimal(20, 2) NULL DEFAULT NULL COMMENT 'Used for stock adjustment.',
  `transfer_parent_id` int(11) NULL DEFAULT NULL,
  `opening_stock_product_id` int(11) NULL DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `regular_balance_date` date NULL DEFAULT NULL,
  `delivery_status` enum('packaging','order_processing','delivered') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `transactions_tax_id_foreign`(`tax_id`) USING BTREE,
  INDEX `transactions_business_id_index`(`business_id`) USING BTREE,
  INDEX `transactions_type_index`(`type`) USING BTREE,
  INDEX `transactions_contact_id_index`(`contact_id`) USING BTREE,
  INDEX `transactions_transaction_date_index`(`transaction_date`) USING BTREE,
  INDEX `transactions_created_by_index`(`created_by`) USING BTREE,
  INDEX `transactions_location_id_index`(`location_id`) USING BTREE,
  INDEX `transactions_expense_for_foreign`(`expense_for`) USING BTREE,
  INDEX `transactions_expense_category_id_index`(`expense_category_id`) USING BTREE,
  CONSTRAINT `transactions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transactions_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transactions_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transactions_expense_for_foreign` FOREIGN KEY (`expense_for`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `transactions_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transactions_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 327 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of transactions
-- ----------------------------
INSERT INTO `transactions` VALUES (1, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 2, NULL, NULL, '35001BCVX', '2018-07-18 22:49:20', 50600.00, 1, 5060.00, NULL, '0', NULL, 0.00, NULL, NULL, 55660.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:27:11', '2018-01-06 09:27:11');
INSERT INTO `transactions` VALUES (2, 1, 1, 0, NULL, NULL, NULL, 'purchase', '', 0, 'paid', NULL, 5, NULL, NULL, '35001BJGN', '2018-07-18 00:00:00', 77000.00, 1, 7700.00, NULL, '0', NULL, 0.00, NULL, NULL, 84700.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:28:10', '2018-08-13 02:02:01');
INSERT INTO `transactions` VALUES (3, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 6, NULL, NULL, '35001BCVJ', '2018-07-03 22:49:20', 5500.00, 1, 550.00, NULL, '0', NULL, 0.00, NULL, NULL, 6050.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:32:22', '2018-01-06 09:32:22');
INSERT INTO `transactions` VALUES (4, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 6, NULL, NULL, '35001BCVK', '2018-07-03 22:49:20', 2000.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 2000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:33:12', '2018-01-06 09:33:12');
INSERT INTO `transactions` VALUES (5, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 6, NULL, NULL, '35001BCVD', '2018-07-26 22:49:20', 11000.00, 1, 1100.00, NULL, '0', NULL, 0.00, NULL, NULL, 12100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:35:26', '2018-01-06 09:35:26');
INSERT INTO `transactions` VALUES (6, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 4, NULL, 'AS0001', '', '2018-04-10 13:23:21', 770.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 770.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:36:11', '2018-01-06 09:36:11');
INSERT INTO `transactions` VALUES (7, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0002', '', '2018-07-31 22:49:20', 825.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 825.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:36:31', '2018-01-06 09:36:31');
INSERT INTO `transactions` VALUES (8, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 4, NULL, 'AS0003', '', '2018-07-31 22:49:20', 7700.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 7700.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:37:22', '2018-01-06 09:37:22');
INSERT INTO `transactions` VALUES (9, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0004', '', '2018-08-02 22:49:20', 750.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 750.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:37:45', '2018-01-06 09:37:45');
INSERT INTO `transactions` VALUES (10, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0005', '', '2018-08-02 22:49:20', 412.50, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 412.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-01-06 09:38:03', '2019-01-24 19:19:51');
INSERT INTO `transactions` VALUES (11, 2, 2, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 8, NULL, NULL, '56247065', '2018-07-26 22:49:20', 300.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 300.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 4, NULL, NULL, '2018-04-10 12:48:16', '2018-04-10 12:48:47');
INSERT INTO `transactions` VALUES (12, 2, 2, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 9, NULL, NULL, '547887025', '2018-07-26 22:49:20', 1200.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1200.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 4, NULL, NULL, '2018-04-10 12:49:40', '2018-04-10 12:49:49');
INSERT INTO `transactions` VALUES (13, 2, 2, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 9, NULL, NULL, '45470025', '2018-07-03 22:49:20', 1350.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1350.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 4, NULL, NULL, '2018-04-10 12:50:41', '2018-04-10 12:50:55');
INSERT INTO `transactions` VALUES (14, 2, 2, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 9, NULL, NULL, '65589898', '2018-07-03 22:49:20', 2160.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 2160.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 4, NULL, NULL, '2018-04-10 12:51:38', '2018-04-10 12:52:10');
INSERT INTO `transactions` VALUES (15, 2, 2, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 7, NULL, '0001', '', '2018-07-31 22:49:20', 75.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 75.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 4, NULL, NULL, '2018-04-10 12:53:35', '2018-04-10 12:53:35');
INSERT INTO `transactions` VALUES (16, 2, 2, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 7, NULL, '0002', '', '2018-07-31 22:49:20', 105.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 105.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 4, NULL, NULL, '2018-04-10 12:53:58', '2018-04-10 12:53:58');
INSERT INTO `transactions` VALUES (17, 2, 2, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 7, NULL, '0003', '', '2018-08-02 22:49:20', 405.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 405.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 4, NULL, NULL, '2018-04-10 12:54:21', '2018-04-10 12:56:26');
INSERT INTO `transactions` VALUES (18, 3, 3, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 11, NULL, NULL, '548471117', '2018-07-03 22:49:20', 9630.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 9630.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:09:54', '2018-04-10 14:10:02');
INSERT INTO `transactions` VALUES (19, 3, 3, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 12, NULL, NULL, '548222220', '2018-07-26 22:49:20', 20000.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 20000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:10:51', '2018-04-10 14:10:58');
INSERT INTO `transactions` VALUES (20, 3, 3, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 12, NULL, NULL, '878445524', '2018-07-18 22:49:20', 13500.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 13500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:11:45', '2018-04-10 14:13:19');
INSERT INTO `transactions` VALUES (21, 3, 3, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 12, NULL, NULL, '582500058', '2018-07-18 22:49:20', 19500.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 19500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:12:34', '2018-04-10 14:13:24');
INSERT INTO `transactions` VALUES (22, 3, 3, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 11, NULL, NULL, '848485552', '2018-07-26 22:49:20', 12000.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 12000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:13:12', '2018-04-10 14:13:35');
INSERT INTO `transactions` VALUES (23, 3, 3, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 10, NULL, 'AE0001', '', '2018-08-02 22:49:20', 2500.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 2500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:14:47', '2018-04-10 14:17:10');
INSERT INTO `transactions` VALUES (24, 3, 3, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 10, NULL, 'AE0002', '', '2018-07-31 22:49:20', 4875.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 4875.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:15:06', '2018-04-10 14:16:43');
INSERT INTO `transactions` VALUES (25, 3, 3, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 10, NULL, 'AE0003', '', '2018-07-31 22:49:20', 625.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 625.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:16:02', '2018-04-10 14:16:02');
INSERT INTO `transactions` VALUES (26, 3, 3, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 10, NULL, 'AE0004', '', '2018-08-02 22:49:20', 15625.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 15625.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:18:48', '2018-04-10 14:18:48');
INSERT INTO `transactions` VALUES (27, 3, 3, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 12, NULL, NULL, '1545477882', '2018-07-18 22:49:20', 26000.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 26000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:23:36', '2018-04-10 14:23:36');
INSERT INTO `transactions` VALUES (28, 3, 3, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 10, NULL, 'AE0005', '', '2018-07-31 22:49:20', 13000.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 13000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 5, NULL, NULL, '2018-04-10 14:24:16', '2018-04-10 14:24:16');
INSERT INTO `transactions` VALUES (29, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0001', '', '2018-08-02 22:49:20', 656.25, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 656.25, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:34:40', '2018-04-10 15:34:40');
INSERT INTO `transactions` VALUES (30, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0002', '', '2018-07-31 22:49:20', 250.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 250.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:34:54', '2018-04-10 15:34:54');
INSERT INTO `transactions` VALUES (31, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0003', '', '2018-08-02 22:49:20', 75.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 75.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:35:19', '2018-04-10 15:35:19');
INSERT INTO `transactions` VALUES (32, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0004', '', '2018-08-02 22:49:20', 37.50, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 37.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:37:50', '2018-04-10 15:37:50');
INSERT INTO `transactions` VALUES (33, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0005', '', '2018-07-31 22:49:20', 375.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 375.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:38:01', '2018-04-10 15:38:01');
INSERT INTO `transactions` VALUES (34, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0006', '', '2018-07-31 22:49:20', 250.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 250.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:38:15', '2018-04-10 15:38:15');
INSERT INTO `transactions` VALUES (35, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0007', '', '2018-08-02 22:49:20', 100.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:38:27', '2018-04-10 15:38:27');
INSERT INTO `transactions` VALUES (36, 4, 4, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 13, NULL, '0008', '', '2018-07-31 22:49:20', 125.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 125.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 6, NULL, NULL, '2018-04-10 15:38:49', '2018-04-10 15:38:49');
INSERT INTO `transactions` VALUES (37, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 6, NULL, NULL, 'PO2018/0001', '2018-07-31 22:49:20', 5180.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 5180.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-06-12 00:47:07', '2019-01-24 08:31:30');
INSERT INTO `transactions` VALUES (38, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 6, NULL, NULL, 'PO2018/0002', '2018-08-02 22:49:20', 235656.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 235656.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `transactions` VALUES (39, 5, 5, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 15, NULL, NULL, 'PO2018/0001', '2018-07-31 22:49:20', 1900.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1900.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 7, NULL, NULL, '2018-07-13 10:04:45', '2018-07-13 10:04:45');
INSERT INTO `transactions` VALUES (40, 5, 5, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 15, NULL, NULL, 'PO2018/0002', '2018-07-31 22:49:20', 800.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 800.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 7, NULL, NULL, '2018-07-13 10:08:24', '2018-07-13 10:08:24');
INSERT INTO `transactions` VALUES (41, 5, 5, 0, 1, 8, 'served', 'sell', '', 0, 'paid', NULL, 14, NULL, '0001', '', '2018-08-02 22:49:20', 42.50, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 42.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 7, NULL, NULL, '2018-07-13 10:14:40', '2018-07-13 10:18:07');
INSERT INTO `transactions` VALUES (42, 5, 5, 0, 2, 8, NULL, 'sell', '', 0, 'paid', NULL, 14, NULL, '0002', '', '2018-08-02 22:49:20', 77.50, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 77.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 7, NULL, NULL, '2018-07-13 10:15:28', '2018-07-13 10:15:29');
INSERT INTO `transactions` VALUES (43, 5, 5, 0, 3, 8, NULL, 'sell', '', 0, 'paid', NULL, 14, NULL, '0003', '', '2018-08-02 22:49:20', 33.75, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 33.75, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 7, NULL, NULL, '2018-07-13 10:16:04', '2018-07-13 10:16:04');
INSERT INTO `transactions` VALUES (44, 5, 5, 0, NULL, NULL, 'cooked', 'sell', '', 0, 'paid', NULL, 14, NULL, '0004', '', '2018-08-02 22:49:20', 71.25, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 71.25, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 7, NULL, NULL, '2018-07-13 10:16:36', '2018-07-13 10:16:55');
INSERT INTO `transactions` VALUES (45, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 2, NULL, NULL, 'with supplier', '2018-08-08 00:00:00', 100.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-08 07:03:01', '2018-08-08 07:03:01');
INSERT INTO `transactions` VALUES (46, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0006', '', '2018-08-08 04:33:35', 125.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 112.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-08 07:03:35', '2019-01-24 19:33:38');
INSERT INTO `transactions` VALUES (47, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0007', '', '2018-08-08 00:00:00', 132.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 118.80, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-08 07:55:04', '2019-01-25 12:14:00');
INSERT INTO `transactions` VALUES (48, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'pending', 0, 'partial', NULL, 2, NULL, NULL, 'ref1', '2018-08-12 00:00:00', 77.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 77.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-13 01:48:41', '2019-01-27 07:42:26');
INSERT INTO `transactions` VALUES (49, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 2, NULL, NULL, 'ref2', '2018-08-12 00:00:00', 77.00, NULL, 0.00, NULL, '0', 'Transport', 20.00, NULL, NULL, 97.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-13 01:50:06', '2018-08-13 01:50:06');
INSERT INTO `transactions` VALUES (50, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 2, NULL, NULL, 'ref3', '2018-08-12 00:00:00', 77.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 77.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-13 01:50:47', '2018-08-13 01:50:47');
INSERT INTO `transactions` VALUES (51, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 2, NULL, NULL, 'ref4', '2018-08-12 00:00:00', 11.00, NULL, 0.00, NULL, '0', 'Transport', 20.00, NULL, NULL, 31.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-13 01:51:29', '2018-08-13 01:51:29');
INSERT INTO `transactions` VALUES (52, 1, 1, 0, NULL, NULL, NULL, 'expense', '', 0, 'paid', NULL, NULL, NULL, NULL, 'dsdsd', '2018-08-12 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 100.00, 2, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2018-08-13 02:18:48', '2019-01-19 10:29:03');
INSERT INTO `transactions` VALUES (54, 1, 1, 0, NULL, NULL, NULL, '', '', 0, 'due', NULL, 19, NULL, NULL, '2019/0001', '2019-01-14 01:16:19', 123.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 123.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-14 01:16:19', '2019-01-14 01:16:19');
INSERT INTO `transactions` VALUES (55, 1, 1, 0, NULL, NULL, NULL, '', '', 0, 'due', NULL, 20, NULL, NULL, '2019/0002', '2019-01-14 01:27:25', 123123123.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 123123123.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-14 01:27:25', '2019-01-14 01:27:25');
INSERT INTO `transactions` VALUES (56, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0008', '', '2019-01-14 00:00:00', 954.20, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 858.78, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-14 04:04:45', '2019-01-24 19:10:11');
INSERT INTO `transactions` VALUES (57, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 09:09:37', 184680.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 184680.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 86, 1, NULL, NULL, '2019-01-16 09:09:37', '2019-01-16 09:09:37');
INSERT INTO `transactions` VALUES (58, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 09:19:06', 1476.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1476.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 88, 1, NULL, NULL, '2019-01-16 09:19:06', '2019-01-16 09:19:06');
INSERT INTO `transactions` VALUES (59, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 02:00:25', 1100.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 90, 1, NULL, NULL, '2019-01-17 02:00:27', '2019-01-17 02:00:27');
INSERT INTO `transactions` VALUES (60, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 02:08:48', 23.60, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 23.60, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 91, 1, NULL, NULL, '2019-01-17 02:08:48', '2019-01-17 02:40:38');
INSERT INTO `transactions` VALUES (61, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 02:39:06', 10.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 10.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 63, 1, NULL, NULL, '2019-01-17 02:39:06', '2019-01-17 02:39:06');
INSERT INTO `transactions` VALUES (62, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0009', '', '2019-01-17 00:00:00', 875.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 787.50, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 20:40:52', '2019-01-25 12:14:00');
INSERT INTO `transactions` VALUES (63, 1, 1, 0, NULL, NULL, NULL, '', '', 0, 'due', NULL, 20, NULL, NULL, '2019/0003', '2019-01-17 21:15:10', 1000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 21:15:10', '2019-01-17 21:15:10');
INSERT INTO `transactions` VALUES (64, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 20, NULL, NULL, 'PO2019/0007', '2019-01-17 00:00:00', 4210.00, NULL, 0.00, 'fixed', '20', NULL, 0.00, NULL, NULL, 4190.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 21:17:47', '2019-01-19 11:03:03');
INSERT INTO `transactions` VALUES (65, 1, 1, 0, NULL, NULL, NULL, '', '', 0, 'due', NULL, 20, NULL, NULL, '2019/0004', '2019-01-17 21:20:31', 1331.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1331.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 21:20:31', '2019-01-17 21:20:31');
INSERT INTO `transactions` VALUES (66, 1, 1, 0, NULL, NULL, NULL, '', '', 0, 'due', NULL, 2, NULL, NULL, '2019/0005', '2019-01-17 21:51:21', 1000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 21:51:21', '2019-01-17 21:51:21');
INSERT INTO `transactions` VALUES (67, 1, 1, 0, NULL, NULL, NULL, '', '', 0, 'due', NULL, 23, NULL, NULL, '2019/0006', '2019-01-17 21:52:41', 1000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 21:52:41', '2019-01-17 21:52:41');
INSERT INTO `transactions` VALUES (68, 1, 1, 0, NULL, NULL, NULL, '', '', 0, 'due', NULL, 4, NULL, NULL, '2019/0007', '2019-01-17 22:10:56', 12123.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 12123.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 22:10:56', '2019-01-17 22:10:56');
INSERT INTO `transactions` VALUES (69, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', '', 0, 'due', NULL, 1, NULL, NULL, '2019/0008', '2019-01-17 22:15:36', 1000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 551.78, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 22:15:36', '2019-01-19 16:00:11');
INSERT INTO `transactions` VALUES (70, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', '', 0, 'due', NULL, 2, NULL, NULL, '2019/0009', '2019-01-17 22:16:01', 100.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 300.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 22:16:01', '2019-01-19 11:33:17');
INSERT INTO `transactions` VALUES (71, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', '', 0, 'due', NULL, 20, NULL, NULL, '2019/0010', '2019-01-17 22:55:09', -20.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, -100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-17 22:55:09', '2019-01-17 22:55:21');
INSERT INTO `transactions` VALUES (72, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', '', 0, 'due', NULL, 23, NULL, NULL, '2019/0011', '2019-01-18 06:22:49', -100.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-18 06:22:49', '2019-01-18 10:20:33');
INSERT INTO `transactions` VALUES (73, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', '', 0, 'due', NULL, 4, NULL, NULL, '2019/0012', '2019-01-18 06:58:06', -100.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, -100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-18 06:58:06', '2019-01-18 07:04:00');
INSERT INTO `transactions` VALUES (75, 1, 1, 0, NULL, NULL, NULL, 'sell_return', '', 0, NULL, NULL, 1, NULL, 'asdfasdf', NULL, '2019-01-18 00:00:00', 79.20, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 79.20, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-18 21:54:10', '2019-01-18 21:54:10');
INSERT INTO `transactions` VALUES (76, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'paid', NULL, 1, NULL, 'AS0010', '', '2019-01-19 00:00:00', 12.50, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 12.50, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 03:37:43', '2019-01-25 12:14:00');
INSERT INTO `transactions` VALUES (77, 1, 1, 0, NULL, NULL, NULL, 'stock_adjustment', 'received', 0, NULL, 'normal', NULL, NULL, NULL, '1234', '2019-01-19 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 15079.20, NULL, NULL, NULL, NULL, 0, 1.000, 0.00, NULL, NULL, 1, NULL, NULL, '2019-01-19 04:37:42', '2019-01-19 04:37:42');
INSERT INTO `transactions` VALUES (78, 1, 1, 0, NULL, NULL, NULL, 'stock_adjustment', 'received', 0, NULL, 'abnormal', NULL, NULL, NULL, '12341234', '2019-01-19 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, 0, 1.000, 0.00, NULL, NULL, 1, NULL, NULL, '2019-01-19 04:39:54', '2019-01-19 04:39:54');
INSERT INTO `transactions` VALUES (81, 1, 7, 0, NULL, NULL, NULL, 'stock_adjustment', 'received', 0, NULL, 'normal', NULL, NULL, NULL, '23132164', '2019-01-19 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 10450.00, NULL, NULL, NULL, NULL, 0, 1.000, 0.00, NULL, NULL, 1, NULL, NULL, '2019-01-19 09:16:38', '2019-01-19 09:16:38');
INSERT INTO `transactions` VALUES (82, 1, 1, 0, NULL, NULL, NULL, 'expense', '', 0, 'paid', NULL, NULL, NULL, NULL, '556', '2019-01-19 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 100.00, 1, 1, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 09:29:40', '2019-01-19 09:29:40');
INSERT INTO `transactions` VALUES (83, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', '', 0, 'due', NULL, 25, NULL, NULL, '2019/0014', '2019-01-19 09:35:15', 100.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 09:35:15', '2019-01-19 09:35:15');
INSERT INTO `transactions` VALUES (84, 1, 1, 0, NULL, NULL, NULL, 'sell', '', 0, 'partial', NULL, 23, NULL, 'AS0011', '', '2019-01-16 00:00:00', 13062.50, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 11756.25, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 12:50:25', '2019-01-25 20:19:27');
INSERT INTO `transactions` VALUES (85, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 4, NULL, NULL, 'PO2019/0008', '2019-01-19 00:00:00', 2000.00, NULL, 0.00, NULL, '0', NULL, 100.00, NULL, NULL, 2100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 13:27:04', '2019-01-19 13:44:05');
INSERT INTO `transactions` VALUES (86, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 6, NULL, NULL, 'PO2019/0009', '2019-01-19 00:00:00', 2000.00, NULL, 0.00, NULL, '0', NULL, 100.00, NULL, NULL, 2100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 13:42:58', '2019-01-19 13:42:59');
INSERT INTO `transactions` VALUES (87, 1, 1, 0, NULL, NULL, NULL, 'stock_adjustment', 'received', 0, NULL, 'normal', NULL, NULL, NULL, 'SA2019/0007', '2019-01-19 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 7462.00, NULL, NULL, NULL, NULL, 0, 1.000, 0.00, NULL, NULL, 1, NULL, NULL, '2019-01-19 15:43:43', '2019-01-19 15:43:43');
INSERT INTO `transactions` VALUES (88, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 4, NULL, NULL, 'PO2019/0010', '2019-01-19 00:00:00', 2700.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 2700.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 15:49:17', '2019-01-19 15:49:17');
INSERT INTO `transactions` VALUES (89, 1, 7, 0, NULL, NULL, NULL, 'sell', '', 0, 'due', NULL, 1, NULL, 'AS0012', '', '2019-01-19 00:00:00', 3375.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 3037.50, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-19 16:01:23', '2019-01-25 20:23:32');
INSERT INTO `transactions` VALUES (90, 1, 1, 0, NULL, NULL, NULL, 'sell_return', '', 0, NULL, NULL, 1, NULL, 'CN2019/0002', NULL, '2019-01-25 00:00:00', 12.50, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 12.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-25 12:46:50', '2019-01-25 12:46:50');
INSERT INTO `transactions` VALUES (91, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 3, NULL, NULL, 'PO2019/0011', '2019-01-26 00:00:00', 19050.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 19050.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-26 23:29:26', '2019-01-26 23:29:26');
INSERT INTO `transactions` VALUES (92, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 3, NULL, NULL, 'PO2019/0012', '2019-01-27 00:00:00', 550.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 550.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-27 07:44:28', '2019-01-27 19:09:08');
INSERT INTO `transactions` VALUES (93, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 3, NULL, NULL, 'PO2019/0013', '2019-01-27 00:00:00', 452.86, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 452.86, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-27 22:13:59', '2019-01-27 22:14:00');
INSERT INTO `transactions` VALUES (94, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 6, NULL, NULL, 'PO2019/0014', '2019-01-30 00:00:00', 223.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 223.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-27 22:15:07', '2019-01-29 18:47:40');
INSERT INTO `transactions` VALUES (95, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'pending', 0, 'paid', NULL, 19, NULL, NULL, 'PO2019/0015', '2019-01-28 00:00:00', 2200.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 2200.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 00:18:05', '2019-01-28 00:18:05');
INSERT INTO `transactions` VALUES (96, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0013', '', '2019-01-28 00:00:00', 437.50, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 393.75, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 01:55:46', '2019-01-28 01:55:46');
INSERT INTO `transactions` VALUES (97, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0014', '', '2019-01-28 00:00:00', 100.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 100.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 05:15:06', '2019-01-28 05:15:06');
INSERT INTO `transactions` VALUES (98, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 05:47:28', 122877.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 122877.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 101, 1, NULL, NULL, '2019-01-28 05:47:28', '2019-01-28 05:52:15');
INSERT INTO `transactions` VALUES (99, 1, 7, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 05:47:28', 122877.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 122877.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 101, 1, NULL, NULL, '2019-01-28 05:47:29', '2019-01-28 05:52:15');
INSERT INTO `transactions` VALUES (100, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 05:58:56', 110889.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 110889.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 103, 1, NULL, NULL, '2019-01-28 05:58:56', '2019-01-28 05:58:56');
INSERT INTO `transactions` VALUES (101, 1, 7, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 05:58:56', 110889.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 110889.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 103, 1, NULL, NULL, '2019-01-28 05:58:56', '2019-01-28 05:58:56');
INSERT INTO `transactions` VALUES (102, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 3, NULL, NULL, 'PO2019/0016', '2019-01-28 00:00:00', 27559147609.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 27559147609.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 06:13:49', '2019-01-28 06:13:49');
INSERT INTO `transactions` VALUES (103, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 19, NULL, NULL, 'PO2019/0017', '2019-01-28 00:00:00', 15144144129.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 15144144129.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 20:20:13', '2019-01-28 20:20:13');
INSERT INTO `transactions` VALUES (104, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 2, NULL, NULL, 'PO2019/0018', '2019-01-30 00:00:00', 1122.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1122.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 20:23:20', '2019-01-28 20:23:20');
INSERT INTO `transactions` VALUES (105, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0015', '', '2019-01-28 00:00:00', 15144129.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 13629716.10, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 20:25:57', '2019-01-28 20:25:57');
INSERT INTO `transactions` VALUES (106, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0016', '', '2019-01-29 00:00:00', 15129000000.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 13616100000.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-28 20:36:58', '2019-01-28 20:36:59');
INSERT INTO `transactions` VALUES (107, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 3, NULL, NULL, 'PO2019/0019', '2019-01-30 00:00:00', 1230.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1230.00, NULL, NULL, NULL, NULL, 0, 0.700, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-29 23:03:39', '2019-01-29 23:07:38');
INSERT INTO `transactions` VALUES (108, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 4, NULL, NULL, 'PO2019/0020', '2019-01-30 00:00:00', 1229.97, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1229.97, NULL, NULL, NULL, NULL, 0, 0.700, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-29 23:08:35', '2019-01-29 23:08:35');
INSERT INTO `transactions` VALUES (109, 1, 7, 0, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 1, NULL, 'CN2019/0003', NULL, '2019-01-30 00:00:00', 1990000000000000.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1990000000000000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-30 11:50:27', '2019-01-30 11:50:27');
INSERT INTO `transactions` VALUES (110, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 4, NULL, NULL, '1665', '2019-02-01 00:00:00', 1650.00, NULL, 0.00, NULL, '0', 'AWB 123123', 450.00, 'Purchase from Turkey', NULL, 2100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-31 01:45:45', '2019-01-31 02:04:42');
INSERT INTO `transactions` VALUES (111, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 31, NULL, NULL, '2019/0015', '2019-01-31 01:53:08', 14000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 14000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-31 01:53:08', '2019-01-31 01:53:08');
INSERT INTO `transactions` VALUES (112, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 31, NULL, 'AS0017', '', '2019-01-31 00:00:00', 1050.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, 'nothing', NULL, 1050.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-31 02:08:07', '2019-01-31 02:11:47');
INSERT INTO `transactions` VALUES (113, 1, 1, 0, NULL, NULL, NULL, 'expense', 'final', 0, 'paid', NULL, NULL, NULL, NULL, '123123', '2019-01-31 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 130.00, 1, 2, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-31 02:28:53', '2019-01-31 02:28:53');
INSERT INTO `transactions` VALUES (114, 1, 1, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'AA', '2019-01-31 00:00:00', 495.00, NULL, 0.00, NULL, NULL, NULL, 35.00, 'excellent thanks', NULL, 495.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transactions` VALUES (115, 1, 7, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'AA', '2019-01-31 00:00:00', 495.00, NULL, 0.00, NULL, NULL, NULL, 35.00, 'excellent thanks', NULL, 495.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 114, NULL, 1, NULL, NULL, '2019-01-31 02:30:50', '2019-01-31 02:30:50');
INSERT INTO `transactions` VALUES (116, 1, 7, 0, NULL, NULL, NULL, 'stock_adjustment', 'received', 0, NULL, 'normal', NULL, NULL, NULL, 'SA2019/0008', '2019-01-31 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 100.00, NULL, NULL, NULL, NULL, 0, 1.000, 0.00, NULL, NULL, 1, NULL, NULL, '2019-01-31 03:36:18', '2019-01-31 03:36:18');
INSERT INTO `transactions` VALUES (117, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 32, NULL, NULL, '2019/0016', '2019-02-02 02:45:16', 1234.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1234.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 02:45:16', '2019-02-02 02:45:16');
INSERT INTO `transactions` VALUES (118, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 26, NULL, NULL, '2019/0017', '2019-02-02 03:01:36', 111.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 111.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 03:01:36', '2019-02-02 03:01:36');
INSERT INTO `transactions` VALUES (119, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 32, NULL, 'AS0018', '', '2019-02-02 00:00:00', 2990.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 2990.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 03:09:29', '2019-02-02 03:09:29');
INSERT INTO `transactions` VALUES (120, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 6, NULL, NULL, 'PO2019/0022', '2019-02-02 00:00:00', 1300.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1300.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 03:21:55', '2019-02-02 03:21:55');
INSERT INTO `transactions` VALUES (121, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0019', '', '2019-02-02 00:00:00', 1500.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 1500.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 03:25:06', '2019-02-02 03:26:48');
INSERT INTO `transactions` VALUES (122, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 1, NULL, 'AS0020', '', '2019-02-02 00:00:00', 600.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 600.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 04:26:23', '2019-02-02 04:27:08');
INSERT INTO `transactions` VALUES (123, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 4, NULL, NULL, 'PO2019/0023', '2019-02-02 00:00:00', 2000.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 2000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 04:34:06', '2019-02-02 04:34:06');
INSERT INTO `transactions` VALUES (124, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 32, NULL, 'AS0021', '', '2019-02-02 00:00:00', 600.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 600.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 04:35:46', '2019-02-02 04:35:46');
INSERT INTO `transactions` VALUES (125, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0022', '', '2019-02-02 00:00:00', 5370.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 5370.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 04:56:17', '2019-02-02 04:56:17');
INSERT INTO `transactions` VALUES (126, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0023', '', '2019-02-02 00:00:00', 437.50, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 437.50, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 05:00:26', '2019-02-02 05:00:26');
INSERT INTO `transactions` VALUES (127, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0024', '', '2019-02-02 00:00:00', 5250.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 5250.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 06:41:42', '2019-02-02 06:41:42');
INSERT INTO `transactions` VALUES (128, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 06:43:27', 1650.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1650.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 111, 1, NULL, NULL, '2019-02-02 06:43:27', '2019-02-02 06:43:27');
INSERT INTO `transactions` VALUES (129, 1, 7, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 06:43:27', 1650.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1650.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 111, 1, NULL, NULL, '2019-02-02 06:43:27', '2019-02-02 06:43:27');
INSERT INTO `transactions` VALUES (130, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 4, NULL, NULL, 'PO2019/0024', '2019-02-02 00:00:00', 200145.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 200145.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 06:47:11', '2019-02-02 06:48:24');
INSERT INTO `transactions` VALUES (137, 1, 1, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0003', '2019-02-02 00:00:00', 825.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 825.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 06:54:35', '2019-02-02 06:54:35');
INSERT INTO `transactions` VALUES (138, 1, 7, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0003', '2019-02-02 00:00:00', 825.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 825.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 137, NULL, 1, NULL, NULL, '2019-02-02 06:54:35', '2019-02-02 06:54:35');
INSERT INTO `transactions` VALUES (139, 1, 1, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0004', '2019-02-02 00:00:00', 165.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 165.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 06:56:37', '2019-02-02 06:56:37');
INSERT INTO `transactions` VALUES (140, 1, 7, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0004', '2019-02-02 00:00:00', 165.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 165.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 139, NULL, 1, NULL, NULL, '2019-02-02 06:56:37', '2019-02-02 06:56:37');
INSERT INTO `transactions` VALUES (141, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0025', '', '2019-02-02 00:00:00', 840.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 840.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:10:23', '2019-02-02 07:10:23');
INSERT INTO `transactions` VALUES (143, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0026', '', '2019-02-02 00:00:00', 199.00, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 199.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:14:29', '2019-02-02 07:14:29');
INSERT INTO `transactions` VALUES (144, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0027', '', '2019-02-02 00:00:00', 2100.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 1890.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:15:52', '2019-02-02 07:15:52');
INSERT INTO `transactions` VALUES (145, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0028', '', '2019-02-02 00:00:00', 840.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 756.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:17:23', '2019-02-02 07:17:23');
INSERT INTO `transactions` VALUES (146, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 2, NULL, NULL, 'PO2019/0025', '2019-02-02 00:00:00', 99900.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 99900.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:18:57', '2019-02-02 07:18:57');
INSERT INTO `transactions` VALUES (147, 1, 7, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0005', '2019-02-02 00:00:00', 49950.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 49950.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transactions` VALUES (148, 1, 1, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0005', '2019-02-02 00:00:00', 49950.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 49950.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 147, NULL, 1, NULL, NULL, '2019-02-02 07:19:57', '2019-02-02 07:19:57');
INSERT INTO `transactions` VALUES (151, 1, 7, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 3, NULL, NULL, 'PO2019/0026', '2019-02-02 00:00:00', 90000.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 90000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:59:09', '2019-02-02 07:59:09');
INSERT INTO `transactions` VALUES (152, 1, 7, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0007', '2019-02-02 00:00:00', 45000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 45000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transactions` VALUES (153, 1, 1, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0007', '2019-02-02 00:00:00', 45000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 45000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 152, NULL, 1, NULL, NULL, '2019-02-02 07:59:45', '2019-02-02 07:59:45');
INSERT INTO `transactions` VALUES (154, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0029', '', '2019-02-02 00:00:00', 22500.00, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 20250.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-02 08:01:49', '2019-02-02 08:01:49');
INSERT INTO `transactions` VALUES (155, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 08:03:57', 9000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 9000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 125, 1, NULL, NULL, '2019-02-02 08:03:57', '2019-02-02 08:03:57');
INSERT INTO `transactions` VALUES (156, 1, 7, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 08:03:57', 9000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 9000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 125, 1, NULL, NULL, '2019-02-02 08:03:57', '2019-02-02 08:03:57');
INSERT INTO `transactions` VALUES (157, 1, 7, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0030', '', '2019-02-06 00:00:00', 647.50, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 582.75, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-06 20:12:04', '2019-02-06 20:12:04');
INSERT INTO `transactions` VALUES (158, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0031', '', '2019-02-07 00:00:00', 11812.50, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 11812.50, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-07 11:08:44', '2019-02-07 11:08:44');
INSERT INTO `transactions` VALUES (159, 1, 1, 0, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 1, NULL, '158', NULL, '2019-02-07 00:00:00', 6737.50, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 6737.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-07 20:01:56', '2019-02-07 20:01:56');
INSERT INTO `transactions` VALUES (160, 1, 1, 0, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 31, NULL, 'AS0017', NULL, '2019-02-07 00:00:00', 630.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 630.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-07 20:07:17', '2019-02-07 20:07:17');
INSERT INTO `transactions` VALUES (161, 1, 1, 0, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 33, NULL, NULL, '2019/0018', '2019-02-07 20:53:19', 12314.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 12314.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-07 20:53:19', '2019-02-07 20:53:19');
INSERT INTO `transactions` VALUES (162, 1, 7, 0, NULL, NULL, NULL, 'stock_adjustment', 'received', 0, NULL, 'normal', NULL, NULL, NULL, 'SA2019/0009', '2019-02-07 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 369.00, NULL, NULL, NULL, NULL, 0, 1.000, 0.00, NULL, NULL, 1, NULL, NULL, '2019-02-07 21:05:57', '2019-02-07 21:05:57');
INSERT INTO `transactions` VALUES (163, 1, 1, 0, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 1, NULL, 'AS0032', '', '2019-02-08 00:00:00', 1687.50, NULL, 0.00, 'percentage', '10', NULL, 0.00, NULL, NULL, 1518.75, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-08 20:28:52', '2019-02-08 20:28:52');
INSERT INTO `transactions` VALUES (164, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 3, NULL, NULL, 'PO2019/0027', '2019-02-08 00:00:00', 165.00, NULL, 0.00, NULL, '0', NULL, 1000.00, NULL, NULL, 1165.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-08 20:32:46', '2019-02-08 20:32:46');
INSERT INTO `transactions` VALUES (165, 1, 1, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0008', '2019-02-08 00:00:00', 16500.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 16500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transactions` VALUES (166, 1, 7, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0008', '2019-02-08 00:00:00', 16500.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 16500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 165, NULL, 1, NULL, NULL, '2019-02-08 21:24:04', '2019-02-08 21:24:04');
INSERT INTO `transactions` VALUES (167, 1, 1, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0009', '2019-02-08 00:00:00', 33000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 33000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transactions` VALUES (168, 1, 7, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0009', '2019-02-08 00:00:00', 33000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 33000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 167, NULL, 1, NULL, NULL, '2019-02-08 21:54:40', '2019-02-08 21:54:40');
INSERT INTO `transactions` VALUES (169, 1, 1, 0, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 3, NULL, NULL, 'PO2019/0028', '2019-02-08 00:00:00', 1500.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-08 21:57:25', '2019-02-08 21:57:25');
INSERT INTO `transactions` VALUES (170, 1, 1, 0, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0010', '2019-02-08 00:00:00', 700.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 700.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 1, NULL, NULL, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transactions` VALUES (171, 1, 7, 0, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0010', '2019-02-08 00:00:00', 700.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 700.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 170, NULL, 1, NULL, NULL, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `transactions` VALUES (172, 7, 8, 0, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 35, NULL, NULL, '2019/0001', '2019-02-09 11:16:07', 1000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 12, NULL, NULL, '2019-02-09 11:16:07', '2019-02-09 11:16:07');
INSERT INTO `transactions` VALUES (173, 8, 9, 0, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 37, NULL, NULL, '2019/0001', '2019-02-10 05:38:30', 1000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-10 05:38:30', '2019-02-10 05:38:30');
INSERT INTO `transactions` VALUES (174, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 37, NULL, NULL, 'PO2019/0001', '2019-02-10 00:00:00', 1500.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-10 05:39:00', '2019-02-10 05:39:00');
INSERT INTO `transactions` VALUES (175, 8, 9, 0, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 20:37:51', 1200.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1200.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 127, 13, NULL, NULL, '2019-02-10 20:37:51', '2019-02-10 21:18:46');
INSERT INTO `transactions` VALUES (176, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0001', '', '2019-02-11 00:00:00', 625.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 625.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-11 15:29:40', '2019-02-19 07:45:29');
INSERT INTO `transactions` VALUES (177, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0001', NULL, '2019-02-11 00:00:00', 375.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 375.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-11 22:46:02', '2019-02-11 22:46:02');
INSERT INTO `transactions` VALUES (188, 8, 9, 3, NULL, NULL, NULL, 'bank_payment', 'received', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-12 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 123.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 10:09:08', '2019-02-12 10:09:08');
INSERT INTO `transactions` VALUES (190, 8, 9, 3, NULL, NULL, NULL, 'bank_payment', 'received', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-12 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 13.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 10:11:42', '2019-02-12 10:11:42');
INSERT INTO `transactions` VALUES (191, 8, 9, NULL, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0001', '2019-02-12 00:00:00', 1500.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 13:48:28', '2019-02-12 13:48:28');
INSERT INTO `transactions` VALUES (192, 8, 10, NULL, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0001', '2019-02-12 00:00:00', 1500.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 191, NULL, 13, NULL, NULL, '2019-02-12 13:48:28', '2019-02-12 13:48:28');
INSERT INTO `transactions` VALUES (193, 8, 9, NULL, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0002', '2019-02-12 00:00:00', 500.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 13:53:16', '2019-02-12 13:53:16');
INSERT INTO `transactions` VALUES (194, 8, 10, NULL, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0002', '2019-02-12 00:00:00', 500.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 193, NULL, 13, NULL, NULL, '2019-02-12 13:53:16', '2019-02-12 13:53:16');
INSERT INTO `transactions` VALUES (195, 8, 9, 3, NULL, NULL, NULL, 'bank_payment', 'received', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-12 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, -100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 14:08:44', '2019-02-12 14:08:44');
INSERT INTO `transactions` VALUES (198, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0004', '', '2019-02-12 00:00:00', 125.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 125.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 14:26:16', '2019-02-19 07:43:56');
INSERT INTO `transactions` VALUES (199, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0001', NULL, '2019-02-12 00:00:00', 375.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 375.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 15:03:09', '2019-02-12 15:03:09');
INSERT INTO `transactions` VALUES (200, 8, 9, NULL, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0004', NULL, '2019-02-12 00:00:00', 125.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 125.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 15:07:06', '2019-02-12 15:07:06');
INSERT INTO `transactions` VALUES (201, 8, 9, NULL, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0004', NULL, '2019-02-12 00:00:00', 125.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 125.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 15:21:54', '2019-02-12 15:21:54');
INSERT INTO `transactions` VALUES (202, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0001', NULL, '2019-02-12 00:00:00', 625.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 625.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 15:29:52', '2019-02-12 15:29:52');
INSERT INTO `transactions` VALUES (203, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0001', NULL, '2019-02-12 00:00:00', 625.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 625.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 15:31:50', '2019-02-12 15:31:50');
INSERT INTO `transactions` VALUES (204, 8, 10, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 37, NULL, NULL, 'PO2019/0002', '2019-02-12 00:00:00', 700.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 700.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 16:40:02', '2019-02-12 16:43:09');
INSERT INTO `transactions` VALUES (207, 8, 9, 3, NULL, NULL, NULL, 'expense', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'EP2019/0003', '2019-02-12 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 123.00, NULL, 13, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 17:04:38', '2019-02-12 17:07:57');
INSERT INTO `transactions` VALUES (210, 8, 9, 3, NULL, NULL, NULL, 'bank_payment', 'received', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2019-02-12 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, -123.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 19:04:46', '2019-02-12 19:04:46');
INSERT INTO `transactions` VALUES (211, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 37, NULL, NULL, 'PO2019/0003', '2019-02-12 00:00:00', 1845.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1845.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 19:13:47', '2019-02-12 19:13:47');
INSERT INTO `transactions` VALUES (212, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 36, NULL, '0005', '', '2019-02-12 00:00:00', 1230.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 1230.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 19:14:30', '2019-02-12 19:15:21');
INSERT INTO `transactions` VALUES (213, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0005', NULL, '2019-02-12 00:00:00', 615.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 615.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-12 19:32:26', '2019-02-12 19:32:26');
INSERT INTO `transactions` VALUES (216, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 37, NULL, NULL, 'PO2019/0004', '2019-02-13 00:00:00', 223.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 223.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-13 19:23:49', '2019-02-18 21:21:29');
INSERT INTO `transactions` VALUES (217, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0006', '', '2019-02-13 00:00:00', 176.71, NULL, 0.00, 'fixed', '123', NULL, 0.00, NULL, NULL, 53.71, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-13 21:47:17', '2019-02-19 07:43:56');
INSERT INTO `transactions` VALUES (218, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0007', '', '2019-02-13 00:00:00', 208.14, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 208.14, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-13 22:36:31', '2019-02-19 07:43:56');
INSERT INTO `transactions` VALUES (219, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'partial', NULL, 37, NULL, NULL, 'PO2019/0005', '2019-02-13 00:00:00', 975.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 975.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-13 23:04:08', '2019-02-13 23:04:08');
INSERT INTO `transactions` VALUES (220, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0008', '', '2019-02-13 00:00:00', 92.86, NULL, 0.00, 'fixed', '12', NULL, 0.00, NULL, NULL, 80.86, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-13 23:04:41', '2019-02-19 07:43:56');
INSERT INTO `transactions` VALUES (221, 8, 9, NULL, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 00:01:13', 1200.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1200.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 131, 13, NULL, NULL, '2019-02-14 00:01:13', '2019-02-14 00:01:13');
INSERT INTO `transactions` VALUES (222, 8, 10, NULL, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 00:01:13', 1400.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1400.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 131, 13, NULL, NULL, '2019-02-14 00:01:13', '2019-02-14 00:01:13');
INSERT INTO `transactions` VALUES (223, 8, 9, NULL, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0004', '2019-02-14 00:00:00', 200.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 200.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 00:02:30', '2019-02-14 00:02:30');
INSERT INTO `transactions` VALUES (224, 8, 10, NULL, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0004', '2019-02-14 00:00:00', 200.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 200.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 223, NULL, 13, NULL, NULL, '2019-02-14 00:02:30', '2019-02-14 00:02:30');
INSERT INTO `transactions` VALUES (225, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0008', NULL, '2019-02-14 00:00:00', 65.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 65.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 00:05:25', '2019-02-14 00:05:25');
INSERT INTO `transactions` VALUES (226, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0006', NULL, '2019-02-14 00:00:00', 223.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 223.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 00:07:03', '2019-02-14 00:07:03');
INSERT INTO `transactions` VALUES (228, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0005', NULL, '2019-02-14 00:00:00', 123.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 123.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 10:36:36', '2019-02-14 10:36:36');
INSERT INTO `transactions` VALUES (229, 8, 9, NULL, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 12:19:54', 24.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 24.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 132, 13, NULL, NULL, '2019-02-14 12:19:54', '2019-02-14 12:19:54');
INSERT INTO `transactions` VALUES (230, 8, 10, NULL, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 12:19:54', 144.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 144.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 132, 13, NULL, NULL, '2019-02-14 12:19:54', '2019-02-14 12:19:54');
INSERT INTO `transactions` VALUES (231, 8, 9, NULL, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 12:21:00', 12.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 12.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 133, 13, NULL, NULL, '2019-02-14 12:21:00', '2019-02-15 09:22:22');
INSERT INTO `transactions` VALUES (232, 8, 10, NULL, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 12:21:00', 45.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 45.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 133, 13, NULL, NULL, '2019-02-14 12:21:00', '2019-02-15 09:22:22');
INSERT INTO `transactions` VALUES (237, 8, 9, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 36, NULL, '0005', NULL, '2019-02-14 00:00:00', 123.00, NULL, 0.00, 'fixed', '21', NULL, 0.00, 'asdfasd', NULL, 102.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 14:11:31', '2019-02-14 14:11:31');
INSERT INTO `transactions` VALUES (238, 8, 9, NULL, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 38, NULL, NULL, '2019/0002', '2019-02-14 14:52:55', 1000.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 1000.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 14:52:55', '2019-02-19 07:55:21');
INSERT INTO `transactions` VALUES (240, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 38, NULL, '0011', '', '2019-02-14 00:00:00', 351.42, NULL, 0.00, 'fixed', '23', NULL, 0.00, NULL, NULL, 328.42, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 14:54:31', '2019-02-19 07:46:29');
INSERT INTO `transactions` VALUES (242, 8, 10, 3, NULL, NULL, NULL, 'sell_return', 'final', 0, NULL, NULL, 38, NULL, '0012', NULL, '2019-02-14 00:00:00', 201.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 201.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-14 15:48:48', '2019-02-14 15:48:48');
INSERT INTO `transactions` VALUES (243, 14, 17, NULL, NULL, NULL, NULL, 'opening_balance', 'final', 0, 'due', NULL, 44, NULL, NULL, '2019/0001', '2019-02-15 11:01:14', 123.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 19, NULL, NULL, '2019-02-15 11:01:14', '2019-02-15 11:01:37');
INSERT INTO `transactions` VALUES (246, 8, 9, NULL, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0005', '2019-02-15 00:00:00', 780.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 780.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-15 14:06:53', '2019-02-15 14:06:53');
INSERT INTO `transactions` VALUES (247, 8, 10, NULL, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0005', '2019-02-15 00:00:00', 780.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 780.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 246, NULL, 13, NULL, NULL, '2019-02-15 14:06:53', '2019-02-15 14:06:53');
INSERT INTO `transactions` VALUES (248, 8, 9, NULL, NULL, NULL, NULL, 'opening_stock', 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, '2019-01-01 14:30:15', 300.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 300.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, 135, 13, NULL, NULL, '2019-02-15 14:30:15', '2019-02-15 14:30:15');
INSERT INTO `transactions` VALUES (249, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 37, NULL, NULL, 'PO2019/0006', '2019-02-15 00:00:00', 100.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 100.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-15 14:34:03', '2019-02-15 14:34:03');
INSERT INTO `transactions` VALUES (250, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0013', '', '2019-02-15 00:00:00', 314.28, NULL, 0.00, 'fixed', '0', NULL, 0.00, NULL, NULL, 314.28, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-15 14:39:44', '2019-02-19 07:43:56');
INSERT INTO `transactions` VALUES (251, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0014', '', '2019-02-15 00:00:00', 220.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 220.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-15 14:44:33', '2019-02-19 07:43:56');
INSERT INTO `transactions` VALUES (252, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 37, NULL, NULL, 'PO2019/0007', '2019-02-15 00:00:00', 1554.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1554.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-15 15:57:23', '2019-02-19 01:20:12');
INSERT INTO `transactions` VALUES (253, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'partial', NULL, 36, NULL, '0015', '', '2019-02-15 00:00:00', 242.00, NULL, 0.00, 'fixed', '10', NULL, 0.00, NULL, NULL, 232.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-15 15:58:10', '2019-02-19 07:43:56');
INSERT INTO `transactions` VALUES (262, 8, 9, 3, NULL, NULL, NULL, 'sell', 'final', 0, 'paid', NULL, 38, NULL, '0016', '', '2019-02-17 00:00:00', 111.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 111.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-17 22:01:01', '2019-02-19 07:48:11');
INSERT INTO `transactions` VALUES (267, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'paid', NULL, 37, NULL, NULL, 'PO2019/0008', '2019-02-17 00:00:00', 1670.55, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1670.55, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-17 22:48:55', '2019-02-19 07:32:05');
INSERT INTO `transactions` VALUES (268, 8, 9, 3, NULL, NULL, NULL, 'sell', 'draft', 0, 'partial', NULL, 38, NULL, '07pmk', '', '2019-02-17 00:00:00', 388.50, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 388.50, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-17 22:49:47', '2019-02-19 18:37:23');
INSERT INTO `transactions` VALUES (290, 8, 9, NULL, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0014', '2019-02-18 00:00:00', 222.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 222.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-18 20:23:17', '2019-02-18 20:23:17');
INSERT INTO `transactions` VALUES (291, 8, 10, NULL, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0014', '2019-02-18 00:00:00', 222.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 222.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 290, NULL, 13, NULL, NULL, '2019-02-18 20:23:17', '2019-02-18 20:23:17');
INSERT INTO `transactions` VALUES (298, 8, 9, NULL, NULL, NULL, NULL, 'sell_transfer', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0017', '2019-02-18 00:00:00', 166.50, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 166.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-18 20:38:07', '2019-02-18 20:38:07');
INSERT INTO `transactions` VALUES (299, 8, 10, NULL, NULL, NULL, NULL, 'purchase_transfer', 'received', 0, 'paid', NULL, NULL, NULL, NULL, 'ST2019/0017', '2019-02-18 00:00:00', 166.50, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 166.50, NULL, NULL, NULL, NULL, 0, 1.000, NULL, 298, NULL, 13, NULL, NULL, '2019-02-18 20:38:07', '2019-02-18 20:38:07');
INSERT INTO `transactions` VALUES (323, 8, 9, 3, NULL, NULL, NULL, 'purchase', 'received', 0, 'due', NULL, 48, NULL, NULL, 'PO2019/0012', '2019-02-19 00:00:00', 1500.00, NULL, 0.00, NULL, '0', NULL, 0.00, NULL, NULL, 1500.00, NULL, NULL, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-19 08:11:30', '2019-02-19 08:11:30');
INSERT INTO `transactions` VALUES (324, 8, 9, 3, NULL, NULL, NULL, 'sell', 'draft', 1, 'due', NULL, 38, NULL, 'c14EU', '', '2019-02-19 00:00:00', 1332.00, NULL, 0.00, 'percentage', '0', NULL, 0.00, NULL, NULL, 1332.00, NULL, NULL, NULL, NULL, 1, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-19 08:12:33', '2019-02-19 18:35:27');
INSERT INTO `transactions` VALUES (325, 8, 9, 3, NULL, NULL, NULL, 'expense', 'final', 0, 'paid', NULL, NULL, NULL, NULL, 'EP2019/0004', '2019-02-19 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 100.00, 3, 13, NULL, NULL, 0, 1.000, NULL, NULL, NULL, 13, NULL, NULL, '2019-02-19 08:31:26', '2019-02-19 08:31:26');
INSERT INTO `transactions` VALUES (326, 8, 9, NULL, NULL, NULL, NULL, 'stock_adjustment', 'received', 0, NULL, 'normal', NULL, NULL, NULL, 'SA2019/0014', '2019-02-19 00:00:00', 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, 100.00, NULL, NULL, NULL, NULL, 0, 1.000, 0.00, NULL, NULL, 13, NULL, NULL, '2019-02-19 09:21:46', '2019-02-19 09:21:46');

-- ----------------------------
-- Table structure for units
-- ----------------------------
DROP TABLE IF EXISTS `units`;
CREATE TABLE `units`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `business_id` int(10) UNSIGNED NOT NULL,
  `actual_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_decimal` tinyint(1) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `units_business_id_foreign`(`business_id`) USING BTREE,
  INDEX `units_created_by_foreign`(`created_by`) USING BTREE,
  CONSTRAINT `units_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `units_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of units
-- ----------------------------
INSERT INTO `units` VALUES (1, 1, 'Pieces', 'Pc(s)', 0, 1, NULL, '2018-01-03 23:15:20', '2018-01-03 23:15:20');
INSERT INTO `units` VALUES (2, 1, 'Packets', 'packets', 0, 1, NULL, '2018-01-06 09:07:01', '2018-01-06 09:08:36');
INSERT INTO `units` VALUES (3, 1, 'Grams', 'g', 1, 1, NULL, '2018-01-06 09:10:34', '2018-01-06 09:10:34');
INSERT INTO `units` VALUES (4, 2, 'Pieces', 'Pc(s)', 0, 4, NULL, '2018-04-10 10:42:40', '2018-04-10 10:42:40');
INSERT INTO `units` VALUES (5, 3, 'Units', 'units', 0, 5, NULL, '2018-04-10 13:16:16', '2018-04-10 13:29:19');
INSERT INTO `units` VALUES (6, 4, 'Units', 'units', 0, 6, NULL, '2018-04-10 14:50:43', '2018-04-10 15:02:04');
INSERT INTO `units` VALUES (7, 5, 'Pieces', 'Pc(s)', 0, 7, NULL, '2018-07-13 13:42:11', '2018-07-13 13:42:11');
INSERT INTO `units` VALUES (8, 5, 'Packets', 'packets', 0, 7, NULL, '2018-07-13 04:27:16', '2018-07-13 04:27:16');
INSERT INTO `units` VALUES (9, 6, 'Pieces', 'Pc(s)', 0, 10, NULL, '2018-08-06 22:45:35', '2018-08-06 22:45:35');
INSERT INTO `units` VALUES (10, 7, 'Pieces', 'Pc(s)', 0, 12, NULL, '2019-02-09 10:37:36', '2019-02-09 10:37:36');
INSERT INTO `units` VALUES (11, 8, 'Pieces', 'Pc(s)', 0, 13, NULL, '2019-02-10 02:01:52', '2019-02-10 02:01:52');
INSERT INTO `units` VALUES (15, 12, 'Pieces', 'Pc(s)', 0, 17, NULL, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `units` VALUES (16, 13, 'Pieces', 'Pc(s)', 0, 18, NULL, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `units` VALUES (17, 14, 'Pieces', 'Pc(s)', 0, 19, NULL, '2019-02-15 10:24:03', '2019-02-15 10:24:03');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `surname` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `contact_no` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `business_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `is_cmmsn_agnt` tinyint(1) NOT NULL DEFAULT 0,
  `cmmsn_percent` decimal(4, 2) NOT NULL DEFAULT 0.00,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_username_unique`(`username`) USING BTREE,
  INDEX `users_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `users_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Mr', 'Admin', NULL, 'admin', 'admin@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, 's4YhD9domViMnPea6cenOzCDRKYkalv4wu2hECpgyPpflXTXrhv4aUzEo6Qv', 1, 0, 0.00, NULL, '2018-01-04 04:45:19', '2018-01-04 04:45:19');
INSERT INTO `users` VALUES (2, 'Mr', 'Demo', 'Cashier', 'cashier', 'cashier@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, NULL, 1, 0, 0.00, NULL, '2018-01-04 04:50:58', '2018-01-04 04:50:58');
INSERT INTO `users` VALUES (3, 'Mr.', 'Demo', 'Admin', 'demo-admin', 'demoadmin@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, NULL, 1, 0, 0.00, NULL, '2018-01-06 09:40:57', '2018-01-06 09:40:57');
INSERT INTO `users` VALUES (4, 'Mr', 'Demo', 'Admin', 'admin-pharmacy', 'admin-pharma@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, 'MJnleh4kefXZtw3FCI2yHKEwr45Rs5nZxyQyGSFRfjIcQn93sJZyw7BAzSUq', 2, 0, 0.00, NULL, '2018-04-10 10:42:40', '2018-04-10 10:42:40');
INSERT INTO `users` VALUES (5, 'Mr', 'Demo', 'Admin', 'admin-electronics', 'admin-electronics@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, 'YzGFoRAfllUjyB12qIZhowlteUPhvR1cd77YREQuqemSUftHp72aRLZMrzwR', 3, 0, 0.00, NULL, '2018-04-10 13:16:15', '2018-04-10 13:16:15');
INSERT INTO `users` VALUES (6, 'Mr', 'Demo', 'Admin', 'admin-services', 'admin-services@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, 'CdBNjmTIXVU0nEgcEg85L97w6JEjvuE6CfF7mvhmz7Ad2K7IxJVd9WPLdxcg', 4, 0, 0.00, NULL, '2018-04-10 14:50:42', '2018-04-10 14:50:42');
INSERT INTO `users` VALUES (7, 'Mr', 'Demo', 'Admin', 'admin-restaurant', 'admin-restaurant@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, 'ZzGDokwQe0vR0YpbBBWwbCWOGAkTgMS4wZlQOzAgWs2yAnovdGFkRwjofy1Y', 5, 0, 0.00, NULL, '2018-07-13 13:42:11', '2018-07-13 13:42:11');
INSERT INTO `users` VALUES (8, 'Mr', 'Kevin', 'Nicols', 'kevin-nicols', 'kevin@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, '57dRoj3knI8dJ9UPSqFo2EH0CVTco5WJHnDgrmB2CY4lvJR6ZTtmzHi7NdLa', 5, 0, 0.00, NULL, '2018-07-13 04:43:20', '2018-07-13 04:43:20');
INSERT INTO `users` VALUES (9, 'Mr.', 'Super', 'Admin', 'superadmin', 'superadmin@example.com', '$2y$10$GFw/K9Mhu6HIioD1WWu44eh1Dd3JdFXoSsaSzBeO5dw..lY/5Gusa', 'en', NULL, NULL, 'hOsbFrWWSYsT7dAnP2rwUAYx6aMvbUhUs1ZYl8yXWe9JYKkumTb0mYLXQYUl', 1, 0, 0.00, NULL, '2018-08-02 06:35:55', '2018-08-02 06:35:55');
INSERT INTO `users` VALUES (10, 'mr.', 'sds', 'dsd', 'dsdsdsds', 'dsdsdsds@dsdsdsds.com', '$2y$10$MQg83RHljeThgl.wxfXi3eO7mLU9cKJa7mROIKS3jtWmHSBnK9XC2', 'en', NULL, NULL, 'cSqo5mWVzRZWeqjI4RBPSLOVbVIqxvRV17QfC7nqsTwtBT8SsNzQyKUg6tgQ', 6, 0, 0.00, NULL, '2018-08-06 22:45:34', '2018-08-06 22:45:34');
INSERT INTO `users` VALUES (11, 'Mr', 'Harry', NULL, '5c49d9706ec47', NULL, 'DUMMY', 'en', NULL, NULL, NULL, 1, 1, 10.00, NULL, '2019-01-24 08:27:44', '2019-01-24 08:27:44');
INSERT INTO `users` VALUES (12, 'Mr', 'Wei Li', 'Jiang', 'account master', 'jwl1013@outlook.com', '$2y$10$QgJRxia3XuoP6n8wjW/CB.V5.4zqqIt4daZ0Umev2Oo5yQ4PmlfKS', 'en', NULL, NULL, 'dlYpgRidVZgcpOrB0K1hZgVeqh97aZanIPPH2g0Hr8viSWbIAhKkCHFqH9vG', 7, 0, 0.00, NULL, '2019-02-09 10:37:35', '2019-02-09 10:37:35');
INSERT INTO `users` VALUES (13, 'Mr', 'Wei Li', 'Jiang', 'acc-master', 'jwl1013@outlook.com', '$2y$10$VBBziVNTEGBg/TYEQKYbBuqssXyEtQZbexh3tZzh2H/fpoYcdF0aa', 'en', NULL, NULL, 'Eq4W9E9drhBh6UWG0lFK4k1bn5IY10QmfCG1BhwALvc5mn7QbpgK8llAsaxN', 8, 0, 0.00, NULL, '2019-02-10 02:01:52', '2019-02-10 02:01:52');
INSERT INTO `users` VALUES (17, 'Mr', 'TEST', 'Jiang', 'test', 'test@yandex.com', '$2y$10$t0AqZLWUPd3QSzd9Oy6Bt.BSdpTAa7Ub9doBuc7lGLgbNpKAJgd5a', 'en', NULL, NULL, 'CpxkYIJMel6nmolpYzro355RewZshHZp2XMt4L1bOzmD6oR2xJLWCW9DM9Cq', 12, 0, 0.00, NULL, '2019-02-15 09:32:09', '2019-02-15 09:32:09');
INSERT INTO `users` VALUES (18, 'as', 'sdfa', 'asdf', 'asdf', 'asdf@yandex.com', '$2y$10$mNi7jYT/kTSjvutnkpzvCO4AjklF9Lf53CgLMFAhstNd9.EYNWgbu', 'en', NULL, NULL, NULL, 13, 0, 0.00, NULL, '2019-02-15 10:11:28', '2019-02-15 10:11:28');
INSERT INTO `users` VALUES (19, 'a', 'a', 'd', 'zxcv', 'asdf@outlook.com', '$2y$10$sEW0dDISk8mDxOiTVIPKzuNtb9/bVDy9so9Ej7sgVDz6RLDgWtTjO', 'en', NULL, NULL, '40oFcwfWgRXwCnOfIO34N4tRthMScLq6gQHISyNTjdsMkzAoArSp1cd4O1fN', 14, 0, 0.00, NULL, '2019-02-15 10:24:03', '2019-02-15 10:24:03');

-- ----------------------------
-- Table structure for variation_location_details
-- ----------------------------
DROP TABLE IF EXISTS `variation_location_details`;
CREATE TABLE `variation_location_details`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL COMMENT 'id from product_variations table',
  `variation_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `qty_available` decimal(20, 4) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `variation_location_details_location_id_foreign`(`location_id`) USING BTREE,
  INDEX `variation_location_details_product_id_index`(`product_id`) USING BTREE,
  INDEX `variation_location_details_product_variation_id_index`(`product_variation_id`) USING BTREE,
  INDEX `variation_location_details_variation_id_index`(`variation_id`) USING BTREE,
  CONSTRAINT `variation_location_details_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `variation_location_details_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of variation_location_details
-- ----------------------------
INSERT INTO `variation_location_details` VALUES (1, 2, 2, 2, 1, 52.0000, '2018-01-06 09:27:11', '2018-08-13 02:00:43');
INSERT INTO `variation_location_details` VALUES (2, 2, 2, 3, 1, 90.0000, '2018-01-06 09:27:11', '2018-01-06 09:37:23');
INSERT INTO `variation_location_details` VALUES (3, 2, 2, 4, 1, 148.0000, '2018-01-06 09:27:11', '2018-08-08 07:55:05');
INSERT INTO `variation_location_details` VALUES (4, 2, 2, 5, 1, 151.0000, '2018-01-06 09:27:11', '2019-01-18 21:54:10');
INSERT INTO `variation_location_details` VALUES (5, 2, 2, 6, 1, 98.0000, '2018-01-06 09:27:11', '2019-01-19 04:37:42');
INSERT INTO `variation_location_details` VALUES (6, 14, 15, 47, 1, 0.0000, '2018-01-06 09:28:10', '2018-08-13 02:02:01');
INSERT INTO `variation_location_details` VALUES (7, 28, 30, 71, 1, 471.0000, '2018-01-06 09:32:22', '2018-08-13 01:51:29');
INSERT INTO `variation_location_details` VALUES (8, 21, 23, 64, 1, 140.0000, '2018-01-06 09:33:12', '2019-01-25 12:46:51');
INSERT INTO `variation_location_details` VALUES (9, 27, 29, 70, 1, 470.0000, '2018-01-06 09:35:26', '2018-01-06 09:36:32');
INSERT INTO `variation_location_details` VALUES (10, 34, 36, 77, 2, 40.0000, '2018-04-10 12:48:16', '2018-04-10 12:53:35');
INSERT INTO `variation_location_details` VALUES (11, 32, 34, 75, 2, 93.0000, '2018-04-10 12:49:40', '2018-04-10 12:53:58');
INSERT INTO `variation_location_details` VALUES (12, 36, 38, 79, 2, 150.0000, '2018-04-10 12:50:41', '2018-04-10 12:50:41');
INSERT INTO `variation_location_details` VALUES (13, 33, 35, 76, 2, 153.0000, '2018-04-10 12:51:38', '2018-04-10 12:54:21');
INSERT INTO `variation_location_details` VALUES (14, 46, 48, 89, 3, 30.0000, '2018-04-10 14:09:54', '2018-04-10 14:09:54');
INSERT INTO `variation_location_details` VALUES (15, 41, 43, 84, 3, 14.0000, '2018-04-10 14:10:51', '2018-04-10 14:18:48');
INSERT INTO `variation_location_details` VALUES (16, 45, 47, 88, 3, 45.0000, '2018-04-10 14:11:45', '2018-04-10 14:11:45');
INSERT INTO `variation_location_details` VALUES (17, 44, 46, 87, 3, 80.0000, '2018-04-10 14:12:34', '2018-04-10 14:15:06');
INSERT INTO `variation_location_details` VALUES (18, 43, 45, 86, 3, 25.0000, '2018-04-10 14:13:12', '2018-04-10 14:14:47');
INSERT INTO `variation_location_details` VALUES (19, 42, 44, 85, 3, 30.0000, '2018-04-10 14:23:36', '2018-04-10 14:24:16');
INSERT INTO `variation_location_details` VALUES (20, 61, 63, 104, 1, 20.0000, '2018-06-12 00:47:07', '2018-06-12 00:47:07');
INSERT INTO `variation_location_details` VALUES (21, 64, 66, 107, 1, 300.0000, '2018-06-12 00:47:07', '2018-06-13 01:48:04');
INSERT INTO `variation_location_details` VALUES (22, 63, 65, 106, 1, 301.0000, '2018-06-12 00:47:07', '2019-01-17 02:39:06');
INSERT INTO `variation_location_details` VALUES (23, 65, 67, 108, 1, 50.0000, '2018-06-12 00:47:07', '2018-06-12 00:47:07');
INSERT INTO `variation_location_details` VALUES (24, 17, 19, 57, 1, 17.0000, '2018-06-13 01:48:04', '2019-02-02 05:00:26');
INSERT INTO `variation_location_details` VALUES (25, 17, 19, 58, 1, 34.0000, '2018-06-13 01:48:04', '2019-02-07 20:01:56');
INSERT INTO `variation_location_details` VALUES (26, 15, 16, 49, 1, 30.0000, '2018-06-13 01:48:04', '2019-02-08 20:42:21');
INSERT INTO `variation_location_details` VALUES (27, 15, 16, 50, 1, 10.0000, '2018-06-13 01:48:04', '2019-01-19 04:37:42');
INSERT INTO `variation_location_details` VALUES (28, 15, 16, 51, 1, 20.0000, '2018-06-13 01:48:04', '2019-01-19 12:50:25');
INSERT INTO `variation_location_details` VALUES (29, 15, 17, 52, 1, 20.0000, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `variation_location_details` VALUES (30, 15, 17, 53, 1, 40.0000, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `variation_location_details` VALUES (31, 18, 20, 59, 1, 20.0000, '2018-06-13 01:48:04', '2019-02-08 20:28:52');
INSERT INTO `variation_location_details` VALUES (32, 18, 20, 60, 1, 11.0000, '2018-06-13 01:48:04', '2019-01-19 15:43:43');
INSERT INTO `variation_location_details` VALUES (33, 19, 21, 61, 1, 30.0000, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `variation_location_details` VALUES (34, 22, 24, 65, 1, 10.0000, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `variation_location_details` VALUES (35, 24, 26, 67, 1, 10.0000, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `variation_location_details` VALUES (36, 25, 27, 68, 1, 20.0000, '2018-06-13 01:48:04', '2018-06-13 01:48:04');
INSERT INTO `variation_location_details` VALUES (37, 77, 79, 120, 5, 100.0000, '2018-07-13 10:04:45', '2018-07-13 10:04:45');
INSERT INTO `variation_location_details` VALUES (38, 76, 78, 119, 5, 300.0000, '2018-07-13 10:04:45', '2018-07-13 10:08:24');
INSERT INTO `variation_location_details` VALUES (39, 80, 82, 128, 1, 0.0000, '2018-08-08 07:03:01', '2018-08-08 07:03:35');
INSERT INTO `variation_location_details` VALUES (40, 86, 86, 132, 1, 15.0000, '2019-01-16 09:09:37', '2019-01-16 09:09:37');
INSERT INTO `variation_location_details` VALUES (41, 88, 88, 134, 1, 123124135.0000, '2019-01-16 09:19:06', '2019-01-28 06:13:49');
INSERT INTO `variation_location_details` VALUES (42, 90, 89, 135, 1, 124125422.0000, '2019-01-17 02:00:25', '2019-01-28 06:13:49');
INSERT INTO `variation_location_details` VALUES (43, 91, 90, 136, 1, 2.0000, '2019-01-17 02:08:48', '2019-01-17 02:08:48');
INSERT INTO `variation_location_details` VALUES (44, 17, 19, 57, 7, 11.0000, '2019-01-17 21:17:47', '2019-02-06 20:12:04');
INSERT INTO `variation_location_details` VALUES (45, 94, 93, 139, 7, 1.0000, '2019-01-19 05:31:55', '2019-01-19 05:31:55');
INSERT INTO `variation_location_details` VALUES (46, 95, 94, 140, 7, 1.0000, '2019-01-19 08:14:18', '2019-01-19 08:14:18');
INSERT INTO `variation_location_details` VALUES (47, 15, 16, 49, 7, -10.0000, '2019-01-19 09:15:07', '2019-02-08 20:42:21');
INSERT INTO `variation_location_details` VALUES (48, 18, 20, 59, 7, 0.0000, '2019-01-19 15:49:17', '2019-01-19 16:01:23');
INSERT INTO `variation_location_details` VALUES (49, 15, 17, 52, 7, 20.0000, '2019-01-26 23:29:26', '2019-01-26 23:29:26');
INSERT INTO `variation_location_details` VALUES (50, 64, 66, 107, 7, 5.0000, '2019-01-26 23:29:26', '2019-01-26 23:29:26');
INSERT INTO `variation_location_details` VALUES (51, 1, 1, 1, 7, 1.0000, '2019-01-27 19:09:08', '2019-01-27 19:09:08');
INSERT INTO `variation_location_details` VALUES (52, 2, 2, 2, 7, 2.0000, '2019-01-27 19:09:08', '2019-01-31 03:36:19');
INSERT INTO `variation_location_details` VALUES (53, 2, 2, 6, 7, 1.0000, '2019-01-27 22:14:00', '2019-01-27 22:14:00');
INSERT INTO `variation_location_details` VALUES (54, 101, 100, 145, 1, 124.0000, '2019-01-28 05:47:28', '2019-01-28 20:23:20');
INSERT INTO `variation_location_details` VALUES (55, 101, 100, 145, 7, 123.0000, '2019-01-28 05:47:28', '2019-01-28 05:47:28');
INSERT INTO `variation_location_details` VALUES (56, 103, 102, 146, 1, 161.0000, '2019-01-28 05:58:56', '2019-02-08 20:42:38');
INSERT INTO `variation_location_details` VALUES (57, 103, 102, 146, 7, 161.0000, '2019-01-28 05:58:56', '2019-02-08 20:42:38');
INSERT INTO `variation_location_details` VALUES (58, 3, 3, 9, 1, 12312.0000, '2019-01-28 06:13:49', '2019-01-28 06:13:49');
INSERT INTO `variation_location_details` VALUES (59, 107, 106, 149, 7, 10000000000006.0000, '2019-01-28 20:20:13', '2019-02-07 21:05:57');
INSERT INTO `variation_location_details` VALUES (60, 107, 106, 149, 1, 1.0000, '2019-01-28 20:23:20', '2019-01-28 20:23:20');
INSERT INTO `variation_location_details` VALUES (61, 111, 110, 150, 1, 903.0000, '2019-01-31 02:04:42', '2019-02-08 21:54:40');
INSERT INTO `variation_location_details` VALUES (62, 111, 110, 150, 7, 300.0000, '2019-01-31 02:30:50', '2019-02-08 21:54:40');
INSERT INTO `variation_location_details` VALUES (63, 112, 111, 151, 1, 0.0000, '2019-02-02 03:21:55', '2019-02-02 04:26:23');
INSERT INTO `variation_location_details` VALUES (64, 115, 114, 152, 1, 17.0000, '2019-02-02 04:34:06', '2019-02-02 04:35:46');
INSERT INTO `variation_location_details` VALUES (65, 125, 124, 154, 7, 35.0000, '2019-02-02 07:59:09', '2019-02-02 08:03:57');
INSERT INTO `variation_location_details` VALUES (66, 125, 124, 154, 1, 60.0000, '2019-02-02 07:59:45', '2019-02-02 08:03:57');
INSERT INTO `variation_location_details` VALUES (67, 126, 125, 155, 1, 8.0000, '2019-02-08 21:57:25', '2019-02-08 21:58:15');
INSERT INTO `variation_location_details` VALUES (68, 126, 125, 155, 7, 7.0000, '2019-02-08 21:58:15', '2019-02-08 21:58:15');
INSERT INTO `variation_location_details` VALUES (69, 127, 126, 156, 9, 21.0000, '2019-02-10 05:39:00', '2019-02-18 22:54:25');
INSERT INTO `variation_location_details` VALUES (70, 127, 126, 156, 10, 25.0000, '2019-02-12 13:48:28', '2019-02-18 21:50:20');
INSERT INTO `variation_location_details` VALUES (71, 128, 127, 157, 9, 8.0000, '2019-02-12 19:13:47', '2019-02-19 00:56:20');
INSERT INTO `variation_location_details` VALUES (72, 129, 128, 158, 9, -2.0000, '2019-02-13 19:23:49', '2019-02-19 09:21:46');
INSERT INTO `variation_location_details` VALUES (73, 130, 129, 159, 9, 3.0000, '2019-02-13 23:04:08', '2019-02-15 14:06:53');
INSERT INTO `variation_location_details` VALUES (74, 131, 130, 160, 9, 10.0000, '2019-02-14 00:01:13', '2019-02-18 22:54:25');
INSERT INTO `variation_location_details` VALUES (75, 131, 130, 160, 10, 17.0000, '2019-02-14 00:01:13', '2019-02-18 21:50:20');
INSERT INTO `variation_location_details` VALUES (76, 132, 131, 161, 9, 2.0000, '2019-02-14 12:19:54', '2019-02-18 22:54:25');
INSERT INTO `variation_location_details` VALUES (77, 132, 131, 161, 10, 12.0000, '2019-02-14 12:19:54', '2019-02-14 12:19:54');
INSERT INTO `variation_location_details` VALUES (78, 133, 132, 162, 9, 12.0000, '2019-02-14 12:21:00', '2019-02-18 22:54:25');
INSERT INTO `variation_location_details` VALUES (79, 133, 132, 162, 10, 46.0000, '2019-02-14 12:21:00', '2019-02-15 17:21:55');
INSERT INTO `variation_location_details` VALUES (81, 130, 129, 159, 10, 12.0000, '2019-02-15 14:06:53', '2019-02-15 14:06:53');
INSERT INTO `variation_location_details` VALUES (82, 135, 134, 164, 9, 0.0000, '2019-02-15 14:30:15', '2019-02-18 12:09:05');
INSERT INTO `variation_location_details` VALUES (83, 136, 135, 165, 9, 22.5500, '2019-02-15 15:57:23', '2019-02-19 18:37:23');
INSERT INTO `variation_location_details` VALUES (84, 136, 135, 165, 10, 3.5000, '2019-02-18 18:38:50', '2019-02-18 23:09:43');
INSERT INTO `variation_location_details` VALUES (85, 138, 137, 167, 9, 15.0000, '2019-02-19 08:11:30', '2019-02-19 18:35:27');

-- ----------------------------
-- Table structure for variation_templates
-- ----------------------------
DROP TABLE IF EXISTS `variation_templates`;
CREATE TABLE `variation_templates`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `variation_templates_business_id_foreign`(`business_id`) USING BTREE,
  CONSTRAINT `variation_templates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of variation_templates
-- ----------------------------
INSERT INTO `variation_templates` VALUES (1, 'Size (Tshirts)', 1, '2018-01-04 05:22:13', '2018-01-04 05:22:13');
INSERT INTO `variation_templates` VALUES (2, 'Size (Shoes)', 1, '2018-01-04 05:23:21', '2018-01-04 05:23:21');
INSERT INTO `variation_templates` VALUES (3, 'Waist Size (Jeans)', 1, '2018-01-04 05:24:34', '2018-01-04 05:24:34');
INSERT INTO `variation_templates` VALUES (4, 'Color', 1, '2018-01-06 15:12:52', '2018-01-06 15:12:52');

-- ----------------------------
-- Table structure for variation_value_templates
-- ----------------------------
DROP TABLE IF EXISTS `variation_value_templates`;
CREATE TABLE `variation_value_templates`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `variation_template_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `variation_value_templates_name_index`(`name`) USING BTREE,
  INDEX `variation_value_templates_variation_template_id_index`(`variation_template_id`) USING BTREE,
  CONSTRAINT `variation_value_templates_variation_template_id_foreign` FOREIGN KEY (`variation_template_id`) REFERENCES `variation_templates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of variation_value_templates
-- ----------------------------
INSERT INTO `variation_value_templates` VALUES (1, 'S', 1, '2018-01-04 05:22:13', '2018-01-04 05:22:13');
INSERT INTO `variation_value_templates` VALUES (2, 'M', 1, '2018-01-04 05:22:13', '2018-01-04 05:22:13');
INSERT INTO `variation_value_templates` VALUES (3, 'L', 1, '2018-01-04 05:22:13', '2018-01-04 05:22:13');
INSERT INTO `variation_value_templates` VALUES (4, 'XL', 1, '2018-01-04 05:22:13', '2018-01-04 05:22:13');
INSERT INTO `variation_value_templates` VALUES (5, '5', 2, '2018-01-04 05:23:21', '2018-01-04 05:23:21');
INSERT INTO `variation_value_templates` VALUES (6, '6', 2, '2018-01-04 05:23:21', '2018-01-04 05:23:21');
INSERT INTO `variation_value_templates` VALUES (7, '7', 2, '2018-01-04 05:23:21', '2018-01-04 05:23:21');
INSERT INTO `variation_value_templates` VALUES (8, '8', 2, '2018-01-04 05:23:21', '2018-01-04 05:23:21');
INSERT INTO `variation_value_templates` VALUES (9, '9', 2, '2018-01-04 05:23:21', '2018-01-04 05:23:21');
INSERT INTO `variation_value_templates` VALUES (10, '28', 3, '2018-01-04 05:24:34', '2018-01-04 05:24:34');
INSERT INTO `variation_value_templates` VALUES (11, '30', 3, '2018-01-04 05:24:34', '2018-01-04 05:24:34');
INSERT INTO `variation_value_templates` VALUES (12, '32', 3, '2018-01-04 05:24:34', '2018-01-04 05:24:34');
INSERT INTO `variation_value_templates` VALUES (13, '34', 3, '2018-01-04 05:24:35', '2018-01-04 05:24:35');
INSERT INTO `variation_value_templates` VALUES (14, '36', 3, '2018-01-04 05:24:35', '2018-01-04 05:24:35');
INSERT INTO `variation_value_templates` VALUES (16, 'Black', 4, '2018-01-06 15:13:17', '2018-01-06 15:13:17');
INSERT INTO `variation_value_templates` VALUES (17, 'Blue', 4, '2018-01-06 15:13:17', '2018-01-06 15:13:17');
INSERT INTO `variation_value_templates` VALUES (18, 'Brown', 4, '2018-01-06 15:13:17', '2018-01-06 15:13:17');
INSERT INTO `variation_value_templates` VALUES (19, 'Grey', 4, '2018-01-06 15:13:17', '2018-01-06 15:13:17');
INSERT INTO `variation_value_templates` VALUES (20, 'Gold', 4, '2018-01-06 15:13:17', '2018-01-06 15:13:17');

-- ----------------------------
-- Table structure for variations
-- ----------------------------
DROP TABLE IF EXISTS `variations`;
CREATE TABLE `variations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sub_sku` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL,
  `default_purchase_price` decimal(20, 2) NULL DEFAULT NULL,
  `dpp_inc_tax` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `profit_percent` decimal(20, 2) NOT NULL DEFAULT 0.00,
  `default_sell_price` decimal(20, 2) NULL DEFAULT NULL,
  `sell_price_inc_tax` decimal(20, 2) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `variations_product_id_foreign`(`product_id`) USING BTREE,
  INDEX `variations_product_variation_id_foreign`(`product_variation_id`) USING BTREE,
  INDEX `variations_name_index`(`name`) USING BTREE,
  INDEX `variations_sub_sku_index`(`sub_sku`) USING BTREE,
  CONSTRAINT `variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `variations_product_variation_id_foreign` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 169 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of variations
-- ----------------------------
INSERT INTO `variations` VALUES (1, 'DUMMY', 1, 'AS0001', 1, 100.00, 100.00, 0.00, 100.00, 100.00, '2018-01-03 23:59:08', '2019-02-02 06:37:11', NULL);
INSERT INTO `variations` VALUES (2, '28', 2, 'AS0002-1', 2, 100.00, 110.00, 0.00, 100.00, 110.00, '2018-01-04 00:00:35', '2019-01-29 18:47:40', NULL);
INSERT INTO `variations` VALUES (3, '30', 2, 'AS0002-2', 2, 100.00, 110.00, 0.00, 100.00, 110.00, '2018-01-04 00:00:35', '2019-01-27 08:43:06', NULL);
INSERT INTO `variations` VALUES (4, '32', 2, 'AS0002-3', 2, 100.00, 110.00, 0.00, 100.00, 110.00, '2018-01-04 00:00:35', '2019-01-27 08:43:06', NULL);
INSERT INTO `variations` VALUES (5, '34', 2, 'AS0002-4', 2, 102.86, 113.14, 0.00, 102.86, 113.14, '2018-01-04 00:00:35', '2019-01-27 08:43:06', NULL);
INSERT INTO `variations` VALUES (6, '36', 2, 'AS0002-5', 2, 102.86, 113.14, 0.00, 102.86, 113.14, '2018-01-04 00:00:35', '2019-01-27 08:43:06', NULL);
INSERT INTO `variations` VALUES (7, 'S', 3, 'AS0003-1', 3, 190.00, 209.00, 0.00, 190.00, 209.00, '2018-01-04 01:21:52', '2019-01-19 11:39:09', NULL);
INSERT INTO `variations` VALUES (8, 'M', 3, 'AS0003-2', 3, 190.00, 209.00, 0.00, 190.00, 209.00, '2018-01-04 01:21:52', '2019-01-19 11:39:09', NULL);
INSERT INTO `variations` VALUES (9, 'L', 3, 'AS0003-3', 3, 190.00, 209.00, 0.00, 190.00, 209.00, '2018-01-04 01:21:52', '2019-01-19 11:39:09', NULL);
INSERT INTO `variations` VALUES (10, 'XL', 3, 'AS0003-4', 3, 191.00, 210.10, 0.00, 191.00, 210.10, '2018-01-04 01:21:52', '2019-01-19 11:39:09', NULL);
INSERT INTO `variations` VALUES (11, '6', 4, 'AS0004-1', 4, 165.00, 181.50, 0.00, 165.00, 181.50, '2018-01-04 01:24:34', '2018-06-11 10:12:27', NULL);
INSERT INTO `variations` VALUES (12, '7', 4, 'AS0004-2', 4, 165.00, 181.50, 0.00, 165.00, 181.50, '2018-01-04 01:24:34', '2018-06-11 10:12:27', NULL);
INSERT INTO `variations` VALUES (13, '8', 4, 'AS0004-3', 4, 165.00, 181.50, 0.00, 165.00, 181.50, '2018-01-04 01:24:34', '2018-06-11 10:12:27', NULL);
INSERT INTO `variations` VALUES (14, '9', 4, 'AS0004-4', 4, 166.00, 182.60, 0.00, 166.00, 182.60, '2018-01-04 01:24:34', '2018-06-11 10:12:27', NULL);
INSERT INTO `variations` VALUES (27, '6', 8, 'AS0008-1', 8, 110.00, 121.00, 0.00, 110.00, 121.00, '2018-01-04 01:40:10', '2018-06-11 10:11:16', NULL);
INSERT INTO `variations` VALUES (28, '7', 8, 'AS0008-2', 8, 110.00, 121.00, 0.00, 110.00, 121.00, '2018-01-04 01:40:10', '2018-06-11 10:11:16', NULL);
INSERT INTO `variations` VALUES (29, '8', 8, 'AS0008-3', 8, 110.00, 121.00, 0.00, 110.00, 121.00, '2018-01-04 01:40:10', '2018-06-11 10:11:16', NULL);
INSERT INTO `variations` VALUES (30, '9', 8, 'AS0008-4', 8, 110.00, 121.00, 0.00, 110.00, 121.00, '2018-01-04 01:40:10', '2018-06-11 10:11:16', NULL);
INSERT INTO `variations` VALUES (35, '5', 10, 'AS0010-1', 10, 150.00, 165.00, 0.00, 150.00, 165.00, '2018-01-04 01:43:02', '2018-06-11 10:11:35', NULL);
INSERT INTO `variations` VALUES (36, '6', 10, 'AS0010-2', 10, 150.00, 165.00, 0.00, 150.00, 165.00, '2018-01-04 01:43:02', '2018-06-11 10:11:35', NULL);
INSERT INTO `variations` VALUES (37, '7', 10, 'AS0010-3', 10, 150.00, 165.00, 0.00, 150.00, 165.00, '2018-01-04 01:43:02', '2018-06-11 10:11:35', NULL);
INSERT INTO `variations` VALUES (38, '8', 10, 'AS0010-4', 10, 150.00, 165.00, 0.00, 150.00, 165.00, '2018-01-04 01:43:02', '2018-06-11 10:11:35', NULL);
INSERT INTO `variations` VALUES (39, '9', 10, 'AS0010-5', 10, 150.00, 165.00, 0.00, 150.00, 165.00, '2018-01-04 01:43:02', '2018-06-11 10:11:35', NULL);
INSERT INTO `variations` VALUES (40, 'DUMMY', 11, 'AS0011', 11, 30.00, 33.00, 0.00, 30.00, 33.00, '2018-01-04 01:44:35', '2018-06-11 10:06:08', NULL);
INSERT INTO `variations` VALUES (41, 'DUMMY', 12, 'AS0012', 12, 25.00, 27.50, 0.00, 25.00, 27.50, '2018-01-04 01:45:50', '2018-06-11 10:05:50', NULL);
INSERT INTO `variations` VALUES (42, 'M', 13, 'AS0013-1', 13, 60.00, 66.00, 0.00, 60.00, 66.00, '2018-01-04 01:47:59', '2018-06-11 10:10:19', NULL);
INSERT INTO `variations` VALUES (43, 'L', 13, 'AS0013-2', 13, 60.00, 66.00, 0.00, 60.00, 66.00, '2018-01-04 01:47:59', '2018-06-11 10:10:19', NULL);
INSERT INTO `variations` VALUES (44, 'XL', 13, 'AS0013-3', 13, 60.00, 66.00, 0.00, 60.00, 66.00, '2018-01-04 01:47:59', '2018-06-11 10:10:19', NULL);
INSERT INTO `variations` VALUES (45, 'Gray', 14, 'AS0014-1', 14, 700.00, 770.00, 25.00, 875.00, 962.50, '2018-01-06 08:12:19', '2018-06-11 10:13:13', NULL);
INSERT INTO `variations` VALUES (46, 'Black', 14, 'AS0014-2', 14, 700.00, 770.00, 25.00, 875.00, 962.50, '2018-01-06 08:12:19', '2018-06-11 10:13:13', NULL);
INSERT INTO `variations` VALUES (47, '64 GB', 14, 'AS0014-1', 15, 700.00, 770.00, 25.00, 875.00, 962.50, '2018-01-06 08:14:14', '2018-06-11 10:13:13', NULL);
INSERT INTO `variations` VALUES (48, '128 GB', 14, 'AS0014-2', 15, 800.00, 880.00, 25.00, 1000.00, 1100.00, '2018-01-06 08:14:14', '2018-06-11 10:13:13', NULL);
INSERT INTO `variations` VALUES (49, 'White', 15, 'AS0015-1', 16, 950.00, 1045.00, 25.00, 1187.50, 1306.25, '2018-01-06 08:19:51', '2018-06-11 10:06:57', NULL);
INSERT INTO `variations` VALUES (50, 'Gray', 15, 'AS0015-2', 16, 950.00, 1045.00, 25.00, 1187.50, 1306.25, '2018-01-06 08:19:51', '2018-06-11 10:06:57', NULL);
INSERT INTO `variations` VALUES (51, 'Black', 15, 'AS0015-3', 16, 950.00, 1045.00, 25.00, 1187.50, 1306.25, '2018-01-06 08:19:51', '2018-06-11 10:06:57', NULL);
INSERT INTO `variations` VALUES (52, '32 GB', 15, 'AS0015-1', 17, 950.00, 1045.00, 25.00, 1187.50, 1306.25, '2018-01-06 08:19:51', '2018-06-11 10:06:57', NULL);
INSERT INTO `variations` VALUES (53, '64 GB', 15, 'AS0015-2', 17, 1010.00, 1111.00, 25.00, 1262.50, 1388.75, '2018-01-06 08:19:51', '2018-06-11 10:06:57', NULL);
INSERT INTO `variations` VALUES (54, 'Gold', 16, 'AS0016-1', 18, 350.00, 350.00, 25.00, 437.50, 437.50, '2018-01-06 08:24:48', '2018-06-11 10:12:58', NULL);
INSERT INTO `variations` VALUES (55, 'White', 16, 'AS0016-2', 18, 350.00, 350.00, 25.00, 437.50, 437.50, '2018-01-06 08:24:48', '2018-06-11 10:12:58', NULL);
INSERT INTO `variations` VALUES (56, 'Black', 16, 'AS0016-3', 18, 350.00, 350.00, 25.00, 437.50, 437.50, '2018-01-06 08:24:48', '2018-06-11 10:12:58', NULL);
INSERT INTO `variations` VALUES (57, 'Black', 17, 'AS0017-1', 19, 350.00, 350.00, 25.00, 437.50, 437.50, '2018-01-06 08:35:01', '2019-01-28 05:38:45', NULL);
INSERT INTO `variations` VALUES (58, 'White', 17, 'AS0017-2', 19, 350.00, 350.00, 25.00, 437.50, 437.50, '2018-01-06 08:35:01', '2019-01-28 05:38:45', NULL);
INSERT INTO `variations` VALUES (59, '256 GB', 18, 'AS0018-1', 20, 1350.00, 1350.00, 25.00, 1687.50, 1687.50, '2018-01-06 08:37:30', '2018-06-11 10:07:29', NULL);
INSERT INTO `variations` VALUES (60, '500 GB', 18, 'AS0018-2', 20, 1450.00, 1450.00, 25.00, 1812.50, 1812.50, '2018-01-06 08:37:30', '2018-06-11 10:07:29', NULL);
INSERT INTO `variations` VALUES (61, 'DUMMY', 19, 'AS0019', 21, 8.00, 8.00, 25.00, 10.00, 10.00, '2018-01-06 08:40:28', '2018-06-11 10:08:23', NULL);
INSERT INTO `variations` VALUES (62, 'Gray', 20, 'AS0020-1', 22, 25.00, 27.50, 25.00, 31.25, 34.38, '2018-01-06 08:43:00', '2018-06-11 10:14:10', NULL);
INSERT INTO `variations` VALUES (63, 'Black', 20, 'AS0020-2', 22, 25.00, 27.50, 25.00, 31.25, 34.38, '2018-01-06 08:43:00', '2018-06-11 10:14:10', NULL);
INSERT INTO `variations` VALUES (64, 'DUMMY', 21, 'AS0021', 23, 10.00, 10.00, 25.00, 12.50, 12.50, '2018-01-06 08:46:35', '2018-06-11 10:12:13', NULL);
INSERT INTO `variations` VALUES (65, 'DUMMY', 22, 'AS0022', 24, 8.00, 8.80, 25.00, 10.00, 11.00, '2018-01-06 08:55:09', '2018-06-11 10:08:37', NULL);
INSERT INTO `variations` VALUES (66, 'DUMMY', 23, 'AS0023', 25, 10.00, 10.00, 25.00, 12.50, 12.50, '2018-01-06 08:56:27', '2018-06-11 10:13:51', NULL);
INSERT INTO `variations` VALUES (67, 'DUMMY', 24, 'AS0024', 26, 8.00, 8.80, 25.00, 10.00, 11.00, '2018-01-06 09:01:22', '2018-06-11 10:08:53', NULL);
INSERT INTO `variations` VALUES (68, 'DUMMY', 25, 'AS0025', 27, 15.00, 15.00, 25.00, 18.75, 18.75, '2018-01-06 09:02:23', '2018-06-11 10:09:09', NULL);
INSERT INTO `variations` VALUES (69, 'DUMMY', 26, 'AS0026', 28, 5.00, 5.00, 25.00, 6.25, 6.25, '2018-01-06 09:05:51', '2018-06-11 10:11:51', NULL);
INSERT INTO `variations` VALUES (70, 'DUMMY', 27, 'AS0027', 29, 20.00, 22.00, 25.00, 25.00, 27.50, '2018-01-06 09:13:16', '2018-06-11 10:08:01', NULL);
INSERT INTO `variations` VALUES (71, 'DUMMY', 28, 'AS0028', 30, 10.00, 11.00, 25.00, 12.50, 13.75, '2018-01-06 09:15:47', '2018-06-11 10:07:45', NULL);
INSERT INTO `variations` VALUES (72, 'DUMMY', 29, 'AS0029', 31, 12.00, 12.00, 25.00, 15.00, 15.00, '2018-01-06 09:16:53', '2018-06-11 10:14:34', NULL);
INSERT INTO `variations` VALUES (73, 'DUMMY', 30, 'AS0030', 32, 40.00, 44.00, 25.00, 50.00, 55.00, '2018-01-06 09:18:59', '2018-06-11 10:09:59', NULL);
INSERT INTO `variations` VALUES (74, 'DUMMY', 31, 'AP0031', 33, 7.00, 7.00, 25.00, 8.75, 8.75, '2018-04-10 12:36:29', '2018-04-10 12:36:29', NULL);
INSERT INTO `variations` VALUES (75, 'DUMMY', 32, 'AP0032', 34, 12.00, 12.00, 25.00, 15.00, 15.00, '2018-04-10 12:37:52', '2018-04-10 12:37:52', NULL);
INSERT INTO `variations` VALUES (76, 'DUMMY', 33, 'AP0033', 35, 12.00, 12.00, 25.00, 15.00, 15.00, '2018-04-10 12:39:45', '2018-04-10 12:39:45', NULL);
INSERT INTO `variations` VALUES (77, 'DUMMY', 34, 'AP0034', 36, 6.00, 6.00, 25.00, 7.50, 7.50, '2018-04-10 12:40:59', '2018-04-10 12:40:59', NULL);
INSERT INTO `variations` VALUES (78, 'DUMMY', 35, 'AP0035', 37, 7.00, 7.00, 25.00, 8.75, 8.75, '2018-04-10 12:42:53', '2018-04-10 12:42:53', NULL);
INSERT INTO `variations` VALUES (79, 'DUMMY', 36, 'AP0036', 38, 9.00, 9.00, 25.00, 11.25, 11.25, '2018-04-10 12:44:18', '2018-04-10 12:44:18', NULL);
INSERT INTO `variations` VALUES (80, 'DUMMY', 37, 'AP0037', 39, 12.00, 12.00, 25.00, 15.00, 15.00, '2018-04-10 13:01:29', '2018-04-10 13:01:29', NULL);
INSERT INTO `variations` VALUES (81, 'DUMMY', 38, 'AP0038', 40, 15.00, 15.00, 25.00, 18.75, 18.75, '2018-04-10 13:02:35', '2018-04-10 13:02:35', NULL);
INSERT INTO `variations` VALUES (82, 'DUMMY', 39, 'AP0039', 41, 12.00, 12.00, 25.00, 15.00, 15.00, '2018-04-10 13:03:26', '2018-04-10 13:03:26', NULL);
INSERT INTO `variations` VALUES (83, 'DUMMY', 40, 'AP0040', 42, 8.00, 8.00, 25.00, 10.00, 10.00, '2018-04-10 13:04:32', '2018-04-10 13:04:49', NULL);
INSERT INTO `variations` VALUES (84, 'DUMMY', 41, 'AE0041', 43, 500.00, 500.00, 25.00, 625.00, 625.00, '2018-04-10 13:38:27', '2018-04-10 13:38:27', NULL);
INSERT INTO `variations` VALUES (85, 'DUMMY', 42, 'AE0042', 44, 520.00, 520.00, 25.00, 650.00, 650.00, '2018-04-10 13:45:52', '2018-04-10 14:21:21', NULL);
INSERT INTO `variations` VALUES (86, 'DUMMY', 43, 'AE0043', 45, 400.00, 400.00, 25.00, 500.00, 500.00, '2018-04-10 13:48:01', '2018-04-10 13:48:01', NULL);
INSERT INTO `variations` VALUES (87, 'DUMMY', 44, 'AE0044', 46, 195.00, 195.00, 25.00, 243.75, 243.75, '2018-04-10 13:49:10', '2018-04-10 13:49:10', NULL);
INSERT INTO `variations` VALUES (88, 'DUMMY', 45, 'AE0045', 47, 300.00, 300.00, 25.00, 375.00, 375.00, '2018-04-10 13:50:22', '2018-04-10 13:50:22', NULL);
INSERT INTO `variations` VALUES (89, 'DUMMY', 46, 'AE0046', 48, 321.00, 321.00, 25.00, 401.25, 401.25, '2018-04-10 13:52:04', '2018-04-10 13:52:04', NULL);
INSERT INTO `variations` VALUES (90, 'DUMMY', 47, 'AE0047', 49, 255.00, 255.00, 25.00, 318.75, 318.75, '2018-04-10 13:53:45', '2018-04-10 13:53:45', NULL);
INSERT INTO `variations` VALUES (91, 'DUMMY', 48, 'AE0048', 50, 850.00, 850.00, 25.00, 1062.50, 1062.50, '2018-04-10 13:54:42', '2018-04-10 14:22:07', NULL);
INSERT INTO `variations` VALUES (92, 'DUMMY', 49, 'AE0049', 51, 1500.00, 1500.00, 25.00, 1875.00, 1875.00, '2018-04-10 13:55:55', '2018-04-10 13:55:55', NULL);
INSERT INTO `variations` VALUES (93, 'DUMMY', 50, 'AE0050', 52, 630.00, 630.00, 25.00, 787.50, 787.50, '2018-04-10 14:04:32', '2018-04-10 14:04:32', NULL);
INSERT INTO `variations` VALUES (94, 'DUMMY', 51, 'AS0051', 53, 100.00, 100.00, 25.00, 125.00, 125.00, '2018-04-10 15:04:57', '2018-04-10 15:04:57', NULL);
INSERT INTO `variations` VALUES (95, 'DUMMY', 52, 'AS0052', 54, 80.00, 80.00, 25.00, 100.00, 100.00, '2018-04-10 15:05:55', '2018-04-10 15:05:55', NULL);
INSERT INTO `variations` VALUES (96, 'DUMMY', 53, 'AS0053', 55, 105.00, 105.00, 25.00, 131.25, 131.25, '2018-04-10 15:09:15', '2018-04-10 15:09:15', NULL);
INSERT INTO `variations` VALUES (97, 'DUMMY', 54, 'AS0054', 56, 10.00, 10.00, 25.00, 12.50, 12.50, '2018-04-10 15:24:16', '2018-04-10 15:24:16', NULL);
INSERT INTO `variations` VALUES (98, 'DUMMY', 55, 'AS0055', 57, 8.00, 8.00, 25.00, 10.00, 10.00, '2018-04-10 15:26:18', '2018-04-10 15:26:18', NULL);
INSERT INTO `variations` VALUES (99, 'DUMMY', 56, 'AS0056', 58, 150.00, 150.00, 25.00, 187.50, 187.50, '2018-04-10 15:31:59', '2018-04-10 15:31:59', NULL);
INSERT INTO `variations` VALUES (100, 'DUMMY', 57, 'AS0057', 59, 20.00, 20.00, 25.00, 25.00, 25.00, '2018-04-10 15:33:01', '2018-04-10 15:33:01', NULL);
INSERT INTO `variations` VALUES (101, 'DUMMY', 58, 'AS0058', 60, 20.00, 20.00, 25.00, 25.00, 25.00, '2018-04-10 15:33:37', '2018-04-10 15:33:37', NULL);
INSERT INTO `variations` VALUES (102, 'DUMMY', 59, 'AS0059', 61, 15.00, 15.00, 25.00, 18.75, 18.75, '2018-04-10 15:36:45', '2018-04-10 15:36:45', NULL);
INSERT INTO `variations` VALUES (103, 'DUMMY', 60, 'AS0060', 62, 15.00, 15.00, 25.00, 18.75, 18.75, '2018-04-10 15:37:08', '2018-04-10 15:37:08', NULL);
INSERT INTO `variations` VALUES (104, 'DUMMY', 61, 'AS0061', 63, 34.00, 34.00, 25.00, 42.50, 42.50, '2018-06-12 00:27:41', '2018-06-12 00:27:41', NULL);
INSERT INTO `variations` VALUES (105, 'DUMMY', 62, 'AS0062', 64, 35.00, 35.00, 25.00, 43.75, 43.75, '2018-06-12 00:32:17', '2018-06-12 00:32:17', NULL);
INSERT INTO `variations` VALUES (106, 'DUMMY', 63, 'AS0063', 65, 10.00, 10.00, 25.00, 12.50, 12.50, '2018-06-12 00:38:12', '2019-01-17 02:38:58', NULL);
INSERT INTO `variations` VALUES (107, 'DUMMY', 64, 'AS0064', 66, 10.00, 10.00, 25.00, 12.50, 12.50, '2018-06-12 00:40:34', '2018-06-12 00:40:34', NULL);
INSERT INTO `variations` VALUES (108, 'DUMMY', 65, 'AS0065', 67, 10.00, 10.00, 25.00, 12.50, 12.50, '2018-06-12 00:44:00', '2018-06-12 00:44:30', NULL);
INSERT INTO `variations` VALUES (109, 'DUMMY', 66, 'AR0066', 68, 15.00, 15.00, 25.00, 18.75, 18.75, '2018-07-13 09:00:31', '2018-07-13 09:00:31', NULL);
INSERT INTO `variations` VALUES (110, 'DUMMY', 67, 'AR0067', 69, 8.00, 8.00, 25.00, 10.00, 10.00, '2018-07-13 09:04:47', '2018-07-13 09:04:47', NULL);
INSERT INTO `variations` VALUES (111, 'DUMMY', 68, 'AR0068', 70, 11.00, 11.00, 25.00, 13.75, 13.75, '2018-07-13 09:08:55', '2018-07-13 09:08:55', NULL);
INSERT INTO `variations` VALUES (112, 'DUMMY', 69, 'AR0069', 71, 12.00, 12.00, 25.00, 15.00, 15.00, '2018-07-13 09:15:51', '2018-07-13 09:15:51', NULL);
INSERT INTO `variations` VALUES (113, 'DUMMY', 70, 'AR0070', 72, 12.00, 12.00, 25.00, 15.00, 15.00, '2018-07-13 09:27:37', '2018-07-13 09:27:37', NULL);
INSERT INTO `variations` VALUES (114, 'DUMMY', 71, 'AR0071', 73, 17.00, 17.00, 25.00, 21.25, 21.25, '2018-07-13 09:30:41', '2018-07-13 09:30:41', NULL);
INSERT INTO `variations` VALUES (115, 'DUMMY', 72, 'AR0072', 74, 18.00, 18.00, 25.00, 22.50, 22.50, '2018-07-13 09:35:03', '2018-07-13 09:35:03', NULL);
INSERT INTO `variations` VALUES (116, 'DUMMY', 73, 'AR0073', 75, 20.00, 20.00, 25.00, 25.00, 25.00, '2018-07-13 09:37:29', '2018-07-13 09:37:29', NULL);
INSERT INTO `variations` VALUES (117, 'DUMMY', 74, 'AR0074', 76, 7.00, 7.00, 25.00, 8.75, 8.75, '2018-07-13 09:40:45', '2018-07-13 09:40:45', NULL);
INSERT INTO `variations` VALUES (118, 'DUMMY', 75, 'AR0075', 77, 8.00, 8.00, 25.00, 10.00, 10.00, '2018-07-13 09:43:09', '2018-07-13 09:43:09', NULL);
INSERT INTO `variations` VALUES (119, 'DUMMY', 76, 'AR0076', 78, 8.00, 8.00, 25.00, 10.00, 10.00, '2018-07-13 09:48:33', '2018-07-13 09:48:33', NULL);
INSERT INTO `variations` VALUES (120, 'DUMMY', 77, 'AR0077', 79, 3.00, 3.00, 25.00, 3.75, 3.75, '2018-07-13 09:54:22', '2018-07-13 09:58:56', NULL);
INSERT INTO `variations` VALUES (121, 'Bacon', 78, 'AR0078-1', 80, 2.00, 2.00, 0.00, 2.00, 2.00, '2018-07-16 10:28:04', '2018-07-16 10:28:51', NULL);
INSERT INTO `variations` VALUES (122, 'Black olives', 78, 'AR0078-2', 80, 1.00, 1.00, 0.00, 1.00, 1.00, '2018-07-16 10:28:33', '2018-07-16 10:28:51', NULL);
INSERT INTO `variations` VALUES (123, 'Green peppers', 78, 'AR0078-3', 80, 1.00, 1.00, 0.00, 1.00, 1.00, '2018-07-16 10:28:51', '2018-07-16 10:28:51', NULL);
INSERT INTO `variations` VALUES (124, 'Cheese', 79, 'AR0079-1', 81, 2.00, 2.00, 0.00, 2.00, 2.00, '2018-07-16 10:35:37', '2018-07-16 10:36:52', NULL);
INSERT INTO `variations` VALUES (125, 'Vegies', 79, 'AR0079-2', 81, 1.00, 1.00, 0.00, 1.00, 1.00, '2018-07-16 10:35:37', '2018-07-16 10:36:52', NULL);
INSERT INTO `variations` VALUES (126, 'Bacon', 79, 'AR0079-3', 81, 2.00, 2.00, 0.00, 2.00, 2.00, '2018-07-16 10:35:37', '2018-07-16 10:36:52', NULL);
INSERT INTO `variations` VALUES (127, 'Chocolate', 79, 'AR0079-4', 81, 2.00, 2.00, 0.00, 2.00, 2.00, '2018-07-16 10:36:52', '2018-07-16 10:36:52', NULL);
INSERT INTO `variations` VALUES (128, 'DUMMY', 80, 'with supplier', 82, 100.00, 100.00, 25.00, 125.00, 125.00, '2018-08-08 06:59:03', '2018-08-08 06:59:03', NULL);
INSERT INTO `variations` VALUES (129, 'DUMMY', 81, 'P1 package', 83, 100.00, 100.00, 25.00, 125.00, 125.00, '2018-08-13 01:40:39', '2018-08-13 01:40:39', NULL);
INSERT INTO `variations` VALUES (130, 'DUMMY', 82, 'P2 package', 84, 250.00, 250.00, 25.00, 312.50, 312.50, '2018-08-13 01:41:16', '2018-08-13 01:41:16', NULL);
INSERT INTO `variations` VALUES (131, 'DUMMY', 83, 'P3 package', 85, 300.00, 300.00, 25.00, 375.00, 375.00, '2018-08-13 01:41:48', '2018-08-13 01:41:48', NULL);
INSERT INTO `variations` VALUES (132, 'DUMMY', 86, 'AS0086', 86, 12312.00, 12312.00, 1231.23, 163901.04, 163901.04, '2019-01-16 09:07:49', '2019-01-16 09:07:49', NULL);
INSERT INTO `variations` VALUES (133, 'DUMMY', 87, 'AS0087', 87, 123.00, 123.00, 25.00, 153.75, 153.75, '2019-01-16 09:14:25', '2019-01-16 09:14:25', NULL);
INSERT INTO `variations` VALUES (134, 'DUMMY', 88, 'AS0088', 88, 123.00, 123.00, 25.00, 153.75, 153.75, '2019-01-16 09:18:57', '2019-01-16 09:18:57', NULL);
INSERT INTO `variations` VALUES (135, 'DUMMY', 90, 'AS0090', 89, 100.00, 110.00, 25.00, 125.00, 137.50, '2019-01-17 02:00:05', '2019-01-17 02:00:05', NULL);
INSERT INTO `variations` VALUES (136, 'DUMMY', 91, NULL, 90, 10.00, 11.80, 25.00, 12.50, 14.75, '2019-01-17 02:08:39', '2019-01-17 02:08:39', NULL);
INSERT INTO `variations` VALUES (137, 'DUMMY', 92, ' ', 91, 10.00, 11.00, 25.00, 12.50, 13.75, '2019-01-17 02:28:09', '2019-01-17 02:28:09', NULL);
INSERT INTO `variations` VALUES (138, 'DUMMY', 93, ' ', 92, 10.00, 11.00, 25.00, 12.50, 13.75, '2019-01-17 02:28:39', '2019-01-17 02:28:39', NULL);
INSERT INTO `variations` VALUES (139, 'DUMMY', 94, 'asdfasdf', 93, 10.00, 10.00, 25.00, 12.50, 12.50, '2019-01-19 05:31:33', '2019-01-19 05:31:33', NULL);
INSERT INTO `variations` VALUES (140, 'DUMMY', 95, 'AS0095', 94, 0.00, 0.00, 25.00, 0.00, 0.00, '2019-01-19 08:13:36', '2019-01-19 08:13:36', NULL);
INSERT INTO `variations` VALUES (141, 'DUMMY', 96, ' ', 95, 123.00, 123.00, 0.00, 123.00, 123.00, '2019-01-19 15:38:00', '2019-01-19 15:38:00', NULL);
INSERT INTO `variations` VALUES (142, '5', 97, 'asd', 96, 17.14, 17.14, 0.00, 17.14, 17.14, '2019-01-25 11:49:04', '2019-01-25 11:49:04', NULL);
INSERT INTO `variations` VALUES (143, '8', 97, ' -2', 96, 2.86, 2.86, 0.00, 2.86, 2.86, '2019-01-25 11:49:04', '2019-01-25 11:49:04', NULL);
INSERT INTO `variations` VALUES (144, '9', 97, ' -3', 96, 4.29, 4.29, 0.00, 4.29, 4.29, '2019-01-25 11:49:04', '2019-01-25 11:49:04', NULL);
INSERT INTO `variations` VALUES (145, 'DUMMY', 101, 'AS0101', 100, 999.00, 999.00, 0.00, 999.00, 999.00, '2019-01-28 05:32:45', '2019-01-28 05:52:07', NULL);
INSERT INTO `variations` VALUES (146, 'DUMMY', 103, ' ', 102, 999.00, 999.00, 0.00, 999.00, 999.00, '2019-01-28 05:58:43', '2019-01-28 05:58:43', NULL);
INSERT INTO `variations` VALUES (147, 'DUMMY', 104, 'AS0104', 103, 12.00, 12.00, 0.00, 12.00, 12.00, '2019-01-28 06:12:45', '2019-01-28 06:12:45', NULL);
INSERT INTO `variations` VALUES (148, 'DUMMY', 106, 'AS0106', 105, 123.00, 123.00, 0.00, 123.00, 123.00, '2019-01-28 20:11:37', '2019-01-28 20:11:37', NULL);
INSERT INTO `variations` VALUES (149, 'DUMMY', 107, 'AS0107', 106, 123.00, 123.00, 61.79, 199.00, 199.00, '2019-01-28 20:12:07', '2019-01-29 23:08:35', NULL);
INSERT INTO `variations` VALUES (150, 'DUMMY', 111, ' ', 110, 165.00, 165.00, 27.27, 210.00, 210.00, '2019-01-31 01:34:00', '2019-02-02 06:43:06', NULL);
INSERT INTO `variations` VALUES (151, 'DUMMY', 112, 'AS0112', 111, 100.00, 100.00, 0.00, 100.00, 100.00, '2019-02-02 03:21:33', '2019-02-02 03:21:33', NULL);
INSERT INTO `variations` VALUES (152, 'DUMMY', 115, 'AS0115', 114, 100.00, 100.00, 0.00, 100.00, 100.00, '2019-02-02 04:33:43', '2019-02-02 04:33:43', NULL);
INSERT INTO `variations` VALUES (153, 'DUMMY', 119, ' ', 118, 500.00, 500.00, 0.00, 500.00, 500.00, '2019-02-02 07:55:02', '2019-02-02 07:55:02', NULL);
INSERT INTO `variations` VALUES (154, 'DUMMY', 125, ' ', 124, 900.00, 900.00, 0.00, 900.00, 900.00, '2019-02-02 07:58:26', '2019-02-02 08:03:40', NULL);
INSERT INTO `variations` VALUES (155, 'DUMMY', 126, 'AS0126', 125, 100.00, 100.00, 0.00, 100.00, 100.00, '2019-02-08 21:57:03', '2019-02-08 21:57:03', NULL);
INSERT INTO `variations` VALUES (156, 'DUMMY', 127, ' ', 126, 124.00, 124.00, 12.00, 138.88, 138.88, '2019-02-10 05:37:10', '2019-02-19 08:18:49', NULL);
INSERT INTO `variations` VALUES (157, 'DUMMY', 128, '0128', 127, 123.00, 123.00, 0.00, 123.00, 123.00, '2019-02-12 19:13:18', '2019-02-12 19:13:18', NULL);
INSERT INTO `variations` VALUES (158, 'DUMMY', 129, ' ', 128, 100.00, 100.00, 0.00, 100.00, 100.00, '2019-02-13 15:13:35', '2019-02-13 15:13:35', NULL);
INSERT INTO `variations` VALUES (159, 'DUMMY', 130, '0130', 129, 65.00, 65.00, 0.00, 65.00, 65.00, '2019-02-13 23:03:28', '2019-02-13 23:03:28', NULL);
INSERT INTO `variations` VALUES (160, 'DUMMY', 131, ' ', 130, 100.00, 100.00, 0.00, 100.00, 100.00, '2019-02-14 00:00:55', '2019-02-14 00:00:55', NULL);
INSERT INTO `variations` VALUES (161, 'DUMMY', 132, ' ', 131, 12.00, 12.00, 0.00, 12.00, 12.00, '2019-02-14 12:19:47', '2019-02-14 12:19:47', NULL);
INSERT INTO `variations` VALUES (162, 'DUMMY', 133, ' ', 132, 1.00, 1.00, 0.00, 1.00, 1.00, '2019-02-14 12:20:37', '2019-02-14 12:21:19', NULL);
INSERT INTO `variations` VALUES (164, 'DUMMY', 135, ' ', 134, 100.00, 100.00, 10.00, 110.00, 110.00, '2019-02-15 09:24:38', '2019-02-15 09:24:38', NULL);
INSERT INTO `variations` VALUES (165, 'DUMMY', 136, ' ', 135, 111.00, 111.00, 9.01, 121.00, 121.00, '2019-02-15 15:56:46', '2019-02-18 20:22:42', NULL);
INSERT INTO `variations` VALUES (166, 'DUMMY', 137, ' ', 136, 12.00, 12.00, 0.00, 12.00, 12.00, '2019-02-16 14:06:26', '2019-02-16 14:06:26', NULL);
INSERT INTO `variations` VALUES (167, 'DUMMY', 138, '0138', 137, 100.00, 100.00, 0.00, 100.00, 100.00, '2019-02-19 08:07:46', '2019-02-19 08:14:06', NULL);
INSERT INTO `variations` VALUES (168, 'DUMMY', 139, ' ', 138, 123.00, 123.00, 0.00, 123.00, 123.00, '2019-02-19 08:15:38', '2019-02-19 08:16:19', NULL);

SET FOREIGN_KEY_CHECKS = 1;
