mongoose = require 'mongoose'

Schema = mongoose.Schema
module.exports = new Schema
    username:
        type: String
        required: true
        index:
            unique: true
    hashed_password:
        type: String
        required: true
