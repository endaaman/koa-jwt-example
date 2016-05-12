module.exports = (next)->
    if (not @user) or (not @user.approved)
        @throw 401
        return
    yield next
