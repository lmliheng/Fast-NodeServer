const express = require('express')
const router = express.Router()
const { article_cart_db_getAll, articleCart_db_getArticleListByUserId, article_cart_db_deleteById, article_cart_db_add, article_cart_db_postEdit } = require('../utils/db_curd')
const { tokenValidator } = require('../utils/token_creator')

//========================================

//table: article_cart 
//cart_id: 文章分类id
//cart_name: 文章分类名称
//user_id: 创建 用户id
//created_at: 创建时间
//updated_at: 更新时间

//========================================
// 查询所有分类列表
router.get('/articleCart/getAll', async (req, res) => {
    const token = req.headers.authorization
    const decoded = tokenValidator(token)
    if (!decoded) {
        return res.status(401).json({
            code: 401,
            success: false,
            message: '未授权'
        })
    }
    const user_id = decoded.id
    // 为什么块级作用域下的user_id在其他router下面有值
    try {
        const articleCartList = await article_cart_db_getAll(user_id)
        res.json({
            code: 200,
            success: true,
            message: '获取成功',
            articleCartList: articleCartList
        })
    } catch (error) {
        console.error('获取文章分类列表错误:', error)
        return res.status(500).send('获取文章分类列表失败', error.message)
    }
})
// 查询某分类下的文章列表
router.get('/articleCart/getArticleListByUserId', async (req, res) => {
    const token = req.headers.authorization
    const decoded = tokenValidator(token)
    if (!decoded) {
        return res.status(401).json({
            code: 401,
            success: false,
            message: '未授权'
        })
    }

    const { cart_id } = req.query
    if (!cart_id) {
        return res.status(400).json({
            code: 400,
            success: false,
            message: '文章分类id不能为空'
        })
    }
    const user_id = decoded.id
    try {
        const articleList = await articleCart_db_getArticleListByUserId(cart_id, user_id)
        res.json({
            code: 200,
            success: true,
            message: '获取成功',
            articleList: articleList
        })
    } catch (error) {
        console.error('获取文章分类下的文章列表错误:', error)
        return res.status(500).send('获取文章分类下的文章列表失败', error.message)
    }
})
// 添加分类
router.post('/articleCart/add', async (req, res) => {
    const token = req.headers.authorization
    const { cart_id, cart_name } = req.body
    if (!cart_id || !cart_name) {
        return res.status(400).json({
            code: 400,
            success: false,
            message: '文章分类id、分类名称不能为空'
        })
    }

    // 获取用户id

    const decoded = tokenValidator(token)
    if (!decoded) {
        return res.status(401).json({
            code: 401,
            success: false,
            message: '未授权'
        })
    }
    const user_id = decoded.id
    try {
        const articleCart = await article_cart_db_add(cart_id, cart_name, user_id)
        res.json({
            code: 200,
            success: true,
            message: '添加成功',
            articleCart: articleCart
        })
    } catch (error) {
        console.error('添加文章分类错误:', error)
        return res.status(500).send('添加文章分类失败', error.message)
    }
})
// 更新分类
router.put('/articleCart/update', async (req, res) => {
    const token = req.headers.authorization
    const { cart_id, cart_name } = req.body
    if (!cart_id || !cart_name) {
        return res.status(400).json({
            code: 400,
            success: false,
            message: '文章分类id、分类名称不能为空'
        })
    }
    // 获取用户id
    const decoded = tokenValidator(token)
    if (!decoded) {
        return res.status(401).json({
            code: 401,
            success: false,
            message: '未授权'
        })
    }
    const user_id = decoded.id

    try {
        const articleCart = await article_cart_db_postEdit(cart_id, cart_name, user_id)
        res.json({
            code: 200,
            success: true,
            message: '更新成功',
            articleCart: articleCart
        })
    } catch (error) {
        console.error('更新文章分类错误:', error)
        return res.status(500).send('更新文章分类失败', error.message)
    }
})

// 删除分类 要谨慎 需要考虑关联的子表数据  目前使用不了
router.delete('/articleCart/delete', async (req, res) => {
    const token = req.headers.authorization
    const { cart_id } = req.query
    if (!cart_id) {
        return res.status(400).json({
            code: 400,
            success: false,
            message: '文章分类id不能为空'
        })
    }
    // 获取用户id
    const decoded = tokenValidator(token)
    if (!decoded) {
        return res.status(401).json({
            code: 401,
            success: false,
            message: '未授权'
        })
    }
    const user_id = decoded.id
    try {
        const articleCart = await article_cart_db_deleteById(cart_id, user_id)
        res.json({
            code: 200,
            success: true,
            message: '删除成功',
            articleCart: articleCart
        })
    } catch (error) {
        console.error('删除文章分类错误:', error)
        return res.status(500).send('删除文章分类失败', error.message)
    }
})


module.exports = router