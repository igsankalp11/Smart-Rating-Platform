pip install flask flask-sqlalchemy mysql-connector-python


from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# Update the connection string to use MySQL
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://username:password@localhost/store_ratings'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Models
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)
    role = db.Column(db.String(10), nullable=False, default='user')  # 'user' or 'admin'

class Store(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

class Rating(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    store_id = db.Column(db.Integer, db.ForeignKey('store.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    rating = db.Column(db.Integer, nullable=False)

# Routes (rest of the code remains the same as before)
@app.route('/')
def index():
    if 'user_id' in session:
        user = User.query.get(session['user_id'])
        stores = Store.query.all()
        return render_template('index.html', user=user, stores=stores)
    return redirect(url_for('login'))

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        username = request.form['username']
        password = generate_password_hash(request.form['password'])
        if User.query.filter_by(username=username).first():
            flash('Username already exists!')
        else:
            user = User(username=username, password=password, role='user')
            db.session.add(user)
            db.session.commit()
            flash('Signup successful! Please log in.')
            return redirect(url_for('login'))
    return render_template('signup.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(username=username).first()
        if user and check_password_hash(user.password, password):
            session['user_id'] = user.id
            session['role'] = user.role
            flash('Login successful!')
            return redirect(url_for('index'))
        flash('Invalid username or password')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    flash('Logged out successfully!')
    return redirect(url_for('login'))

@app.route('/rate/<int:store_id>', methods=['POST'])
def rate_store(store_id):
    if 'user_id' not in session:
        flash('Please log in to rate stores.')
        return redirect(url_for('login'))

    rating_value = int(request.form['rating'])
    user_id = session['user_id']
    existing_rating = Rating.query.filter_by(store_id=store_id, user_id=user_id).first()

    if existing_rating:
        existing_rating.rating = rating_value
        flash('Rating updated!')
    else:
        rating = Rating(store_id=store_id, user_id=user_id, rating=rating_value)
        db.session.add(rating)
        flash('Rating submitted!')

    db.session.commit()
    return redirect(url_for('index'))

@app.route('/admin', methods=['GET', 'POST'])
def admin():
    if 'user_id' in session and session['role'] == 'admin':
        if request.method == 'POST':
            store_name = request.form['store_name']
            store = Store(name=store_name)
            db.session.add(store)
            db.session.commit()
            flash('Store added successfully!')
        stores = Store.query.all()
        return render_template('admin.html', stores=stores)
    flash('Access denied!')
    return redirect(url_for('index'))

# Initialize the database
@app.before_first_request
def create_tables():
    db.create_all()

if __name__ == '__main__':
    app.run(debug=True)
