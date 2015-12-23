module.exports = (next)->
    if not @user
        @throw 401
        return

    yield next
