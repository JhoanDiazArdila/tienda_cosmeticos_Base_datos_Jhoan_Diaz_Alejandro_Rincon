
-- 1. Listar todos los productos de cosméticos de un tipo específico (por ejemplo, "labial").
DELIMITER //
CREATE PROCEDURE PRODUCTOS_LABIAL()
BEGIN 
SELECT 
    p.id_producto,
    p.nombre,
    p.descripcion,
    p.precio,
    p.stock,
    c.tipo,
    c.tono_color,
    c.fecha_expiracion
FROM 
    productos p
JOIN 
    cosmeticos c ON p.id_producto = c.id_producto
WHERE 
    c.tipo = 'labial';

END // 
DELIMITER ;

CALL PRODUCTOS_LABIAL();
-- 2. Obtener todos los productos en una categoría (cosméticos, cuidado de la piel, perfumes, accesorios) cuyo stock sea inferior a un valor dado.
DELIMITER //
CREATE PROCEDURE productos_Categoria(IN TIPO VARCHAR(100) , in Numero int)
BEGIN 
SELECT 
    p.id_producto,
    p.nombre,
    p.descripcion,
    p.precio,
    p.stock,
    c.nombre AS categoria
FROM 
    productos p
JOIN 
    categorias c ON p.categoria_id = c.ID
LEFT JOIN 
    cosmeticos cos ON p.id_producto = cos.id_producto
LEFT JOIN 
    cuidado_piel cp ON p.id_producto = cp.id_producto
LEFT JOIN 
    perfumes per ON p.id_producto = per.id_producto
LEFT JOIN 
    accesorios a ON p.id_producto = a.id_producto
WHERE 
    c.nombre = TIPO
    AND p.stock < Numero;
END // 

DELIMITER ; 
 CALL productos_Categoria('Cosméticos',10000);
-- 3. Mostrar todas las ventas realizadas por un cliente específico en un rango de fechas.
DELIMITER //
CREATE PROCEDURE VentasPorFehca(in Fecha1 DATE, in Fecha2 DATE,  in ID_Cleinte int) 
BEGIN
SELECT 
    v.id_venta,
    v.fecha,
    u.nombre AS nombre_cliente,
    e.nombre AS nombre_empleado,
    p.nombre AS nombre_producto,
    vp.cantidad,
    p.precio,
    (vp.cantidad * p.precio) AS total_venta
FROM 
    Ventas v
JOIN 
    Usuarios u ON v.id_usuario = u.id
JOIN 
    Empleados e ON v.id_empleado = e.id_empleado
JOIN 
    VentasProductos vp ON v.id_venta = vp.id_venta
JOIN 
    Productos p ON vp.id_producto = p.id_producto
WHERE 
    v.id_usuario = ID_Cleinte AND v.fecha BETWEEN Fecha1 AND Fecha2
ORDER BY 
    v.fecha;
END // 
DELIMITER ; 
CALL VentasPorFehca('2023-01-9', '2023-12-24', 2);
-- 4. Calcular el total de ventas realizadas por un empleado en un mes dado.
DELIMITER //
CREATE PROCEDURE ventaPorEmpleadoenMesDado(IN mes INT, IN ano INT, IN id INT)
BEGIN 
    SELECT 
        e.id_empleado,
        e.nombre AS nombre_empleado,
        SUM(vp.cantidad * p.precio) AS total_ventas
    FROM 
        Ventas v
    JOIN 
        Empleados e ON v.id_empleado = e.id_empleado
    JOIN 
        VentasProductos vp ON v.id_venta = vp.id_venta
    JOIN 
        Productos p ON vp.id_producto = p.id_producto
    WHERE 
        MONTH(v.fecha) = mes
        AND YEAR(v.fecha) = ano
        AND e.id_empleado = id
    GROUP BY 
        e.id_empleado, e.nombre;
END // 
DELIMITER ;

CALL ventaPorEmpleadoenMesDado(1, 2023, 1);
-- 5. Listar los productos más vendidos en un período determinado.
DELIMITER //
CREATE PROCEDURE listarProductosMasVendidos(IN FECHA1 DATE, IN FECHA2 DATE)
BEGIN
    SELECT 
        p.id_producto,
        p.nombre AS nombre_producto,
        SUM(vp.cantidad) AS total_vendido
    FROM 
        Ventas v
    JOIN 
        VentasProductos vp ON v.id_venta = vp.id_venta
    JOIN 
        Productos p ON vp.id_producto = p.id_producto
    WHERE 
        v.fecha BETWEEN FECHA1 AND FECHA2  
    GROUP BY 
        p.id_producto, p.nombre
    ORDER BY 
        total_vendido DESC
    LIMIT 5;  
END // 
DELIMITER ;

CALL listarProductosMasVendidos('2023-01-01', '2023-12-31');


-- 6. Consultar el stock disponible de un producto por su nombre o identificador.
DELIMITER $$
CREATE PROCEDURE consultar_stock_id(
    IN p_id_producto INT
)
BEGIN
    SELECT stock 
    FROM productos 
    WHERE id_producto = p_id_producto;
END$$
DELIMITER ;

CALL consultar_stock_id(1);


-- 7. Mostrar las órdenes de compra realizadas a un proveedor específico en el último año.
DELIMITER $$
CREATE PROCEDURE consultar_ordenes_compra_proveedor(
    IN p_id_proveedor INT
)
BEGIN
    SELECT o.id_orden_compra, o.fecha, p.nombre
    FROM OrdenCompra o
    JOIN proveedores p ON o.id_proveedor = p.id
    WHERE o.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) 
        AND o.id_proveedor = p_id_proveedor;
END$$
DELIMITER ;

CALL consultar_ordenes_compra_proveedor(1);

-- 8. Listar los empleados que han trabajado más de un año en la tienda.
DELIMITER $$

CREATE PROCEDURE consultar_empleados_mayor_año()
BEGIN
    SELECT e.id_empleado, e.nombre, e.fecha_contratacion
    FROM empleados e
    WHERE e.fecha_contratacion < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
END$$
DELIMITER ;

CALL consultar_empleados_mayor_año();


-- 9. Obtener la cantidad total de productos vendidos en un día específico.
DELIMITER $$
CREATE PROCEDURE consultar_productos_vendidos_dia(
    IN p_fecha DATE
)
BEGIN
    SELECT SUM(vp.cantidad) AS total_productos_vendidos
    FROM VentasProductos vp
    WHERE vp.fecha = p_fecha;
END$$
DELIMITER ;

CALL consultar_productos_vendidos_dia('2024-10-01');



-- 10. Consultar las ventas de un producto específico (por nombre o ID) y cuántas unidades se vendieron.
DELIMITER $$
CREATE PROCEDURE consultar_ventas_producto(
    IN p_nombre_producto VARCHAR(50)
)
BEGIN
    SELECT vp.cantidad, vp.fecha, vp.id_venta
    FROM VentasProductos vp
    JOIN productos p ON vp.id_producto = p.id_producto
    WHERE p.nombre = p_nombre_producto;
END$$
DELIMITER ;

CALL consultar_ventas_producto ('Labial Hidratante');
