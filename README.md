# School Management API

A RESTful API built with Node.js, Express.js, and MySQL for managing school data with proximity-based sorting.

---

## Project Structure

```
school-api/
├── src/
│   ├── config/
│   │   ├── db.js                 # MySQL connection pool
│   ├── controllers/
│   │   └── schoolController.js
│   ├── middlewares/
│   │   └── validation.js         # Joi input validation
│   ├── routes/
│   │   └── schoolRoutes.js
│   ├── utils/
│   │   └── distance.js           # Haversine formula
│   └── server.js                 # Entry point
├── postman_collection.json
├── .env.example
└── package.json
```

---

## Prerequisites

| Tool    | Version |
|---------|---------|
| Node.js | >= 18.x |
| npm     | >= 9.x  |
| MySQL   | >= 8.x  |

---

## Local Setup

### 1. Clone and install

```bash
git clone <your-repo-url>
cd school-api
npm install
```

### 2. Configure environment

```bash
cp .env.example .env
```

Edit `.env` with your MySQL credentials:

```env
PORT=3000
NODE_ENV=development
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=school_management
```

### 3. Set up the database

Open the MySQL Command Line Client and run the migration:

```bash
mysql -u root -p < src/config/migration.sql
```

This creates the `school_management` database, the `schools` table, and inserts 10 sample schools.

or just use 

```
CREATE DATABASE school_management;
USE school_management;

CREATE TABLE schools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(500) NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL
);
```

And then manually add and get the schools.

### 4. Start the server

```bash
npm start        # production
npm run dev      # development with auto-restart
```

Server runs at `http://localhost:3000`.

---

## API Reference

### GET /

Health check. Returns API info and available endpoints.

---

### POST /add-school

Adds a new school to the database.

**Request body** (`application/json`):

```json
{
  "name": "Sunrise Public School",
  "address": "12 MG Road, Agra, Uttar Pradesh 282001",
  "latitude": 27.1767,
  "longitude": 78.0081
}
```

| Field     | Type   | Constraints                    |
|-----------|--------|--------------------------------|
| name      | string | Required, max 255 chars        |
| address   | string | Required, max 500 chars        |
| latitude  | number | Required, -90 to 90            |
| longitude | number | Required, -180 to 180          |

**201 Created:**

```json
{
  "success": true,
  "message": "School added successfully.",
  "data": {
    "id": 11,
    "name": "Sunrise Public School",
    "address": "12 MG Road, Agra, Uttar Pradesh 282001",
    "latitude": 27.1767,
    "longitude": 78.0081
  }
}
```

**400 Bad Request:**

```json
{
  "success": false,
  "message": "Validation failed.",
  "errors": [
    "\"name\" is not allowed to be empty",
    "\"latitude\" must be less than or equal to 90"
  ]
}
```

---

### GET /list-schools

Returns all schools sorted by proximity (nearest first) using the Haversine formula.

**Query parameters:**

| Param     | Type   | Required | Example  |
|-----------|--------|----------|----------|
| latitude  | number | Yes      | 27.1767  |
| longitude | number | Yes      | 78.0081  |

**Example:**

```
GET /list-schools?latitude=27.1767&longitude=78.0081
```

**200 OK:**

```json
{
  "success": true,
  "message": "Schools retrieved and sorted by proximity.",
  "user_location": {
    "latitude": 27.1767,
    "longitude": 78.0081
  },
  "count": 10,
  "data": [
    {
      "id": 8,
      "name": "Agra Public School",
      "address": "Sanjay Place, Agra, Uttar Pradesh 282002",
      "latitude": 27.1767,
      "longitude": 78.0081
    },
    {
      "id": 9,
      "name": "City Montessori School",
      "address": "Mahanagar, Lucknow, Uttar Pradesh 226006",
      "latitude": 26.8467,
      "longitude": 80.9462
    }
  ]
}
```

---

## Database Schema

```sql
CREATE TABLE schools (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(255)  NOT NULL,
  address     VARCHAR(500)  NOT NULL,
  latitude    FLOAT(10, 6)  NOT NULL,
  longitude   FLOAT(10, 6)  NOT NULL
);
```

---