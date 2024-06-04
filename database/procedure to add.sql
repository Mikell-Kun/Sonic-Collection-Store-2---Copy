DELIMITER //
CREATE PROCEDURE sp_AddUser(IN pUserName VARCHAR(20), IN pPassword VARCHAR(102), in pRole tinyint)
BEGIN
 DECLARE hashedPassword VARCHAR(255);
 SET hashedPassword = SHA2(pPassword, 256); -- Utiliza SHA-256 para hashear la contraseña.
 INSERT INTO users (username, password, role )
 VALUES (pUserName, hashedPassword, pRole);
END //
DELIMITER 