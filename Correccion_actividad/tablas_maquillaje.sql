

CREATE DATABASE maquillaje_en_casa; 

USE maquillaje_en_casa;


CREATE TABLE IF NOT EXISTS tipo_cosmetico(
    id_tipo_cosmetico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS tono_Color(
    id_tono_color INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS tipo_piel(
    id_tipo_piel INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS aroma(
    id_aroma INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS material(
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS categoria(
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS producto(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);
CREATE TABLE IF NOT EXISTS cosmetico(
    id_cosmetico INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_tipo_cosmetico INT NOT NULL,
    id_tono_color INT NOT NULL,
    fecha_expiracion DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_tipo_cosmetico) REFERENCES tipo_cosmetico(id_tipo_cosmetico),
    FOREIGN KEY (id_tono_color) REFERENCES tono_Color(id_tono_color)
);
CREATE TABLE IF NOT EXISTS cuidado_piel(
    id_cuidado_piel INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_tipo_piel INT NOT NULL,
    componente TEXT NOT NULL,
    fecha_expiracion DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_tipo_piel) REFERENCES tipo_piel(id_tipo_piel)
);
CREATE TABLE IF NOT EXISTS perfume(
    id_perfume INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_aroma INT NOT NULL,
    tamaño VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_aroma) REFERENCES aroma(id_aroma)
);
CREATE TABLE IF NOT EXISTS accesorio(
    id_accesorio INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_material INT NOT NULL,
    tamaño VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_material) REFERENCES material(id_material)
);
CREATE TABLE IF NOT EXISTS area_trabajo(
    id_area_trabajo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS empleado(
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    id_area_trabajo INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    FOREIGN KEY (id_area_trabajo) REFERENCES area_trabajo(id_area_trabajo)
);
CREATE TABLE IF NOT EXISTS cliente(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL UNIQUE 
);
CREATE TABLE IF NOT EXISTS venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);
CREATE TABLE IF NOT EXISTS venta_producto(
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    PRIMARY KEY(id_venta, id_producto)
);
CREATE TABLE IF NOT EXISTS proveedor(
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    nombre_contacto VARCHAR(100) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);
CREATE TABLE IF NOT EXISTS compra_producto(
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    PRIMARY KEY(id_compra, id_producto)
);


INSERT INTO tipo_cosmetico(nombre)
VALUES ('labial'),('base'),
('sombrea'),('blush'),
('polvo'),('humectante');

INSERT INTO tono_Color(nombre)
VALUES ('rosado'),('azul'),
('verde'),('amarillo'),
('negro'),('blanco');

INSERT INTO tipo_piel(nombre)
VALUES('seca'),('grasa'),
('normal'),('mixta'),
('sensible');

INSERT INTO aroma(nombre)
VALUES('rosas'),('lavanda'),
('limon'),('canela'),
('frutal');

INSERT INTO material(nombre)
VALUES('cuero'),('vidrio'),
('metal'),('oro'),
('plata');

INSERT INTO categoria(nombre)
VALUES 
('cosmetico'),('cuidado piel'),
('perfume'),('accesorio');

INSERT INTO producto(nombre, descripcion, precio, stock, id_categoria)
VALUES 
('labial rojo', 'labial rojo', 10.00, 100, 1),
('base transparente', 'base transparente', 15.00, 50, 1),
('sombrea azul', 'sombrea azul', 12.00,50, 1),
('crema cara','crema cara', 50.00, 20, 2),
('crema labial', 'crema labial', 25.00, 100, 2),
('perfume rosas', 'perfume rosas', 20.00, 100, 3),
('perfume limon', 'perfume limon', 20.00, 10, 3),
('cinturón', 'cinturón', 30.00, 50, 4),
('candongas', 'circulares', 40.00, 20, 4);

INSERT INTO cosmetico(id_producto, id_tipo_cosmetico, id_tono_color, fecha_expiracion)
VALUES 
(1, 1, 1, '2025-01-01'),
(2, 2, 2, '2025-01-01'),
(3, 3, 3, '2025-01-01');


INSERT INTO cuidado_piel(id_producto, id_tipo_piel, componente, fecha_expiracion)
VALUES
(4, 1, 'humectante', '2025-01-01'),
(5, 2, 'humectante', '2025-01-01');

INSERT INTO perfume(id_producto, id_aroma, tamaño)
VALUES
(6, 1, 'pequeño'),
(7, 2, 'grande');

INSERT INTO accesorio(id_producto, id_material, tamaño)
VALUES
(8, 1, 'grande'),
(9, 4, 'pequeño');

INSERT INTO area_trabajo(nombre)
VALUES ('ventas'), ('bodega'), ('administracion'), ('aseo');

INSERT INTO empleado(id_area_trabajo, nombre, fecha_contratacion)
VALUES
(1, 'Juan', '2020-01-01'),
(1, 'lupe', '2024-01-01'),
(2, 'Pedro', '2021-01-01'),
(3, 'Maria', '2020-01-01'),
(4, 'pepito', '2024-01-01');

INSERT INTO cliente(nombre, correo, direccion, telefono)
VALUES
('juan', 'juan@gmail.com', 'calle 1', '123456'),
('luis', 'luis@gmail.com', 'calle 2', '654321'),
('maria', 'maria@gmail.com', 'calle 3', '987654'),
('pepito', 'pepito@gmail.com', 'calle 4', '111');

INSERT INTO venta(id_cliente, id_empleado, fecha_venta)
VALUES
(1, 1, '2024-01-01'),
(1, 2, '2024-01-01'),
(2, 2, '2024-01-01'),
(3, 1, '2024-01-01'),
(3, 2, '2024-01-01');

INSERT INTO venta_producto(id_venta, id_producto, cantidad)
VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(4, 8, 10),
(4, 6, 2),
(5, 5, 5);


INSERT INTO proveedor(nombre_empresa, nombre_contacto, telefono, direccion)
VALUES
('Loreal', 'alberto', '123456', 'calle 1'),
('CeraV', 'Jose', '654321', 'calle 2'),
('Lacoste', 'eduardo', '987654', 'calle 3'),
('Monet', 'juan', '111', 'calle 4');


INSERT INTO compra(id_proveedor, fecha)
VALUES
(1, '2023-01-01'),
(1, '2024-10-01'),
(2, '2024-10-01'),
(3, '2024-10-10'),
(4, '2024-10-11'),
(4, '2024-10-12');


INSERT INTO compra_producto(id_compra, id_producto, cantidad)
VALUES
(1, 1, 10),(1, 2, 50),
(2, 3, 20),
(3, 6, 10),(3, 4, 100),
(4, 8, 10),
(5, 6, 20),
(6, 5, 50);






