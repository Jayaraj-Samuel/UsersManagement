# User Management System

A secure, modern, full-stack Java web application for managing application users, roles, and security statuses from a centralized dashboard.

Built using **Java 22**, **Jersey REST API**, **JDBC**, **MySQL**, **JSP**, **jQuery**, **Bootstrap 5**, and **Apache Tomcat 10.1**.

---

## 🚀 Architecture & Key Features

```
Browser (JSP + Bootstrap 5 + jQuery AJAX)
       │
       ▼
SessionFilter (Protected /api/users/*)
       │
       ▼
Jersey REST API Controllers
       │
       ▼
DAO Layer (JDBC + PreparedStatement)
       │
       ▼
MySQL Database (user_management)
```

### ✨ Highlights & Features
- **Session-Based Authentication**: Secure authentication using `HttpSession` and `SessionFilter` protecting all `/api/users/*` endpoints.
- **PBKDF2 Password Hashing**: Passwords are securely hashed with **PBKDF2 HMAC SHA-256 (210,000 iterations)** via `PasswordUtil`. Plaintext passwords and `password_hash` are never exposed to the frontend.
- **Full User CRUD Operations**:
  - **Add User**: Interactive Bootstrap 5 modal with client & server validation, email format verification, and duplicate email prevention (`409 Conflict`).
  - **Edit User**: Modal pre-populated via `GET /api/users/{id}`, with optional password updates without overwriting existing hashes when left blank.
  - **Delete User**: Dedicated confirmation dialog preventing accidental deletions (`DELETE /api/users/{id}`).
  - **List Users**: Asynchronously loaded table with role/status badges, dynamic avatars, and localized date formatting.
- **Live Search & Statistics**: Client-side filtering by name, email, role, or status, alongside real-time stats cards (Total Users, Active Users, Administrators).
- **Settings Workspace**: Self-service account password update form and live system health check (`/api/health`).
- **Cloud & Docker Ready**: Configurable via environment variables and includes a multi-stage `Dockerfile` for single-command deployment on Render, Railway, Fly.io, or Docker containers.

---

## 🛠️ Technology Stack

| Layer | Technology |
| :--- | :--- |
| **Language** | Java 22 |
| **Web / Servlet** | Jakarta Servlet 6.0, JSP 3.1 |
| **REST Framework** | Jersey REST API (Glassfish 3.1.11), Jackson JSON |
| **Persistence** | JDBC (MySQL Connector 26.7.0) |
| **Database** | MySQL 8.0+ |
| **Frontend** | JSP, HTML5, Vanilla CSS, Bootstrap 5, Bootstrap Icons |
| **Client Scripting** | jQuery 3.7.1, AJAX |
| **Build & Container** | Maven 3.9+, Docker |
| **Application Server** | Apache Tomcat 10.1 |

---

## 🗄️ Database Schema

Database Name: `user_management`  
Table: `users`

```sql
CREATE DATABASE IF NOT EXISTS user_management;
USE user_management;

CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER',
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

---

## 📡 REST API Reference

All REST endpoints produce and consume `application/json`.

| Method | Endpoint | Description | Auth Required | Status Codes |
| :--- | :--- | :--- | :---: | :--- |
| `POST` | `/api/auth/login` | Authenticate user & start session | ❌ | `200`, `400`, `401`, `403` |
| `GET` | `/api/auth/logout` | Invalidate current session | ❌ | `200` |
| `GET` | `/api/health` | Service health status check | ❌ | `200` |
| `GET` | `/api/users` | Retrieve all registered users | ✅ | `200`, `401`, `500` |
| `GET` | `/api/users/{id}` | Retrieve single user by ID | ✅ | `200`, `401`, `404`, `500` |
| `POST` | `/api/users` | Create a new user account | ✅ | `201`, `400`, `401`, `409`, `500` |
| `PUT` | `/api/users/{id}` | Update existing user account | ✅ | `200`, `400`, `401`, `404`, `409`, `500` |
| `DELETE` | `/api/users/{id}` | Remove user account | ✅ | `200`, `401`, `404`, `500` |

---

## 💻 Local Setup & Deployment

### Prerequisites
- JDK 22 installed & configured (`JAVA_HOME`)
- Apache Maven 3.9+
- MySQL Server 8.0+ running on port `3306`
- Apache Tomcat 10.1+

### 1. Configure Environment Variables
Set your local MySQL root password in your shell session:

**PowerShell (Windows)**:
```powershell
$env:USER_DB_PASSWORD="your_mysql_password"
```

**Bash / Zsh (Linux / macOS)**:
```bash
export USER_DB_PASSWORD="your_mysql_password"
```

### 2. Build WAR Package
Build the project using Maven:
```bash
mvn clean package
```
This generates `target/user-management.war`.

### 3. Deploy to Tomcat
Copy `target/user-management.war` into Tomcat's `webapps/` folder:
```powershell
Copy-Item .\target\user-management.war C:\Servers\apache-tomcat-10.1.60\webapps\ -Force
```

### 4. Start Tomcat & Launch
Start the server:
```powershell
C:\Servers\apache-tomcat-10.1.60\bin\startup.bat
```
Navigate to:
👉 **`http://localhost:8080/user-management/`**

---

## ☁️ Cloud & Docker Deployment

This project includes a multi-stage `Dockerfile` suitable for one-click deployment on platforms like **Render**, **Railway**, or **Fly.io**.

### Environment Variables for Cloud DB:
- `USER_DB_URL`: `jdbc:mysql://<host>:3306/<db_name>?useSSL=false&allowPublicKeyRetrieval=true`
- `USER_DB_USER`: `<database_username>`
- `USER_DB_PASSWORD`: `<database_password>`

> **Automatic Schema & First Login**:
> On initial startup, the application automatically creates the `users` table and provisions a default administrator account:
> - **Email**: `admin@example.com`
> - **Password**: `admin123`

### Run via Docker Locally:
```bash
# Build Docker image
docker build -t user-management-system .

# Run container
docker run -d -p 8080:8080 \
  -e USER_DB_URL="jdbc:mysql://host.docker.internal:3306/user_management?useSSL=false&allowPublicKeyRetrieval=true" \
  -e USER_DB_USER="root" \
  -e USER_DB_PASSWORD="your_password" \
  --name user-management user-management-system
```

---

## 🛡️ Security Best Practices Implemented
- **PreparedStatement**: All database queries use parametrized SQL to completely eliminate SQL Injection risks.
- **No Plaintext Passwords**: Passwords are never logged, exposed in JSON responses, or stored in plaintext in the database.
- **Session Protection**: `SessionFilter` verifies session validity on protected `/api/users/*` endpoints, returning `401 Unauthorized` for unauthenticated requests.
- **XSS Prevention**: Dynamic user data rendered in HTML is sanitized.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
