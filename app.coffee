koa = require 'koa'
mongoose = require 'mongoose'

mongoose.model 'User', require './model/user'
mongoose.connect 'mongodb://localhost:27017/example'

api = do require 'koa-router'
api.use '/users', require './api/user'
api.use '/session', require './api/session'

app = koa()
app
.use do require 'koa-logger'
.use do require 'koa-bodyparser'
.use do require 'koa-json'
.use api.routes()
.use api.allowedMethods()
.listen 3000
