-- Esta vista, muestra un Estado de resultado, mes a mes.
-- Muestra por mes, Ventas, Costos de (Compra, Envios, comisiones)
-- la utilidad y el ratio Margen de ganancia.

create view v_EstadoResultado as
select month(v.fecha_venta) as Mes,
sum(v.precio_venta) as Venta,
sum(c.costo_reposicion ) as Costo_Compra,
round(sum(v.precio_venta)*0.09)  as Envio,
round(sum(v.precio_venta)*0.15) as Comision,
#Calculo de utilidad
round(
sum(v.precio_venta) -
sum(c.costo_reposicion ) -
round(sum(v.precio_venta)*0.09) -
round(sum(v.precio_venta)*0.15) 
) as Utilidad,
#Calculo de Margen = (Utilidad - Ventas)*100
round(((round(
sum(v.precio_venta) -
sum(c.costo_reposicion ) -
round(sum(v.precio_venta)*0.09) -
round(sum(v.precio_venta)*0.15) 
))/
sum(v.precio_venta))
*100,2)
as Margen
from ventas as v
inner join costos as c
on v.Id_costos = c.Id_costos
group by month(v.fecha_venta);
