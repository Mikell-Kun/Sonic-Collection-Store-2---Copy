DELIMITER //
CREATE PROCEDURE sp_UpdateProducts(IN pIdproduct INT, IN pProductName VARCHAR(50), IN pNewPrice DOUBLE, IN pNewImage LONGBLOB)
BEGIN
    UPDATE products
    SET idproduct = pIdproduct, price = pNewPrice, image = pNewImage
    WHERE idproduct = pIdproduct;
END //
DELIMITER ;
