# RetailPro — Proyecto de Data Analyst

## Descripción del proyecto
Este repositorio contiene el desarrollo del proyecto final de la certificación como Data Analyst: un dashboard de inteligencia de negocios para **RetailPro**, una distribuidora de tecnología. El proyecto recorre el circuito completo de un analista de datos: desde el diseño de la base de datos hasta las consultas SQL que van a alimentar un dashboard en Power BI.

## Caso de negocio
RetailPro necesita entender por qué las ventas de tecnología en la Zona Sur del país aumentaron un 18% entre mayo y julio, y si ese incremento se explica por las bajas temperaturas y el mayor tiempo que los clientes pasan en el hogar (home office). Sobre esa pregunta se construyó todo el proyecto: el modelo de datos, las consultas de negocio y, más adelante, el dashboard.

## Estructura del repositorio
- `ventas_tech_db.sql` — Script de creación de la base de datos **Ventas_Tech_DB**: definición de tablas (DDL), restricciones de integridad (PK/FK) y carga de datos inicial (DML).
- `m4_consultas_negocio.sql` — Consultas de agregación (`COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`, `CASE WHEN`) que responden preguntas de negocio: resumen mensual, ranking de productos, clientes recurrentes y comparación contra el promedio.
- `m5_consultas_joins.sql` — Consultas que cruzan tablas con `INNER JOIN` y `LEFT JOIN` para enriquecer la vista de ventas, e identifican clientes y productos sin movimiento. Incluye un consolidado con `UNION ALL`.

## Motor de base de datos
Todos los scripts están escritos para **SQL Server**.

## Cómo ejecutar los scripts
1. Abrí SQL Server Management Studio (o Azure Data Studio) y conectate a tu instancia.
2. Ejecutá `ventas_tech_db.sql` primero — crea la base, las tablas y carga los datos iniciales. El script es repetible: podés volver a ejecutarlo las veces que quieras, porque empieza eliminando las tablas si ya existen (`DROP TABLE IF EXISTS`).
3. Ejecutá `m4_consultas_negocio.sql` para ver las métricas de negocio sobre la tabla `ventas`.
4. Ejecutá `m5_consultas_joins.sql` para ver la vista enriquecida (ventas + clientes + productos + categorías) y los reportes de clientes/productos sin movimiento.
