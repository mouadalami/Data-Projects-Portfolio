# Features

## Flask Blog Application

### User Authentication
- Users can register, log in, and log out securely.
- Passwords are hashed using **Flask-Bcrypt** for added security.

### Profile Management
- Users can update their account details, including uploading a profile picture.
- Uploaded profile pictures are resized and saved securely.

### Dynamic Content
- The homepage dynamically displays a list of posts.
- Posts include metadata such as author and date.

### Session Management
- Implemented with **Flask-Login**, ensuring secure access to authenticated routes like the account page.

### Responsive Design
- UI built with **Bootstrap** for a responsive and clean design.

---

## Technologies Used

### Backend
- **Flask**: Core web framework.
- **Flask-SQLAlchemy**: Database integration.
- **Flask-Bcrypt**: Password hashing.
- **Flask-Login**: User session management.

### Frontend
- **Bootstrap**: Styling and responsiveness.
- **Custom CSS**: Additional styling provided in `style.css`.

### Database
- **SQLite**: Lightweight database used for development.

### Other Libraries
- **PIL**: Used for image processing when resizing profile pictures.

---

## File Structure

### `run.py`
- Entry point for running the Flask application.

### `flaskblog/`
- **`__init__.py`**: Initializes the app and sets up extensions.
- **`routes.py`**: Defines application routes and their logic.
- **`models.py`**: Defines database models (User and Post).
- **`forms.py`**: Contains WTForms classes for user input.
- **`static/`**:
  - `style.css`: Custom styles for the app.
  - `profile_pics/`: Directory for user-uploaded profile pictures.
- **`templates/`**:
  - `base.html`: Base template with shared layout.
  - `home.html`: Homepage template displaying posts.
  - `account.html`: Account management page.
  - `register.html`: Register page.
  - `login.html`: Login page.
- **`instance/`**:
  - `site.db`: SQLite database file storing user and post data.


