# 🌐 SocialApp — Spring Boot Social Media Platform
**Group 05 | CSCI 22082 - Object Oriented Programming II | University of Kelaniya**

---

## 📋 Project Overview
A full-featured social media web application built with Spring Boot, Thymeleaf, and PostgreSQL.

### Features Implemented
| Feature | Type | Points |
|---|---|---|
| User Registration & Login | Mandatory | ✅ |
| Home Feed (own + friends' posts) | Mandatory | ✅ |
| Create / Delete Posts | Mandatory | ✅ |
| Like / Unlike Posts | Mandatory | ✅ |
| Friend Request System | Mandatory | ✅ |
| Session Management & Logout | Mandatory | ✅ |
| Comment System | Optional | 5% ✅ |
| User Profile Page | Optional | 5% ✅ |
| Search (users + posts) | Optional | 5% ✅ |

---

## 🏗️ Project Structure

```
src/main/java/com/social/app/
├── SocialAppApplication.java      ← Entry point
│
├── model/                         ← Domain entities (JPA)
│   ├── User.java
│   ├── Post.java
│   ├── Comment.java
│   ├── Like.java
│   ├── FriendRequest.java
│   └── Friendship.java
│
├── repository/                    ← Data access layer (Spring Data JPA)
│   ├── UserRepository.java
│   ├── PostRepository.java
│   ├── CommentRepository.java
│   ├── LikeRepository.java
│   ├── FriendRequestRepository.java
│   └── FriendshipRepository.java
│
├── service/                       ← Business logic layer
│   ├── CustomUserDetailsService.java
│   ├── UserService.java
│   ├── PostService.java
│   ├── InteractionService.java
│   └── FriendService.java
│
├── controller/                    ← HTTP request handlers (MVC)
│   ├── AuthController.java
│   ├── FeedController.java
│   └── ProfileController.java
│
├── dto/                           ← Data Transfer Objects
│   ├── RegisterDTO.java
│   └── UpdateProfileDTO.java
│
├── exception/                     ← Custom exceptions
│   ├── ResourceNotFoundException.java
│   └── UnauthorizedException.java
│
└── config/
    └── SecurityConfig.java        ← Spring Security configuration

src/main/resources/
├── application.properties         ← Database and Spring config
├── static/css/style.css           ← UI stylesheet
└── templates/                     ← Thymeleaf HTML templates
    ├── fragments/layout.html      ← Shared navbar, footer, flash messages
    ├── auth/login.html
    ├── auth/register.html
    ├── feed.html
    ├── search.html
    └── profile/
        ├── view.html
        └── edit.html
```

---

## 🛠️ Setup Instructions

### Prerequisites
- Java 17+
- Maven 3.8+
- PostgreSQL 14+

### 1. Create the Database
```sql
CREATE DATABASE socialapp_db;
```

### 2. Configure Database Credentials
Edit `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/socialapp_db
spring.datasource.username=postgres
spring.datasource.password=YOUR_PASSWORD_HERE
```

### 3. Run the Application
```bash
mvn spring-boot:run
```

Or build and run the JAR:
```bash
mvn clean package
java -jar target/socialapp-1.0.0.jar
```

### 4. Access the App
Open your browser and go to: **http://localhost:8080/auth/register**

---

## 🔑 OOP Concepts Used

| Concept | Where Applied |
|---|---|
| **Encapsulation** | All entity fields are private with Lombok getters/setters |
| **Inheritance** | Spring Security's UserDetails interface implemented |
| **Polymorphism** | Service interfaces + Spring's DI container |
| **Abstraction** | Repository interfaces hide database implementation |
| **Composition** | User owns Posts, Comments, Likes via OneToMany |
| **Association** | FriendRequest links two User instances |
| **Enum** | `FriendRequest.Status` models PENDING/ACCEPTED/REJECTED |
| **Design Patterns** | MVC (Controller→Service→Repository), Builder (Lombok), DTO |

---

## 👨‍💻 Team Contributions

| Student | Name | Responsibility |
|---|---|---|
| CS/2022/002 | DESHAN K.S. | Spring Boot setup, Security config, backend integration |
| CS/2022/017 | MENAKA W.A.G. | User registration, login, profile, password encryption |
| CS/2022/031 | DINARA M.V. | Post CRUD, home feed, sorting |
| CS/2022/037 | SEWMINA H.T.G.A. | Like/Unlike, Comment system |
| CS/2022/052 | SENANAYAKE J.V. | Friend request system, friendships |
| CS/2022/054 | PRAMODYA N.A.H. | Search functionality, UI templates |

---

## 📚 Tech Stack
- **Backend**: Spring Boot 3.2, Spring Security, Spring Data JPA
- **Frontend**: Thymeleaf, HTML5, CSS3 (no external CSS frameworks)
- **Database**: PostgreSQL 14
- **ORM**: Hibernate
- **Security**: BCrypt password hashing (strength 12)
- **Build**: Maven
