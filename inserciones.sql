INSERT INTO Usuarios (id, nombre, Telefono) VALUES 
(1, 'Juan Perez', '555-1234'),
(2, 'Ana Gomez', '555-5678'),
(3, 'Carlos Lopez', '555-2345'),
(4, 'Laura Rodriguez', '555-6789'),
(5, 'Pedro Morales', '555-3456'),
(6, 'Marta Sánchez', '555-7890'),
(7, 'Luis Ramírez', '555-4567');


INSERT INTO Empleados (nombre, telefono, correo, fecha_contratacion) VALUES
('Juan Pérez', '555-1234', 'juan.perez@example.com', '2023-01-15'),
('Ana Gómez', '555-5678', 'ana.gomez@example.com', '2023-02-20'),
('Carlos López', '555-2345', 'carlos.lopez@example.com', '2023-03-10'),
('Laura Rodríguez', '555-6789', 'laura.rodriguez@example.com', '2023-04-05'),
('Pedro Morales', '555-3456', 'pedro.morales@example.com', '2023-05-12'),
('Marta Sánchez', '555-7890', 'marta.sanchez@example.com', '2023-06-25'),
('Luis Ramírez', '555-4567', 'luis.ramirez@example.com', '2023-07-18');

INSERT INTO Ventas (fecha, id_empleado, id_usuario) VALUES
('2023-01-10', 1, 2),
('2023-01-15', 2, 2),
('2023-01-20', 3, 3),
('2023-01-25', 4, 4),
('2023-02-05', 5, 5),
('2023-02-10', 6, 6),
('2023-02-15', 5, 7),
('2023-03-01', 1, 1),
('2023-03-05', 1, 5),
('2023-03-10', 2, 5);

INSERT INTO Proveedores (nombre, celular, correo) VALUES
('Proveedor 1', '555-1111', 'proveedor1@example.com'),
('Proveedor 2', '555-2222', 'proveedor2@example.com'),
('Proveedor 3', '555-3333', 'proveedor3@example.com'),
('Proveedor 4', '555-4444', 'proveedor4@example.com'),
('Proveedor 5', '555-5555', 'proveedor5@example.com');

INSERT INTO categorias (nombre) 
VALUES ('Cosméticos'), ('Cuidado de la piel'), ('Perfumes'), ('Accesorios');

INSERT INTO productos (nombre, descripcion, categoria_id, precio, stock) VALUES
('Base de Maquillaje', 'La capa mágica que hace que tu piel brille como una estrella.', 1, 29.99, 50),
('Máscara de Pestañas', 'Pestañas que dicen “¡Mírame!” sin tener que hablar.', 4, 15.99, 100),
('Delineador de Ojos', 'Para que tus ojos tengan la actitud de un gato astuto.', 1, 12.49, 75),
('Sombra de Ojos', 'Colores que te transportan a un festival de fuegos artificiales.', 3, 19.99, 80),
('Labial Hidratante', 'Dale a tus labios el beso de la vida con un toque de color.', 2, 10.99, 120),
('Rubor en Crema', 'Para que tus mejillas luzcan como si acabas de correr una maratón (pero sin el sudor).', 1, 14.99, 60),
('Brillo Labial', 'Brillo que hará que tus labios sean el centro de atención (¡o al menos de la conversación!).', 2, 8.99, 150),
('Spray Fijador', 'El superhéroe que mantiene tu maquillaje en su lugar, sin importar el drama del día.', 3, 18.49, 90);



INSERT INTO VentasProductos (id_venta, id_producto, cantidad, fecha) VALUES
(1, 1, 2, '2024-10-01'),   
(1, 2, 1, '2024-10-01'),   
(2, 3, 3, '2024-10-02'),   
(3, 4, 1, '2024-10-02'),   
(3, 5, 4, '2024-10-03'),   
(3, 6, 2, '2024-10-03'),   
(4, 6, 5, '2024-10-04'),   
(1, 6, 1, '2024-10-04');  

INSERT INTO ProductosProveedores (id_proveedor, id_producto) VALUES
(1, 1),  
(1, 2),   
(2, 3),   
(3, 4),   
(4, 5),   
(2, 6),   
(5, 7),   
(3, 8);  

INSERT INTO OrdenCompra (fecha, id_proveedor) VALUES
('2024-10-01', 1),  
('2024-10-03', 2),   
('2024-10-05', 3),   
('2024-10-07', 4),   
('2024-10-10', 5);   
 
INSERT INTO ProductosOrdenCompra (id_producto, id_orden_compra, cantidad) 
VALUES 
(1, 1, 50),  
(2, 2, 30),  
(3, 3, 100), 
(4, 4, 10),  
(5, 5, 60);  


INSERT INTO cosmeticos (id_producto, tipo, tono_color, fecha_expiracion) 
VALUES 
(1, 'Labial', 'Rojo Intenso', '2025-08-12'), 
(2, 'Labial', 'Rosa Suave', '2026-01-20'), 
(3, 'Labial', 'Nude Brillante', '2024-12-15'), 
(4, 'Labial', 'Cereza Oscuro', '2025-06-30'), 
(5, 'Labial', 'Coral Vibrante', '2025-11-05'), 
(6, 'Polvos ', 'Marrón Chocolate', '2026-02-10'), 
(7, 'Labial', 'Vino Tinto', '2025-09-22'), 
(8, 'Labial', 'Naranja Neón', '2026-03-18');
