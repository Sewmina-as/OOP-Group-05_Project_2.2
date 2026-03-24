## `TEAM_GUIDE.md`

```md
# TEAM_GUIDE.md
Internal guide for the Spring Boot Social Media Application project.

## 1. Project Summary
This project is for **CSCI 22082 - Object Oriented Programming II**.

We must design and implement a **social media web application using Spring Boot**.

### Required technology stack
- Spring Boot
- Spring Data JPA
- MySQL or PostgreSQL
- Spring Security
- Thymeleaf
- Git and GitHub

### Frontend rules
- Thymeleaf must handle server-side page rendering
- Vanilla JavaScript with `fetch()` can be used for dynamic interactions such as updating like counts
- Styling may use plain CSS, Bootstrap, or Tailwind CSS
- **React, Vue, and Angular are not permitted**

---

## 2. Team Rules
- Team size must be **6 members**
- Team must be registered by **end of Week 1**
- One member must act as **Team Lead**
- Team Lead is responsible for repository setup and submission

### Team Lead responsibilities
- create the private GitHub repository
- add all team members as collaborators
- add the LIC as collaborator: `@haturusinghe`
- make sure the repository has a proper `.gitignore`
- make sure the team follows feature-branch workflow
- make sure milestones are submitted on time

---

## 3. Key Dates
- **End of Week 1** — Team registration
- **End of Week 4** — Requirements document + UML diagrams
- **Week 10** — Progress presentation
- **Week 14** — Final submission + live demo + presentation

---

## 4. Assessment Breakdown
- Mandatory Core Features — 60%
- Requirements Document & UML Diagrams — 5%
- Optional Additional Features — 20%
- Progress Presentation — 5%
- Final Presentation — 5%
- GitHub Workflow & Team Practices — 5%

---

## 5. Mandatory Features Checklist

### 5.1 Landing Page, Registration & Authentication
Must include:
- default landing page with login form
- visible link/button to registration form
- registration fields:
  - email
  - first name
  - last name
  - password
- input validation using Spring validation annotations
- BCrypt password hashing
- graceful handling of:
  - duplicate email registration
  - validation failures
- login using Spring Security
- session-based authentication
- redirect to Home Feed after successful login
- proper error messages for failed login

### 5.2 Home Feed & Post Creation
Must include:
- home feed after successful login
- create post section available from home feed
- text-only posts
- post validation
- each post must display:
  - author name
  - post content
  - timestamp
  - like count

### 5.3 Session Management & Logout
Must include:
- logout option on every authenticated page
- logout must invalidate session
- logout must redirect to landing page

### 5.4 Friend Management System
Must include:
- paginated user directory
- current logged-in user must not appear in own directory listing
- send friend requests
- view incoming requests separately
- view outgoing requests separately
- accept incoming requests
- decline incoming requests
- prevent duplicate friend requests
- prevent self-requests
- once users become friends, they should see each other’s posts in the home feed
- feed must combine own posts + friends’ posts
- feed must be sorted by newest first

### 5.5 Like / Unlike System
Must include:
- toggle button to like or unlike posts
- like count must update dynamically
- use AJAX / `fetch()` call to a REST endpoint
- no full page reload for like count update
- visible indicator showing whether current user liked a post

---

## 6. Optional Features
Optional features are not mandatory, but can increase marks up to a total of 20%.

### Available optional features
- User Profile Page — 5%
- Comment System — 5%
- Post Privacy Controls — 5%
- Search — 5%
- Notification System — 10%
- Admin Role & Dashboard — 10%

### Chosen optional features
- [Write selected optional feature 1]
- [Write selected optional feature 2]
- [Write selected optional feature 3]

### Recommendation
Finish all mandatory features first.
Only start optional features after the core system is stable.

---

## 7. Technical Rules We Must Follow

### 7.1 Object-Oriented Design
Code must follow:
- encapsulation
- inheritance
- polymorphism
- abstraction where appropriate
- SOLID principles

### 7.2 MVC Architecture
The app must follow the MVC pattern:
- Controllers handle requests
- Services contain business logic
- Repositories handle persistence

**Business logic must not be placed in controllers.**

### 7.3 Spring Boot Standards
Use these annotations properly:
- `@Controller`
- `@RestController`
- `@Service`
- `@Repository`
- `@Entity`

Rules:
- use Spring Data JPA for database operations
- raw SQL should be avoided unless absolutely necessary
- use Spring Security for authentication and authorization

### 7.4 Validation & Error Handling
- all input must be validated
- no unhandled exceptions should be shown to the end user
- validation messages must be user-friendly

### 7.5 Code Quality
- clean and readable code
- consistent formatting
- meaningful variable, method, and class names
- avoid duplication
- move reusable logic into services or utility classes

---

## 8. GitHub Workflow Rules

### 8.1 Repository Setup
- one private GitHub repository for the whole team
- Team Lead must initialize the repository by end of Week 1
- add all team members as collaborators
- add LIC as collaborator: `@haturusinghe`
- initialize with proper `.gitignore`

### 8.2 `.gitignore` rules
The repository must exclude:
- `target/`
- IDE files
- sensitive configuration

Recommended `.gitignore`:
```gitignore
target/

.idea/
*.iml
.vscode/
.project
.classpath
.settings/

*.log
.env
application-local.properties
application-secret.properties
.DS_Store
Thumbs.db