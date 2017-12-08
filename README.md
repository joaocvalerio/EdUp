 **Edup**
===========================

**Synopsis**
--------------

EdUp is a Learning Platform for companies.

A company can have Publishers and Students.

Publishers can create courses and invite students (employers). A course has only one Publisher.

Students can only watch courses with an invite.


A Publisher can only invite Students who own a company email (emails that exist in the company db). Every time a Publisher invites a Student, an email with a link is sent to the Student. This link has a unique identifier and if a Student clicks on that link it goes directly to course. Publishers can see which students clicked the link (trackable).

Only EdUp can assign a user as a Publisher.

----------

**How To Use**
---------------
To clone and run this application, you'll need Git installed on your computer. From your command line:

#### Clone this repository
```
 git clone https://github.com/joaocvalerio/EdUp
 cd Edup
```

#### Install dependencies
```
 bundle install
```

#### Create db, migrate schema, seed db

```
 rails db:create
 rails db:migrate
 rails db:seed
```

### Run application

```
 rails s
 http://localhost:3000/
```

 To sign in as:

   Publisher
   ```
   email: joaocvalerio@gmail.com
   password: 1234567
   ```

   Student
   ```
   email: mrrobot@crazyhacker.com
   password: 1234567
   ```



> **Note:** If you want more data on your db, please uncomment Faker Seed on seed.rb.

**Testing**
---------------
To run tests

```
rails test:system
```

**API**
---------------

## Authentication
### Method 1: Query Params

You can authenticate passing the user_email and user_token params as query params:

```

GET http://localhost:3000/api/v1/?user_email=EMAIL&user_token=TOKEN

```
To authenticate as:

Publisher
```
EMAIL: joaocvalerio@gmail.com
TOKEN: ue-xRA-oGfPxEpu1TfYB
```

Student
```
EMAIL: mrrobot@crazyhacker.com
TOKEN: QY2L1zrfx98PquNLQ4_C
```


### Method 2: Request Headers

You can also use request headers:

Publisher

```
X-User-Email joaocvalerio@gmail.com
X-User-Token xRA-oGfPxEpu1TfYB
```
Student

```
X-User-Email mrrobot@crazyhacker.com
X-User-Token QY2L1zrfx98PquNLQ4_C
```

## **Examples**

### List courses

#### Request
```
GET http://localhost:3000/api/v1/
```
#### Response
```

{
    "courses": [
        {
            "company_id": 1,
            "id": 1,
            "name": "RoR",
            "description": "Learn RoR in a few days",
            "publisher": "João Valério"
        },
        {
            "company_id": 1,
            "id": 2,
            "name": "React",
            "description": "Learn React",
            "publisher": "João Valério"
        }
    ]
}
```
### Show Course
#### Request
```
GET http://localhost:3000/api/v1/courses/1
```
#### Response
```

{
    "course": {
        "id": 1,
        "name": "RoR",
        "description": "Learn RoR in a few days",
        "parts": [
            {
                "id": 1,
                "description": "What is Ruby on Rails?",
                "video": "exEduZlJS7Q"
            },
            {
                "id": 2,
                "description": "Installing RoR",
                "video": "UT4W6jAyO_o"
            },
            {
                "id": 3,
                "description": "Create a Sample App",
                "video": "_Xh7H_fAn2c"
            },
            {
                "id": 4,
                "description": "Git and Heroku",
                "video": "y9n6NDPz28A"
            }
        ],
        "students": [
            {
                "first_name": "Darth",
                "last_name": "Vader",
                "email": "luke@iam.yourfather",
                "state": "clicked"
            },
            {
                "first_name": "Elliot",
                "last_name": "Anderson",
                "email": "mrrobot@crazyhacker.com",
                "state": "not_clicked"
            }
        ]
    }
```
### Create a Course
####  Request


```
POST http://localhost:3000/api/v1/courses/
```
```
{
    "course": {
        "name": "HTML",
        "description": "Learn Basic HTML"
    }
}
```
#### Response
```
{
    "course": {
        "id": 44,
        "name": "HTML",
        "description": "Learn Basic HTML",
        "parts": [],
        "students": []
    }
}
```
### Update a Course
#### Request


```
PATCH  http://localhost:3000/api/v1/courses/44
```
```
{
    "course": {
        "name": "BASIC HTML",
        "description": "Learn HTML"
    }
}
```
#### Response
```
{
    "course": {
       "name": "BASIC HTML",
        "description": "Learn HTML"

    }
}
```
### Destroy a Course
#### Request


```
DELETE  http://localhost:3000/api/v1/courses/44
```
### Add Part to Course
#### Request


```
POST  http://localhost:3000/api/v1/courses/44/parts
```
```
{
  "part":
  {
    "description": "Part1",
    "video": "link_video_part1"
  }
}
```
#### Response
```
{
    "part": {
        "id": 1,
        "course_id": 44,
        "description": "Part1",
        "video": "link_video_part1"
    }
}
```
### Show Part
#### Request


```
GET  http://localhost:3000/api/v1/courses/44/parts/1
```

#### Response
```
{
    "part": {
        "id": 1,
        "course_id": 44,
        "description": "Part1",
        "video": "link_video_part1"
    }
}
```
### Update a Part
#### Request


```
PATCH  http://localhost:3000/api/v1/courses/44/parts/1
```
```
{
  "part":
  {
    "description": "Part1 - Basics",
  }
}
```
#### Response
```
{
    "part": {
        "id": 1,
        "course_id": 44,
        "description": "Part1 - Basics",
        "video": "link_video_part1"
    }
}
```
### Destroy a Part
#### Request


```
DELETE  http://localhost:3000/api/v1/courses/44/part/1
```


### List company employees
#### Request


```
GET http://localhost:3000/api/v1/company_users
```
#### Response
```
{
    "company_users": [
        {
            "id": 3,
            "first_name": "Elliot",
            "last_name": "Anderson",
            "email": "mrrobot@crazyhacker.com"
        },
        {
            "id": 2,
            "first_name": "Darth",
            "last_name": "Vader",
            "email": "luke@iam.yourfather"
        },
        {
            "id": 1,
            "first_name": "João",
            "last_name": "Valério",
            "email": "joaocvalerio@gmail.com"
        }
    ]
}
```

> **Note:**  This is the list of users  that can be invited to courses
### Invite students to course
#### Request


```
POST  http://localhost:3000/api/v1/courses/44/add_students
```
```
{
  "students": {
    "emails": [
      {
        "email": "luke@iam.yourfather"
      },
      {
        "email": "mrrobot@crazyhacker.com"
      }
    ]
  }
}

```
#### Response
```
{
    "students": [
        {
            "id": 2,
            "first_name": "Darth",
            "last_name": "Vader",
            "email": "luke@iam.yourfather"
        },
        {
            "id": 3,
            "first_name": "Elliot",
            "last_name": "Anderson",
            "email": "mrrobot@crazyhacker.com"
        }
    ]
}
```

### Remove Student From Course
#### Request


```
GET http://localhost:3000/api/v1/courses/44/remove_student/3
```


