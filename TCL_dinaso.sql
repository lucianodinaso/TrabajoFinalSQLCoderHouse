SELECT * FROM dcldinaso.productos;

select @@autocommit;
SET AUTOCOMMIT=0;
select @@autocommit;


START transaction;
delete from productos
where Id_productos in (13,12,11);

SELECT * FROM dcldinaso.productos;

-- Este rollback, deshace todas las operaciones realizadas después del star transacción.
-- Se habian eliminado 3 productos de la tabla productos, se deshacen los cambios con este roolback.
rollback;

-- Este commit, no genera ningún efecto, ya que se aplico un rollback previo.

commit;

SELECT * FROM dcldinaso.productos;

START transaction;
delete from productos
where Id_productos in (13,12,11);

SELECT * FROM dcldinaso.productos;

-- Este commit confirma y efectiviza las transacciones realizadas después del start transanccion.
-- Se eliminaron 3 productos, de la tabla, productos, este commit efectiviza los cambios.
commit;

-- Este rollback, no genera ningún efecto, ya que se aplico un commit previo.
rollback;

SELECT * FROM dcldinaso.productos;


-- TABLA NRO 2, APLICACION DE savepoint

SELECT * FROM dcldinaso.publicacion;

start transaction;
insert INTO publicacion VALUES(19,'MLA1134805261', 'Termo vintage 0.5l', 1);
insert INTO publicacion VALUES(20,'MLA1134805265', 'Termo vintage 0.6l', 1);
insert INTO publicacion VALUES(21,'MLA1134805269', 'Termo vintage 0.75l', 1);
insert INTO publicacion VALUES(22,'MLA1134805271', 'Termo vintage 1l', 1);
savepoint inserta_publicacion_1;
insert INTO publicacion values(23,'MLA1134805273', 'Termo vintage 1.25l', 1);
insert INTO publicacion values(24,'MLA1134805276', 'Termo vintage 1.5l', 1);
insert INTO publicacion values(25,'MLA1134805278', 'Termo vintage 1.75l', 1);
insert INTO publicacion values(26,'MLA1134805284', 'Termo vintage 2', 1);
savepoint inserta_publicacion_2;
insert INTO publicacion values(27,'MLA1134805273', 'Termo vintage 1.25l', 1);
insert INTO publicacion values(28,'MLA1134805276', 'Termo vintage 1.5l', 1);
insert INTO publicacion values(29,'MLA1134805278', 'Termo vintage 1.75l', 1);
insert INTO publicacion values(30,'MLA1134805284', 'Termo vintage 2', 1);
savepoint inserta_publicacion_3;

-- Se elimina el savepoint inserta_publicaion_2, se deshace el punto de recupero.
RELEASE savepoint inserta_publicacion_2;

-- Se intenta regresar al eliminarlo en la sentencia anterior, no es posible regresar a este punto.
rollback TO inserta_publicacion_2;

-- Se puede regresar al punto de recupero, donde se ingresaron las primeras 4 publicaciones.
rollback TO inserta_publicacion_1;

-- Efectiviza la inserción de los primeras 4 publicaciones.
commit;

SELECT * FROM dcldinaso.publicacion;


