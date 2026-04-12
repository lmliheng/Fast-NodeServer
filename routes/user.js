const express = require('express')
const router = express.Router()
const { token_db_getUserInfo } = require('../utils/db_curd')
const { tokenCreator } = require('../utils/token_creator')
const { user_db_update } = require('../utils/db_curd')
const { ToHash } = require('../utils/bcrypt_login')

//========================================
//table: user
//id: 用户id
//username: 用户名
//email: 邮箱
//password: 密码
//created_at: 创建时间
//updated_at: 更新时间
//========================================

// 获取用户信息
router.get('/userInfo', async (req, res) => {
    try {
        const token = req.headers.authorization
        const user = await token_db_getUserInfo(token)
        if (user == null) {
            return res.status(401).json({
                code: 401,
                success: false,
                message: '未登录或登录过期'
            })
        }
        res.json({
            code: 200,
            success: true,
            message: '获取用户信息成功',
            user_info: {
                id: user.id,
                username: user.username,
                email: user.email,
                login_time: new Date().toLocaleString()
            }
        })
    } catch (error) {
        console.error('获取用户信息错误:', error)
        res.status(500).json({
            success: false,
            message: '服务器内部错误'
        })
    }
})

// 更新用户信息
router.put('/userInfo', async (req, res) => {
    const { id, username, email } = req.body
    // 参数校验
    if (!id || !username || !email) {
        return res.status(400).json({
            code: 400,
            success: false,
            message: '用户id、用户名、邮箱不能为空'
        })
    }



    try {
        // 密码加密
        await user_db_update(id, username, email)
        res.json({
            code: 200,
            success: true,
            message: '更新用户信息成功'
        })
    } catch (error) {
        console.error('更新用户信息错误:', error)
        res.status(500).json({
            success: false,
            message: '服务器内部错误'
        })
    }
}
)
// 修改用户密码
module.exports = router
