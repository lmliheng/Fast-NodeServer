const express = require('express')
const router = express.Router()
const { register_db_checkExistByEmail, register_db_register } = require('../utils/db_curd')
const { ToHash } = require('../utils/bcrypt_login')
const { generateId } = require('../utils/id_creator')
const tokenCreator = require('../utils/token_creator')

//========================================
//table: user
//id: 用户id
//username: 用户名
//email: 邮箱
//password: 密码
//created_at: 创建时间
//updated_at: 更新时间
//========================================


router.post('/register', async (req, res) => {
    const { username, email, password } = req.body
    // 判断用户名和邮箱是否为空
    if (!username || !email || !password) {
        return res.json({
            code: 400,
            success: false,
            message: '用户名、邮箱或密码不能为空'
        })
    }
    // 判断用户名和邮箱是否已存在
    const existingUser = await register_db_checkExistByEmail(email)  //boolean类型
    if (existingUser) {
        return res.json({
            code: 400,
            success: false,
            message: '邮箱已存在'
        })
    }

    try {
        const hashedPassword = await ToHash(password)
        // 生成id
        const id = await generateId()
        // 注册用户
        await register_db_register(id, username, email, hashedPassword)
        // 生成token
        const token = await tokenCreator({ id, username, email })
        // 响应
        res.json({
            code: 200,
            success: true,
            message: '注册成功',
            token,
            user_info: {
                id: id,
                username: username,
                email: email
            }
        })
    } catch (error) {
        console.error('注册用户错误:', error)
        return res.status(500).send('注册用户失败', error.message)
    }

})

module.exports = router
