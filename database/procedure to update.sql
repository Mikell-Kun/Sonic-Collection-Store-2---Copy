DELIMITER //
CREATE PROCEDURE sp_UpdateUser(IN pUserName VARCHAR(20), IN pNewPassword VARCHAR(102), IN pNewRole TINYINT
)
BEGIN
    DECLARE hashedPassword VARCHAR(255);
    SET hashedPassword = SHA2(pNewPassword, 256); -- Utiliza SHA-256 para hashear la nueva contraseña.
    UPDATE users
    SET password = hashedPassword, role = pNewRole
    WHERE username = pUserName;
END //
DELIMITER ;
