# README — Lenguaje M en el Editor Avanzado

## ¿Qué hace exactamente el bloque let...in? ¿Por qué cada paso puede referenciar al anterior?

`let` arranca una lista de pasos con nombre, y `in` indica cuál de todos esos pasos es el resultado final que se muestra. Cada paso puede usar el nombre del paso de arriba porque, en el fondo, cada uno **es una variable** que guarda el resultado de la transformación anterior — por eso mi `LimpiarEspacios` puede escribir `Table.TransformColumns(Origen, ...)`: está diciendo "agarrá lo que dejó el paso Origen, y aplicale esto". Es una cadena: cada eslabón parte de donde terminó el anterior, nunca vuelve a tocar los datos originales sin pasar por los pasos de en medio.

## ¿Por qué M es Case Sensitive y qué consecuencia práctica tiene?

Porque M distingue mayúsculas de minúsculas en TODO: nombres de funciones, de pasos, y hasta en los valores de texto que comparás dentro del código. Un ejemplo concreto de mi propio script: en el Paso 4 filtro `[categoria] <> "Prueba"`, con mayúscula inicial solamente. Si hubiera escrito `<> "prueba"` (todo en minúscula), la fila no se hubiera filtrado, porque para M "Prueba" y "prueba" son dos textos completamente distintos, no la misma palabra con distinto formato.

## ¿Cuál es la diferencia entre Text.Trim y Text.Clean?

`Text.Trim` saca específicamente los **espacios en blanco** que están al principio o al final de un texto (los espacios que están en el medio no los toca). Es justo lo que usé en el Paso 2 para sacar el espacio de `" Laptop Pro 15 "`.

`Text.Clean`, en cambio, no se mete con los espacios — lo que saca son **caracteres no imprimibles**, como saltos de línea, tabulaciones o caracteres de control invisibles que a veces quedan pegados en un texto por errores de exportación de otro sistema. Son dos problemas distintos: uno es "hay espacio de más en los bordes" (Trim), el otro es "hay basura invisible dentro del texto" (Clean).

## ¿Por qué filtré los registros "PRUEBA" después de estandarizar la categoría y no antes?

Porque mi tabla tenía "PRUEBA" escrito de forma inconsistente (algunas en mayúscula total). Si filtraba `categoria <> "PRUEBA"` antes del Paso 3, solo hubiera capturado las filas que decían exactamente "PRUEBA" en mayúscula — y como M es Case Sensitive, cualquier variante como "prueba" o "Prueba" se hubiera colado sin filtrar. Al estandarizar primero con `Text.Proper` (Paso 3), TODAS las variantes de "prueba" terminan escritas igual ("Prueba"), y recién ahí un solo filtro exacto alcanza para sacarlas a todas de una vez.
