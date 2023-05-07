-#Procedure 1: ‘sp_get_compradores_order’
/*Este procedimiento consiste en enviar por parámetro, el campo por el cual
se desea ordenar y como segundo parámetro ASC/DESC, 
para determinar el tipo de orden ascendente o descendente. */

DELIMITER $$
CREATE PROCEDURE sp_get_compradores_order(IN campo char(20), orden char(4))
BEGIN
	IF campo <> ' ' THEN 
		SET @compradores_order = concat('ORDER BY ', campo, ' ', orden);
	ELSE
		SET @compradores_order= concat(" ");
	END IF;
    
    SET @sentencia_order = concat('SELECT * FROM compradores ', @compradores_order);
    
    PREPARE runSQL FROM @sentencia_order;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;	
    
END$$

#Procedure 2: sp_insert_products
/*Este procedimiento realiza un control al insertar datos en una tabla,
sino se envía el parámetro de nombre o variantes vacíos, no ingresa el registro,
 En todos los casos devuelve en una variable el resultado del procedimiento.*/
 
 DELIMITER $$
 CREATE PROCEDURE sp_insert_products(IN nombre varchar(50), descripcion varchar(100), cod_barras varchar(50), variantes varchar(25), OUT mensaje varchar(50))
BEGIN
	IF nombre = '' THEN
		SET @mensaje = 'No se puede agregar el producto, sin nombre';
	ELSEIF variantes ='' THEN
		SET @mensaje = 'No se puede agregar el producto, sin variante';
    ELSE
		INSERT INTO productos(nombre_producto, descripcion, cod_barras, variantes)
        VALUES (lcase(nombre), descripcion, cod_barras, (lcase(variantes)));
		SET mensaje = 'Producto agregado exitosamente';
		
        SET @clausula = 'SELECT * FROM productos ORDER BY Id_productos DESC LIMIT 1';
		PREPARE runSQL FROM @clausula;
		EXECUTE runSQL;
		DEALLOCATE PREPARE runSQL;    
	END IF;
    
 
       
    
END$$
