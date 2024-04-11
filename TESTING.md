# Testing

I prefer to use Postman for testing the REST API but any tool which allows a developer to directly interact with the API should work fine.  I'll lay out each of the tests below. Each of these tests assume you've already started the REST API server via `mix phx.server`.

## Client

1. Create a new member

Method: POST
URL: http://localhost:4000/api/users
Body:
```json
{
    "user": {
        "role": "pal",
        "first_name": "John",
        "last_name": "Doe",
        "email": "nowhere@nomail.com",
        "account_minutes": 0
    }
}
```
Expected result: 201 Created

2. Attempt to create a new member with an empty first name:

Method: POST
URL: http://localhost:4000/api/users
Body:
```json
{
    "user": {
        "role": "pal",
        "first_name": "",
        "last_name": "Doe",
        "email": "nowhere@nomail.com",
        "account_minutes": 0
    }
}
```
Expected result: 422 Unprocessable Entity 

3. Attempt to create a new member with an empty last name:

Method: POST
URL: http://localhost:4000/api/users
Body:
```json
{
    "user": {
        "role": "pal",
        "first_name": "John",
        "last_name": "",
        "email": "nowhere@nomail.com",
        "account_minutes": 0
    }
}
```
Expected result: 422 Unprocessable Entity 

4. Attempt to create a new member with an empty email:

Method: POST
URL: http://localhost:4000/api/users
Body:
```json
{
    "user": {
        "role": "pal",
        "first_name": "John",
        "last_name": "Doe",
        "email": "",
        "account_minutes": 0
    }
}
```

Expected result: 422 Unprocessable Entity

5. Attempt to create a new member with negative initial balance:

Method: POST
URL: http://localhost:4000/api/users
Body:
```json
{
    "user": {
        "role": "pal",
        "first_name": "John",
        "last_name": "Doe",
        "email": "nowhere@nomail.com",
        "account_minutes": -1
    }
}
```

Expected result: 422 Unprocessable Entity

