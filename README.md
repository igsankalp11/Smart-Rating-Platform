Store Rating Platform

This is a web application that allows users to rate stores on a scale of 1 to 5. It includes features for user signup, login, and role-based functionalities for normal users and admins. The backend is powered by Flask, and the database is managed using MySQL.

Features

User Roles:

Admin: Add new stores to the platform.

User: Rate stores (1-5) and update existing ratings.

Authentication:

Signup and login system with hashed passwords for security.

Database:

MySQL database to store user data, store information, and ratings.

Technologies Used

Backend: Flask (Python)

Database: MySQL

Frontend: HTML, CSS (templates included in templates folder)

Password Security: Hashing with Werkzeug

Installation and Setup

Clone the Repository:

git clone https://github.com/yourusername/store-rating-app.git
cd store-rating-app

Set Up a Virtual Environment:

python -m venv venv
source venv/bin/activate   # On Windows: venv\Scripts\activate

Install Dependencies:

pip install -r requirements.txt

Set Up the Database:

Install MySQL and start the MySQL service.

Log in to MySQL and create a database:

CREATE DATABASE store_ratings;

Update the database connection string in app.config:

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://username:password@localhost/store_ratings'

Run the Application:

flask run

The application will be available at http://127.0.0.1:5000/.

Initialize the Database:
Tables will be created automatically on the first request to the app.

File Structure

store-rating-app/
├── app.py                # Main application file
├── templates/            # HTML templates
│   ├── index.html        # Homepage
│   ├── login.html        # Login page
│   ├── signup.html       # Signup page
│   └── admin.html        # Admin page for adding stores
├── static/               # Static files (CSS, JS, images)
├── requirements.txt      # Python dependencies
└── README.md             # Project documentation

Routes

/ - Homepage (Displays stores, accessible after login)

/signup - User registration page

/login - User login page

/logout - Logout

/rate/<store_id> - Submit or update a store rating

/admin - Admin page to add stores (accessible only to admins)

Admin Access

To grant admin access to a user, update their role in the database:

UPDATE user SET role = 'admin' WHERE username = 'admin_username';

Future Enhancements

Pagination for stores

Average rating calculation for stores

User profile pages

Enhanced admin dashboard

Contributing

Contributions are welcome! Please fork this repository and submit a pull request for review.

License

This project is licensed under the MIT License. See the LICENSE file for details.

Contact

For any questions or suggestions, please contact your_email@example.com.
