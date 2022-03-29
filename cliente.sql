CREATE DATABASE IF NOT EXISTS cliente;
USE cliente;
#DROP DATABASE cliente;

# TABLAS

CREATE TABLE IF NOT EXISTS cliente (
	id_cliente INT,
    codigo VARCHAR(16),
    apellido VARCHAR(100), 
    nombre VARCHAR(100),
    PRIMARY KEY (id_cliente));

CREATE TABLE IF NOT EXISTS factura (
	id_factura INT,
    id_cliente INT,
    fecha DATETIME, 
    numero INT,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE IF NOT EXISTS producto (
	id_producto INT,
    codigo VARCHAR(16),
    descripcion VARCHAR(256),
    id_precio INT,
    PRIMARY KEY (id_producto)
);

CREATE TABLE IF NOT EXISTS factura_producto (
	id_factura INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE IF NOT EXISTS precio (
	id_precio INT,
    monto DECIMAL(8,2),
    fecha DATE,
    id_producto INT,
    PRIMARY KEY (id_precio),
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

# Ejercicio 2

INSERT INTO cliente (id_cliente, codigo, apellido, nombre)
VALUES (1, "abc", "Perez", "Carlos");

INSERT INTO cliente (id_cliente, codigo, apellido, nombre)
VALUES (2, "bcd", "Rodriguez", "Hugo");

INSERT INTO cliente (id_cliente, codigo, apellido, nombre)
VALUES (3, "efg", "Rodriguez", "Hugo");

INSERT INTO factura (id_factura, id_cliente, fecha, numero)
VALUES (1, 1, 20/20/20, 1);

INSERT INTO factura (id_factura, id_cliente, fecha, numero)
VALUES (3, 1, 20/20/22, 3);

INSERT INTO factura (id_factura, id_cliente, fecha, numero)
VALUES (2, 2, 20/20/20, 2);

INSERT INTO producto (id_producto, codigo, descripcion, id_precio)
VALUES (1,"d34","una almohada", 1);

INSERT INTO producto (id_producto, codigo, descripcion, id_precio)
VALUES (2,"d23","una taza", 3);

INSERT INTO factura_producto (id_factura, id_producto, cantidad)
VALUES (1,1,20);

INSERT INTO factura_producto (id_factura, id_producto, cantidad)
VALUES (1,1,40);

INSERT INTO factura_producto (id_factura, id_producto, cantidad)
VALUES (2,1,40);

INSERT INTO factura_producto (id_factura, id_producto, cantidad)
VALUES (2,2,10);

INSERT INTO precio (id_precio, monto, fecha, id_producto)
VALUES (1,200.50,24/10/22, 1);

INSERT INTO precio (id_precio, monto, fecha, id_producto)
VALUES (2,150.50,24/10/21, 1);

INSERT INTO precio (id_precio, monto, fecha, id_producto)
VALUES (3,90.50,24/10/21, 2);

# Ejercicio 3
SELECT codigo, apellido, nombre, numero
FROM cliente INNER JOIN factura
WHERE cliente.id_cliente = factura.id_cliente;

# Ejercicio 4
SELECT codigo, monto
FROM producto INNER JOIN precio
WHERE producto.id_producto = precio.id_producto;

# Ejercicio 5
SELECT codigo, SUM(cantidad) AS cantidad_de_ventas
FROM factura_producto INNER JOIN producto 
WHERE factura_producto.id_producto = producto.id_producto
GROUP BY producto.id_producto
ORDER BY cantidad_de_ventas DESC;

# Ejercicio 6
SELECT codigo, SUM(monto) AS monto_total
FROM factura_producto INNER JOIN producto INNER JOIN precio
WHERE factura_producto.id_producto = producto.id_producto
GROUP BY producto.id_producto
ORDER BY monto_total DESC;

# Ejercicio 7
SELECT cliente.id_cliente, COUNT(factura.id_cliente) AS cantidad_de_facturas
FROM cliente LEFT JOIN factura 
ON cliente.id_cliente = factura.id_cliente
GROUP BY cliente.id_cliente
ORDER BY cantidad_de_facturas DESC