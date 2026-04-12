-- =============================================
-- 视图：文章列表（带分类名称和作者）
-- =============================================
DROP VIEW IF EXISTS v_article_list;

CREATE VIEW v_article_list AS
SELECT
    a.id,
    a.title,
    a.content,
    a.user_id,
    u.username AS author_name,
    a.cate_id,
    ac.cart_name AS category_name,
    a.created_at,
    a.updated_at
FROM
    article a
    LEFT JOIN user u ON a.user_id = u.id
    LEFT JOIN article_cart ac ON a.cate_id = ac.cart_id;

-- =============================================
-- 存储过程：分页查询文章
-- =============================================
DROP PROCEDURE IF EXISTS sp_get_articles;

DELIMITER / /

CREATE PROCEDURE sp_get_articles(
    IN p_page INT,
    IN p_page_size INT
)
BEGIN
    DECLARE p_offset INT;
    SET p_offset = (p_page - 1) * p_page_size;
    
    SELECT * FROM article 
    ORDER BY created_at DESC
    LIMIT p_offset, p_page_size;
END //

DELIMITER;

-- 调用示例: CALL sp_get_articles(1, 10);

-- =============================================
-- 常用查询示例
-- =============================================

-- 查询所有文章（带作者和分类）
SELECT * FROM v_article_list;

-- 用户登录查询
SELECT * FROM user WHERE email = 'admin@example.com';

-- 分页查询文章
SELECT * FROM article ORDER BY created_at DESC LIMIT 0, 10;

-- 查询某用户的所有文章
SELECT * FROM article WHERE user_id = 1;

-- 查询文章分类
SELECT * FROM article_cart WHERE user_id = 1;