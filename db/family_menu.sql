-- MySQL dump 10.13  Distrib 8.4.9, for Win64 (x86_64)
--
-- Host: localhost    Database: family_menu
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dish`
--

DROP TABLE IF EXISTS `dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '菜名',
  `category` varchar(20) NOT NULL COMMENT '分类: 主荤/素菜/汤/凉菜/主食',
  `spicy_level` tinyint DEFAULT '0' COMMENT '辣度 0-3',
  `cook_time` int DEFAULT '30' COMMENT '制作时间(分钟)',
  `kid_friendly` tinyint(1) DEFAULT '0' COMMENT '宝宝能吃',
  `elder_friendly` tinyint(1) DEFAULT '1' COMMENT '老人能吃',
  `description` text COMMENT '做法描述',
  `tags` varchar(500) DEFAULT NULL COMMENT '标签',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '启用',
  `sort_order` int DEFAULT '0' COMMENT '排序',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜谱表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish`
--

LOCK TABLES `dish` WRITE;
/*!40000 ALTER TABLE `dish` DISABLE KEYS */;
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (1,'麻婆豆腐','主荤',3,20,1,0,'豆腐切丁汆水，热锅下油爆香豆瓣、花椒，下肉末炒散，加豆腐烧入味，淋花椒油。','川菜经典,下饭',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (2,'回锅肉','主荤',2,25,1,1,'五花肉煮熟切薄片，热锅煸出油，下豆瓣、甜面酱炒香，加青蒜翻炒。','川菜经典,下饭',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (3,'鱼香肉丝','主荤',2,25,1,1,'肉丝腌制滑油，泡椒、木耳、胡萝卜丝同炒，调鱼香汁勾芡。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (4,'宫保鸡丁','主荤',2,25,1,1,'鸡丁腌制滑油，花椒、干辣椒爆香，加花生米、葱白炒匀。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (5,'水煮肉片','主荤',3,30,0,0,'肉片腌制上浆，豆芽垫底，肉片铺上浇热油和花椒。','川菜经典,麻辣',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (6,'辣子鸡','主荤',3,30,0,0,'鸡块腌制炸干，辣椒花椒爆香，鸡肉回锅炒香。','川菜经典,麻辣',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (7,'夫妻肺片','凉菜',0,20,0,0,'牛肉、牛杂卤熟切薄片，调红油汁拌匀。','凉菜,麻辣',1,0,'2026-10-06 10:13:30','2026-10-06 18:04:04',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (8,'口水鸡','凉菜',0,30,0,0,'鸡腿煮熟冰镇，调麻辣料汁浇上。','凉菜,麻辣',1,0,'2026-10-06 10:13:30','2026-10-06 18:04:04',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (9,'蒜泥白肉','凉菜',0,20,1,1,'五花肉煮熟切薄片，蒜泥、红油、酱油调汁拌匀。','凉菜',1,0,'2026-10-06 10:13:30','2026-10-06 18:04:04',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (10,'粉蒸肉','主荤',2,60,1,1,'五花肉切块裹米粉，蒸 1 小时。','传统,蒸菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (11,'盐煎肉','主荤',2,20,1,1,'五花肉煸出油，下豆瓣、豆豉炒香，加青蒜。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (12,'干煸肉丝','主荤',2,25,1,1,'肉丝煸干水分，豆瓣、姜丝、蒜苗同炒。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (13,'糖醋里脊','主荤',0,30,1,1,'里脊肉裹粉炸两次，糖醋汁翻炒挂匀。','酸甜,下饭',1,0,'2026-10-06 10:13:30','2026-10-06 17:48:46',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (14,'红烧肉','主荤',1,60,1,1,'五花肉切块焯水，糖色炒制，加料酒、酱油、清水炖 50 分钟。','经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (15,'蚂蚁上树','主荤',2,25,1,1,'粉丝泡软，肉末炒香加豆瓣、粉丝翻炒。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (16,'啤酒鸭','主荤',2,50,1,1,'鸭肉切块煸炒，加啤酒、调料焖煮。','下饭',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (17,'泡椒凤爪','凉菜',0,40,1,0,'凤爪焯水冰镇，泡椒水浸泡 24 小时。','凉菜,泡椒',1,0,'2026-10-06 10:13:30','2026-10-06 18:04:04',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (18,'干锅鸡','主荤',3,40,0,0,'鸡肉切块煸炒，洋葱、土豆垫底，干锅上桌。','麻辣,干锅',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (19,'干锅虾','主荤',3,30,0,0,'虾开背煸炒，土豆、芹菜垫底。','麻辣,干锅',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (20,'农家小炒肉','主荤',2,20,1,1,'五花肉煸炒，青红辣椒、豆豉爆香。','下饭',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (21,'梅菜扣肉','主荤',0,90,1,1,'五花肉煮透炸至起虎皮，梅干菜垫底蒸 1 小时。','传统',1,0,'2026-10-06 10:13:30','2026-10-06 17:48:46',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (22,'啤酒鸡翅','主荤',0,30,1,1,'鸡翅煎香，加调料、啤酒焖煮。','下饭',1,0,'2026-10-06 10:13:30','2026-10-06 17:48:46',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (23,'红烧排骨','主荤',1,50,1,1,'排骨焯水，糖色炒制，加香料焖 40 分钟。','经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (24,'糖醋排骨','主荤',0,40,2,1,'排骨炸至外酥，糖醋汁翻炒。','酸甜,经典',1,0,'2026-10-06 10:13:30','2026-10-06 17:48:46',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (25,'椒盐排骨','主荤',1,40,1,1,'排骨腌好炸至外酥，撒椒盐。','经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (26,'香辣猪蹄','主荤',3,90,0,0,'猪蹄焯水卤熟，辣料爆炒。','麻辣,下饭',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (27,'水煮鱼','主荤',3,30,0,0,'鱼片腌制上浆，豆芽垫底，浇热油花椒。','川菜经典,麻辣',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (28,'酸菜鱼','主荤',2,30,0,1,'酸菜炒香，鱼片滑入，加汤煮沸。','酸辣,下饭',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (29,'番茄牛腩','主荤',0,90,1,1,'牛腩切块焯水，番茄炒烂，加牛腩炖 60 分钟。','汤菜',1,0,'2026-10-06 10:13:30','2026-10-06 17:48:46',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (30,'小煎鸡','主荤',2,25,1,1,'鸡腿肉切丁，莴笋丁、泡椒同炒。','川菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (31,'干煸四季豆','素菜',2,20,1,1,'四季豆炸至虎皮，蒜末、肉末爆香，下豆角翻炒。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (32,'虎皮青椒','素菜',2,15,1,1,'青椒煎至虎皮，蒜末、豆豉、酱油炒香。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (33,'鱼香茄子','素菜',2,25,1,1,'茄子切条炸软，调鱼香汁翻炒。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (34,'麻酱凤尾','素菜',0,10,1,1,'莴笋尖焯水冰镇，麻酱、蒜泥调汁拌匀。','凉菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (35,'蒜蓉空心菜','素菜',1,10,1,1,'空心菜摘段，大火爆炒蒜蓉。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (36,'蒜蓉西兰花','素菜',0,15,1,1,'西兰花焯水，蒜蓉爆香翻炒。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (37,'清炒小白菜','素菜',0,10,1,1,'小白菜大火爆炒。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (38,'醋溜白菜','素菜',0,15,1,1,'白菜帮切块，醋、糖、干辣椒翻炒。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (39,'凉拌黄瓜','凉菜',0,10,1,1,'黄瓜拍碎，蒜泥、醋、酱油、香油拌匀。','凉菜,快手',1,0,'2026-10-06 10:13:30','2026-10-06 18:04:04',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (40,'凉拌木耳','凉菜',0,15,1,1,'木耳焯水冰镇，蒜泥、醋、生抽拌匀。','凉菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (41,'凉拌折耳根','凉菜',0,10,1,1,'折耳根洗净，蒜泥、辣椒油、醋拌匀。','凉菜,川味',1,0,'2026-10-06 10:13:30','2026-10-06 18:04:04',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (42,'酸辣土豆丝','素菜',2,15,1,1,'土豆切丝泡水，醋、干辣椒爆炒。','川菜经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (43,'干煸土豆条','素菜',2,20,1,1,'土豆条炸至外酥，蒜末、花椒爆香翻炒。','川味',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (44,'上汤娃娃菜','素菜',0,15,1,1,'娃娃菜焯水，皮蛋、火腿、浓汤煮沸淋上。','汤菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (45,'番茄炒蛋','素菜',0,15,1,1,'鸡蛋炒熟盛出，番茄炒烂，鸡蛋回锅。','快手,经典',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (46,'番茄蛋汤','汤',0,15,1,1,'番茄炒烂，加水煮沸，蛋液淋入。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (47,'紫菜蛋花汤','汤',0,10,1,1,'水烧开，紫菜、虾皮煮 1 分钟，蛋液淋入。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (48,'酸萝卜老鸭汤','汤',2,90,1,1,'鸭肉焯水，酸萝卜、枸杞、生姜炖 90 分钟。','汤菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (49,'莲藕排骨汤','汤',0,90,1,1,'排骨焯水，莲藕切块炖 90 分钟。','汤菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (50,'冬瓜排骨汤','汤',0,90,1,1,'排骨焯水，冬瓜块炖 60 分钟。','汤菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (51,'玉米排骨汤','汤',0,90,1,1,'排骨焯水，玉米、胡萝卜炖 60 分钟。','汤菜',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (52,'丝瓜蛋汤','汤',0,15,1,1,'丝瓜切片炒软，加水煮沸，蛋液淋入。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (53,'老姜鸡汤','汤',1,90,1,1,'土鸡焯水，老姜、当归、红枣炖 90 分钟。','滋补',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (54,'银耳莲子汤','汤',0,60,1,1,'银耳泡发撕碎，莲子、红枣、冰糖炖 60 分钟。','甜汤',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
INSERT INTO `dish` (`id`, `name`, `category`, `spicy_level`, `cook_time`, `kid_friendly`, `elder_friendly`, `description`, `tags`, `is_active`, `sort_order`, `created_at`, `updated_at`, `deleted`) VALUES (55,'酸菜粉丝汤','汤',1,15,1,1,'酸菜爆香，加水煮沸，粉丝煮软。','快手',1,0,'2026-10-06 10:13:30','2026-10-06 10:13:30',0);
/*!40000 ALTER TABLE `dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish_ingredient`
--

DROP TABLE IF EXISTS `dish_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish_ingredient` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dish_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '食材名',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '用量',
  `unit` varchar(20) DEFAULT NULL COMMENT '单位',
  `category` varchar(20) DEFAULT NULL COMMENT '食材分类',
  `is_optional` tinyint(1) DEFAULT '0' COMMENT '是否可选',
  `sort_order` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_dish` (`dish_id`),
  CONSTRAINT `dish_ingredient_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='食材表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish_ingredient`
--

LOCK TABLES `dish_ingredient` WRITE;
/*!40000 ALTER TABLE `dish_ingredient` DISABLE KEYS */;
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (7,2,'五花肉',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (8,2,'青蒜',100.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (9,2,'郫县豆瓣',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (10,2,'甜面酱',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (11,2,'生姜',1.00,'块','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (12,3,'里脊肉',300.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (13,3,'木耳',50.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (14,3,'胡萝卜',1.00,'根','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (15,3,'泡椒',20.00,'g','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (16,3,'葱姜蒜',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (17,4,'鸡腿肉',300.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (18,4,'花生米',50.00,'g','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (19,4,'干辣椒',10.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (20,4,'花椒',5.00,'g','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (21,4,'大葱',1.00,'根','蔬菜',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (22,5,'里脊肉',300.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (23,5,'豆芽',200.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (24,5,'郫县豆瓣',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (25,5,'花椒',10.00,'g','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (26,5,'干辣椒',10.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (27,14,'五花肉',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (28,14,'冰糖',30.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (29,14,'生抽',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (30,14,'老抽',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (31,14,'料酒',2.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (32,14,'八角',2.00,'个','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (33,23,'排骨',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (34,23,'冰糖',30.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (35,23,'生抽',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (36,23,'料酒',2.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (37,23,'葱姜',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (38,29,'牛腩',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (39,29,'番茄',3.00,'个','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (40,29,'洋葱',1.00,'个','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (41,29,'番茄酱',2.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (42,29,'葱姜',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (100,6,'鸡腿肉',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (101,6,'干辣椒',100.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (102,6,'花椒',30.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (103,6,'葱姜蒜',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (104,6,'熟芝麻',10.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (105,7,'牛肉',300.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (106,7,'牛杂',200.00,'g','肉类',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (107,7,'花生碎',30.00,'g','其他',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (108,7,'香菜',20.00,'g','蔬菜',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (109,7,'红油',2.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (110,7,'花椒粉',5.00,'g','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (111,8,'鸡腿',2.00,'只','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (112,8,'花生碎',30.00,'g','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (113,8,'葱姜蒜',0.00,'适量','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (114,8,'红油',2.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (115,8,'花椒粉',5.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (116,8,'香菜',20.00,'g','蔬菜',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (117,9,'五花肉',400.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (118,9,'大蒜',6.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (119,9,'红油',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (120,9,'生抽',2.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (121,9,'醋',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (122,9,'黄瓜',1.00,'根','蔬菜',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (123,10,'五花肉',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (124,10,'蒸肉米粉',100.00,'g','主食',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (125,10,'红薯',1.00,'个','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (126,10,'郫县豆瓣',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (127,10,'葱姜蒜',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (128,11,'五花肉',300.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (129,11,'青蒜',100.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (130,11,'郫县豆瓣',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (131,11,'豆豉',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (132,11,'生姜',1.00,'块','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (133,12,'里脊肉',300.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (134,12,'冬笋',100.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (135,12,'蒜苗',50.00,'g','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (136,12,'郫县豆瓣',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (137,12,'姜丝',20.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (138,13,'里脊肉',400.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (139,13,'鸡蛋',1.00,'个','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (140,13,'淀粉',50.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (141,13,'番茄酱',3.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (142,13,'白糖',2.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (143,13,'醋',2.00,'勺','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (144,15,'粉丝',100.00,'g','主食',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (145,15,'肉末',150.00,'g','肉类',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (146,15,'郫县豆瓣',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (147,15,'葱姜蒜',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (148,15,'生抽',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (149,16,'鸭肉',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (150,16,'啤酒',1.00,'罐','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (151,16,'生姜',1.00,'块','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (152,16,'大蒜',5.00,'瓣','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (153,16,'干辣椒',5.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (154,16,'八角',2.00,'个','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (155,17,'鸡爪',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (156,17,'泡椒',100.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (157,17,'泡椒水',200.00,'ml','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (158,17,'生姜',1.00,'块','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (159,17,'花椒',5.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (160,18,'鸡腿肉',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (161,18,'土豆',1.00,'个','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (162,18,'洋葱',1.00,'个','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (163,18,'芹菜',100.00,'g','蔬菜',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (164,18,'干辣椒',20.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (165,18,'花椒',10.00,'g','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (166,19,'大虾',500.00,'g','水产',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (167,19,'土豆',1.00,'个','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (168,19,'芹菜',100.00,'g','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (169,19,'干辣椒',20.00,'g','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (170,19,'花椒',10.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (171,19,'郫县豆瓣',1.00,'勺','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (172,20,'五花肉',300.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (173,20,'青椒',200.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (174,20,'红椒',1.00,'个','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (175,20,'豆豉',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (176,20,'大蒜',4.00,'瓣','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (177,21,'五花肉',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (178,21,'梅干菜',200.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (179,21,'生抽',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (180,21,'老抽',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (181,21,'冰糖',20.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (182,22,'鸡翅',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (183,22,'啤酒',1.00,'罐','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (184,22,'生姜',1.00,'块','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (185,22,'生抽',2.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (186,22,'冰糖',20.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (187,24,'排骨',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (188,24,'冰糖',50.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (189,24,'醋',3.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (190,24,'生抽',2.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (191,24,'料酒',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (192,25,'排骨',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (193,25,'淀粉',50.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (194,25,'椒盐',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (195,25,'葱姜蒜',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (196,25,'料酒',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (197,26,'猪蹄',2.00,'只','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (198,26,'干辣椒',30.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (199,26,'花椒',10.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (200,26,'八角',3.00,'个','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (201,26,'生抽',2.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (202,26,'冰糖',30.00,'g','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (203,27,'草鱼',1.00,'条','水产',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (204,27,'豆芽',200.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (205,27,'郫县豆瓣',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (206,27,'花椒',20.00,'g','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (207,27,'干辣椒',30.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (208,27,'蛋清',1.00,'个','其他',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (209,28,'草鱼',1.00,'条','水产',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (210,28,'酸菜',200.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (211,28,'泡椒',20.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (212,28,'蛋清',1.00,'个','其他',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (213,28,'花椒',10.00,'g','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (214,28,'生姜',1.00,'块','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (215,30,'鸡腿肉',400.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (216,30,'莴笋',1.00,'根','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (217,30,'泡椒',20.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (218,30,'生姜',1.00,'块','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (219,30,'大蒜',3.00,'瓣','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (275,1,'嫩豆腐',1.00,'盒','蔬菜',0,0);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (276,1,'瘦肉末',100.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (277,1,'郫县豆瓣',2.00,'勺','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (278,1,'花椒',10.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (279,1,'蒜苗',2.00,'根','蔬菜',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (280,1,'生姜',1.00,'块','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (281,31,'四季豆',400.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (282,31,'肉末',80.00,'g','肉类',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (283,31,'干辣椒',10.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (284,31,'花椒',5.00,'g','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (285,31,'大蒜',4.00,'瓣','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (286,31,'生抽',1.00,'勺','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (287,32,'青椒',400.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (288,32,'大蒜',4.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (289,32,'生抽',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (290,32,'醋',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (291,32,'盐',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (292,33,'茄子',2.00,'根','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (293,33,'肉末',80.00,'g','肉类',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (294,33,'泡椒',20.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (295,33,'郫县豆瓣',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (296,33,'葱姜蒜',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (297,33,'生抽',1.00,'勺','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (298,34,'菠菜',400.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (299,34,'麻酱',2.00,'勺','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (300,34,'生抽',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (301,34,'醋',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (302,34,'蒜末',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (303,34,'香油',1.00,'滴','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (304,35,'空心菜',500.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (305,35,'大蒜',5.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (306,35,'生抽',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (307,35,'盐',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (308,36,'西兰花',1.00,'颗','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (309,36,'大蒜',5.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (310,36,'生抽',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (311,36,'盐',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (312,37,'小白菜',500.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (313,37,'大蒜',3.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (314,37,'盐',0.00,'适量','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (315,38,'白菜',500.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (316,38,'干辣椒',5.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (317,38,'醋',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (318,38,'生抽',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (319,38,'蒜末',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (320,38,'白糖',0.50,'勺','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (321,39,'黄瓜',2.00,'根','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (322,39,'大蒜',3.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (323,39,'醋',1.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (324,39,'生抽',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (325,39,'香油',1.00,'滴','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (326,40,'木耳',50.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (327,40,'大蒜',4.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (328,40,'醋',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (329,40,'生抽',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (330,40,'香油',1.00,'滴','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (331,40,'小米椒',2.00,'个','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (332,41,'折耳根',400.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (333,41,'大蒜',4.00,'瓣','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (334,41,'醋',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (335,41,'生抽',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (336,41,'香油',1.00,'滴','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (337,41,'小米椒',3.00,'个','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (338,42,'土豆',2.00,'个','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (339,42,'干辣椒',5.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (340,42,'醋',2.00,'勺','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (341,42,'生抽',1.00,'勺','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (342,42,'蒜末',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (343,43,'土豆',2.00,'个','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (344,43,'花椒',5.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (345,43,'干辣椒',5.00,'g','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (346,43,'大蒜',3.00,'瓣','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (347,44,'娃娃菜',2.00,'颗','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (348,44,'皮蛋',1.00,'个','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (349,44,'火腿',30.00,'g','肉类',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (350,44,'高汤',500.00,'ml','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (351,44,'盐',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (352,45,'番茄',2.00,'个','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (353,45,'鸡蛋',3.00,'个','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (354,45,'葱花',0.00,'适量','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (355,45,'盐',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (356,45,'白糖',0.50,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (357,46,'番茄',2.00,'个','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (358,46,'鸡蛋',2.00,'个','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (359,46,'葱花',0.00,'适量','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (360,46,'盐',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (361,46,'香油',1.00,'滴','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (362,47,'紫菜',10.00,'g','其他',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (363,47,'鸡蛋',1.00,'个','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (364,47,'虾皮',5.00,'g','其他',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (365,47,'葱花',0.00,'适量','蔬菜',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (366,47,'盐',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (367,48,'老鸭',1.00,'半只','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (368,48,'酸萝卜',300.00,'g','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (369,48,'枸杞',10.00,'g','其他',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (370,48,'生姜',1.00,'块','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (371,48,'料酒',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (372,48,'盐',0.00,'适量','调料',0,6);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (373,49,'排骨',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (374,49,'莲藕',1.00,'节','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (375,49,'红枣',6.00,'颗','其他',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (376,49,'生姜',1.00,'块','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (377,49,'料酒',1.00,'勺','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (378,50,'冬瓜',500.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (379,50,'排骨',500.00,'g','肉类',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (380,50,'生姜',1.00,'块','调料',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (381,50,'盐',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (382,51,'排骨',500.00,'g','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (383,51,'玉米',1.00,'根','蔬菜',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (384,51,'胡萝卜',1.00,'根','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (385,51,'生姜',1.00,'块','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (386,51,'盐',0.00,'适量','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (387,52,'丝瓜',1.00,'根','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (388,52,'鸡蛋',2.00,'个','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (389,52,'葱花',0.00,'适量','蔬菜',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (390,52,'盐',0.00,'适量','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (391,52,'生姜',1.00,'块','调料',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (392,53,'土鸡',1.00,'半只','肉类',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (393,53,'老姜',50.00,'g','调料',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (394,53,'红枣',6.00,'颗','其他',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (395,53,'枸杞',10.00,'g','其他',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (396,53,'当归',2.00,'片','其他',0,5);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (397,54,'银耳',1.00,'朵','其他',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (398,54,'莲子',50.00,'g','其他',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (399,54,'红枣',6.00,'颗','其他',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (400,54,'冰糖',30.00,'g','调料',0,4);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (401,55,'酸菜',100.00,'g','蔬菜',0,1);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (402,55,'粉丝',50.00,'g','主食',0,2);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (403,55,'猪肉',50.00,'g','肉类',0,3);
INSERT INTO `dish_ingredient` (`id`, `dish_id`, `name`, `amount`, `unit`, `category`, `is_optional`, `sort_order`) VALUES (404,55,'生姜',1.00,'块','调料',0,4);
/*!40000 ALTER TABLE `dish_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `family_member`
--

DROP TABLE IF EXISTS `family_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `relation` varchar(20) DEFAULT NULL COMMENT '关系',
  `spicy_max` tinyint DEFAULT '3',
  `notes` text,
  `allergies` varchar(500) DEFAULT NULL COMMENT '过敏食材，多个用逗号分隔',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_relation` (`name`,`relation`,`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='家庭成员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family_member`
--

LOCK TABLES `family_member` WRITE;
/*!40000 ALTER TABLE `family_member` DISABLE KEYS */;
INSERT INTO `family_member` (`id`, `name`, `relation`, `spicy_max`, `notes`, `allergies`, `is_active`, `created_at`, `updated_at`, `deleted`) VALUES (1,'爸爸','爸爸',3,'川人，无辣不欢，爱吃回锅肉、啤酒鸭',NULL,1,'2026-10-06 12:41:24','2026-10-06 12:41:24',0);
INSERT INTO `family_member` (`id`, `name`, `relation`, `spicy_max`, `notes`, `allergies`, `is_active`, `created_at`, `updated_at`, `deleted`) VALUES (2,'妈妈','妈妈',1,'微辣即可，喜欢清淡',NULL,1,'2026-10-06 12:41:24','2026-10-06 12:41:24',0);
INSERT INTO `family_member` (`id`, `name`, `relation`, `spicy_max`, `notes`, `allergies`, `is_active`, `created_at`, `updated_at`, `deleted`) VALUES (3,'女儿','女儿',0,'1岁半，不辣，少油少盐','花生,海鲜',1,'2026-10-06 12:41:24','2026-10-06 12:41:24',0);
INSERT INTO `family_member` (`id`, `name`, `relation`, `spicy_max`, `notes`, `allergies`, `is_active`, `created_at`, `updated_at`, `deleted`) VALUES (4,'奶奶','奶奶',0,'牙口不好，爱软糯食物，少盐',NULL,1,'2026-10-06 12:41:24','2026-10-06 12:41:24',0);
/*!40000 ALTER TABLE `family_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal_record`
--

DROP TABLE IF EXISTS `meal_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `meal_date` date NOT NULL COMMENT '用餐日期',
  `meal_type` varchar(20) DEFAULT 'dinner' COMMENT '类型',
  `notes` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_date_type` (`meal_date`,`meal_type`,`deleted`),
  KEY `idx_date` (`meal_date`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用餐记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal_record`
--

LOCK TABLES `meal_record` WRITE;
/*!40000 ALTER TABLE `meal_record` DISABLE KEYS */;
INSERT INTO `meal_record` (`id`, `meal_date`, `meal_type`, `notes`, `created_at`, `updated_at`, `deleted`) VALUES (1,'2026-10-07','dinner',NULL,'2026-10-06 11:22:11','2026-10-06 11:22:11',0);
/*!40000 ALTER TABLE `meal_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal_record_dish`
--

DROP TABLE IF EXISTS `meal_record_dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal_record_dish` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `meal_record_id` bigint NOT NULL,
  `dish_id` bigint NOT NULL,
  `role` varchar(20) NOT NULL COMMENT '角色: 主荤/素菜/汤/凉菜',
  `rating` tinyint DEFAULT NULL COMMENT '评分 1-5',
  PRIMARY KEY (`id`),
  KEY `idx_record` (`meal_record_id`),
  KEY `idx_dish` (`dish_id`),
  CONSTRAINT `meal_record_dish_ibfk_1` FOREIGN KEY (`meal_record_id`) REFERENCES `meal_record` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meal_record_dish_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用餐-菜品关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal_record_dish`
--

LOCK TABLES `meal_record_dish` WRITE;
/*!40000 ALTER TABLE `meal_record_dish` DISABLE KEYS */;
INSERT INTO `meal_record_dish` (`id`, `meal_record_id`, `dish_id`, `role`, `rating`) VALUES (1,1,1,'??',NULL);
INSERT INTO `meal_record_dish` (`id`, `meal_record_id`, `dish_id`, `role`, `rating`) VALUES (2,1,40,'??',NULL);
INSERT INTO `meal_record_dish` (`id`, `meal_record_id`, `dish_id`, `role`, `rating`) VALUES (3,1,31,'?',NULL);
/*!40000 ALTER TABLE `meal_record_dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_preference`
--

DROP TABLE IF EXISTS `member_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_preference` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `dish_id` bigint DEFAULT NULL,
  `ingredient_name` varchar(50) DEFAULT NULL,
  `preference_type` varchar(20) NOT NULL COMMENT 'like/dislike/allergy',
  PRIMARY KEY (`id`),
  KEY `dish_id` (`dish_id`),
  KEY `idx_member` (`member_id`),
  CONSTRAINT `member_preference_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `family_member` (`id`) ON DELETE CASCADE,
  CONSTRAINT `member_preference_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成员偏好';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_preference`
--

LOCK TABLES `member_preference` WRITE;
/*!40000 ALTER TABLE `member_preference` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'family_menu'
--

--
-- Dumping routines for database 'family_menu'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-07  9:18:41
