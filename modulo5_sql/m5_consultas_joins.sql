-- ============================================================
-- m5_consultas_joins.sql
-- Proyecto RetailPro — Consultas con JOINs (M5)
-- Base de datos: Ventas_Tech_DB (creada en M3)
-- Motor: SQL Server
-- ============================================================

-- ============================================================
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Cruza ventas con sus 3 tablas descriptivas (clientes, productos,
-- categorias). "ciudad" sirve para filtrar por zona geográfica y
-- "nombre_categoria" para agrupar por tipo de producto.
-- ============================================================
SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre            AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes   c   ON v.id_cliente   = c.id_cliente
INNER JOIN productos  p   ON v.id_producto  = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;


-- ============================================================
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- El cliente 6 (Sofía Ibáñez) no tiene ninguna fila en ventas,
-- así que v.id_venta queda en NULL para ella y es la única que
-- pasa el filtro.
-- ============================================================
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ============================================================
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Mismo patrón: el producto 7 (Webcam HD 1080p) nunca se vendió,
-- así que es el único que queda tras el filtro.
-- ============================================================
SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v        ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- ============================================================
-- Consulta 4: Consolidado por canal (UNION ALL)
-- Ventas_Tech_DB no tiene una columna real de "canal", así que
-- (tal como pide la consigna) la creamos como valor literal,
-- usando el mes como criterio de separación entre dos orígenes.
-- ============================================================
SELECT origen, SUM(total) AS total_facturado, COUNT(*) AS cantidad_ventas
FROM (
    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Marzo' AS origen
    FROM ventas
    WHERE MONTH(fecha_venta) = 3

    UNION ALL

    SELECT fecha_venta, (cantidad * precio_unitario) AS total, 'Abril' AS origen
    FROM ventas
    WHERE MONTH(fecha_venta) = 4
) AS consolidado
GROUP BY origen;
