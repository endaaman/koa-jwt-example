_ = require 'lodash'
Q = require 'q'
jwt = require 'jsonwebtoken'
mongoose = require 'mongoose'

secret = require '../secret'

User = mongoose.model 'User'

# Make yieldable
jwtVerify = Q.nbind jwt.verify, jwt


module.exports = (next)->
    # Header Style
    #   `Authorization: Bearer TOKEN_STRING`

    @user = null

    # Check `Authorization` header
    if not @request.header.authorization?
        yield next
        return

    # Check a value of `Authorization`
    parts = @request.header.authorization.split ' '
    validTokenStyle = parts.length is 2 and parts[0] is 'Bearer'

    if not validTokenStyle
        yield next
        return

    # Obtain token
    token = parts[1]

    # Decode token
    # `jwtVerify` will raise error if token is invalid.
    try
        decoded = yield jwtVerify token, secret
    catch
        yield next
        return

    try
        user = yield User.findById decoded._id
    catch
        yield next
        return

    # Return value of `jwt.verify` contains `iat` field.
    # This time it is not needed.
    @user = user

    yield next
