# koa-jwt-example

This is a simple JSON Web Token authentication implementation on koa.js.

This example shows you how to
- Sign up
- Log in
- authenticate


## Requirements

* MongoDB
* node.js >= 0.12

## Settings

See `./config.coffee`. Default:

* Server port: `mongodb://localhost:27017/example`
* DB URI: `example` DB of MongoDB


## Hands-on

### Confirm you are not logged in,

Request:

```
$ curl http://localhost:3000
```

Reponse:

```json
You are not logged in
```


### Sign up

Create an user whose name is `'hoge'` and password is `'fuga'`

```
$ curl -v \
    -X POST \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'X-Accept: application/json' \
    -d '{"username": "hoge", "password": "fuga"}' \
    http://localhost:3000/users
```

If Success, You will get empty response with code `201`

### Log in

Obtain the *JSON WEB TOKEN* using username and password.

```
$ curl -v \
    -X POST \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'X-Accept: application/json' \
    -d '{"username": "hoge", "password": "fuga"}' \
    http://localhost:3000/session
```

If success, You will get json like

```json
{
  "token": "<JSON WEB TOKEN>",
  "user": {
    "_id": "<USER ID>",
    "username": "hoge"
  }
}
```

with code `201` else 401


### Then, you can be authorized

Request

```
$ curl -v \
    -H 'X-Accept: application/json' \
    -H 'Authorization: Bearer <JSON WEB TOKEN>' \
    http://localhost:3000
```

Reponse

```json
Konnichiwa, hoge=san.
```
