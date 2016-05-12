_ = require 'lodash'
Q = require 'q'
bcrypt = require 'bcrypt'
jwt = require 'jsonwebtoken'
mongoose = require 'mongoose'

config = require '../config'
auth = require '../lib/auth'

User = mongoose.model 'User'
router = do require 'koa-router'

bcryptGenSalt = Q.nbind bcrypt.genSalt, bcrypt
bcryptHash = Q.nbind bcrypt.hash, bcrypt


router.post '/', (next)->
    valid = @request.body.username and @request.body.password
    if not valid
        @throw 400

    doc = yield User.findOne username: @request.body.username
    if doc
        @throw 400

    user = new User
        username: @request.body.username
        password: @request.body.password

    yield user.save()
    @status = 201
    yield next


router.get '/', auth, (next)->
    q = User.find {}
    @body = yield q.select '_id username'
    yield next


router.delete '/:id', (next)->
    if @user._id is @params.id
        @status = 403
        @body =
            message: 'Do not delete youself'
        return
    q = User.findByIdAndRemove @params.id
    yield q.exec()
    @status = 204
    yield next


module.exports = router.routes()
