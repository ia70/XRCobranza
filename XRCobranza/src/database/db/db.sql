CREATE TABLE `abono`  (
  `id_abono` int NOT NULL AUTO_INCREMENT,
  `folio` varchar(50) NULL,
  `id_usuario` int NULL,
  `monto` decimal(10, 2) NULL,
  `no_pagos` decimal(10, 2) NULL,
  `id_tipo_pago` int NULL,
  `fecha_abono` date NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_abono`),
  INDEX `i_folio`(`folio`)
);

CREATE TABLE `articulo`  (
  `id_articulo` varchar(30) NOT NULL,
  `id_empresa` varchar(50) NULL,
  `nombre` varchar(100) NULL,
  `descripcion` varchar(500) NULL,
  `clave_media` varchar(30) NULL,
  `conmision_venta` decimal(10, 2) NULL,
  `precio` decimal(10, 2) NULL,
  `existencia` int NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_articulo`),
  FULLTEXT INDEX `i_art_nombre`(`nombre`, `descripcion`)
);

CREATE TABLE `aval`  (
  `id_aval` int NOT NULL AUTO_INCREMENT,
  `ine` varchar(50) NULL,
  `nombre` varchar(50) NULL,
  `apellido_paterno` varchar(20) NULL,
  `apellido_materno` varchar(20) NULL,
  `direccion` varchar(250) NULL,
  `telefono` varchar(12) NULL,
  `id_tipo_parentesco` int NULL,
  `id_persona` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_aval`),
  INDEX `i_aval_ine`(`ine`)
);

CREATE TABLE `capital`  (
  `id_capital` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int NULL,
  `id_periodo` int NULL,
  `id_usuario` int NULL,
  `id_tipo_capital` int NULL,
  `id_tipo_concepto` int NULL,
  `empresa` varchar(120) NULL,
  `monto` decimal(10, 2) NULL,
  `hora` varchar(20) NULL,
  `folio_ticket` varchar(50) NULL,
  `id_media` int NULL,
  `fecha` date NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_capital`)
);

CREATE TABLE `configuracion`  (
  `id_configuracion` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NULL,
  `no_cobradores` int NULL,
  `licencia_inicio` date NULL,
  `licencia_fin` date NULL,
  `id_moneda` int NULL,
  `id_zona_horaria` int NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_configuracion`)
);

CREATE TABLE `credito`  (
  `folio` varchar(50) NOT NULL,
  `id_usuario_reg` int NULL,
  `id_usuario` int NULL,
  `descripcion` varchar(255) NULL,
  `id_tipo_cobro` int NULL,
  `monto_credito` decimal(10, 2) NULL,
  `monto_pago` decimal(10, 2) NULL,
  `fecha_entrega` date NULL,
  `fecha_inicio` date NULL,
  `fecha_siguiente_pago` date NULL,
  `total_pagos` int NULL,
  `no_pagos_adicional` int NULL DEFAULT 0,
  `id_tipo_credito` int NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`folio`),
  INDEX `i_usuario`(`id_usuario`)
);

CREATE TABLE `empresa`  (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(250) NULL,
  `rfc` varchar(50) NULL,
  `direccion` varchar(250) NULL,
  `ciudad` varchar(255) NULL,
  `cp` int NULL,
  `telefono` varchar(12) NULL,
  `porcentaje_x_cobro` decimal(10) NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_empresa`),
  UNIQUE INDEX `i_razon_social`(`razon_social`),
  UNIQUE INDEX `i_rfc`(`rfc`)
);

CREATE TABLE `estado`  (
  `id_estado` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_estado`)
);

CREATE TABLE `inventario`  (
  `id_reg` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int NULL,
  `id_articulo` varchar(50) NULL,
  `precio_publico` decimal(10, 2) NULL,
  `existencia` int NULL,
  `id_estado` int NULL,
  PRIMARY KEY (`id_reg`)
);

CREATE TABLE `media`  (
  `id_media` int NOT NULL AUTO_INCREMENT,
  `clave_media` varchar(30) NULL,
  `id_tipo_media` int NULL,
  `descripcion` varchar(250) NULL,
  `elemento` longblob NULL,
  `extension` varchar(10) NULL,
  `tamano` int NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_media`),
  INDEX `i_media_clave`(`clave_media`)
);

CREATE TABLE `moneda`  (
  `id_moneda` int NOT NULL AUTO_INCREMENT,
  `abreviatura` varchar(5) NULL,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_moneda`)
);

CREATE TABLE `periodo`  (
  `id_periodo` int NOT NULL,
  `id_sucursal` int NULL,
  `anio` int NULL,
  `mes` int NULL,
  `capital_inicio` decimal(10, 2) NULL,
  `capital_fin` decimal(10, 2) NULL,
  PRIMARY KEY (`id_periodo`)
);

CREATE TABLE `permiso`  (
  `id_permiso` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) NULL,
  `descripcion` varchar(200) NULL,
  `id_estado` int NULL,
  PRIMARY KEY (`id_permiso`)
);

CREATE TABLE `persona`  (
  `id_persona` int NOT NULL AUTO_INCREMENT,
  `ine` varchar(20) NULL,
  `alias` varchar(60) NULL,
  `nombre` varchar(50) NULL,
  `apellido_paterno` varchar(20) NULL,
  `apellido_materno` varchar(20) NULL,
  `direccion` varchar(250) NULL,
  `no_casa` varchar(10) NULL,
  `referencias` varchar(250) NULL,
  `telefono` varchar(12) NULL,
  `id_tipo_inmueble` int NULL,
  `disp_hr_ini` varchar(30) NULL,
  `disp_hr_fin` varchar(30) NULL,
  `coordenadas` varchar(60) NULL,
  `clave_media` varchar(30) CHARACTER SET binary NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE INDEX `i_ine`(`ine`),
  FULLTEXT INDEX `i_nombre`(`alias`, `nombre`, `apellido_paterno`, `apellido_materno`)
);

CREATE TABLE `persona_ruta`  (
  `id_persona_ruta` int NOT NULL AUTO_INCREMENT,
  `ine` varchar(20) NULL,
  `id_ruta` int NULL,
  PRIMARY KEY (`id_persona_ruta`)
);

CREATE TABLE `rol`  (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_rol`)
);

CREATE TABLE `rol_permiso`  (
  `id_rol_permiso` int NOT NULL,
  `id_rol` int NULL,
  `id_permiso` int NULL,
  PRIMARY KEY (`id_rol_permiso`)
);

CREATE TABLE `ruta`  (
  `id_ruta` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int NULL,
  `descripcion` varchar(100) NULL,
  `id_estado` int NULL,
  PRIMARY KEY (`id_ruta`)
);

CREATE TABLE `secuencia_cobro`  (
  `id_secuencia_cobro` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NULL,
  `posicion` int NULL,
  PRIMARY KEY (`id_secuencia_cobro`),
  UNIQUE INDEX `i_id_usuario`(`id_usuario`)
);

CREATE TABLE `sesion`  (
  `id_sesion` varchar(150) NOT NULL,
  `id_empresa` int NULL,
  `id_sucursal` int NULL,
  `id_usuario` int NULL,
  `sesion_inicio` datetime NULL,
  `sesion_ult_con` datetime NULL,
  `sesion_fin` datetime NULL,
  `id_estado` int NULL,
  PRIMARY KEY (`id_sesion`),
  INDEX `i_usuario`(`usuario`),
  INDEX `i_empresa`(`id_empresa`),
  INDEX `i_sucursal`(`id_susursal`)
);

CREATE TABLE `solicitud`  (
  `id_solicitud` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NULL,
  `ine` varchar(20) NULL,
  `monto` decimal(10, 2) NULL,
  `pagos` int NULL,
  `id_tipo_cobro` int NULL,
  `fecha_requerida` date NULL,
  `id_estado_solicitud` int NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_solicitud`)
);

CREATE TABLE `sucursal`  (
  `id_sucursal` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NULL,
  `nombre` varchar(120) NULL,
  `direccion` varchar(500) NULL,
  `cp` int NULL,
  `telefono` varchar(45) NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_sucursal`)
);

CREATE TABLE `tipo_capital`  (
  `id_tipo_capital` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_tipo_capital`)
);

CREATE TABLE `tipo_cobro`  (
  `id_tipo_cobro` int NOT NULL AUTO_INCREMENT,
  `periocidad_dias` int NULL,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_tipo_cobro`)
);

CREATE TABLE `tipo_concepto`  (
  `id_tipo_concepto` int NOT NULL AUTO_INCREMENT,
  `id_tipo_capital` int NULL,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_tipo_concepto`)
);

CREATE TABLE `tipo_credito`  (
  `id_tipo_credito` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_tipo_credito`)
);

CREATE TABLE `tipo_inmueble`  (
  `id_tipo_inmueble` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_tipo_inmueble`)
);

CREATE TABLE `tipo_media`  (
  `id_tipo_media` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NULL,
  PRIMARY KEY (`id_tipo_media`)
);

CREATE TABLE `tipo_pago`  (
  `id_tipo_pago` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_tipo_pago`)
);

CREATE TABLE `tipo_parentesco`  (
  `id_tipo_perentesco` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NULL,
  PRIMARY KEY (`id_tipo_perentesco`)
);

CREATE TABLE `usuario`  (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(100) NULL,
  `id_persona` int NULL,
  `usuario_padre` int NULL,
  `id_rol` int NULL,
  `id_ruta` int NULL,
  `id_empresa` int NULL,
  `id_sucursal` int NULL,
  `id_estado` int NULL,
  `fecha_reg` datetime NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `i_usuario`(`usuario`),
  UNIQUE INDEX `i_id_persona`(`id_persona`)
);

CREATE TABLE `venta`  (
  `id_reg` int NOT NULL AUTO_INCREMENT,
  `folio` varchar(50) NULL,
  `id_articulo` varchar(20) NULL,
  PRIMARY KEY (`id_reg`),
  INDEX `i_folio`(`folio`)
);

CREATE TABLE `zona_horaria`  (
  `id_zona_horaria` int NOT NULL,
  `utc` varchar(10) NULL,
  `zona` varchar(50) NULL,
  `descripcion` varchar(100) NULL,
  PRIMARY KEY (`id_zona_horaria`)
);

