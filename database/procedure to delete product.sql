DELIMITER //
CREATE PROCEDURE sp_DeleteProducts(IN pIdproduct INT)
BEGIN
    DELETE FROM products WHERE idproduct = pIdproduct;
END //
DELIMITER ;
