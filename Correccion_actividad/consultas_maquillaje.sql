


-- 1. Listar todos los productos de cosméticos de un tipo específico (por ejemplo, "labial").
DELIMITER $$
CREATE PROCEDURE listar_productos_cosmeticos(
    IN p_tipo_cosmetico VARCHAR(50)
)
BEGIN
    SELECT  p.id_producto AS ID,
            p.nombre AS nombre, 
            p.precio AS precio,
            p.stock AS stock,
            c.nombre AS categoria,
            tc.nombre AS Tipo
    FROM productos AS p
    JOIN categoria c ON p.id_categoria = c.id_categoria
    JOIN cosmetico co ON p.id_producto = co.id_producto
    JOIN tipo_cosmetico tc ON co.id_tipo_cosmetico = tc.id_tipo_cosmetico
    WHERE tc.nombre = p_tipo_cosmetico;
END $$
DELIMITER ;

CALL listar_productos_cosmeticos('labial');
SELECT * FROM producto;
SELECT * FROM tipo_cosmetico;
SELECT * FROM categoria;


-- 2. Obtener todos los productos en una categoría (cosméticos, cuidado de la piel, perfumes, accesorios) cuyo stock sea inferior a un valor dado.
DELIMITER $$
CREATE PROCEDURE productos_con_stock_inferior(
    IN p_categoria VARCHAR(50),
    IN p_stock INT
)
BEGIN
    SELECT *
    FROM producto AS p
    JOIN categoria c ON p.id_categoria = c.id_categoria
    WHERE c.nombre = p_categoria AND p.stock < p_stock;
END$$
DELIMITER ;

CALL productos_con_stock_inferior('cosmetico', 51);
SELECT * FROM producto;
SELECT * FROM categoria;


-- 3. Mostrar todas las ventas realizadas por un cliente específico en un rango de fechas.
DELIMITER $$
CREATE PROCEDURE ventas_cliente_rango_fecha(
    IN p_cliente INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT c.id_cliente AS cliente,
            c.nombre AS nombre,
            v.fecha_venta AS 'Fecha venta'
    FROM cliente c
    JOIN venta v ON c.id_cliente = v.id_cliente
    WHERE v.id_cliente = p_cliente
        AND v.fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin;
END $$
DELIMITER ;

CALL ventas_cliente_rango_fecha(1,'2023-12-20','2024-01-30');

SELECT * FROM cliente;
SELECT * FROM venta;


-- 4. Calcular el total de ventas realizadas por un empleado en un mes dado.
DELIMITER $$
CREATE PROCEDURE ventas_realizadas_x_empleado(
    IN p_id_empleado INT,
    IN p_mes INT,
    IN p_año INT
)
BEGIN
    -- IF p_mes NOT IN('enero','febrero','marzo','abril','mayo','junio',' julio','agosto','septiembre','octubre','noviembre','diciembre') THEN
    --     SIGNAL SQLSTATE '45000'
    --     SET MESSAGE_TEXT = 'Mes no valido';
    -- END IF;
    SELECT e.id_empleado AS 'ID empleado',
            e.nombre AS nombre,
            SUM(p.precio) AS 'ventas totales'
    FROM empleado AS e
    JOIN venta v ON e.id_empleado = v.id_empleado
    JOIN venta_producto vp ON v.id_venta = vp.id_venta
    JOIN producto p ON vp.id_producto = p.id_producto
    WHERE v.id_empleado = p_id_empleado
        AND MONTH(v.fecha_venta) = p_mes
        AND YEAR(v.fecha_venta) = p_año
    GROUP BY e.id_empleado,e.nombre;
END $$
DELIMITER ;

CALL ventas_realizadas_x_empleado(1,1,2024);

SELECT * FROM venta;



-- 5. Listar los productos más vendidos en un período determinado.
DELIMITER $$
CREATE PROCEDURE producto_mas_vendidos_fecha(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT p.id_producto AS ID,
            p.nombre AS producto,
            p.precio AS precio,
            SUM(vp.cantidad) AS cantidad_vendida
    FROM producto p
    JOIN venta_producto vp ON p.id_producto = vp.id_producto
    JOIN venta v ON vp.id_venta = v.id_venta
    WHERE v.fecha_venta 
        BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY p.id_producto, p.nombre, p.precio
    ORDER BY cantidad_vendida DESC;
END $$
DELIMITER ;

CALL producto_mas_vendidos_fecha('2023-12-25','2024-01-31');

SELECT * FROM venta;
SELECT * FROM producto;
SELECT * FROM venta_producto;


-- 6. Consultar el stock disponible de un producto por su nombre o identificador.
DELIMITER $$
CREATE PROCEDURE stock_x_idproducto(
    IN p_id_producto INT,
    IN p_nombre_producto VARCHAR(50)
)
BEGIN
    SELECT p.id_producto AS ID,
            p.nombre AS nombre,
            p.precio AS precio,
            p.stock AS disponible
    FROM producto AS p
    WHERE (p.id_producto = p_id_producto OR p.nombre = p_nombre_producto);
END $$
DELIMITER ;

CALL stock_x_idproducto(1,NULL);
SELECT * FROM producto;


-- 7. Mostrar las órdenes de compra realizadas a un proveedor específico en el último año.
DELIMITER $$
CREATE PROCEDURE ordenes_compra_proveedor(
    IN p_id_proveedor INT
)
BEGIN
    SELECT c.id_compra AS factura,
            pr.nombre_empresa AS 'Nombre empresa',
            c.fecha AS fecha,
            SUM(cp.cantidad) AS 'Total productos'
    FROM proveedor AS pr 
    JOIN compra c ON pr.id_proveedor = c.id_proveedor
    JOIN compra_producto cp ON c.id_compra = cp.id_compra
    WHERE c.fecha BETWEEN NOW() - INTERVAL 1 YEAR AND NOW()
        AND pr.id_proveedor = p_id_proveedor
    GROUP BY c.id_compra, pr.nombre_empresa, c.fecha;
END $$
DELIMITER ;

CALL ordenes_compra_proveedor(4);

SELECT * FROM proveedor;
SELECT * FROM compra;
SELECT * FROM compra_producto;


-- 8. Listar los empleados que han trabajado más de un año en la tienda.
DELIMITER $$
CREATE PROCEDURE empleados_trabajando()
BEGIN
    SELECT e.id_empleado AS ID, 
            e.nombre AS Nombre, 
            e.fecha_contratacion AS 'Fecha contratacion'
    FROM empleado AS e 
    WHERE TIMESTAMPDIFF(YEAR, e.fecha_contratacion, CURDATE()) > 1;
END $$
DELIMITER ;

CALL empleados_trabajando();

SELECT * FROM empleado;


-- 9. Obtener la cantidad total de productos vendidos en un día específico.
DELIMITER $$
CREATE PROCEDURE productos_vendidos_x_dia(
    IN p_fecha DATE
)
BEGIN
    SELECT v.id_venta AS 'ID compra',
            v.fecha_venta AS fecha,
            SUM(vp.cantidad) AS 'Cantidad comprada'
    FROM venta AS v 
    JOIN venta_producto vp ON v.id_venta = vp.id_venta
    WHERE v.fecha_venta = p_fecha
    GROUP BY v.id_venta, v.fecha_venta;
END $$
DELIMITER ;

CALL productos_vendidos_x_dia('2024-01-01');

SELECT * FROM venta;


-- 10. Consultar las ventas de un producto específico (por nombre o ID) y cuántas unidades se vendieron.

DELIMITER $$
CREATE PROCEDURE ventas_producto_total(
    IN p_id_producto INT,
    IN p_nombre_producto VARCHAR(255)
)
BEGIN
    SELECT p.id_producto AS 'ID producto',
            p.nombre AS 'Nombre producto',
            p.precio AS 'Precio unidad',
            SUM(vp.cantidad) AS 'Cantidad vendida',
            SUM(vp.cantidad * p.precio) AS 'Total vendido'
    FROM producto AS p 
    JOIN venta_producto vp ON p.id_producto = vp.id_producto
    WHERE (p.id_producto = p_id_producto OR p.nombre = p_nombre_producto)
    GROUP BY p.id_producto,p.nombre,p.precio;
END $$
DELIMITER ;

CALL ventas_producto_total(1,NULL);

SELECT * FROM venta_producto;
SELECT * FROM producto;
