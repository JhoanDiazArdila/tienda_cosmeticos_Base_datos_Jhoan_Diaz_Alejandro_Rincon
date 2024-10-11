CREATE DATABASE TiendaComesticos;
USE TiendaComesticos;


CREATE TABLE Usuarios (
    id INT PRIMARY KEY,         
    nombre VARCHAR(255),        
    Telefono VARCHAR(255)          
);
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,               
    telefono VARCHAR(15),                         
    correo VARCHAR(100) UNIQUE NOT NULL,         
    fecha_contratacion DATE NOT NULL              
);


CREATE TABLE Ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,     
    fecha DATE NOT NULL,                          
    id_empleado INT NOT NULL,                   
    id_usuario INT NOT NULL,                     
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado), 
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)    
);

CREATE TABLE Proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,          
	nombre VARCHAR(255),
    celular VARCHAR(15),                         
    correo VARCHAR(100) UNIQUE NOT NULL          
);

CREATE TABLE categorias (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria_id INT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias(ID)
);


CREATE TABLE VentasProductos (
    id_venta INT,                              
    id_producto INT,                           
    cantidad INT NOT NULL,                     
    fecha DATE NOT NULL,                       
    PRIMARY KEY (id_venta, id_producto),      
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),  
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto) 
);

CREATE TABLE ProductosProveedores (
    id_proveedor INT,                           
    id_producto INT,                            
    PRIMARY KEY (id_proveedor, id_producto),    
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id),   
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto) 
);


CREATE TABLE OrdenCompra (
    id_orden_compra INT AUTO_INCREMENT PRIMARY KEY,  
    fecha DATE NOT NULL,                             
    id_proveedor INT,                                
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id)  
);

CREATE TABLE ProductosOrdenCompra (
    id_producto INT,                                
    id_orden_compra INT,                            
    cantidad INT NOT NULL,                          
    PRIMARY KEY (id_producto, id_orden_compra),     
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),  
    FOREIGN KEY (id_orden_compra) REFERENCES OrdenCompra(id_orden_compra) 
);

CREATE TABLE cosmeticos (
    id_producto INT PRIMARY KEY,
    tipo VARCHAR(50),  
    tono_color VARCHAR(50),
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


CREATE TABLE cuidado_piel (
    id_producto INT PRIMARY KEY,
    tipo_piel VARCHAR(50),  
    componentes_principales TEXT,
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


CREATE TABLE perfumes (
    id_producto INT PRIMARY KEY,
    tipo_aroma VARCHAR(100),  
    tamano VARCHAR(50),  
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


CREATE TABLE accesorios (
    id_producto INT PRIMARY KEY,
    material VARCHAR(100),  
    tamano VARCHAR(50),  
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)

);




























