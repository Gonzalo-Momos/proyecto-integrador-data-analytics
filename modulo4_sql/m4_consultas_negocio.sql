-- ============================================================
-- m4_consultas_negocio.sql
-- Proyecto RetailPro — Consultas SQL de negocio (M4)
-- Base de datos: Ventas_Tech_DB (creada en M3)
-- Autor: [Gonzalo Balmaceda]
-- Motor: SQL Server. Usa MONTH() y SELECT TOP N, específicos de
-- este motor (no de PostgreSQL, donde equivaldrían a
-- EXTRACT(MONTH FROM ...) y LIMIT N).
-- ============================================================

-- ============================================================
-- Consulta 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio,
-- agrupados por mes.
-- Se usa MONTH() por que en SQLserver no existe EXTRACT(MONTH FROM fecha_venta)
-- ============================================================
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*)                        AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- ============================================================
-- Consulta 2: Ranking de productos
-- Top 5 de id_producto por total facturado.
-- Usamos SELECT TOP 5 ya que LIMIT me daba error, no existe en SQLServer.
-- ============================================================
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


-- ============================================================
-- Consulta 3: Clientes recurrentes
-- Clientes con más de un pedido (HAVING se aplica DESPUÉS de
-- agrupar, a diferencia de WHERE que filtra fila por fila).
-- Al ajustar las ventas me quedo que los 5 clientes tienen mas de 1 pedido.
-- ============================================================
SELECT
    id_cliente,
    COUNT(*)                        AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;


-- ============================================================
-- Consulta 4: Meses por encima/por debajo del promedio
-- El promedio mensual general se calcula con una subconsulta
-- (una consulta "adentro" de otra): primero se arma la tabla
-- de totales por mes, y sobre esa se calcula el promedio para
-- comparar cada mes contra él.
-- ============================================================
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
    WHEN SUM(cantidad * precio_unitario) > (
    SELECT AVG(total_mes)
    FROM (
    SELECT SUM(cantidad * precio_unitario) AS total_mes
    FROM ventas
    GROUP BY MONTH(fecha_venta) 
    ) AS totales_por_mes
    ) THEN 'Por encima'
    ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- ============================================================
-- Hallazgos (calculados sobre los 15 registros cargados en M3:
-- 10 de marzo + 5 de abril de 2024 cargados nuevos para 
-- poder diferenciar)
-- ============================================================
-- 1. El producto 1 (Laptop Pro 15) sigue siendo el más vendido:
--    concentra el 48.6% de la facturación total ($4800 de
--    $9872) — es, por lejos, el producto mas vendido.
--
-- 2. Con dos meses de datos, marzo ($6444) quedó "Por encima"
--    del promedio mensual ($4936) y abril ($3428) "Por debajo".
--    Todavía es poca información para sacar una conclusión firme (son solo dos meses),
--    pero es la primera pista de que puede haber estacionalidad.
--
-- 3. Los 5 clientes cargados son recurrentes: todos volvieron a comprar
--    más de una vez, lo que sugiere que confían en la marca después de
--    la primera compra. Eso sí, no compran todos igual: hay clientes
--    que ya llevan 4 pedidos (los más fieles) y otros que todavía van
--    por 2 — buena señal en general, pero conviene mirar a los de 2
--    pedidos para ver si los podemos activar más seguido.
