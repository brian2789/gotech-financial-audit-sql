USE GoTech_Analytics;
GO

-- =====================================================================
-- CONTROL DE AUDITORÍA 1: Fuga de Margen (Precios por debajo del costo)
-- Objetivo: Detectar si se realizaron ventas donde el precio de venta 
-- configurado fue menor o igual al costo operativo del producto.
-- =====================================================================
SELECT 
    v.ID_Venta,
    p.Nombre AS Producto,
    p.Precio_Costo,
    p.Precio_Venta,
    (p.Precio_Venta - p.Precio_Costo) AS Margen_Unitario
FROM Ventas v
JOIN Productos p ON v.ID_Producto = p.ID_Producto
WHERE p.Precio_Venta <= p.Precio_Costo;


-- =====================================================================
-- CONTROL DE AUDITORÍA 2: Integridad del Padrón de Clientes Activos
-- Objetivo: Identificar qué clientes registrados en el sistema no han 
-- generado ningún movimiento comercial (Clientes Huérfanos / Costo de Adquisición ocioso).
-- =====================================================================
SELECT 
    c.ID_Cliente,
    c.Nombre,
    c.Provincia,
    v.ID_Venta
FROM Clientes c
LEFT JOIN Ventas v ON c.ID_Cliente = v.ID_Cliente
WHERE v.ID_Venta IS NULL;


-- =====================================================================
-- CONTROL DE AUDITORÍA 3: Rendimiento y Desvío de Comisiones
-- Objetivo: Calcular cuánto le corresponde cobrar a cada vendedor en base 
-- a sus ventas reales y su porcentaje de comisión contractual.
-- =====================================================================
SELECT 
    vd.Nombre AS Vendedor,
    SUM(v.Cantidad * p.Precio_Venta) AS Total_Facturado,
    vd.Comision_Porcentaje AS Ratio_Comision,
    SUM(v.Cantidad * p.Precio_Venta) * vd.Comision_Porcentaje AS Comision_A_Pagar
FROM Ventas v
JOIN Productos p ON v.ID_Producto = p.ID_Producto
JOIN Vendedores vd ON v.ID_Vendedor = vd.ID_Vendedor
GROUP BY vd.Nombre, vd.Comision_Porcentaje;
GO