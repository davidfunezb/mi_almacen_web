# Endpoints propuestos — API "Mi Almacén Web"

Lista de futuros endpoints a implementar en Node.js + Express, basados en el
modelo de datos de `almacen_db` (etapa de diseño de base de datos).

## Productos
- `GET /api/productos` — listar todos los productos
- `GET /api/productos/:id` — obtener un producto por id
- `POST /api/productos` — crear un nuevo producto
- `PUT /api/productos/:id` — actualizar un producto existente
- `DELETE /api/productos/:id` — eliminar (o desactivar) un producto

## Categorías
- `GET /api/categorias` — listar todas las categorías
- `GET /api/categorias/:id` — obtener una categoría por id
- `POST /api/categorias` — crear una nueva categoría
- `PUT /api/categorias/:id` — actualizar una categoría
- `DELETE /api/categorias/:id` — eliminar una categoría

## Proveedores
- `GET /api/proveedores` — listar todos los proveedores
- `GET /api/proveedores/:id` — obtener un proveedor por id
- `POST /api/proveedores` — crear un nuevo proveedor
- `PUT /api/proveedores/:id` — actualizar un proveedor
- `DELETE /api/proveedores/:id` — eliminar un proveedor

## Usuarios
- `GET /api/usuarios` — listar todos los usuarios
- `GET /api/usuarios/:id` — obtener un usuario por id
- `POST /api/usuarios` — crear un nuevo usuario
- `PUT /api/usuarios/:id` — actualizar un usuario
- `DELETE /api/usuarios/:id` — eliminar (o desactivar) un usuario

## Movimientos de Inventario
- `GET /api/movimientos` — listar todos los movimientos
- `GET /api/movimientos/:id` — obtener un movimiento por id
- `POST /api/movimientos` — registrar un nuevo movimiento (entrada o salida)


