_ = require 'lodash'
Q = require 'q'
bcrypt = require 'bcrypt'
jwt = require 'jsonwebtoken'
mongoose = require 'mongoose'

secret = require '../secret'
auth = require '../lib/auth'

User = mongoose.model 'User'
router = do require 'koa-router'

# Make yieldable
bcryptCompare = Q.nbind bcrypt.compare, bcrypt
jwtVerify = Q.nbind jwt.verify, jwt


# `POST /session` = Login
router.post '/', (next)->
    # Find user
    q = User.findOne username: @request.body.username
    doc = yield q.exec()
    if not doc
        @throw 400
        return

    # Compare `password` with `hashed_password`
    ok = yield bcryptCompare @request.body.password, doc.hashed_password
    if not ok
        @throw 400
        return

    # Sign user id to json web token
    token = jwt.sign (_id: doc.id), secret

    # Serialize user object
    user = _.pick doc, ['_id', 'username']

    # Make response
    @body =
        token: token
        user: user
    @status = 201
    yield next


# `GET /session` = Check if authorized
router.get '/', auth, (next)->
    @body = user: _.pick @user, ['_id', 'username']
    yield next


module.exports = router.routes()
