# koa-jwt-example
This is a simple JSON Web Token authentication implementation on koa.js.

This example shows you how to
- Sign up
- Log in
- authenticattion

## libraries
- koa.js(v1.x)
- koa-router
- jsonwebtoken
- bcrypt
- mongoose


## Requirements

* MongoDB
* node.js >= 4.x

## Settings

See `./config.coffee`. Default:

* Server: `mongodb://localhost:27017/example`
* DB URI: `example` DB of MongoDB


## Hands-on

### Ensure you are not logged in,

Request:

```
$ curl http://localhost:3000
```

then, you will get response
```
You are not logged in
```


### Sign up

Create user account whose name is `'hoge'` and password is `'fuga'`

```
$ curl -v \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'X-Accept: application/json' \
    -d '{"username": "hoge", "password": "fuga"}' \
    http://localhost:3000/users
```

If Success, the user acocunt is created and you will get empty response with code `201`

### Log in

Obtain a *JSON WEB TOKEN* using username and password.

```
$ curl -v \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'X-Accept: application/json' \
    -d '{"username": "hoge", "password": "fuga"}' \
    http://localhost:3000/session
```

If success, You will get a json like

```json
{
  "token": "<JSON WEB TOKEN>",
  "user": {
    "_id": "<USER ID>",
    "username": "hoge"
  }
}
```

with code `201` else `401`

### Then, you can be authorized!

```
$ curl -v \
    -H 'X-Accept: application/json' \
    -H 'Authorization: Bearer <JSON WEB TOKEN>' \
    http://localhost:3000
```

Then you will get

```json
Konnichiwa, hoge=san.
```

Have fun.
