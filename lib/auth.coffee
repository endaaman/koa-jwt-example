_ = require 'lodash'
Q = require 'q'
jwt = require 'jsonwebtoken'

secret = require '../secret'

# Make it yieldable
jwtVerify = Q.nbind jwt.verify, jwt

module.exports = (next)->
    # Header Style
    #   `Authorization: Bearer TOKEN_STRING`

    # Check `Authorization` header
    if not @request.header.authorization?
        @throw 401
        return

    # Check a value of `Authorization`
    parts = @request.header.authorization.split ' '
    validTokenStyle = parts.length is 2 and parts[0] is 'Bearer'

    if not validTokenStyle
        @throw 401
        return

    # Obtain token
    token = parts[1]

    # Decode token
    # `jwtVerify` will raise error if token is invalid.
    try
        decoded = yield jwtVerify token, secret
    catch
        @throw 401
        return

    # Return value of `jwt.verify` contains `iat` field.
    # This time it is not needed.
    @user =  _.pick decoded, ['_id', 'username']

    yield next
