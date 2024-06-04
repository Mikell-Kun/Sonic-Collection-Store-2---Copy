DELIMITER //
CREATE PROCEDURE sp_verifyIdentity(IN pUsername VARCHAR(20), IN pPlainTextPassword VARCHAR(20))
BEGIN
 DECLARE storedPassword VARCHAR(255);
 
 SELECT password INTO storedPassword FROM users 
 WHERE username = pUsername COLLATE utf8mb4_unicode_ci;
 
 IF storedPassword IS NOT NULL AND storedPassword = SHA2(pPlainTextPassword, 256) THEN
 SELECT id, username, storedPassword, role FROM users
 WHERE username = pUserName COLLATE utf8mb4_unicode_ci;
 ELSE
 SELECT NULL;
 END IF;
END //
DELIMITER ;
