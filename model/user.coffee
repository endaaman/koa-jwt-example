mongoose = require 'mongoose'
Q = require 'q'
bcrypt = require 'bcrypt'


Schema = mongoose.Schema
bcryptGenSalt = Q.nbind bcrypt.genSalt, bcrypt
bcryptHash = Q.nbind bcrypt.hash, bcrypt


module.exports = new Schema
    username:
        type: String
        required: true
        index:
            unique: true
    password:
        type: String
        required: true

.pre 'save', (next)->
    bcryptGenSalt 10
    .then (salt)=>
        bcryptHash @password, salt
    .then (password)=>
        @password = password
    .then next, next
