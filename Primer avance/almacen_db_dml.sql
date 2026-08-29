USE almacen_db;


-- Categorías

INSERT INTO categorias (nombre, descripcion) VALUES
('Limpieza', 'Productos de limpieza para el hogar y negocios'),
('Alimentos', 'Productos comestibles y de consumo básico'),
('Electrónica', 'Dispositivos y accesorios electrónicos'),
('Papelería', 'Artículos de oficina y material escolar');


-- Proveedores

INSERT INTO proveedores (razon_social, telefono, correo_electronico, direccion_ciudad) VALUES
('Distribuidora Central S.A.', '2550-1234', 'ventas@distcentral.hn', 'San Pedro Sula'),
('Comercial Honduras Ltda.', '2650-5678', 'contacto@comercialhn.com', 'Tegucigalpa'),
('Importadora del Norte', '2540-9012', 'info@impnorte.hn', 'San Pedro Sula');


-- Usuarios

INSERT INTO usuarios (nombre_completo, correo_electronico, username, rol, activo) VALUES
('Ana Martínez', 'ana.martinez@almacen.hn', 'amartinez', 'Administrador', TRUE),
('Carlos Rivera', 'carlos.rivera@almacen.hn', 'crivera', 'Vendedor', TRUE),
('Diana López', 'diana.lopez@almacen.hn', 'dlopez', 'Vendedor', TRUE);


-- Productos

INSERT INTO productos (nombre, descripcion, sku, precio_compra, precio_venta, stock_minimo, activo, categoria_id, proveedor_id) VALUES
('Detergente en polvo 1kg', 'Detergente para ropa, bolsa de 1kg', 'LIM-001', 45.00, 65.00, 10, TRUE, 1, 1),
('Cloro 1 galón', 'Cloro desinfectante de uso general', 'LIM-002', 30.00, 48.00, 15, TRUE, 1, 1),
('Arroz 5lb', 'Arroz blanco grano largo, bolsa 5lb', 'ALI-001', 60.00, 85.00, 20, TRUE, 2, 2),
('Frijol rojo 5lb', 'Frijol rojo seco, bolsa 5lb', 'ALI-002', 70.00, 95.00, 20, TRUE, 2, 2),
('Audífonos inalámbricos', 'Audífonos bluetooth con estuche de carga', 'ELE-001', 180.00, 280.00, 5, TRUE, 3, 3),
('Cuaderno universitario', 'Cuaderno de 100 hojas, cuadriculado', 'PAP-001', 15.00, 25.00, 30, TRUE, 4, NULL);


INSERT INTO movimientos_inventario (producto_id, tipo_movimiento, cantidad, observaciones, usuario_id) VALUES
(1, 'E', 50, 'Compra inicial a proveedor', 1),
(2, 'E', 40, 'Compra inicial a proveedor', 1),
(3, 'E', 100, 'Compra inicial a proveedor', 1),
(1, 'S', 5, 'Venta mostrador', 2),
(3, 'S', 8, 'Venta mostrador', 3),
(5, 'E', 15, 'Compra inicial a proveedor', 1),
(5, 'S', 2, 'Venta mostrador', 2),
(6, 'S', 3, 'Ajuste por daño', 1);
