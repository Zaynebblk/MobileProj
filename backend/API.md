# API Documentation

Base URL: `http://localhost:3000/api`

## Authentication

All protected endpoints require JWT authentication. Include the token in the Authorization header:

```
Authorization: Bearer <token>
```

### Login
- **POST** `/auth/login`
- **Body**: 
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```
- **Response**:
  ```json
  {
    "token": "jwt_token_here",
    "user": {
      "id": "user_id",
      "email": "user@example.com",
      "role": "student|professor|admin"
    }
  }
  ```

### Password Reset
- **POST** `/auth/forgot-password`
- **Body**:
  ```json
  {
    "email": "user@example.com"
  }
  ```

- **POST** `/auth/reset-password`
- **Body**:
  ```json
  {
    "token": "reset_token",
    "newPassword": "newPassword123"
  }
  ```

## User Endpoints

### Get Current User Profile
- **GET** `/user/profile`
- **Auth**: Required
- **Response**: User object with profile details

### Update Profile
- **PUT** `/user/profile`
- **Auth**: Required
- **Body**:
  ```json
  {
    "firstName": "John",
    "lastName": "Doe",
    "phone": "+1234567890"
  }
  ```

## Student Endpoints

### Get Courses
- **GET** `/students/courses`
- **Auth**: Required (Student)
- **Response**: List of enrolled courses

### Get Attendance
- **GET** `/students/attendance`
- **Auth**: Required (Student)
- **Response**: Attendance records

### Get Grades
- **GET** `/students/grades`
- **Auth**: Required (Student)
- **Response**: Grade records

### Submit Document Request
- **POST** `/doc-requests`
- **Auth**: Required (Student)
- **Body**:
  ```json
  {
    "documentType": "transcript",
    "notes": "Need for job application"
  }
  ```

## Professor Endpoints

### Mark Attendance
- **POST** `/attendance`
- **Auth**: Required (Professor)
- **Body**:
  ```json
  {
    "courseId": "course_id",
    "date": "2026-01-07",
    "students": [
      {
        "studentId": "student_id",
        "status": "present|absent|late"
      }
    ]
  }
  ```

### Create Announcement
- **POST** `/announcements`
- **Auth**: Required (Professor)
- **Body**:
  ```json
  {
    "title": "Exam Schedule",
    "content": "Midterm exam on January 15",
    "courseId": "course_id"
  }
  ```

### Upload Document
- **POST** `/documents`
- **Auth**: Required (Professor)
- **Content-Type**: `multipart/form-data`
- **Fields**:
  - `file`: File to upload
  - `title`: Document title
  - `courseId`: Course ID
  - `description`: Optional description

## Admin Endpoints

### Manage Users
- **GET** `/admin/users` - List all users
- **POST** `/admin/users` - Create user
- **PUT** `/admin/users/:id` - Update user
- **DELETE** `/admin/users/:id` - Delete user

### Manage Courses
- **GET** `/admin/courses` - List all courses
- **POST** `/admin/courses` - Create course
- **PUT** `/admin/courses/:id` - Update course
- **DELETE** `/admin/courses/:id` - Delete course

### Manage Schedules
- **GET** `/admin/schedules` - List all schedules
- **POST** `/admin/schedules` - Create schedule
- **PUT** `/admin/schedules/:id` - Update schedule
- **DELETE** `/admin/schedules/:id` - Delete schedule

### Process Document Requests
- **GET** `/admin/doc-requests` - List all document requests
- **PUT** `/admin/doc-requests/:id` - Update request status
  ```json
  {
    "status": "approved|rejected|completed"
  }
  ```

## Common Response Codes

- `200 OK` - Request successful
- `201 Created` - Resource created successfully
- `400 Bad Request` - Invalid request data
- `401 Unauthorized` - Authentication required
- `403 Forbidden` - Insufficient permissions
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server error

## Error Response Format

```json
{
  "error": {
    "message": "Error description",
    "code": "ERROR_CODE"
  }
}
```

## Notes

- All dates should be in ISO 8601 format
- File uploads limited to 10MB
- Pagination: Use `?page=1&limit=10` query parameters
- Filtering: Use query parameters like `?status=active`
