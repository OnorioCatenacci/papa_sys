# Testing

I prefer to use Postman for testing the REST API but any tool which allows a developer to directly interact with the API should work fine.  I'll lay out each of the tests below. Each of these tests assume you've already started the REST API server via `mix phx.server`.


### Set up

1. Assuming the database has been created, run the following command to create the tables:

```bash
mix run priv/repo/seed_for_test.exs 
```

This will populate the tables so that you get the results laid out below.  Warning: this will overwrite the development version of the DB.

2. Start the server:

```bash
mix phx.server
```


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
        "email_address": "nowhere@nomail.com",
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
        "email_address": "nowhere@nomail.com",
        "account_minutes": 0
    }
}
```
Expected result: 422 Unprocessable Entity 

Response Body: 
```json
{
    "errors": {
        "first_name": [
            "can't be blank"
        ]
    }
}
```

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
        "email_address": "nowhere@nomail.com",
        "account_minutes": 0
    }
}
```
Expected result: 422 Unprocessable Entity 

Response Body: 
```json
{
    "errors": {
        "last_name": [
            "can't be blank"
        ]
    }
}
```

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
        "email_address": "",
        "account_minutes": 0
    }
}
```

Expected result: 422 Unprocessable Entity

Response Body: 
```json
{
    "errors": {
        "email_address": [
            "can't be blank"
        ]
    }
}
``` 

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
        "email_address": "nowhere@nomail.com",
        "account_minutes": -1
    }
}
```

Expected result: 422 Unprocessable Entity

Response Body: 
```json
{
    "errors": {
        "account_minutes": [
            "must be greater than or equal to 0"
        ]
    }
}
```

## Visit

1. Create a new visit

Method: POST

URL: http://localhost:4000/api/visits


Body:
```json
{
    "visit": {
        "user_id": 1,
        "visit_date": "2024-05-01",
        "visit_duration": 60
    }
}
```

Expected result: 201 Created

2. Attempt to create a new visit with a negative duration:

Method: POST

URL: http://localhost:4000/api/visits

Body:
```json
{
    "visit": {
        "user_id": 1,
        "visit_date": "2024-05-01",
        "visit_duration": -1
    }
}
```

Expected result: 422 Unprocessable Entity

Response Body:
```json
{
    "errors": {
        "visit_duration": [
            "must be greater than 0"
        ]
    }
}
```

3. Attempt to create a new visit with a visit date in the past:

Body:
```json
{
    "visit": {
        "user_id": 1,
        "visit_date": "2000-05-01",
        "visit_duration": 60
    }
}
```

Expected result: 422 Unprocessable Entity

Response Body:
```json


{
    "errors": {
        "visit_date": [
            "cannot be in the past"
        ]
    }
}
```

