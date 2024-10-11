# Tienda Cosmeticos📁


## 🔗 Índice

| Índice | Título |
| --- | --- |
| 📍 | Análisis inicial |
| 🤝 | Diagrama entidad-relación |
| 🧩 | Explicacion de tablas |

## 📍 Análisis inicial
Esta proyecto se centra en el desarrollo de una base de datos relacional para la gestion de productos, clientes, ventas, empleados y proveedores. 
A través de un esquema lógico UML, se han definido las entidades necesarias y sus relaciones. 
El objetivo es proporcionar un sistema eficiente que permita gestionar la información relacionada y las consultas pertinentes.

## 🤝 Diagrama entidad-relación 
![image](https://github.com/JhoanDiazArdila/tienda_cosmeticos_Base_datos_Jhoan_Diaz_Alejandro_Rincon/blob/main/UML-cosmeticos.jpeg)



## 🧩 Explicacion de tablas
categorias: La tabla de categorías sigue siendo la misma, con las 4 categorías de productos.
productos: La tabla principal de productos almacena la información básica de todos los productos.
cosmeticos: Tabla que incluye los detalles adicionales de los productos cosméticos como tipo, tono/color y fecha de expiración.
cuidado_piel: Tabla específica para los productos de cuidado de la piel, con campos como tipo de piel, componentes principales y fecha de expiración.
perfumes: Tabla para los perfumes, que incluye campos como tipo de aroma, tamaño y fecha de expiración.
accesorios: Tabla para los accesorios, con campos para el material y tamaño.
Esta estructura permite manejar las particularidades de cada categoría de producto de manera organizada y flexible.
Clientes: La tabla clientes se encuentra relacionada a las ventas.
Empleados: Esta tabla se encuentra relacionada a las ventas para que cada venta tenga un empleado a cargo.
Ventas: Esta tabla tiene una relacion de muchos a muchos con productos para relacionar la cantidad de productos en cada venta.
Ventas_productos: Es la tabla relacional de productos y la venta.

