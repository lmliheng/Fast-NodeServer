-- =============================================
-- FastWebUtils 数据库建表语句
-- 基于 routes 目录下的 JS 文件注释生成
-- =============================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS fastweb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE fastweb;

-- =============================================
-- 用户表 (user)
-- 来源: login.js, register.js
-- =============================================
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
    `id` BIGINT NOT NULL COMMENT '用户ID',
    `username` VARCHAR(50) NOT NULL COMMENT '用户名',
    `email` VARCHAR(100) NOT NULL COMMENT '邮箱',
    `password` VARCHAR(255) NOT NULL COMMENT '密码(加密存储)',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_email` (`email`) COMMENT '邮箱唯一索引',
    KEY `idx_username` (`username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表';

-- =============================================
-- 文章分类表 (article_cart)
-- 来源: article_cart.js
-- =============================================
DROP TABLE IF EXISTS `article_cart`;

CREATE TABLE `article_cart` (
    `cart_id` BIGINT NOT NULL COMMENT '文章分类ID',
    `cart_name` VARCHAR(100) NOT NULL COMMENT '文章分类名称',
    `user_id` BIGINT NOT NULL COMMENT '创建用户ID',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`cart_id`),
    UNIQUE KEY `uk_cart_name` (`cart_name`) COMMENT '文章分类名称唯一索引'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章分类表';

-- =============================================
-- 文章表 (article)
-- 来源: article.js
-- =============================================
DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
    `id` BIGINT NOT NULL COMMENT '文章ID',
    `title` VARCHAR(255) NOT NULL COMMENT '文章标题',
    `content` TEXT COMMENT '文章内容',
    `user_id` BIGINT NOT NULL COMMENT '创建用户ID',
    `cart_id` BIGINT NOT NULL COMMENT '分类ID',
    `cart_name` VARCHAR(100) NOT NULL COMMENT '文章分类名称',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
       KEY idx_cart_id (cart_id),
    CONSTRAINT fk_article_cart
        FOREIGN KEY (cart_id)
        REFERENCES article_cart(cart_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章表';

-- =============================================
-- 插入测试数据 (用户ID全部为1)
-- =============================================

-- 插入测试用户
INSERT INTO
    `user`
VALUES (
        1,
        'test',
        'test@1',
        '$2a$10$rMS0Y/3f07HBsBKAkY.imuzGtJHDGaOenZp2IbUptundZZXt5q0xy',
        '2026-03-09 16:46:55',
        '2026-03-13 13:08:09'
    ),
    (
        5,
        '117',
        'liheng221994@qq.com',
        '$2a$10$qVmGHboHxnph8dKMQw5Rlu/nl9ZA/HK3.g80Bl7fm7hXIlkopXIza',
        '2026-03-12 15:40:41',
        '2026-03-12 15:53:42'
    ),
    (
        6,
        'Nelson_liveldy',
        '2690034441@qq.com',
        '$2a$10$.xywnW9xFo8niScTgccDmuTfR4ChB5hZRLr4PKkfj1b1HoQNtJ89W',
        '2026-03-13 12:13:35',
        '2026-03-13 12:13:35'
    ),
    (
        7,
        '叶11',
        '2377445473@qq.com',
        '$2a$10$IKprutJU3sBlXLPlw4SOJeZPA0UBEet3Z4OvfsoUth667l8CXlJda',
        '2026-03-13 13:26:41',
        '2026-03-13 13:26:54'
    );
-- 插入测试文章分类 (user_id = 1)
INSERT INTO `article_cart` (`cart_id`, `cart_name`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '技术分享', 1, NOW(), NOW()),
(2, '生活随笔', 1, NOW(), NOW()),
(3, '产品思考', 1, NOW(), NOW()),
(4, '读书笔记', 1, NOW(), NOW()),
(5, '旅行记录', 1, NOW(), NOW());

-- 插入测试文章 (user_id = 1)
INSERT INTO `article` (
    `id`, `title`, `content`, `user_id`, `cart_id`, `cart_name`, `created_at`, `updated_at`
) VALUES
(
    10001,
    'MySQL 索引优化实战',
    '本文介绍如何合理使用索引提升查询性能...',
    1,
    1,
    '技术分享',
    NOW(),
    NOW()
),
(
    10002,
    '我的第一台相机',
    '记录我购买相机的全过程和使用体验...',
    1,
    5,
    '旅行记录',
    NOW(),
    NOW()
),
(
    10003,
    '如何写好产品需求文档',
    '从用户故事到原型设计的完整流程...',
    1,
    3,
    '产品思考',
    NOW(),
    NOW()
),
(
    10004,
    '《人类简史》读后感',
    '重新理解人类发展的底层逻辑...',
    1,
    4,
    '读书笔记',
    NOW(),
    NOW()
),
(
    10005,
    '前端性能优化实践',
    '从加载速度到渲染性能的实战总结...',
    1,
    1,
    '技术分享',
    NOW(),
    NOW()
);
      

-- 会失败（cart_id 不存在）
-- INSERT INTO article (id, title, user_id, cart_id, cart_name)
-- VALUES (99999, '非法分类文章', 1001, 999, '不存在的分类');