DELIMITER //
CREATE PROCEDURE sp_AddProducts (IN pProductname varchar(50), IN pPrice double, IN pImage LONGBLOB)
BEGIN 
 INSERT INTO products (productname, price, image) 
 VALUES (pProductname, pPrice, pimage);
END // 
DELIMITER ;