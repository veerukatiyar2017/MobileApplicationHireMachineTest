# Application Machine Test
> Application Design must be good.

## 1. Create Login Screen with fields:

#### Email : Valid email id.

#### Password : Valid password.

### Api to Login:

URL: `https://reqres.in/api/ login`
Request Type: POST
Request JSON:
```
{
“email” : “test@novuse.com”,
“password”: “cityslicka”
}
```
Response JSON:
```
{
“token”: “Qaxtypver”
}
```

## 2. Create SignUp Screen with fields:

#### Email : Valid email id.

#### Password : Valid password.

### Api to Register:

URL: `https://reqres.in/api/register`
Request Type: POST
Request JSON:
```
{
“email” : “test@novuse.com”,
“password”: “cityslicka”
}
```
Response JSON:
```
{
“token”: “Qaxtypver”
}
```


## 3. After Login there should be a user list screen with Image:

### Use Api to get users list:

URL: `https://reqres.in/api/users?page=2`
Request Type: GET
Response JSON:
```
{
     "page": 2,
     "per_page": 3,
     "total": 12,
     "total_pages": 4,
     "data": [
          {
               "id": 4,
               "first_name": "Eve",
               "last_name": "Holt",
               "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/marcoramires/128.jpg"
           },
           {
               "id": 5,
               "first_name": "Charles",
               "last_name": "Morris",
               "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/stephenmoon/128.jpg"
            },
            {
               "id": 6,
               "first_name": "Tracey",
               "last_name": "Ramos",
               "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/bigmancho/128.jpg"
            }
        ]
    }
```

## 4. On Select any user from list a user detail page should be there and can update

## image:

### Use Api to Upload image:

URL: `https://api.pixhost.to/images`
Request Type: POST
Headers:
```
{
“Content-Type”: “multipart/form-data; charset=utf-8”,
“Accept”: “application/json”
}
```

Multi Part Parms:
```
img = Image Path,
content_type = 0,
max_th_size = 420
```
