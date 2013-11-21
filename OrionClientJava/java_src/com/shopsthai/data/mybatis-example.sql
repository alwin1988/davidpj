/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : mybatis-example

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2013-10-12 23:21:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_no` bigint(19) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL,
  `comment_content` mediumtext NOT NULL,
  `reg_date` datetime NOT NULL,
  PRIMARY KEY (`comment_no`),
  UNIQUE KEY `XPKnwc_comment` (`comment_no`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('2', 'user1', 'ëŒ“ê¸€2', '2012-04-13 15:04:32');
INSERT INTO `comment` VALUES ('3', 'user2', 'ëŒ“ê¸€3', '2012-04-13 15:04:35');
INSERT INTO `comment` VALUES ('4', 'user2', 'ëŒ“ê¸€4', '2012-04-13 15:04:37');
INSERT INTO `comment` VALUES ('5', 'user3', 'ëŒ“ê¸€5', '2012-04-13 15:04:41');
INSERT INTO `comment` VALUES ('6', 'user3', 'ëŒ“ê¸€6', '2012-04-13 15:04:43');
INSERT INTO `comment` VALUES ('7', 'fromm0', 'test', '2013-10-12 23:12:23');
INSERT INTO `comment` VALUES ('8', 'fromm0', 'test', '2013-10-12 23:15:07');
INSERT INTO `comment` VALUES ('9', 'fromm0', 'test', '2013-10-12 23:15:34');

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES ('1', 'a');
INSERT INTO `friend` VALUES ('2', 'b');
INSERT INTO `friend` VALUES ('3', 'c');
INSERT INTO `friend` VALUES ('4', 'd');
INSERT INTO `friend` VALUES ('5', 'e');
INSERT INTO `friend` VALUES ('6', 'f');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  `MAIL` varchar(255) NOT NULL,
  `MESSAGE` mediumtext NOT NULL,
  `DAY` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `productID` int(11) NOT NULL,
  `productName` varchar(50) DEFAULT NULL,
  `productPrice` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', 'aaa', '100');
INSERT INTO `product` VALUES ('2', 'bbb', '200');
INSERT INTO `product` VALUES ('3', 'ccc', '300');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `reply_no` bigint(19) NOT NULL AUTO_INCREMENT,
  `comment_no` bigint(19) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  `reply_content` varchar(300) NOT NULL,
  `reg_date` datetime NOT NULL,
  PRIMARY KEY (`reply_no`),
  UNIQUE KEY `XPKnwc_reply` (`reply_no`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES ('1', '1', 'user1', 'ëŒ“ê¸€1_1', '2012-04-13 15:05:49');
INSERT INTO `reply` VALUES ('2', '1', 'user1', 'ëŒ“ê¸€1_2', '2012-04-13 15:05:52');
INSERT INTO `reply` VALUES ('3', '1', 'user1', 'ëŒ“ê¸€1_3', '2012-04-13 15:05:54');
INSERT INTO `reply` VALUES ('4', '1', 'user1', 'ëŒ“ê¸€1_4', '2012-04-13 15:05:55');
INSERT INTO `reply` VALUES ('5', '2', 'user1', 'ëŒ“ê¸€1_5', '2012-04-13 15:06:03');
INSERT INTO `reply` VALUES ('6', '3', 'user2', 'ëŒ“ê¸€2_1', '2012-04-13 15:06:10');
INSERT INTO `reply` VALUES ('7', '3', 'user2', 'ëŒ“ê¸€2_2', '2012-04-13 15:06:12');
INSERT INTO `reply` VALUES ('8', '3', 'user2', 'ëŒ“ê¸€2_3', '2012-04-13 15:06:13');
INSERT INTO `reply` VALUES ('9', '3', 'user2', 'ëŒ“ê¸€2_4', '2012-04-13 15:06:15');
INSERT INTO `reply` VALUES ('10', '4', 'user2', 'ëŒ“ê¸€2_5', '2012-04-13 15:06:21');
INSERT INTO `reply` VALUES ('11', '4', 'user2', 'ëŒ“ê¸€2_6', '2012-04-13 15:06:22');
INSERT INTO `reply` VALUES ('12', '5', 'user3', 'ëŒ“ê¸€3_1', '2012-04-13 15:06:31');
INSERT INTO `reply` VALUES ('13', '5', 'user3', 'ëŒ“ê¸€3_2', '2012-04-13 15:06:33');
INSERT INTO `reply` VALUES ('14', '6', 'user3', 'ëŒ“ê¸€3_3', '2012-04-13 15:06:38');
INSERT INTO `reply` VALUES ('15', '6', 'user3', 'ëŒ“ê¸€3_4', '2012-04-13 15:06:40');
INSERT INTO `reply` VALUES ('16', '6', 'user3', 'ëŒ“ê¸€3_5', '2012-04-13 15:06:41');
INSERT INTO `reply` VALUES ('17', '6', 'user3', 'ëŒ“ê¸€3_', '2012-04-13 15:06:42');
INSERT INTO `reply` VALUES ('18', '6', 'user3', 'ëŒ“ê¸€3_6', '2012-04-13 15:06:43');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` varchar(32) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('user1', 'ì‚¬ìš©ìž1');
INSERT INTO `user` VALUES ('user2', 'ì‚¬ìš©ìž2');
INSERT INTO `user` VALUES ('user3', 'ì‚¬ìš©ìž3');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `no` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `content` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('1', 'aaa', 'aaaa', 'aaaa', '10.0.0.1');
INSERT INTO `userinfo` VALUES ('2', 'cccc', 'ccc', 'cccc', '10.0.0.3');
INSERT INTO `userinfo` VALUES ('3', 'bbb', 'bbb', 'bbb', '10.0.0.2');
