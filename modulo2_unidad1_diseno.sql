-- ============================================================
-- Práctica: Diseño de esquemas con DDL y Tipos de Datos
-- Archivo: modulo2_unidad1_diseno.sql
-- ============================================================
Use modulo2_unidad1_diseno
-- 1. Tabla de Clientes
Create Table Clientes (
IDCliente INT NOT NULL IDENTITY (1,1) PRIMARY KEY, -- clave primaria: identifica cada fila, no se repite
Nombre Varchar(100) NOT NULL, -- Texto de hasta 100 caracteres para el nombre completo, NOT NULL = este dato es obligatorio, no puede quedar vacío
Perfil_Bio TEXT Not null, -- Texto largo para notas o biografía extensa
Fecha_registro DATE Not null,-- Fecha en la que se registra el cliente (año/mes/dia)
);
SELECT * FROM Clientes;
-- 2. Tabla de Productos
Create Table Productos (
IDproducto INT NOT NULL IDENTITY (1,1) PRIMARY KEY, -- clave primaria: identifica cada fila, no se repite
descripcion VARCHAR(255), -- TEXTO de hasta 255 caracteres
precio DECIMAL (10,2) NOT NULL, -- DECIMAL es exacto para dinero con 10 digitos y 2 decimales
esta_activo BIT NOT NULL, -- NO sabia que poner tuve que buscar en internet, es para si esta da 1 y sino 0.
);
