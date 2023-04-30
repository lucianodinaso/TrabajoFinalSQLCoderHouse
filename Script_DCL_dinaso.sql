-- Se cro el 'usuarionuevo1' y este tiene una contraseña de ingreso
CREATE USER 'usuarionuevo1@localhost' IDENTIFIED BY 'Password1';

-- Se cro el 'usuarionuevo2' y este tiene una contraseña de ingreso
CREATE USER 'usuarionuevo2@localhost' IDENTIFIED BY 'Password2';

-- Al 'usuarionuevo1', se le aplico el permiso de lectura.
GRANT SELECT ON *.* TO 'usuarionuevo1@localhost';

-- Al 'usuarionuevo2', se le aplico el permiso de lectura.
GRANT SELECT, UPDATE, INSERT ON *.* TO 'usuarionuevo2@localhost';

-- Sentencia para chequear la creacion de los usuario y ver los permisos.
select * from mysql.user;

-- Sentencia para ver los permisos que posee cada usuario.
SHOW GRANTS FOR 'usuarionuevo1@localhost';
SHOW GRANTS FOR 'usuarionuevo2@localhost';