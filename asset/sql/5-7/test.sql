-- Active: 1773072033347@@127.0.0.1@3306@fastweb_test

-- 默认角色为2 普通用户
ALTER TABLE `user`
CHANGE `role` `role` bigint unsigned UNSIGNED DEFAULT 2;
---- 增加了头像字段----
ALTER TABLE `user`
ADD COLUMN `avatar` varchar(255) DEFAULT NULL COMMENT '头像' AFTER `email`;

----
ALTER TABLE `user`
CHANGE `role` `role_id` bigint unsigned UNSIGNED DEFAULT 2 COMMENT '角色ID';

-- 根据用户id查询权限列表--
SELECT p.*
FROM user u
    JOIN role r ON u.role_id = r.role_id
    JOIN roleandpermission_middle rp ON rp.role_id = r.role_id
    JOIN permission p ON p.permission_id = rp.permission_id
WHERE
    u.id = 3;

-- 更换用户角色--
UPDATE user
SET role_id = 3
WHERE id = 3;


