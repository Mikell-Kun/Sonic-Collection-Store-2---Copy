# Proyecto Tienda Online parte 2
### Gabriel Miguel Cabrera Samano - No.Control 20491199
### Aplicacion de flask

## Presentacion
Este proyecto tiene como objetivo crear una plataforma de comercio electrónico simple pero eficiente, que incluya funcionalidades básicas como la gestión de productos, el carrito de compras y un sistema de login para usuarios.

## Requisitos de instalacion:
editor de codigo: Visual Studio Code
lenguaje de programacion: python
librerias de Python: Flask (derivados: Flask-login, Flask-MySQLdb, Flask-WTF, FLASK_LOGIN)

## Pasos de instalacion en terminal
paso 1, para que podamos realizar una direccion, tenemos que crear un entorno virtual con el cual interacutar. 
Para que esto funcione debemos de crear el entorno virtual dentro de la carpeta env en donde se implementara todos los recursos que necesite el programa;
para crear un entorno virtual, ejecutamos el siguiente comando:
- py -m venv env
paso 2, en este paso debemos de activar el entorno virtual, por ende, ejecutaremos el siguiente comando:
- env\Scripts\activate
paso 3, dentro del entorno virtual, se instalaran los siguientes paquetes, con la finalidad de que nuestro proyecto permita realizar diferentes accesos dependiente del login,
es decir, que mientras un usuario no este logeado, automaticamente redireccione a la pagina de logeo.
ejecutamos los siguientes comandos:
- pip install Flask
- pip install Flask-Login
- pip install Flask-MySQLdb
- pip install Flask-WTF
- pip install FLASK_LOGIN

## librerias a usar:
En el desarrollo de aplicaciones web con Flask, se hace uso de varias librerías para gestionar diversas funcionalidades.
Flask es un microframework para Python que permite desarrollar aplicaciones web dentro de python, de esta manera es lo que utilizaremos para crear una instancia de la aplicación, configurar rutas y manejar solicitudes HTTP.
las siguientes librerias representan los siguientes significados:
- render_template: Renderiza plantillas HTML con datos dinámicos.
- redirect: Redirige a otra ruta de la aplicación.
- request: Maneja las solicitudes HTTP y sus datos.
- url_for: Genera URLs para las rutas definidas en la aplicación.
- flash: Envía mensajes de una sola vez a las plantillas.
- abort: Genera errores HTTP.
- LoginManager: Configura y maneja el sistema de autenticación de usuarios.
- login_user: Inicia la sesión de un usuario.
- logout_user: Cierra la sesión de un usuario.
- login_required: Protege rutas que requieren autenticación.
- current_user: Proporciona información sobre el usuario actualmente autenticado
- wraps se utiliza comúnmente para preservar la información de las funciones decoradas, como su nombre y docstring.

### implementacion en app.py:
```
from flask import Flask
from config import config
from flask import render_template, redirect, request, url_for, flash, abort

from flask_mysqldb import MySQL
from models.ModelUsers import ModelUsers
from models.entities.users import User

from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from functools import wraps
```

## config
la importacion de config es utilizada para cargar y manejar diferentes configuraciones de la aplicación, como las variables de entorno y en este caso, la configuración de la base de datos predeterminada.
esta configuracion dependera del acceso que manejes de manera predeterminada en tu base de datos de MySQL, por lo que deberas de implementar la informacion correspondiente de tu caso.
```
class DevelopmentConfig():
    DEBUG = True
    SECRET_KEY = "qhrf$edjYTJ)*21nsThdK"
    MYSQL_HOST = "localhost"
    MYSQL_USER = "root"
    MYSQL_PASSWORD = "asfsdfasdfsadf"
    MYSQL_DB = "store_sonic_database"
config = {"development": DevelopmentConfig}
```

## modelos y entidades
dentro de la carpeta de Models/Entities, contiene el objeto que representara la estructura de los usuarios
```
class User:
    def __init__(self, id, username, password, role) -> None:
        self.id = id
        self.username = username
        self.password = password
        self.role = role
```
La clase ModelUsers crea una interaccion con la base de datos para operaciones relacionadas con los usuarios, específicamente para la autenticación (login) y la recuperación de usuarios por ID (get_by_id). 
En este se usan los procedimientos almacenados y consultas SQL para interactuar con la base de datos y maneja posibles excepciones lanzando errores específicos.
```
from .entities.users import User

class ModelUsers():
    @classmethod
    def login(self, db, user):
        try:
            cursor = db.connection.cursor()
            cursor.execute(
                    "call sp_verifyIdentity(%s, %s)", (user.username, user.password))
            row = cursor.fetchone()
            if row[0] != None:
                user = User(row[0], row[1], row[2], row[3])
                return user
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_by_id(self, db, id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("SELECT id, username, role, FROM users WHERE id = %s", (id))
            row = cursor.fetchone()
            if row != None:
                return User(row[0], row[1], None, row[2])
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
```

