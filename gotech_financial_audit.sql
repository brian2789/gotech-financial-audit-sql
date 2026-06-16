USE GoTech_Analytics;
GO

-- =====================================================================
-- CONTROL DE AUDITORÍA 1: Fuga de Margen Comercial (Venta Bajo Costo)
-- Análisis de distorsión de precios y alertas de rentabilidad negativa.
-- =====================================================================
SELECT 
    v.ID_Venta,
    p.Nombre AS Producto,
    p.Precio_Costo,
    p.Precio_Venta,
    (p.Precio_Venta - p.Precio_Costo) AS Margen_Unitario
FROM Ventas v
INNER JOIN Productos p ON v.ID_Producto = p.ID_Producto
WHERE p.Precio_Venta <= p.Precio_Costo;


-- =====================================================================
-- CONTROL DE AUDITORÍA 2: Conciliación de Cuentas / Clientes Inactivos
-- Detección de registros sin transacciones en la tabla de hechos (Ventas).
-- =====================================================================
SELECT 
    c.ID_Cliente,
    c.Nombre,
    c.Provincia
FROM Clientes c
LEFT JOIN Ventas v ON c.ID_Cliente = v.ID_Cliente
WHERE v.ID_Venta IS NULL;


-- =====================================================================
-- CONTROL DE AUDITORÍA 3: Liquidación y Desvío de Comisiones
-- Cálculo consolidado de haberes variables según desempeño comercial.
-- =====================================================================
SELECT 
    vd.Nombre AS Vendedor,
    SUM(v.Cantidad * p.Precio_Venta) AS Total_Facturado,
    vd.Comision_Porcentaje AS Ratio_Comision,
    SUM(v.Cantidad * p.Precio_Venta) * vd.Comision_Porcentaje AS Comision_A_Pagar
FROM Ventas v
INNER JOIN Productos p ON v.ID_Producto = p.ID_Producto
INNER JOIN Vendedores vd ON v.ID_Vendedor = vd.ID_Vendedor
GROUP BY vd.Nombre, vd.Comision_Porcentaje;
GO
