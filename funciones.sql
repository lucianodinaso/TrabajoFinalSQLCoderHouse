#Función 1: `FN_CANT_VENTAS_MES`
/*Se envía por parámetro el número del mes que se desea obtener la información, 
y devuelve la suma total de ventas en cantidades por mes.*/

DELIMITER $$
CREATE FUNCTION FN_CANT_VENTAS_MES(P_MES VARCHAR(2)) RETURNS int
    DETERMINISTIC
BEGIN

	DECLARE NUMERO INT;

	SELECT COUNT(*) INTO NUMERO FROM VENTAS
	WHERE month(fecha_venta) = P_MES;
	RETURN NUMERO;

END$$

#Función 2: `FN_TOTAL_PROVINCIA`
/*Se envía por parámetro la provincia que se desea obtener la información
 y devuelve la suma total de ventas en cantidades por provincia.*/
 
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_TOTAL_PROVINCIA`(P_PALABRA VARCHAR(40)) RETURNS float
    DETERMINISTIC
BEGIN
DECLARE NUMERO INT;

SELECT COUNT(*) INTO NUMERO FROM COMPRADORES
WHERE PROVINCIA LIKE CONCAT('%', P_PALABRA, '%');

RETURN NUMERO;

END$$

#Función 3: `FN_TOTALVENTAS_POR_PRODUCTO`
/*Se envía por parámetro el nombre del producto que se desea obtener la información
 y devuelve la suma total de ventas en pesos por producto.*/
 
DELIMITER $$
CREATE FUNCTION FN_TOTALVENTAS_POR_PRODUCTO(P_PRODUCTO varchar(60)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE NUMERO INT;

	SELECT  sum(ventas.precio_venta) into NUMERO
	FROM ventas
	INNER JOIN productos
	on productos.Id_productos = ventas.Id_productos
	where productos.nombre_producto like  P_PRODUCTO ;

	RETURN NUMERO;

END$$
