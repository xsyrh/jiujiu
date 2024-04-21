/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : jiujiu

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 21/04/2024 01:16:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '收货人',
  `sex` tinyint NOT NULL COMMENT '性别 0 女 1 男',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认 0 否 1是',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '地址管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address_book
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL COMMENT '主键',
  `type` int NULL DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT 0 COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_category_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '菜品及套餐分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1397844263642378242, 1, '感冒用药', 1, '2021-05-27 09:16:58', '2024-04-19 22:14:59', 1, 1759827841190477825);
INSERT INTO `category` VALUES (1397844303408574465, 1, '胃肠道用药', 2, '2021-05-27 09:17:07', '2024-04-20 16:16:18', 1, 1);
INSERT INTO `category` VALUES (1397844391040167938, 1, '维生素矿物类', 3, '2021-05-27 09:17:28', '2024-04-20 02:04:24', 1, 1);
INSERT INTO `category` VALUES (1413341197421846529, 1, '儿科用药', 4, '2021-07-09 11:36:15', '2024-04-20 16:17:42', 1, 1);
INSERT INTO `category` VALUES (1413342269393674242, 2, '感冒用药组合', 7, '2021-07-09 11:40:30', '2024-04-20 19:58:14', 1, 1781364046403870722);
INSERT INTO `category` VALUES (1413384954989060097, 1, '保健药品', 5, '2021-07-09 14:30:07', '2024-04-20 19:59:12', 1, 1781364046403870722);
INSERT INTO `category` VALUES (1413386191767674881, 2, '儿童用药组合', 8, '2021-07-09 14:35:02', '2024-04-20 19:58:42', 1, 1781364046403870722);
INSERT INTO `category` VALUES (1781621216051601409, 1, '五官科用药', 6, '2024-04-20 17:49:33', '2024-04-20 17:49:33', 1, 1);
INSERT INTO `category` VALUES (1781653798894153730, 2, '保健药品组合', 9, '2024-04-20 19:59:02', '2024-04-20 19:59:02', 1781364046403870722, 1781364046403870722);

-- ----------------------------
-- Table structure for combination
-- ----------------------------
DROP TABLE IF EXISTS `combination`;
CREATE TABLE `combination`  (
  `id` bigint NOT NULL COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '药品分类id',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '组合名称',
  `price` decimal(10, 2) NOT NULL COMMENT '组合价格',
  `status` int NULL DEFAULT NULL COMMENT '状态 0:停用 1:启用',
  `code` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '编码',
  `description` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_combination_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '套餐' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of combination
-- ----------------------------
INSERT INTO `combination` VALUES (1781654800267456513, 1413386191767674881, '儿童感冒药', 5500.00, 1, '', '', 'e1a3044b-a6c1-48a2-a8c8-6d4a6050f03c.jpg', '2024-04-20 20:03:01', '2024-04-20 20:50:15', 1781364046403870722, 1, 0);
INSERT INTO `combination` VALUES (1781655094388830210, 1413342269393674242, '普通感冒药组合', 5500.00, 1, '', '', 'f6a4a8ba-d416-4646-a050-084275e5cf81.jpg', '2024-04-20 20:04:11', '2024-04-20 20:04:11', 1781364046403870722, 1781364046403870722, 0);
INSERT INTO `combination` VALUES (1781675333846622210, 1781653798894153730, '保健品组合包', 35000.00, 1, '', '', '9f1de3da-871d-4bf3-aaa7-7e04aa4b21b1.jpg', '2024-04-20 21:24:36', '2024-04-20 21:24:36', 1, 1, 0);
INSERT INTO `combination` VALUES (1781676033599135745, 1781653798894153730, '国际保健品组合', 70000.00, 1, '', '', 'e6971dfc-0c68-4968-b42f-a7e5f02cc43a.jpg', '2024-04-20 21:27:23', '2024-04-20 21:27:23', 1, 1, 0);

-- ----------------------------
-- Table structure for combination_drug
-- ----------------------------
DROP TABLE IF EXISTS `combination_drug`;
CREATE TABLE `combination_drug`  (
  `id` bigint NOT NULL COMMENT '主键',
  `combination_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '组合id ',
  `drug_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '药品id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '药品名称（冗余字段）',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '药品原价（冗余字段）',
  `copies` int NOT NULL COMMENT '份数',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '套餐菜品关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of combination_drug
-- ----------------------------
INSERT INTO `combination_drug` VALUES (1781655094388830211, '1781655094388830210', '1397849739276890114', '感冒清热颗粒', 2570.00, 1, 0, '2024-04-20 20:04:11', '2024-04-20 20:04:11', 1781364046403870722, 1781364046403870722, 0);
INSERT INTO `combination_drug` VALUES (1781655094388830212, '1781655094388830210', '1397851099502260226', '999感冒灵胶囊', 2000.00, 1, 0, '2024-04-20 20:04:11', '2024-04-20 20:04:11', 1781364046403870722, 1781364046403870722, 0);
INSERT INTO `combination_drug` VALUES (1781655094388830213, '1781655094388830210', '1397850851245600769', '感冒止咳胶囊', 650.00, 1, 0, '2024-04-20 20:04:11', '2024-04-20 20:04:11', 1781364046403870722, 1781364046403870722, 0);
INSERT INTO `combination_drug` VALUES (1781655094388830214, '1781655094388830210', '1397851370462687234', '感冒疏风片', 790.00, 1, 0, '2024-04-20 20:04:11', '2024-04-20 20:04:11', 1781364046403870722, 1781364046403870722, 0);
INSERT INTO `combination_drug` VALUES (1781666687621214210, '1781654800267456513', '1781612023206780929', '健儿清解液', 2490.00, 1, 0, '2024-04-20 20:50:15', '2024-04-20 20:50:15', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781666687621214211, '1781654800267456513', '1781604124493488130', '小儿化痰止咳颗粒', 3500.00, 1, 0, '2024-04-20 20:50:15', '2024-04-20 20:50:15', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781666687621214212, '1781654800267456513', '1781603540491182082', '小儿消食片', 781.00, 1, 0, '2024-04-20 20:50:15', '2024-04-20 20:50:15', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781666687621214213, '1781654800267456513', '1413342036832100354', '小儿感冒颗粒_瑞药', 1320.00, 1, 0, '2024-04-20 20:50:15', '2024-04-20 20:50:15', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781666687621214214, '1781654800267456513', '1413384757047271425', '健儿乐颗粒', 2500.00, 1, 0, '2024-04-20 20:50:15', '2024-04-20 20:50:15', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781675333913731073, '1781675333846622210', '1781619186784411650', '来益牌叶黄素咀嚼片', 12800.00, 1, 0, '2024-04-20 21:24:36', '2024-04-20 21:24:36', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781675333913731074, '1781675333846622210', '1781619912138956802', '益生菌粉', 8000.00, 1, 0, '2024-04-20 21:24:36', '2024-04-20 21:24:36', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781675333913731075, '1781675333846622210', '1781617563676844033', '鱼油软胶囊', 17100.00, 1, 0, '2024-04-20 21:24:36', '2024-04-20 21:24:36', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781675333913731076, '1781675333846622210', '1781616304202850306', 'RB族维生素片', 3000.00, 2, 0, '2024-04-20 21:24:36', '2024-04-20 21:24:36', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781676033599135746, '1781676033599135745', '1781618736437796865', '汤臣倍健牛初乳加钙咀嚼片', 11990.00, 2, 0, '2024-04-20 21:27:23', '2024-04-20 21:27:23', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781676033599135747, '1781676033599135745', '1781619186784411650', '来益牌叶黄素咀嚼片', 12800.00, 1, 0, '2024-04-20 21:27:23', '2024-04-20 21:27:23', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781676033599135748, '1781676033599135745', '1781617193521127426', '香丹清牌珂妍胶囊', 39800.00, 1, 0, '2024-04-20 21:27:23', '2024-04-20 21:27:23', 1, 1, 0);
INSERT INTO `combination_drug` VALUES (1781676033599135749, '1781676033599135745', '1744633842800631809', '氨糖软骨素钙片', 12900.00, 1, 0, '2024-04-20 21:27:23', '2024-04-20 21:27:23', 1, 1, 0);

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '药品名称',
  `category_id` bigint NOT NULL COMMENT '药品分类id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '药品价格',
  `code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '商品码',
  `image` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '图片',
  `description` varchar(400) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '描述信息',
  `status` int NOT NULL DEFAULT 1 COMMENT '0 停售 1 起售',
  `sort` int NOT NULL DEFAULT 0 COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_drug_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '菜品管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of drug
-- ----------------------------
INSERT INTO `drug` VALUES (1397849739276890114, '感冒清热颗粒', 1397844263642378242, 2570.00, '222222222', 'ec65f5a4-edf5-45dc-8b4a-172baf865e04.jpg', '疏风散寒，解表清热。用于风寒感冒，头痛发热，恶寒身痛，鼻流清涕，咳嗽咽干。', 1, 0, '2021-05-27 09:38:43', '2024-04-19 18:49:26', 1, 1, 0);
INSERT INTO `drug` VALUES (1397850140982161409, '小儿感冒颗粒', 1397844263642378242, 1320.00, '123412341234', '9f56f371-a6bd-43cb-9eb4-1c5a05d1af59.jpg', '疏风解表，清热解毒。用于小儿风热感冒，症见发热、头胀痛、咳嗽痰黏、咽喉肿痛；流感见上述证候者。', 1, 0, '2021-05-27 09:40:19', '2024-04-19 18:46:57', 1, 1, 0);
INSERT INTO `drug` VALUES (1397850392090947585, '黄石感冒片', 1397844263642378242, 1300.00, '123412341234', '781f921d-cc0c-4b58-848f-4cf88c4c255c.jpg', '清热解毒，止咳化痰。用于感冒，咽炎、扁桃体炎、支气管炎咳嗽。', 1, 0, '2021-05-27 09:41:19', '2024-04-19 18:45:00', 1, 1, 0);
INSERT INTO `drug` VALUES (1397850851245600769, '感冒止咳胶囊', 1397844263642378242, 650.00, '123412341234', '80c206de-6c55-46ba-8c7e-1e56081f0fd3.jpg', '解表清热，止咳化痰。用于感冒或流感发热，头痛鼻塞，伤风咳嗽，咽痛，肢痛。', 1, 0, '2021-05-27 09:43:08', '2024-04-19 18:37:21', 1, 1, 0);
INSERT INTO `drug` VALUES (1397851099502260226, '999感冒灵胶囊', 1397844263642378242, 2000.00, '23412341234', 'd92aa0cd-f30a-414a-9f1d-8897988c74e5.jpg', '解热镇痛。用于感冒引起的头痛，发热，鼻塞。流涕，咽痛等。', 1, 0, '2021-05-27 09:44:08', '2024-04-19 18:38:57', 1, 1, 0);
INSERT INTO `drug` VALUES (1397851370462687234, '感冒疏风片', 1397844263642378242, 790.00, '1246812345678', '1e9b4e51-aa8d-4cb3-9fe1-01f31a2f8604.jpg', '辛温解表，宣肺和中。用于风寒感冒，发热咳嗽，头痛怕冷，鼻流清涕，骨节酸痛，四肢疲倦。', 1, 0, '2021-05-27 09:45:12', '2024-04-19 18:37:02', 1, 1, 0);
INSERT INTO `drug` VALUES (1397851668262465537, '复方感冒灵片', 1397844263642378242, 1080.00, '1234567812345678', '0d91838c-dea9-4e48-a189-9ec8df5c9814.jpg', '复方感冒灵片，辛凉解表，清热解毒。 用于风热感冒之发热，微恶风寒，头身痛，口干而渴，鼻塞涕浊，咽喉红肿疼痛，咳嗽，痰黄粘稠。', 1, 0, '2021-05-27 09:46:23', '2024-04-19 18:26:45', 1, 1, 0);
INSERT INTO `drug` VALUES (1397852391150759938, '藿香清胃片', 1397844303408574465, 1380.00, '2346812468', 'c95bb61f-5da1-442d-8a2f-2f916adbe189.jpg', '清热化湿，醒脾消滞。用于消化不良，脘腹胀满，不思饮食、口苦口臭。', 1, 0, '2021-05-27 09:49:16', '2024-04-19 20:58:48', 1, 1, 0);
INSERT INTO `drug` VALUES (1397853183287013378, '肝胃气痛片', 1397844303408574465, 990.00, '123456787654321', '4c490916-bc58-42a6-b70e-ab08cf98e2c0.jpg', '健胃制酸。用于肝胃不和所致的胃胀反酸作痛，积食停滞，食欲不振。', 1, 0, '2021-05-27 09:52:24', '2024-04-19 20:55:33', 1, 1, 0);
INSERT INTO `drug` VALUES (1397853709101740034, '海洋胃药', 1397844303408574465, 2000.00, '1234321234321', '00907bb9-843f-4901-837d-31ea57d846fe.jpg', '益气健脾，温中止痛。用于脾胃虚弱，胃寒作痛，泛酸。\n', 1, 0, '2021-05-27 09:54:30', '2024-04-19 20:53:07', 1, 1, 0);
INSERT INTO `drug` VALUES (1397853890262118402, '胃康灵胶囊', 1397844303408574465, 3500.00, '1234212321234', '82e27292-9e41-4aa7-ba7b-f7e3b1a7fdfc.jpg', '柔肝和胃，散瘀，缓急止痛。用于肝胃不和、瘀血阻络所致的胃脘疼痛、连及两胁、嗳气、泛酸；慢性胃炎见上述证候者。', 1, 0, '2021-05-27 09:55:13', '2024-04-19 20:50:50', 1, 1, 0);
INSERT INTO `drug` VALUES (1397854652581064706, '三九胃泰颗粒', 1397844303408574465, 1700.00, '2345312·345321', '07f33b89-42d0-4a9e-90bc-6bce82c39ad8.jpg', '清热燥湿，行气活血，柔肝止痛。用于湿热内蕴、气滞血瘀所致的胃痛，症见脘腹隐痛、饱胀反酸、恶心呕吐、嘈杂纳减；浅表性胃炎见上述证候者。', 1, 0, '2021-05-27 09:58:15', '2024-04-19 20:48:27', 1, 1, 0);
INSERT INTO `drug` VALUES (1397854865672679425, '健胃消食片', 1397844303408574465, 3500.00, '23456431·23456', '8c076f9b-693f-4f8d-b758-7db95d62762d.jpg', '健胃消食。用于脾胃虚弱所致的食积，症见不思饮食、嗳腐酸臭、脘腹胀满；消化不良见上述证候者。', 1, 0, '2021-05-27 09:59:06', '2024-04-19 20:45:09', 1, 1, 0);
INSERT INTO `drug` VALUES (1397860242057375745, '果维康维生素C含片', 1397844391040167938, 2240.00, '123456786543213456', 'e82c4e80-af1a-4169-8a65-96daffbca9e1.jpg', '1、本品不能代替药物；2、不宜超过推荐量或与同类营养素补充剂同时食用', 1, 0, '2021-05-27 10:20:27', '2024-04-20 02:28:06', 1, 1, 0);
INSERT INTO `drug` VALUES (1397860578738352129, '维生素c注射液', 1397844391040167938, 2890.00, '12345678654', '9abe8ccb-0cc9-4ae7-8f8a-a947a4dcd494.jpg', '1.用于治疗坏血病，也可用于各种急慢性传染性疾病及紫癜等辅助治疗。2.慢性铁中毒的治疗：维生素C促进去铁胺对铁的螯合，使铁排出加速。3.特发性高铁血红蛋白症的治疗。4.下列情况对维生素C的需要量增加：（1）病人接受慢性血液透析、胃肠道疾病（长期腹泻、胃或回肠切除术后）、结核病、癌症、溃疡病、甲状腺功能亢进、发热、感染、创伤、烧伤、手术等；（2）因严格控制或选择饮食，接受肠道外营养的病人，因营养不良', 1, 0, '2021-05-27 10:21:48', '2024-04-20 02:24:16', 1, 1, 0);
INSERT INTO `drug` VALUES (1397860792492666881, '维生素D2软胶囊', 1397844391040167938, 5000.00, '213456432123456', 'd99ac94d-f583-41ef-9a2f-c9f6e23acdd4.jpg', '1用于维生素D缺乏症的预防与治疗。如：绝对素食者、肠外营养病人、胰腺功能不全伴吸收不良综合征、肝胆疾病（肝功能损害、肝硬化、阻塞性黄疸）、小肠疾病（脂性腹泻、局限性肠炎、长期腹泻）、胃切除等。2用于慢性低钙血症、低磷血症、佝偻病及伴有慢性肾功能不全的骨软化症、家族性低磷血症及甲状旁腺功能低下（术后、特发性或假性甲状旁腺功能低下）的治疗。3用于治疗急、慢性及潜在手术后手足搐搦症及特发性手足搐搦症。', 1, 0, '2021-05-27 10:22:39', '2024-04-20 02:22:14', 1, 1, 0);
INSERT INTO `drug` VALUES (1397860963880316929, '复合维生素B片', 1397844391040167938, 4500.00, '1234563212345', 'ce23efd3-3ade-4427-8ee5-731866aff778.jpg', '维生素B1是糖代谢所需辅酶的重要组成成份。维生素B2为组织呼吸所需的重要辅酶组成成份，烟酰胺为辅酶I及II的组分，脂质代谢，组织呼吸的氧化作用所必需。维生素B6为多种酶的辅基，参与氨基酸及脂肪的代谢。泛酸钙为辅酶A的组分，参与糖、脂肪、蛋白质的代谢。', 1, 0, '2021-05-27 10:23:19', '2024-04-20 02:20:02', 1, 1, 0);
INSERT INTO `drug` VALUES (1397861683434139649, '天然维生素E软胶囊', 1397844391040167938, 4000.00, '1234567876543213456', '625c74a4-6da6-4d15-bb34-72d12fe9377a.jpg', '', 1, 0, '2021-05-27 10:26:11', '2024-04-20 02:17:19', 1, 1, 0);
INSERT INTO `drug` VALUES (1397862198033297410, '维生素 C片', 1397844391040167938, 1800.00, '123456786532455', 'd3c3f074-7103-44fd-a919-de5fd633dc70.jpg', '维生素C参与氨基酸代谢、神经递质的合成、胶原蛋白和组织细胞间质的合成，可降低毛细血管的通透性，加速血液的凝固，刺激凝血功能，促进铁在肠内吸收，促使血脂下降，增加对感染的抵抗力，参与解毒功能，且有抗组胺的作用及阻止致癌物质(亚硝胺)生成的作用。\n', 1, 0, '2021-05-27 10:28:14', '2024-04-20 02:14:14', 1, 1, 0);
INSERT INTO `drug` VALUES (1397862477831122945, '维生素B1', 1397844391040167938, 1300.00, '1234567865432', 'f4c95dcf-b743-431c-ae1e-6a81519dd5fd.jpg', '1.维生素B1缺乏的预防和治疗，如“脚气病”，周围神经炎及消化不良。2.妊娠或哺乳期，甲状腺功能亢进，烧伤，长期慢性感染，重体力劳动，吸收不良综合症伴肝胆疾病，小肠系统疾病及胃切除后维生素B1的补充。', 1, 0, '2021-05-27 10:29:20', '2024-04-20 02:09:48', 1, 1, 0);
INSERT INTO `drug` VALUES (1413342036832100354, '小儿感冒颗粒_瑞药', 1413341197421846529, 1320.00, '', 'f73c2dae-9b71-49bd-8821-f866a5be4c8a.jpg', '疏风解表，清热解毒。用于小儿风热感冒，症见发热、头胀痛、咳嗽痰黏、咽喉肿痛；流感见上述证候者。', 1, 0, '2021-07-09 11:39:35', '2024-04-20 16:34:32', 1, 1, 0);
INSERT INTO `drug` VALUES (1413384757047271425, '健儿乐颗粒', 1413341197421846529, 2500.00, '', '47186bb8-2ef0-4afb-a467-53298ba4a80e.jpg', '清热平肝，清心除烦，健脾消食。用于儿童夜眠不宁，消化不良。', 1, 0, '2021-07-09 14:29:20', '2024-04-20 16:20:10', 1, 1, 0);
INSERT INTO `drug` VALUES (1744633842800631809, '氨糖软骨素钙片', 1413384954989060097, 12900.00, '', 'fc0853a2-51c1-477b-bfc9-3bdb0caad5eb.jpg', '主要原料：碳酸钙、D-氨基葡萄糖硫酸钾盐、硫酸软骨素、酪蛋白磷酸肽、骨碎补提取物、微晶纤维素、低取代羟丙纤维素、羧甲淀粉钠、二氧化硅、硬脂酸镁、羟丙甲纤维素、滑石粉、三乙酸甘油酯', 1, 0, '2024-01-09 16:14:57', '2024-04-20 17:23:24', 1, 1, 0);
INSERT INTO `drug` VALUES (1781603167672082433, '婴儿健脾颗粒', 1413341197421846529, 2000.00, '', '26a1dbb1-2985-48f1-8db7-cf5a9fd78d85.jpg', '用于婴儿非感染性腹泻属脾虚挟滞证候者，证见：大便次数增多，粪质稀，气臭，含有未化之物，面色不华，乳食少进，腹胀腹痛，睡眠不宁。', 1, 0, '2024-04-20 16:37:50', '2024-04-20 16:37:50', 1, 1, 0);
INSERT INTO `drug` VALUES (1781603540491182082, '小儿消食片', 1413341197421846529, 781.00, '', '9b4236c8-2e45-4896-af08-a71852266f4b.jpg', '用于脾胃不和，消化不良，食欲不振，便秘，食滞，疳积。', 1, 0, '2024-04-20 16:39:19', '2024-04-20 16:39:19', 1, 1, 0);
INSERT INTO `drug` VALUES (1781604124493488130, '小儿化痰止咳颗粒', 1413341197421846529, 3500.00, '', 'd698b789-5450-40a2-9ceb-36cf431e106f.jpg', '1 本品不应与优降宁等单胺氧化酶抑制剂合用。 2 本品不应与磺胺嘧啶、呋喃妥因同用。 3 本品不应与洋地黄类药物同用。 4 如与其他药物同时使用可能会发生药物相互作用，详情请咨询医师或药师。', 1, 0, '2024-04-20 16:41:39', '2024-04-20 16:41:39', 1, 1, 0);
INSERT INTO `drug` VALUES (1781612023206780929, '健儿清解液', 1413341197421846529, 2490.00, '', '4d00c711-bf02-447e-87b4-13841c6723d9.jpg', '清热解毒，祛痰止咳，消滞和中。用于口腔糜烂，咳嗽咽痛，食欲不振，脘腹胀满等症。小儿咳喘。', 1, 0, '2024-04-20 17:13:02', '2024-04-20 17:15:12', 1, 1, 0);
INSERT INTO `drug` VALUES (1781612484878016513, '小儿秘通口服液', 1413341197421846529, 1698.00, '', '62ab7323-f783-4c8f-8c3e-0a7b3f13e6d5.jpg', '润肠通便，消食健胃。用于功能性便秘。', 1, 0, '2024-04-20 17:14:52', '2024-04-20 17:14:52', 1, 1, 0);
INSERT INTO `drug` VALUES (1781615687812128770, '儿童益生菌冲剂', 1413384954989060097, 4900.00, '', '62029e01-f472-4ca0-8de6-99c35f88e9fe.jpg', '1.法国进口，专为儿童及婴幼儿配制；2.采用天然菌种，不会对人体产生任何副作用；3.富含嗜酸乳杆菌，婴儿双歧杆菌，两歧双歧杆菌。这些菌在人体肠道内占益生菌3的95%，它们在维护整个肠道的微生态平衡中起主要作用。', 1, 0, '2024-04-20 17:27:35', '2024-04-20 17:27:35', 1, 1, 0);
INSERT INTO `drug` VALUES (1781616304202850306, 'RB族维生素片', 1413384954989060097, 3000.00, '', '9f0f591b-abd7-4f13-ab69-d8d6f6f38a94.jpg', '主要原料：维生素B1、维生素B2、维生素B6、D-泛酸钙、烟酸、糊精、麦芽糊精、硬脂酸镁、白砂糖、食用玉米淀粉、羧甲淀粉钠、微晶纤维素、羟丙甲纤维素、聚乙二醇、滑石粉、二氧化钛、日落黄\n', 1, 0, '2024-04-20 17:30:02', '2024-04-20 17:30:02', 1, 1, 0);
INSERT INTO `drug` VALUES (1781617193521127426, '香丹清牌珂妍胶囊', 1413384954989060097, 39800.00, '', '520f7690-08df-400e-84fb-bb053ccff50a.jpg', '改善胃肠道功能(润肠通便)、美容(祛黄褐斑)', 1, 0, '2024-04-20 17:33:34', '2024-04-20 17:33:34', 1, 1, 0);
INSERT INTO `drug` VALUES (1781617563676844033, '鱼油软胶囊', 1413384954989060097, 17100.00, '', '4c016525-5074-4f4b-b6ef-6153dfdf6255.jpg', '辅助降血脂', 1, 0, '2024-04-20 17:35:03', '2024-04-20 17:35:03', 1, 1, 0);
INSERT INTO `drug` VALUES (1781618736437796865, '汤臣倍健牛初乳加钙咀嚼片', 1413384954989060097, 11990.00, '', '61027f41-305c-4aae-b160-a217e194f6d8.jpg', '增强免疫力', 1, 0, '2024-04-20 17:39:42', '2024-04-20 17:39:42', 1, 1, 0);
INSERT INTO `drug` VALUES (1781619186784411650, '来益牌叶黄素咀嚼片', 1413384954989060097, 12800.00, '', 'e72a4599-9f44-417b-a199-c43fbcd80399.jpg', '缓解视疲劳', 1, 0, '2024-04-20 17:41:30', '2024-04-20 17:41:30', 1, 1, 0);
INSERT INTO `drug` VALUES (1781619912138956802, '益生菌粉', 1413384954989060097, 8000.00, '', '5946a401-8b1e-40ea-a456-706c7184d371.jpg', '增强免疫力、调节肠道菌群', 1, 0, '2024-04-20 17:44:23', '2024-04-20 17:44:23', 1, 1, 0);
INSERT INTO `drug` VALUES (1781620273339834369, '褪黑素片', 1413384954989060097, 8800.00, '', '2b8b1ded-9338-4e19-a2b0-da01251d384f.jpg', '改善睡眠', 1, 0, '2024-04-20 17:45:49', '2024-04-20 17:45:49', 1, 1, 0);
INSERT INTO `drug` VALUES (1781621758714847234, '复方托吡卡胺滴眼液', 1781621216051601409, 13400.00, '', 'd112bb3b-2d71-40c8-88ca-6a609a2bfd80.png', '散瞳药。检查用散瞳及调节麻痹剂。', 1, 0, '2024-04-20 17:51:43', '2024-04-20 17:51:43', 1, 1, 0);
INSERT INTO `drug` VALUES (1781622223666028546, '口炎清颗粒', 1781621216051601409, 2300.00, '', 'b0eea8be-5aa8-4666-986c-2ac4abdb0791.jpg', '滋阴清热，解毒消肿。用于阴虚火旺所致的口腔炎症。', 1, 0, '2024-04-20 17:53:34', '2024-04-20 17:53:34', 1, 1, 0);
INSERT INTO `drug` VALUES (1781622933195464706, '鼻炎灵丸', 1781621216051601409, 8000.00, '', '2bc0cb52-8932-4599-a7ec-c4550223a613.jpg', '透窍消肿，祛风退热。用于慢性鼻窦炎、鼻炎及鼻塞头痛，浊涕臭气，嗅觉失灵等。', 1, 0, '2024-04-20 17:56:23', '2024-04-20 17:56:23', 1, 1, 0);
INSERT INTO `drug` VALUES (1781623374964727810, '妥布霉素滴眼液', 1781621216051601409, 2300.00, '', '56454220-5aa3-4726-abc7-a82dcd388243.png', '本品适用于外眼及附属器敏感菌株感染的局部抗感染治疗。应用妥布霉素时，应注意观察细菌感染的控制情况。', 1, 0, '2024-04-20 17:58:08', '2024-04-20 17:58:08', 1, 1, 0);
INSERT INTO `drug` VALUES (1781623813600845826, '咽炎片', 1781621216051601409, 1320.00, '', '5b60a9cd-3d77-472e-9037-648d09e54737.jpg', '养阴润肺，清热解毒，清利咽喉，镇咳止痒。用于慢性咽炎引起咽干，咽痒，刺激性咳嗽。', 1, 0, '2024-04-20 17:59:53', '2024-04-20 17:59:53', 1, 1, 0);
INSERT INTO `drug` VALUES (1781624564045717505, '诺氟沙星胶囊', 1781621216051601409, 1800.00, '', '2ace7c9d-b428-4f9d-a4e7-ab584e4b3d85.jpg', '适用于敏感菌所致的尿路感染、淋病、前列腺炎、肠道感染和伤寒及其他沙门菌感染。', 1, 0, '2024-04-20 18:02:52', '2024-04-20 18:02:52', 1, 1, 0);
INSERT INTO `drug` VALUES (1781625184039346177, '鼻通宁滴剂', 1781621216051601409, 3400.00, '', 'd4323769-df94-4339-8273-5c50173b4635.jpg', '通利鼻窍。用于鼻塞不通。', 1, 0, '2024-04-20 18:05:20', '2024-04-20 18:05:20', 1, 1, 0);
INSERT INTO `drug` VALUES (1781625915962171394, '滴耳油', 1781621216051601409, 1900.00, '', '5b3d067e-04e2-4c42-88e4-f7a10f249c2a.jpg', '滴耳油清热解毒，消肿止痛，用于肝经湿热上攻耳鸣耳聋，耳内生疮肿痛刺痒，破流脓水久不收敛。', 1, 0, '2024-04-20 18:08:14', '2024-04-20 18:08:14', 1, 1, 0);

-- ----------------------------
-- Table structure for drug_attention
-- ----------------------------
DROP TABLE IF EXISTS `drug_attention`;
CREATE TABLE `drug_attention`  (
  `id` bigint UNSIGNED NOT NULL COMMENT '主键',
  `drug_id` bigint NOT NULL COMMENT '药品',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '注意名称',
  `value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '注意数据list',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '菜品口味关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of drug_attention
-- ----------------------------
INSERT INTO `drug_attention` VALUES (1781268187754508289, 1397851668262465537, '服用次数', '[\"一日三次\"]', '2024-04-19 18:26:45', '2024-04-19 18:26:45', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781269306174058497, 1397850851245600769, '吃药忌口', '[\"吸烟\",\"喝酒\"]', '2024-04-19 18:37:21', '2024-04-19 18:37:21', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781269306174058498, 1397850851245600769, '服用次数', '[\"一日三次\"]', '2024-04-19 18:37:21', '2024-04-19 18:37:21', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781269862749810689, 1397851099502260226, '服用次数', '[\"一日三次\"]', '2024-04-19 18:38:57', '2024-04-19 18:38:57', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781269862749810690, 1397851099502260226, '吃药忌口', '[\"吸烟\",\"喝酒\"]', '2024-04-19 18:38:57', '2024-04-19 18:38:57', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781270776147587074, 1397851370462687234, '服用次数', '[\"一日两次\"]', '2024-04-19 18:37:02', '2024-04-19 18:37:02', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781270776147587075, 1397851370462687234, '禁用人群', '[\"老年人\",\"孕妇\",\"儿童\"]', '2024-04-19 18:37:02', '2024-04-19 18:37:02', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781272778831278081, 1397850392090947585, '服用次数', '[\"一日三次\"]', '2024-04-19 18:45:00', '2024-04-19 18:45:00', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781272778831278082, 1397850392090947585, '吃药忌口', '[\"吸烟\",\"喝酒\"]', '2024-04-19 18:45:00', '2024-04-19 18:45:00', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781273269946527746, 1397850140982161409, '服用次数', '[\"一日两次\"]', '2024-04-19 18:46:57', '2024-04-19 18:46:57', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781273738039242753, 1397849739276890114, '服用次数', '[\"一日两次\"]', '2024-04-19 18:49:26', '2024-04-19 18:49:26', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781273738039242754, 1397849739276890114, '吃药忌口', '[\"吸烟\",\"喝酒\"]', '2024-04-19 18:49:26', '2024-04-19 18:49:26', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781303016143405058, 1397854865672679425, '服用次数', '[\"一日三次\"]', '2024-04-19 20:45:09', '2024-04-19 20:45:09', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781303847655784450, 1397854652581064706, '服用次数', '[\"一日两次\"]', '2024-04-19 20:48:27', '2024-04-19 20:48:27', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781304447294455809, 1397853890262118402, '服用次数', '[\"一日三次\"]', '2024-04-19 20:50:50', '2024-04-19 20:50:50', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781304447294455810, 1397853890262118402, '吃药忌口', '[\"喝酒\"]', '2024-04-19 20:50:50', '2024-04-19 20:50:50', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781305022102847489, 1397853709101740034, '服用次数', '[\"一日三次\"]', '2024-04-19 20:53:07', '2024-04-19 20:53:07', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781305634567700481, 1397853183287013378, '服用次数', '[\"一日三次\"]', '2024-04-19 20:55:33', '2024-04-19 20:55:33', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781305634567700482, 1397853183287013378, '禁用人群', '[\"孕妇\"]', '2024-04-19 20:55:33', '2024-04-19 20:55:33', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781306451844612097, 1397852391150759938, '服用次数', '[\"一日三次\"]', '2024-04-19 20:58:48', '2024-04-19 20:58:48', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781385834773045250, 1397862198033297410, '服药方式', '[\"\"]', '2024-04-20 02:14:14', '2024-04-20 02:14:14', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781386608106233858, 1397861683434139649, '服用次数', '[\"一日两次\"]', '2024-04-20 02:17:19', '2024-04-20 02:17:19', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781386608106233859, 1397861683434139649, '服药方式', '[\"喝水送服\"]', '2024-04-20 02:17:19', '2024-04-20 02:17:19', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781387291672928258, 1397860963880316929, '服用次数', '[\"一日三次\"]', '2024-04-20 02:20:02', '2024-04-20 02:20:02', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781598720011264001, 1413384757047271425, '服用次数', '[\"一日三次\"]', '2024-04-20 16:20:10', '2024-04-20 16:20:10', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781602335912288257, 1413342036832100354, '服用次数', '[\"一日两次\"]', '2024-04-20 16:34:32', '2024-04-20 16:34:32', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781603167684665346, 1781603167672082433, '服用次数', '[\"一日两次\"]', '2024-04-20 16:37:50', '2024-04-20 16:37:50', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781603540491182083, 1781603540491182082, '服用次数', '[\"一日三次\"]', '2024-04-20 16:39:19', '2024-04-20 16:39:19', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781604124493488131, 1781604124493488130, '服用次数', '[\"一日三次\"]', '2024-04-20 16:41:39', '2024-04-20 16:41:39', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781612484878016514, 1781612484878016513, '服用次数', '[\"一日两次\"]', '2024-04-20 17:14:52', '2024-04-20 17:14:52', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781612569414213634, 1781612023206780929, '服药方式', '[\"口服\"]', '2024-04-20 17:15:12', '2024-04-20 17:15:12', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781612569414213635, 1781612023206780929, '服用次数', '[\"一日两次\"]', '2024-04-20 17:15:12', '2024-04-20 17:15:12', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781614631489249281, 1744633842800631809, '服用次数', '[\"一日两次\"]', '2024-04-20 17:23:24', '2024-04-20 17:23:24', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781616304269959170, 1781616304202850306, '服药方式', '[\"喝水送服\"]', '2024-04-20 17:30:02', '2024-04-20 17:30:02', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781616304269959171, 1781616304202850306, '服用次数', '[\"一日一次\"]', '2024-04-20 17:30:02', '2024-04-20 17:30:02', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781617193521127427, 1781617193521127426, '服用次数', '[\"一日两次\"]', '2024-04-20 17:33:34', '2024-04-20 17:33:34', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781618736437796866, 1781618736437796865, '服用次数', '[\"一日一次\"]', '2024-04-20 17:39:42', '2024-04-20 17:39:42', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781619186784411651, 1781619186784411650, '服用次数', '[\"一日一次\"]', '2024-04-20 17:41:30', '2024-04-20 17:41:30', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781619912138956803, 1781619912138956802, '服用次数', '[\"一日两次\"]', '2024-04-20 17:44:23', '2024-04-20 17:44:23', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781620273339834370, 1781620273339834369, '服用次数', '[\"一日一次\"]', '2024-04-20 17:45:49', '2024-04-20 17:45:49', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781621758777761793, 1781621758714847234, '禁用人群', '[\"老年人\",\"孕妇\",\"婴儿\"]', '2024-04-20 17:51:43', '2024-04-20 17:51:43', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781622223666028547, 1781622223666028546, '服用次数', '[\"一日两次\"]', '2024-04-20 17:53:34', '2024-04-20 17:53:34', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781622223666028548, 1781622223666028546, '吃药忌口', '[\"吸烟\",\"喝酒\"]', '2024-04-20 17:53:34', '2024-04-20 17:53:34', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781622223666028549, 1781622223666028546, '禁用人群', '[\"孕妇\",\"哺乳期妇女\",\"婴儿\"]', '2024-04-20 17:53:34', '2024-04-20 17:53:34', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781622933195464707, 1781622933195464706, '服用次数', '[\"一日三次\"]', '2024-04-20 17:56:23', '2024-04-20 17:56:23', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781623374964727811, 1781623374964727810, '服用次数', '[\"一日两次\"]', '2024-04-20 17:58:08', '2024-04-20 17:58:08', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781623374964727812, 1781623374964727810, '禁用人群', '[\"老年人\"]', '2024-04-20 17:58:08', '2024-04-20 17:58:08', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781623813600845827, 1781623813600845826, '禁用人群', '[\"孕妇\",\"儿童\"]', '2024-04-20 17:59:53', '2024-04-20 17:59:53', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781624564112826370, 1781624564045717505, '服用次数', '[\"一日两次\"]', '2024-04-20 18:02:52', '2024-04-20 18:02:52', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781624564112826371, 1781624564045717505, '禁用人群', '[\"老年人\",\"孕妇\",\"哺乳期妇女\",\"儿童\"]', '2024-04-20 18:02:52', '2024-04-20 18:02:52', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781624564112826372, 1781624564045717505, '服药方式', '[\"喝水送服\"]', '2024-04-20 18:02:52', '2024-04-20 18:02:52', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781625184039346178, 1781625184039346177, '服用次数', '[\"一日两次\"]', '2024-04-20 18:05:20', '2024-04-20 18:05:20', 1, 1, 0);
INSERT INTO `drug_attention` VALUES (1781625915962171395, 1781625915962171394, '服用次数', '[\"一日四次\"]', '2024-04-20 18:08:14', '2024-04-20 18:08:14', 1, 1, 0);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT 1 COMMENT '状态 0:禁用，1:正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建人',
  `update_user` bigint NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '员工信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', 1, '2021-05-06 17:20:07', '2021-05-10 02:24:09', 1, 1);
INSERT INTO `employee` VALUES (1781678023133749249, '111', '111', 'e10adc3949ba59abbe56e057f20f883e', '13344556677', '1', '130324166276776542', 1, '2024-04-20 21:35:17', '2024-04-20 21:35:17', 1759827841190477825, 1759827841190477825);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '名字',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `drug_id` bigint NULL DEFAULT NULL COMMENT '药品id',
  `combination_id` bigint NULL DEFAULT NULL COMMENT '组合id',
  `drug_attention` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '注意',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1781677428981227522, '益生菌粉', '5946a401-8b1e-40ea-a456-706c7184d371.jpg', 1781677428981227521, 1781619912138956802, NULL, '', 1, 80.00);
INSERT INTO `order_detail` VALUES (1781677428981227523, '来益牌叶黄素咀嚼片', 'e72a4599-9f44-417b-a199-c43fbcd80399.jpg', 1781677428981227521, 1781619186784411650, NULL, '', 1, 128.00);
INSERT INTO `order_detail` VALUES (1781732082793213954, '滴耳油', '5b3d067e-04e2-4c42-88e4-f7a10f249c2a.jpg', 1781732082726105090, 1781625915962171394, NULL, '', 1, 19.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT 1 COMMENT '订单状态 1待付款，2待派送，3已派送，4已完成，5已取消',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime NOT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT 1 COMMENT '支付方式 1微信,2支付宝',
  `amount` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `consignee` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1781677428981227521, '1781677428981227521', 2, 1759827841190477825, 1781677405837058049, '2024-04-20 21:32:56', '2024-04-20 21:32:56', 1, 208.00, '', '13344445555', '汤臣一品驳岸是', NULL, '刘');
INSERT INTO `orders` VALUES (1781732082726105090, '1781732082726105090', 2, 1759827841190477825, 1781677405837058049, '2024-04-21 01:10:06', '2024-04-21 01:10:06', 1, 19.00, '', '13344445555', '汤臣一品驳岸是', NULL, '刘');

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '名称',
  `image` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `drug_id` bigint NULL DEFAULT NULL COMMENT '药品id',
  `combination_id` bigint NULL DEFAULT NULL COMMENT '组合id',
  `drug_attention` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '注意',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '购物车' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (1781366274997080066, '黄石感冒片', '781f921d-cc0c-4b58-848f-4cf88c4c255c.jpg', 1781366227068768258, 1397850392090947585, NULL, ',', 1, 13.00, '2024-04-20 00:56:31');
INSERT INTO `shopping_cart` VALUES (1781367789937717249, '小儿感冒颗粒', '9f56f371-a6bd-43cb-9eb4-1c5a05d1af59.jpg', 1781367765656891394, 1397850140982161409, NULL, '一日两次', 1, 13.20, '2024-04-20 01:02:32');
INSERT INTO `shopping_cart` VALUES (1781367805653774337, '黄石感冒片', '781f921d-cc0c-4b58-848f-4cf88c4c255c.jpg', 1781367765656891394, 1397850392090947585, NULL, '一日三次,吸烟', 1, 13.00, '2024-04-20 01:02:36');
INSERT INTO `shopping_cart` VALUES (1781376670466285569, '感冒清热颗粒', 'ec65f5a4-edf5-45dc-8b4a-172baf865e04.jpg', 1781376647041097730, 1397849739276890114, NULL, '一日两次,喝酒', 1, 25.70, '2024-04-20 01:37:49');
INSERT INTO `shopping_cart` VALUES (1781676870123773954, '感冒清热颗粒', 'ec65f5a4-edf5-45dc-8b4a-172baf865e04.jpg', 1, 1397849739276890114, NULL, '', 1, 25.70, '2024-04-20 21:30:42');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '头像',
  `status` int NULL DEFAULT 0 COMMENT '状态 0:禁用，1:正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1759827841190477825, NULL, '13344445555', NULL, NULL, NULL, 1);

SET FOREIGN_KEY_CHECKS = 1;
