# README — Limpieza de datos de ventas (Power BI)

## ¿Qué hice y en qué orden?

Descargue el archivo `Ventas_export_legacy.xlsx` tal como vino del sistema viejo y lo fui modificando paso a paso en Power Query:

1. **Saqué las filas que estaban completamente vacías.** Eran 4 filas, sin un solo dato adentro — no aportaban nada.
2. **Saqué los duplicados exactos.** Había 48 filas que eran una copia de otra. Ojo con esto: al principio metí la pata y le pedí que compare duplicados mirando solo la columna de ciudad, y me borró filas que no tenían nada que ver entre sí. Lo corregí comparando la fila completa, que es como tiene que ser.
3. **Le cambie el nombre a las columnas.** De `COD_CLI` o `FLG_ACT` — ahora todo se llama como pide la consigna: `id_cliente`, `cliente_activo`, `fecha_venta`, etc.
5. **Unifiqué el canal de venta.** Tenía "ONLINE", "online" y "Online" como si fueran tres cosas distintas cuando en realidad son lo mismo. Lo pasé todo a Mayúscula y le saqué los espacios de más.
6. **Rellené las casillas Null** de dos columnas puntuales (lo explico abajo).
7. **Separé todo en dos tablas**: una para los datos del cliente y otra para los datos de la venta en sí (también lo explico abajo).

El orden importa: primero hay que limpiar lo obvio (vacíos, duplicados, nombres) antes de meterse a corregir tipos y calcular fórmulas — si se intenta calcular algo sobre datos sucios, después tenés que rehacer todo dos veces.

## ¿Por qué elegí cada tipo de dato?

- **Texto** para todo lo que tiene letras mezcladas con números o no se usa para hacer cuentas: `id_operacion` (tipo `OP-100820`), `id_cliente` (tipo `COD_CLI_005`), nombres, emails, ciudades, provincias. El teléfono también va como texto y si tuviera un 0 adelante, un número lo perdería.
- **Número entero** para lo que son cantidades o códigos puramente numéricos, sin decimales: `id_producto` y `cantidad`. No existe "vender 2.5 productos".
- **Número decimal** para todo lo que tiene dinero o porcentajes de por medio: `precio_unitario`, `descuento_pct`, `total_venta`. Estos necesitan los centavos.
- **Fecha** para `fecha_alta_cliente` y `fecha_venta`. Esto es clave: si las dejás como texto, Power BI no te deja filtrar "ventas de marzo" ni calcular cuántos días pasaron entre dos fechas.

## ¿Cómo resolví los nulos y los duplicados?

**Duplicados:** los borré sin más, no se pierde información real al sacarlos, solo estás sacando información repetida.

**Nulos**, acá fui caso por caso, porque no todos significan lo mismo:

- **Email y teléfono vacíos:** los dejé tal cual, en blanco. Que un cliente no tenga cargado el mail o el teléfono es un dato "vital" (no todo el mundo lo deja), no un error — borrar esas filas hubiera sido perder información de algunos clientes reales.
- **Descuento vacío:** lo reemplacé por `0`. La lógica es simple: si no hay ningún número cargado en descuento, lo más razonable es asumir que esa venta no tuvo descuento, no que "falta un dato".
- **Total de venta vacío:** en vez de inventar un número, lo **calculé** con la fórmula `cantidad × precio_unitario × (1 − descuento_pct)`. Esto es mejor que poner un `0` fijo, porque el 0 me hubiera arruinado cualquier suma o promedio de ventas más adelante — el número calculado es matemáticamente correcto según los otros datos que sí tenía esa fila.

## ¿Cómo separé cliente de transacción?

El criterio fue simple: **todo lo que describe A LA PERSONA** (quién es, cómo la contacto, dónde vive, qué tipo de cliente es) va en una tabla; **todo lo que describe LA VENTA EN SÍ** (qué se compró, cuánto, cuándo, a qué precio) va en otra.

Quedaron así:

- **`D_CLIENTES`** (la dimensión): `id_cliente`, `nombre_cliente`, `email_cliente`, `telefono_cliente`, `ciudad_cliente`, `provincia_cliente`, `tipo_cliente`, `cliente_activo`, `fecha_alta_cliente`.
- **`F_VENTAS`** (los hechos): `id_operacion`, `id_cliente`, `fecha_venta`, `id_producto`, `nombre_producto`, `categoria_producto`, `cantidad`, `precio_unitario`, `descuento_pct`, `total_venta`, `moneda`, `canal_venta`.

El puente entre las dos es `id_cliente`, que está en ambas — así Power BI arma la relación solo y sabe que un cliente puede tener muchas ventas (por eso `D_CLIENTES` es el "1" y `F_VENTAS` es el "muchos" en el modelo).


Tuve conflictos con la subida de este repositorio, no me tomaba el .pbix diciendome que estaba corrupto y quedaba la entrega en 0% despues de darle muchisimas vueltas creo que es por que baje la base de datos como archivo .xlsx a mi pc y ahi trabaje, cuando intentaba hacerlo andar la IA no tenia los datos, probe con abir directamente la planilla en la web "https://docs.google.com/spreadsheets/d/1LkzC7vEzLyRcCeh9dZmZ1a2ICghKd64M/export?format=xlsx" provista por Ticher. Adjunto los dos .pbix uno trabajando con el Excel descargado y otra con el Excel desde la web.
