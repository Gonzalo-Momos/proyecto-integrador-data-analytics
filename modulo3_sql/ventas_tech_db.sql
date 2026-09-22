-- =====================================================================
-- Ventas_Tech_DB
-- Script de creación de base de datos para TechStore
-- Incluye: DROP TABLES, CREATE TABLES (DDL + constraints), INSERT DATA (DML)
-- Motor: SQL Server
-- =====================================================================

-- (Opcional según motor) Si tu SGBD lo soporta y aún no existe la base:
-- CREATE DATABASE Ventas_Tech_DB;
-- Luego conectate a esa base antes de ejecutar el resto del script.
-- =====================================================================
-- 1. DROP TABLES
--    Orden inverso de dependencias: primero la tabla de hechos (ventas),
--    luego productos, clientes y por último categorías.
-- =====================================================================
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
-- =====================================================================
-- 2. CREATE TABLES (DDL + Restricciones de integridad)
--    Orden: primero las tablas de dimensión, al final la tabla de hechos.
-- =====================================================================
-- Tabla: categorias
CREATE TABLE categorias (
    id_categoria     INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion      VARCHAR(200)
);
-- Tabla: clientes
CREATE TABLE clientes (
    id_cliente     INT PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE,
    ciudad         VARCHAR(50),
    fecha_registro DATE NOT NULL
);
-- Tabla: productos
CREATE TABLE productos (
    id_producto     INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria    INT,
    precio          DECIMAL(10,2) NOT NULL,
    stock           INT DEFAULT 0,
    activo          TINYINT DEFAULT 1,
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);
-- Tabla: ventas (tabla de hechos)
CREATE TABLE ventas (
    id_venta        INT PRIMARY KEY,
    id_cliente      INT,
    id_producto     INT,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta     DATE NOT NULL,
    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    CONSTRAINT fk_ventas_producto
        FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
-- =====================================================================
-- 3. INSERT DATA (DML)
--    Orden: primero las tablas sin dependencias (categorias, clientes),
--    luego productos, y por último ventas.
-- =====================================================================
-- categorias (4 registros)
INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');
-- clientes (5 registros)
INSERT INTO clientes VALUES (1, 'María López',  'maria@mail.com',  'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez',    'ana@mail.com',    'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres', 'laura@mail.com',  'Tucumán',      '2024-03-01');
-- Sexto cliente agregado que será de utilidad para M5
INSERT INTO clientes VALUES (6, 'Sofía Ibáñez', 'sofia@mail.com', 'Salta', '2024-04-25');
-- productos (6 registros)
INSERT INTO productos VALUES (1, 'Laptop Pro 15',      1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',  2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',     1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro', 3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',    4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',   2,   95.00, 40, 1);
-- Septimo producto agregado que se usará en M5
INSERT INTO productos VALUES (7, 'Webcam HD 1080p', 2, 45.00, 25, 1);
-- ventas (10 registros)
INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');
-- se agregan 5 ventas para poder diferenciar algunos meses
INSERT INTO ventas VALUES (11, 2, 3, 3,  450.00, '2024-04-02');
INSERT INTO ventas VALUES (12, 2, 6, 2,   95.00, '2024-04-05');
INSERT INTO ventas VALUES (13, 1, 5, 4,  130.00, '2024-04-10');
INSERT INTO ventas VALUES (14, 3, 1, 1, 1200.00, '2024-04-15');
INSERT INTO ventas VALUES (15, 1, 2, 6,   28.00, '2024-04-20');

-- =====================================================================
-- 4. Consultas de validación (opcional, para verificar la carga)
-- =====================================================================
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;

SELECT
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*)                        AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;
