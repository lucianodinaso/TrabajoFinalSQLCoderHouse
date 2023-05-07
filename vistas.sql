#Vista 1: ‘rankingventasmensuales’
CREATE VIEW rankingventasmensuales AS
SELECT month(fecha_venta), sum(precio_venta)
FROM ventas
group by month(fecha_venta);

#Vista 2: rankingventasproductos
CREATE VIEW rankingventasproductos AS
SELECT p.nombre_producto, sum(v.precio_venta)
FROM productos p
inner join ventas v
on p.Id_productos = v.Id_productos 
group by p.nombre_producto
order by sum(v.precio_venta) desc;

#Vista 3: rankingventasprovincias
CREATE VIEW rankingventasprovincias AS
select c.provincia, sum(v.precio_venta)
from compradores c
inner join ventas v
on c.Id_compradores = v.Id_compradores
group by c.provincia
order by sum(v.precio_venta) desc;

#Vista 4: ‘ticketpromediomensual’
CREATE VIEW ticketpromediomensual AS
SELECT month(fecha_venta), round(sum(precio_venta)/count(Id_venta))
FROM ventas
group by month(fecha_venta);

#Vista 5: ‘utilidadtotalproductos’
CREATE VIEW utilidadtotalproductos AS
SELECT p.nombre_producto, (sum(v.precio_venta)-sum(c.costo_reposicion)) as utilidad
FROM productos p
inner join ventas v
on p.Id_productos = v.Id_productos 
inner join costos c
on c.Id_costos = v.Id_costos
group by p.nombre_producto
order by sum(v.precio_venta) desc;

#Vista 6: v_estadoresuldado;
CREATE VIEW v_estadoresuldado AS
SELECT 
        MONTH(v.fecha_venta) AS Mes,
        SUM(v.precio_venta) AS Venta,
        SUM(c.costo_reposicion) AS Costo_Compra,
        ROUND((SUM(v.precio_venta) * 0.09), 0) AS Envio,
        ROUND((SUM(v.precio_venta) * 0.15), 0) AS Comision,
        ROUND((((SUM(v.precio_venta) - SUM(c.costo_reposicion)) - ROUND((SUM(v.precio_venta) * 0.09), 0)) - ROUND((SUM(v.precio_venta) * 0.15), 0)),
                0) AS Utilidad,
        ROUND(((ROUND((((SUM(v.precio_venta) - SUM(c.costo_reposicion)) - ROUND((SUM(v.precio_venta) * 0.09), 0)) - ROUND((SUM(v.precio_venta) * 0.15), 0)),
                        0) / SUM(v.precio_venta)) * 100),
                2) AS Margen
    FROM
        (ventas v
        INNER JOIN costos c 
        ON ((v.Id_costos = c.Id_costos)))
    GROUP BY MONTH(v.fecha_venta)
