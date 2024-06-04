CREATE DATABASE store_sonic_database;

use store_sonic_database;

create table users(
id smallint unsigned NOT NULL AUTO_INCREMENT,
username varchar(20) NOT NULL,
password char(102) NOT NULL,
role tinyint NOT NULL,
primary key(id)
);

create table products(
idproduct smallint unsigned NOT NULL AUTO_INCREMENT,
productname varchar(50) NOT NULL,
price double NOT NULL,
image LONGBLOB,
primary key(idproduct)
);

DROP TABLE users;

DROP DATABASE store_sonic_database;

DROP procedure sp_AddProducts;
DROP procedure sp_DeleteProducts;
DROP procedure sp_UpdateProduct;

