const express = require('express')
const router = express.Router()
const { login_db } = require('../utils/db_curd')
const { tokenCreator } = require('../utils/token_creator')



//========================================
//table: user
//id: 用户id
//username: 用户名
//email: 邮箱
//password: 密码
//created_at: 创建时间
//updated_at: 更新时间
//========================================

router.post('/login', async (req, res) => {
    try {
        const { email, password } = req.body
        // 参数校验
        if (!email || !password) {
            return res.status(400).json({
                code: 400,
                success: false,
                message: '邮箱和密码不能为空'
            })
        }

        const user = await login_db(email, password)

        if (user == null) {
            console.log('login.js 用户不存在或密码错误');
            return res.status(401).json({
                code: 401,
                success: false,
                message: '用户名或密码错误'
            })
        }

        const token = tokenCreator(user)

        console.log('login.js 用户登录成功', user.id, user.username, user.email);
        res.json({
            code: 200,
            success: true,
            message: '登录成功',
            token,
            user_info: {
                id: user.id,
                username: user.username,
                email: user.email,
                login_time: new Date().toLocaleString()
            }
        })
    } catch (error) {
        console.error('登录错误:', error)
        res.status(500).json({
            success: false,
            message: '服务器内部错误'
        })
    }
})



module.exports = router
