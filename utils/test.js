const { ToHash, ComparePassword } = require('./bcrypt_login')
const { generateId } = require('./id_creator')

//- 使用了 require (CommonJS 语法)
//- 同时在顶层使用了 await (ES Modules 语法)


async function test() {
    // 测试密码加密
    const testPassword = 'test'
    const hashedPassword = await ToHash(testPassword)
    console.log('加密后的密码:', hashedPassword);
    // 测试密码验证
    const isPasswordValid = await ComparePassword(testPassword, hashedPassword)
    console.log('密码验证结果:', isPasswordValid);
    // 测试id生成
    const id = generateId()
    console.log('生成的id:', id);

}
test().catch(console.error)