# koa-jwt-example

## Requirements

* MongoDB
* node.js >= 0.12

## Notice

This example uses
* port `3000`
* `example` DB of MongoDB

Please check if these are free.

## Hands-on

Clone this repo and run
```
npm i
npm start
```

or if you are using [PM2](https://github.com/Unitech/pm2)

```
npm i
npm run pm2
pm2 logs example
```

### Sign up

Request

```
curl -v \
    -X POST \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'X-Accept: application/json' \
    -d '{"username": "hoge", "password": "fuga"}' \
    http://localhost:3000/users
```

Reponse `201`

### Log in

Request

```
curl -v \
    -X POST \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'X-Accept: application/json' \
    -d '{"username": "hoge", "password": "fuga"}' \
    http://localhost:3000/session
```

Reponse

```json
{
  "token": "<JSON WEB TOKEN>",
  "user": {
    "_id": "<USER ID>",
    "username": "hoge"
  }
}
```

### Check if authorized

Request

```
curl -v \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'X-Accept: application/json' \
    -H 'Authorization: Bearer <JSON WEB TOKEN>' \
    http://localhost:3000/session
```

Reponse

```json
{
  "_id": "<USER ID>",
  "username": "hoge"
}
```
