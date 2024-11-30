from flask import Flask, render_template, flash, redirect, url_for
from forms import RegistrationForm, LoginForm
app = Flask(__name__)

app.config['SECRET_KEY'] = '9f193177fcb14bb78e11859a6846a69e'

posts = [
    {
         'author' : 'Mouad Alami',
         'title' : 'Blog Post 1',
         'content' : 'First post content',
         'date_posted' : 'April 20, 2018',
    },
    {
         'author' : 'Jane Doe',
         'title' : 'Blog Post 2',
         'content' : 'Second post content',
         'date_posted' : 'April 21, 2028',
    }
]

@app.route("/")
@app.route("/home")
def home():
    return render_template("home.html", title = 'Home', posts = posts)

@app.route("/about")
def about():
    return render_template("about.html", title = 'About')

@app.route("/register", methods=['GET', 'POST'])
def register():
    form=RegistrationForm()
    if form.validate_on_submit():
        flash(f'Account created for {form.username.data}!', 'success')
        return redirect(url_for('home'))
    return render_template('register.html', title= 'Register', form=form)

@app.route("/login", methods=['GET', 'POST'])
def login():
    form=LoginForm()
    if form.validate_on_submit():
        if form.email.data == 'admin@blog.com' and form.password.data == 'password':
            flash('You have been logged in!', 'success')
            return redirect(url_for('home'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
    return render_template('login.html', title= 'Login', form=form)

if __name__ == '__main__':
    app.run(debug=True)


