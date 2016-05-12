secret = ->
    process.env.SECRET or (console.warn 'you are using degerous secret key') or 'DENGEROUS_SECRET'

module.exports =
    port: 3000
    secret: secret()
    db: 'mongodb://localhost:27017/koa-jwt-example'
