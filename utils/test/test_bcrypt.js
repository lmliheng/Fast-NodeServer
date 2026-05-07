const { ToHash, ComparePassword } = require('../bcrypt_password')

let password = 'test'
 ToHash(password).then(res => {
    console.log(res)
})

let hashedPassword = '$2b$10$5mBh3DVuJNPqd5P9y337UONPNcplSBGG73NYKCBdr3hFt/TB2ypiO'
ComparePassword(password, hashedPassword).then(res => {
    console.log(res)
})
