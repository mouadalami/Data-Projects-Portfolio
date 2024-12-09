
# FlaskBlog Project

## Overview

**FlaskBlog** is a full-stack blog application built with Flask. It provides features such as user authentication, profile management, blog post creation, and a password reset system. The app follows a modular structure for scalability and maintainability using Flask Blueprints.

The project was designed to enhance skills in Python, Flask, database management, and front-end integration, with a focus on building a fully functional web application.

---

## Features

### User Management
- **Registration**: Users can create accounts using a unique username and email.
- **Login/Logout**: Secure user authentication with password hashing (using bcrypt).
- **Profile Update**: Users can update their username, email, and profile picture.
- **Password Reset**: Email-based password reset functionality.

### Blog Functionality
- **Create, Read, Update, Delete (CRUD)**: Users can write, edit, and delete blog posts.
- **Pagination**: Posts on the homepage and user-specific pages are paginated for better readability.
- **Post Management**: Posts are displayed with metadata like author, timestamp, and profile picture.

### Modular Design
- Implemented **Flask Blueprints** to organize routes and functionality into logical modules:
  - **Users**: Handles authentication and account management.
  - **Posts**: Manages blog posts.
  - **Main**: Includes general routes like homepage and about page.

### Email Notifications
- Integrated **Flask-Mail** for sending password reset emails with token-based validation.

### Responsive UI
- Styled using **Bootstrap 4** for a clean and responsive user experience.

---

## Technologies Used

- **Backend**: Flask (Python)
- **Database**: SQLite (with SQLAlchemy ORM)
- **Authentication**: Flask-Login and bcrypt for secure login and password management.
- **Email**: Flask-Mail for email notifications.
- **Front-end**: HTML, CSS, and Bootstrap 4.
- **Image Processing**: PIL (Python Imaging Library) for handling profile pictures.

---

## File Structure

```
flaskblog_project/
│
├── flaskblog/
│   ├── __init__.py       # App and blueprint initialization
│   ├── config.py         # App configuration
│   ├── models.py         # Database models for User and Post
│   ├── users/            # Blueprint for user-related functionality
│   │   ├── __init__.py
│   │   ├── forms.py      # WTForms for user-related features
│   │   ├── routes.py     # Routes for user authentication and management
│   │   └── utils.py      # Helper functions (e.g., saving pictures, email reset)
│   ├── posts/            # Blueprint for post-related functionality
│   │   ├── __init__.py
│   │   ├── forms.py      # WTForms for creating and editing posts
│   │   └── routes.py     # Routes for creating, updating, and deleting posts
│   ├── main/             # Blueprint for main/general routes
│   │   ├── __init__.py
│   │   └── routes.py     # Home and About routes
│   ├── static/           # Static files (CSS, images)
│   │   ├── style.css     # Custom styling
│   │   └── profile_pics/ # Directory for user profile pictures
│   └── templates/        # HTML templates
│       ├── base.html     # Base layout template
│       ├── home.html     # Homepage
│       ├── account.html  # User account page
│       ├── create_post.html # Post creation/editing
│       ├── post.html     # Individual post page
│       ├── login.html    # Login page
│       ├── register.html # Registration page
│       ├── reset_request.html # Password reset request page
│       └── reset_token.html # Password reset page
│
├── instance/
│   └── site.db           # SQLite database
├── run.py                # Application entry point
└── README.md             # Project documentation
```

---

## Installation and Usage

### Prerequisites
- Python 3.8+
- Virtual environment (recommended)

### Installation Steps

1. Clone the repository:
   ```bash
   git clone <repository_url>
   cd flaskblog_project
   ```

2. Set up a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate   # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set environment variables for email functionality:
   ```bash
   export EMAIL_USER=<your_email>
   export EMAIL_PASS=<your_email_password>
   ```

5. Run the application:
   ```bash
   python run.py
   ```

6. Access the application in your browser at `http://127.0.0.1:5000`.

---

## Future Enhancements
- **API Integration**: Build a RESTful API for external data interactions.
- **Unit Testing**: Add test cases for critical routes and models.
- **Deployment**: Deploy the app using services like Heroku or AWS.
---

## Author
This project was developed as a learning exercise in Flask, Python, and web development. For questions or feedback, feel free to reach out!
