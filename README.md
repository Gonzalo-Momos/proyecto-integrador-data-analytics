# RetailPro – Proyecto Integrador de Data Analytics

Proyecto de análisis de ventas para RetailPro, desarrollado a lo largo del curso de Data Analytics. Cubre desde el armado de la base de datos y las consultas SQL hasta el modelado y las medidas en Power BI.

## Herramientas utilizadas

- **SQL Server** y **SQL Server Management Studio (SSMS)** para la base de datos y las consultas
- **Power BI Desktop** (Power Query y DAX) para la transformación de datos, el modelo y las medidas
- **GitHub** para el control de versiones
- **Claude.ai** (versión gratuita) como asistente de IA para revisar consultas SQL, validar cálculos y redactar documentación

## Base de datos

Ventas_Tech_DB contiene cuatro tablas:

| Tabla | Descripción |
|---|---|
| ventas | Registro de cada venta: fecha, cliente, producto, cantidad y precio unitario |
| clientes | Datos de los clientes: nombre, email, ciudad y fecha de registro |
| productos | Catálogo de productos y su categoría |
| categorias | Tipos de producto |

Se agregaron 5 ventas de abril de 2024 a las 10 de marzo, para un total de **15 ventas**. Así se pueden comparar dos meses y los cálculos se ven mejor.

## Estructura del repositorio

| Carpeta | Contenido |
|---|---|
| `modulo3_sql` | Creación de la base de datos `Ventas_Tech_DB` y carga de datos. Es la base que se usa en los módulos 4 y 5 |
| `modulo4_sql` | `m4_consultas_negocio.sql`: resumen mensual, ranking de productos, clientes recurrentes y comparación de meses contra el promedio |
| `modulo5_sql` | `m5_consultas_joins.sql`: INNER JOIN de 4 tablas, LEFT JOIN y UNION ALL |
| `modulo6_powerbi` | Limpieza y transformación de datos en Power Query (pipeline ETL). Archivo principal: `Pipeline_ETL_Balmaceda_Gonzalo.pbix`, que usa el dataset `Pipeline_ETL_Dataset.xlsx`. El resto son prácticas intermedias (`lenguaje-m-editor-avanzado`, `practica_lenguaje_m`, `m6_unidad2.pbix`) y `Ventas_export_legacy.xlsx` |
| `modulo8_Dax` | `Balmaceda_Gonzalo_Checkpoint2.pbix`: modelo estrella y 5 medidas DAX |

## Cómo ejecutar los scripts SQL

1. Abrí SQL Server Management Studio y conectate a tu servidor.
2. Ejecutá primero el script de `modulo3_sql` para crear la base y cargar los datos.
3. Abrí el archivo que quieras probar (por ejemplo, `m4_consultas_negocio.sql`).
4. Verificá que la base activa sea `Ventas_Tech_DB`.
5. Seleccioná la consulta que quieras correr y presioná **F5**.

## Cómo conectar el .xlsx desde Power BI

Para poder conectar el archivo `.xlsx` directamente desde GitHub usando el conector Web de Power BI, usá el enlace en formato **raw**, no el enlace normal de GitHub:

- ❌ No funciona: `https://github.com/Gonzalo-Momos/proyecto-integrador-data-analytics/blob/main/modulo6_powerbi/Pipeline_ETL_Dataset.xlsx`
- ✅ Sí funciona: `https://github.com/Gonzalo-Momos/proyecto-integrador-data-analytics/raw/main/modulo6_powerbi/Pipeline_ETL_Dataset.xlsx`

El enlace con `blob` apunta a la página de GitHub que muestra el archivo (HTML), mientras que `raw` apunta al archivo real, que es lo que Power BI necesita para poder leerlo.


## Medidas DAX (módulo 8)

El archivo `.pbix` incluye cinco medidas: Total Ventas, Ventas Online, Ventas YTD, Ventas LY y % Crecimiento Anual.

## Autor

Gonzalo Ariel Balmaceda Manzanares.
