from flask import Flask
from config import config
from flask import render_template, redirect, request, url_for, flash, abort

from flask_mysqldb import MySQL
from models.ModelUsers import ModelUsers
from models.entities.users import User

from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from functools import wraps

app = Flask(__name__)
db = MySQL(app)
login_manager_app = LoginManager(app)

@app.route("/")
def index():
    return redirect("home")

@app.route("/login")
def home():
    return render_template("login.html")

@app.route("/shopAdmin.html")
def admin():
    return render_template("shopAdmin.html")

@app.route("/crudProducts")
def crudProducts():
    return render_template("crudProducts.html")

@app.route("/crudUser")
def crudProducts():
    return render_template("crudUser.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        user = User(0, request.form['username'], request.form['password'], 0)
        logged_user = ModelUsers.login(db, user)
        if logged_user != None:
            login_user(logged_user)
            if logged_user.role == 1:
                return redirect(url_for("shopAdmin"))
            else:
                return redirect(url_for("home"))
        else:
            flash("---Acceso denegado---")
            return render_template("auth/login.html")
    else:
        return render_template("auth/login.html")
    
@login_manager_app.user_loader
def load_user(id):
    return ModelUsers.get_by_id(db, id)

if __name__ == '__main__':
    app.config.from_object(config['development'])
    app.run()