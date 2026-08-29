CREATE DATABASE IF NOT EXISTS almacen_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE almacen_db;

CREATE TABLE categorias (
    categoria_id INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NULL,
    PRIMARY KEY (categoria_id),
    CONSTRAINT uq_categorias_nombre UNIQUE (nombre)
) ENGINE = InnoDB;

CREATE TABLE proveedores (
    proveedor_id INT UNSIGNED AUTO_INCREMENT,
    razon_social VARCHAR(150) NOT NULL,
    telefono VARCHAR(25) NULL,
    correo_electronico VARCHAR(150) NULL,
    direccion_ciudad VARCHAR(255) NULL,
    PRIMARY KEY (proveedor_id),
    CONSTRAINT uq_proveedores_correo UNIQUE (correo_electronico)
) ENGINE = InnoDB;

CREATE TABLE usuarios (
    usuario_id INT UNSIGNED AUTO_INCREMENT,
    nombre_completo VARCHAR(150) NOT NULL,
    correo_electronico VARCHAR(150) NOT NULL,
    username VARCHAR(50) NOT NULL,
    rol VARCHAR(20) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (usuario_id),
    CONSTRAINT uq_usuarios_correo UNIQUE (correo_electronico),
    CONSTRAINT uq_usuarios_username UNIQUE (username),
    CONSTRAINT chk_usuarios_rol
        CHECK (rol IN ('Administrador', 'Vendedor'))
) ENGINE = InnoDB;

CREATE TABLE productos (
    producto_id INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(500) NULL,
    sku VARCHAR(50) NOT NULL,
    precio_compra DECIMAL(12,2) NOT NULL,
    precio_venta DECIMAL(12,2) NOT NULL,
    stock_minimo INT UNSIGNED NOT NULL DEFAULT 0,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    categoria_id INT UNSIGNED NOT NULL,
    proveedor_id INT UNSIGNED NULL,
    PRIMARY KEY (producto_id),
    CONSTRAINT uq_productos_sku UNIQUE (sku),
    CONSTRAINT chk_productos_precio_compra CHECK (precio_compra > 0),
    CONSTRAINT chk_productos_precio_venta CHECK (precio_venta > 0),
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias (categoria_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_productos_proveedor
        FOREIGN KEY (proveedor_id)
        REFERENCES proveedores (proveedor_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    INDEX idx_productos_categoria (categoria_id),
    INDEX idx_productos_proveedor (proveedor_id),
    INDEX idx_productos_nombre (nombre)
) ENGINE = InnoDB;

-- Registra todas las entradas y salidas de cada producto.
CREATE TABLE movimientos_inventario (
    movimiento_id BIGINT UNSIGNED AUTO_INCREMENT,
    producto_id INT UNSIGNED NOT NULL,
    tipo_movimiento CHAR(1) NOT NULL,
    cantidad INT UNSIGNED NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observaciones VARCHAR(500) NULL,
    usuario_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (movimiento_id),
    CONSTRAINT chk_movimientos_tipo
        CHECK (tipo_movimiento IN ('E', 'S')),
    CONSTRAINT chk_movimientos_cantidad
        CHECK (cantidad > 0),
    CONSTRAINT fk_movimientos_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos (producto_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_movimientos_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios (usuario_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    INDEX idx_movimientos_producto_fecha (producto_id, fecha_hora),
    INDEX idx_movimientos_usuario (usuario_id),
    INDEX idx_movimientos_tipo (tipo_movimiento)
) ENGINE = InnoDB;

CREATE OR REPLACE VIEW vista_stock_productos AS
SELECT
    p.producto_id,
    p.sku,
    p.nombre,
    p.stock_minimo,
    COALESCE(
        SUM(
            CASE
                WHEN m.tipo_movimiento = 'E' THEN m.cantidad
                WHEN m.tipo_movimiento = 'S' THEN -m.cantidad
                ELSE 0
            END
        ),
        0
    ) AS stock_actual,
    CASE
        WHEN COALESCE(
            SUM(
                CASE
                    WHEN m.tipo_movimiento = 'E' THEN m.cantidad
                    WHEN m.tipo_movimiento = 'S' THEN -m.cantidad
                    ELSE 0
                END
            ),
            0
        ) <= p.stock_minimo THEN 'REABASTECER'
        ELSE 'SUFICIENTE'
    END AS estado_stock
FROM productos AS p
LEFT JOIN movimientos_inventario AS m
    ON m.producto_id = p.producto_id
GROUP BY
    p.producto_id,
    p.sku,
    p.nombre,
    p.stock_minimo;



