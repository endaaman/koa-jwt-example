module.exports = do ->
    if not process.env.SECRET
        console.warn 'secret was set dengerous key'
    process.env.SECRET or 'THIS_IS_DENGEROUS_SECRET'
