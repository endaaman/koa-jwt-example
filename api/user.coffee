_ = require 'lodash'
Q = require 'q'
bcrypt = require 'bcrypt'
jwt = require 'jsonwebtoken'
mongoose = require 'mongoose'

secret = require '../secret'
auth = require '../lib/auth'

User = mongoose.model 'User'
router = do require 'koa-router'

# Make it yieldable
bcryptGenSalt = Q.nbind bcrypt.genSalt, bcrypt
bcryptHash = Q.nbind bcrypt.hash, bcrypt


# `POST /users` = Sign up
router.post '/', (next)->
    # Easy validation
    valid = @request.body.username and @request.body.password
    if not valid
        @throw 400
        return

    # Make salt
    salt = yield bcryptGenSalt 10
    # Crypt with salt
    hashed_password = yield bcryptHash @request.body.password, salt

    # `salt` is not needed because `hashed_password` contains it.
    user = new User
        username: @request.body.username
        hashed_password: hashed_password

    # `username` is indexed as unique
    # So if it is dupricated, `user.save()` will fail
    try
        yield user.save()
    catch e
        @throw 400
        return

    @status = 201
    yield next


# `GET /users` = List users
router.get '/', auth, (next)->
    q = User.find {}
    docs = yield q.select '_id username'
    @body = docs
    yield next


module.exports = router.routes()
