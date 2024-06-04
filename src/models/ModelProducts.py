from .entities.products import Product

class ModelProducts():
    @classmethod
    def add_product(cls, db, product):
        try:
            cursor = db.connection.cursor()
            cursor.execute(
                "CALL sp_AddProducts(%s, %s, %s)", 
                (product.productname, product.price, product.image)
            )
            db.connection.commit()
        except Exception as ex:
            db.connection.rollback()
            raise Exception(ex)
    
    @classmethod
    def get_product_by_id(cls, db, product_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute(
                "SELECT idproduct, productname, price, image FROM products WHERE id = %s", 
                (product_id))
            row = cursor.fetchone()
            if row:
                return Product(row[0], row[1], row[2], row[3])
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
    
    # You can add more methods like update_product, delete_product, get_all_products, etc.
