-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: fastweb
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `id` bigint NOT NULL COMMENT '文章ID',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '文章内容',
  `user_id` bigint NOT NULL COMMENT '创建用户ID',
  `cart_id` bigint NOT NULL COMMENT '分类ID',
  `cart_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章分类名称',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_cart_id` (`cart_id`),
  CONSTRAINT `fk_article_cart` FOREIGN KEY (`cart_id`) REFERENCES `article_cart` (`cart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (10002,'我的第一台相机','记录我购买相机的全过程和使用体验...',1,5,'旅行记录','2026-04-11 00:06:07','2026-04-11 00:06:07'),(10003,'如何写好产品需求文档','从用户故事到原型设计的完整流程...',1,3,'产品思考','2026-04-11 00:06:07','2026-04-11 00:06:07'),(10004,'《人类简史》读后感','重新理解人类发展的底层逻辑...',1,4,'读书笔记','2026-04-11 00:06:07','2026-04-11 00:06:07'),(10005,'前端性能优化实践','从加载速度到渲染性能的实战总结...',1,1,'技术分享','2026-04-11 00:06:07','2026-04-11 00:06:07'),(111111,'更新了','哈哈哈哈哈哈哈哈哈哈哈哈',1,3,'产品思考','2026-04-11 01:23:01','2026-04-11 01:34:01');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

--
-- Table structure for table `article_cart`
--

DROP TABLE IF EXISTS `article_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_cart` (
  `cart_id` bigint NOT NULL COMMENT '文章分类ID',
  `cart_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章分类名称',
  `user_id` bigint NOT NULL COMMENT '创建用户ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `uk_cart_name` (`cart_name`) COMMENT '文章分类名称唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_cart`
--

/*!40000 ALTER TABLE `article_cart` DISABLE KEYS */;
INSERT INTO `article_cart` VALUES (1,'技术分享',1,'2026-04-11 00:06:07','2026-04-11 00:06:07'),(2,'生活随笔',1,'2026-04-11 00:06:07','2026-04-11 00:06:07'),(3,'产品思考',1,'2026-04-11 00:06:07','2026-04-11 00:06:07'),(4,'读书笔记',1,'2026-04-11 00:06:07','2026-04-11 00:06:07'),(5,'旅行记录',1,'2026-04-11 00:06:07','2026-04-11 00:06:07'),(6,'哈哈哈',1,'2026-04-11 00:56:29','2026-04-11 00:56:29');
/*!40000 ALTER TABLE `article_cart` ENABLE KEYS */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL COMMENT '用户ID',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码(加密存储)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_email` (`email`) COMMENT '邮箱唯一索引',
  KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test','test@1','$2a$10$rMS0Y/3f07HBsBKAkY.imuzGtJHDGaOenZp2IbUptundZZXt5q0xy','2026-03-09 16:46:55','2026-03-13 13:08:09'),(5,'117','111','$2b$10$YSQ0WtUswLYDTX3VLIcD0.cQ.cysoEwJ0L1I00twtgNrLgwpcxhyO','2026-03-12 15:40:41','2026-04-11 01:40:31'),(6,'Nelson_liveldy','2690034441@qq.com','$2a$10$.xywnW9xFo8niScTgccDmuTfR4ChB5hZRLr4PKkfj1b1HoQNtJ89W','2026-03-13 12:13:35','2026-03-13 12:13:35'),(7,'叶11','2377445473@qq.com','$2a$10$IKprutJU3sBlXLPlw4SOJeZPA0UBEet3Z4OvfsoUth667l8CXlJda','2026-03-13 13:26:41','2026-03-13 13:26:54');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

--
-- Dumping routines for database 'fastweb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-11 17:42:14
