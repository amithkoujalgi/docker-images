# docker-images

sample.http

```shell
### Authorization

POST {{KEYCLOAK_HOST}}/realms/{{KEYCLOAK_REALM}}/protocol/openid-connect/token
Content-Type: application/x-www-form-urlencoded

client_id={{KEYCLOAK_CLIENT_ID}}&username={{ADMIN_USERNAME}}&password={{ADMIN_PASSWORD}}&grant_type=password

> {% client.global.set("user_auth_token", response.body.access_token); %}

### Get org stats

GET {{APP_HOST}}/api/data/org-stats
Accept: */*
x-token: {{user_auth_token}}
```

http-client.env.json

```shell
{
  "dev": {
    "KEYCLOAK_HOST": "http://192.168.49.65:8095/auth",
    "KEYCLOAK_REALM": "df",
    "KEYCLOAK_CLIENT_ID": "df-client",
    "ADMIN_USERNAME": "test",
    "ADMIN_PASSWORD": "test",
    "REGULAR_USER_USERNAME": "test",
    "REGULAR_USER_PASSWORD": "test",
    "APP_HOST": "http://192.168.49.65:8501"
  }
}
```