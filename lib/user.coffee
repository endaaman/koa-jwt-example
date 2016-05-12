Q = require 'q'
jwt = require 'jsonwebtoken'
mongoose = require 'mongoose'

config = require '../config'

jwtVerify = Q.nbind jwt.verify, jwt
User = mongoose.model 'User'


module.exports = (next)->
    # Header style
    #   Authorization: Bearer TOKEN_STRING
    @user = null
    authStyle = 'Bearer'

    if not @request.header.authorization?
        yield next
        return

    parts = @request.header.authorization.split ' '
    validTokenStyle = parts.length is 2 and parts[0] is authStyle

    if not validTokenStyle
        yield next
        return

    token = parts[1]
    try
        decoded = yield jwtVerify token, config.secret
    catch
        yield next
        return

    q = User.findById decoded._id
    doc = yield q.select '_id username'

    if not doc
        yield next
        return

    @user = doc

    yield next
