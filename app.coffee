koa = require 'koa'
mongoose = require 'mongoose'
Router = require 'koa-router'

config = require './config'

mongoose.model 'User', require './model/user'
mongoose.connect config.dbUrl

api = new Router
api.get '/', (next)->
    @body = if @user then "Konnichiwa, #{@user.username}=san." else 'You are not logged in'
    yield next
api.use '/users', require './api/user'
api.use '/session', require './api/session'

app = koa()
app
.use do require 'koa-logger'
.use do require 'koa-bodyparser'
.use do require 'koa-json'
.use require './lib/user'
.use api.routes()
.use api.allowedMethods()
.listen config.port

console.log "Listening at #{config.port}"
