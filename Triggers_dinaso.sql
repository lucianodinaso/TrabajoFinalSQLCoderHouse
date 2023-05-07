#Trigger 1: ‘tr_ventas_ai_aud’

CREATE TRIGGER tr_ventas_ai_aud 
AFTER INSERT ON ventas 
FOR EACH ROW
	INSERT INTO _ventas_insert_aud (Id_venta, cod_venta_market, fecha_venta, cantidad,
						precio_venta, fecha_en_camino, fecha_entregado, Id_costos,
                        Id_costos_com, Id_compradores, Id_estado, Id_productos, 
                        Id_publicacion, usuario, fecha)
	VALUES ( NEW.Id_venta, NEW.cod_venta_market, NEW.fecha_venta, NEW.cantidad, NEW.precio_venta, 
			NEW.fecha_en_camino, NEW.fecha_entregado, NEW.Id_costos, NEW.Id_costos_com, 
            NEW.Id_compradores, NEW.Id_estado, NEW.Id_productos, NEW.Id_publicacion, 
			CURRENT_USER() , NOW()) ;



#Trigger 2: “tr_compradores_bu_aud”

CREATE TRIGGER tr_compradores_bu_aud 
BEFORE UPDATE ON compradores
FOR EACH ROW 
    INSERT INTO _compradores_update_aud
        ( entidad ,  Id_compradores, nombre , apellido,
         dni ,  ciudad , provincia,  codigo_postal ,  domicilio, 
         email,  telefono , usuario , fecha)
    VALUES ('compradores', OLD.Id_compradores, OLD.nombre , OLD.apellido,
            OLD.dni ,  OLD.ciudad , OLD.provincia,  OLD.codigo_postal ,  OLD.domicilio, 
            OLD.email,  OLD.telefono , current_user() , now());
