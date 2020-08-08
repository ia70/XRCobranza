-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema XRPrestamos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema XRPrestamos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `XRPrestamos` DEFAULT CHARACTER SET utf8 ;
USE `XRPrestamos` ;

-- -----------------------------------------------------
-- Table `XRPrestamos`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT COMMENT '1 - Activo\n2 - Inactivo\n3 - Suspendido \n4 - Eliminado\n5 - Verificar',
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`moneda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`moneda` (
  `id_moneda` INT NOT NULL AUTO_INCREMENT,
  `abreviatura` VARCHAR(5) NULL,
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id_moneda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`zona_horaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`zona_horaria` (
  `id_zona_horaria` INT NOT NULL AUTO_INCREMENT,
  `utc` VARCHAR(10) NULL,
  `zona` VARCHAR(50) NULL,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`id_zona_horaria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`configuracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`configuracion` (
  `id_configuracion` INT NOT NULL AUTO_INCREMENT,
  `no_cobradores` INT NULL,
  `licencia_inicio` DATE NULL,
  `licencia_fin` DATE NULL,
  `id_moneda` INT NULL,
  `id_zona_horaria` INT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_configuracion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`empresa` (
  `id_empresa` VARCHAR(50) NOT NULL,
  `razon_social` VARCHAR(250) NULL,
  `direccion` VARCHAR(250) NULL,
  `id_ciudad` INT NULL,
  `cp` INT NULL,
  `telefono` VARCHAR(12) NULL,
  `id_configuracion` INT NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`sucursal` (
  `id_sucursal` INT NOT NULL AUTO_INCREMENT,
  `id_empresa` VARCHAR(13) NOT NULL,
  `nombre` VARCHAR(120) NOT NULL,
  `direccion` VARCHAR(500) NULL,
  `id_ciudad` INT NULL,
  `cp` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_sucursal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`tipo_inmueble`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`tipo_inmueble` (
  `id_tipo_inmueble` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id_tipo_inmueble`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`provincia` (
  `id_provincia` INT NOT NULL AUTO_INCREMENT,
  `id_pais` INT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `id_provinvia` INT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_ciudad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`colonia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`colonia` (
  `id_colonia` INT NOT NULL AUTO_INCREMENT,
  `id_ciudad` INT NULL,
  `nombre` VARCHAR(50) NULL,
  PRIMARY KEY (`id_colonia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`calle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`calle` (
  `id_calle` INT NOT NULL AUTO_INCREMENT,
  `id_colonia` INT NULL,
  `nombre` VARCHAR(150) NULL,
  PRIMARY KEY (`id_calle`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`persona` (
  `ine` VARCHAR(100) NOT NULL,
  `ine_ref` VARCHAR(30) NULL COMMENT 'INE de usuario que está refiriendo',
  `alias` VARCHAR(60) NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido_paterno` VARCHAR(20) NOT NULL,
  `apellido_materno` VARCHAR(20) NOT NULL,
  `id_calle` INT NULL,
  `direccion` VARCHAR(250) NULL,
  `no_casa` VARCHAR(10) NULL,
  `referencias` VARCHAR(250) NULL,
  `foto_casa` LONGBLOB NULL,
  `telefono` VARCHAR(12) NULL,
  `correo` VARCHAR(100) NULL,
  `foto` LONGBLOB NULL,
  `ine_img` LONGBLOB NULL,
  `id_tipo_inmueble` INT NULL,
  `id_estado` INT NOT NULL,
  `fecha_reg` DATETIME NOT NULL COMMENT 'Fecha de Registro de Persona',
  PRIMARY KEY (`ine`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`usuario` (
  `id_usuario` VARCHAR(30) NOT NULL,
  `id_sucursal` INT NOT NULL DEFAULT 0,
  `ine` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `id_rol` INT NOT NULL,
  `usuario_padre` VARCHAR(20) NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`estado_credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`estado_credito` (
  `id_estado_credito` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(20) NULL,
  PRIMARY KEY (`id_estado_credito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`periodo` (
  `id_periodo` INT NOT NULL AUTO_INCREMENT,
  `id_sucursal` INT NOT NULL,
  `anio` INT NOT NULL,
  `mes` INT NOT NULL,
  `capital_inicio` DECIMAL(10,2) NULL,
  `capital_fin` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id_periodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`tipo_cobro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`tipo_cobro` (
  `id_tipo_cobro` INT NOT NULL AUTO_INCREMENT COMMENT 'Al cambiar los valores de la pestaña Insert debe actualizarce el código de la función CAL_FECHA_PAGO que esta ligada\na dicha información de esta tabla.',
  `perioricidad_dias` INT NOT NULL COMMENT 'Periodo de cobro en dias. Cada cuantos dias se cobrará.\n\nAl cambiar los valores de la pestaña Insert debe actualizarce el código de la función CAL_FECHA_PAGO que esta ligada\na dicha información de esta tabla.',
  `descripcion` VARCHAR(50) NOT NULL COMMENT 'Al cambiar los valores de la pestaña Insert debe actualizarce el código de la función CAL_FECHA_PAGO que esta ligada\na dicha información de esta tabla.',
  PRIMARY KEY (`id_tipo_cobro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`tipo_credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`tipo_credito` (
  `id_tipo_credito` INT NOT NULL AUTO_INCREMENT COMMENT 'Tipo de operqación:\n1- Nuevo cliente\n2- Renovación credito\n3- Nuevo credito a cliente Con credito activo\n4- Moroso',
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id_tipo_credito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`actividad_economica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`actividad_economica` (
  `id_actividad_economica` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_actividad_economica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`ruta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`ruta` (
  `id_ruta` INT NOT NULL AUTO_INCREMENT,
  `id_sucursal` INT NOT NULL,
  `descripcion` VARCHAR(500) NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_ruta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`tipo_local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`tipo_local` (
  `id_tipo_local` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(20) NULL,
  PRIMARY KEY (`id_tipo_local`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`usuario_establecimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`usuario_establecimiento` (
  `id_usuario_establecimiento` INT NOT NULL AUTO_INCREMENT,
  `ine` VARCHAR(100) NOT NULL,
  `nombre` VARCHAR(100) NULL,
  `id_calle` INT NULL,
  `numero_ext` VARCHAR(10) NULL,
  `referencias` VARCHAR(250) NULL,
  `id_actividad_economica` INT NULL,
  `id_tipo_inmueble` INT NULL,
  `id_tipo_local` INT NULL COMMENT 'Fijo\nAmbulante\nEmpleado',
  `documento_adicional` LONGBLOB NULL,
  `disponibilidad_hr_inicio` VARCHAR(30) NULL COMMENT 'Hora de paertura de local | Hora de inicio de disponibilidad',
  `disponibilidad_hr_fin` VARCHAR(30) NULL COMMENT 'Hora de cierre de local | Hora de fin de disponibilidad',
  `coordenadas` VARCHAR(100) NULL,
  `foto` LONGBLOB NULL,
  `id_ruta` INT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_usuario_establecimiento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`credito` (
  `folio_credito` VARCHAR(50) NOT NULL COMMENT 'Barcode or QR code',
  `descripcion` VARCHAR(100) NULL,
  `id_usuario` VARCHAR(30) NULL COMMENT 'Usuario quien registra el credito',
  `id_usuario_establecimiento` INT NOT NULL COMMENT 'Usuario a quien se le otorga el credito',
  `id_periodo` INT NULL,
  `id_tipo_cobro` INT NOT NULL,
  `monto_credito` DECIMAL(10,2) NOT NULL COMMENT 'Monto del prestamo',
  `monto_pago` DECIMAL(10,2) NOT NULL COMMENT 'Monto Pago Diario',
  `monto_total` DECIMAL(10,2) NOT NULL COMMENT 'Monto Total a Pagar con intereses',
  `fecha_entrega` DATE NOT NULL,
  `fecha_inicio_cobro` DATE NOT NULL,
  `fecha_siguiente_pago` DATE NULL,
  `pagos_total` INT NULL COMMENT 'Numero de pagos total a realizar',
  `id_estado_credito` INT NOT NULL,
  `id_estado` INT NOT NULL,
  `id_tipo_credito` INT NOT NULL COMMENT 'Tipo de operqación:\n1- Nuevo cliente\n2- Renovación credito\n3- Nuevo credito a cliente Con credito activo\n4- Moroso',
  `fecha_reg` DATETIME NULL,
  PRIMARY KEY (`folio_credito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`tipo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`tipo_pago` (
  `id_tipo_pago` INT NOT NULL AUTO_INCREMENT COMMENT 'Tipo de pago:\n1- Pago normal completo\n2- Pago parcial\n3- Extra\n4- No pago\n5- Sin visitar',
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id_tipo_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`abono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`abono` (
  `id_abono` INT NOT NULL AUTO_INCREMENT,
  `folio_credito` VARCHAR(50) NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `no_pagos` DECIMAL(10,2) NULL COMMENT 'Cantidad de pagos (adelantado - atrasado)',
  `id_tipo_pago` INT NOT NULL COMMENT 'Tipo de pago:\n1- Pago normal completo\n2- Pago parcial\n3- Extra\n4- No pago\n5- Sin visitar',
  `fecha_abono` DATE NOT NULL,
  `id_estado` INT NOT NULL,
  `fecha_reg` DATETIME NULL,
  PRIMARY KEY (`id_abono`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`permiso` (
  `id_permiso` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(50) NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_permiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`usuario_ruta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`usuario_ruta` (
  `id_usuario_ruta` INT NOT NULL AUTO_INCREMENT,
  `id_ruta` INT NOT NULL,
  `id_usuario` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_usuario_ruta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`tipo_capital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`tipo_capital` (
  `id_tipo_capital` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_tipo_capital`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`tipo_concepto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`tipo_concepto` (
  `id_tipo_concepto` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_capital` INT NOT NULL,
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id_tipo_concepto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`capital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`capital` (
  `id_capital` INT NOT NULL AUTO_INCREMENT,
  `id_sucursal` INT NOT NULL,
  `id_periodo` INT NOT NULL,
  `id_usuario` VARCHAR(30) NOT NULL,
  `id_tipo_capital` INT NOT NULL COMMENT '- Ingreso\n- Egreso',
  `id_tipo_concepto` INT NOT NULL COMMENT 'Tipo de consecto de ingreso o egreso:\n- Ingreso\n--- Remanente de entrega\n--- Recuperación de deuda\n--- General\n\n- Egreso\n--- Gasto oficina\n--- Mantenimiento Vehiculos\n--- General\n',
  `emisor` VARCHAR(45) NULL,
  `concepto` VARCHAR(500) NULL,
  `empresa` VARCHAR(120) NULL,
  `monto` DECIMAL(10,2) NULL,
  `hora` VARCHAR(20) NULL,
  `folio_ticket` VARCHAR(50) NULL,
  `comprobante` LONGBLOB NULL,
  `fecha` DATE NULL COMMENT 'Fecha del Ingreso/Egreso',
  `id_estado` INT NOT NULL,
  `fecha_reg` DATETIME NULL COMMENT 'Fecha en que se registro',
  PRIMARY KEY (`id_capital`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`aval`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`aval` (
  `id_aval` INT NOT NULL AUTO_INCREMENT,
  `ine` VARCHAR(100) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido_paterno` VARCHAR(20) NULL,
  `apellido_materno` VARCHAR(20) NULL,
  `direccion` VARCHAR(250) NULL,
  `telefono` VARCHAR(12) NULL,
  `parentesco` VARCHAR(50) NULL,
  PRIMARY KEY (`id_aval`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`sesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`sesion` (
  `id_sesion` VARCHAR(150) NOT NULL,
  `id_usuario` VARCHAR(30) NOT NULL,
  `inicio_sesion` DATETIME NOT NULL,
  `ultima_conexion` DATETIME NULL,
  `fin_sesion` DATETIME NULL,
  `id_estado` INT NOT NULL,
  PRIMARY KEY (`id_sesion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`estado_solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`estado_solicitud` (
  `id_estado_solicitud` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`id_estado_solicitud`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`solicitud` (
  `id_solicitud` INT NOT NULL AUTO_INCREMENT,
  `id_sucursal` INT NOT NULL,
  `id_usuario` VARCHAR(30) NOT NULL,
  `ine` VARCHAR(100) NOT NULL,
  `monto` DECIMAL(10) NOT NULL,
  `pagos` INT NULL COMMENT 'Número de pagos',
  `id_tipo_cobro` INT NULL COMMENT 'Tipo / perioricidad de pagos',
  `fecha_requerida` DATE NOT NULL COMMENT 'Fecha en que se requiere el prestamo.',
  `id_estado_solicitud` INT NULL,
  `id_estado` INT NOT NULL,
  `fecha_reg` DATETIME NULL,
  PRIMARY KEY (`id_solicitud`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`rol_permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`rol_permiso` (
  `id_rol_permiso` INT NOT NULL AUTO_INCREMENT,
  `id_rol` INT NULL,
  `id_permiso` INT NULL,
  PRIMARY KEY (`id_rol_permiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`usuario_permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`usuario_permiso` (
  `id_usuario_permiso` INT NOT NULL AUTO_INCREMENT,
  `id_permiso` INT NULL,
  PRIMARY KEY (`id_usuario_permiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`estadistica_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`estadistica_cliente` (
  `folio_credito` VARCHAR(50) NOT NULL,
  `ine` VARCHAR(100) NULL,
  `monto_credito` DECIMAL(10,2) NULL,
  `fecha_entrega` DATETIME NULL,
  `pagos_total` INT NULL,
  `no_pagos` DECIMAL(10,2) NULL,
  `no_abonos` INT NULL,
  `no_adelantos` DECIMAL(10,2) NULL,
  `no_atrasos` INT NULL,
  PRIMARY KEY (`folio_credito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `XRPrestamos`.`cobro_dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `XRPrestamos`.`cobro_dia` (
  `folio_credito` VARCHAR(50) NOT NULL,
  `ine` VARCHAR(100) NULL,
  `id_ruta` INT NULL,
  `id_usuario` VARCHAR(30) NULL,
  PRIMARY KEY (`folio_credito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`estado`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`estado` (`id_estado`, `descripcion`) VALUES (1, 'Activo');
INSERT INTO `XRPrestamos`.`estado` (`id_estado`, `descripcion`) VALUES (2, 'Inactivo');
INSERT INTO `XRPrestamos`.`estado` (`id_estado`, `descripcion`) VALUES (3, 'Suspendido');
INSERT INTO `XRPrestamos`.`estado` (`id_estado`, `descripcion`) VALUES (4, 'Eliminado');
INSERT INTO `XRPrestamos`.`estado` (`id_estado`, `descripcion`) VALUES (5, 'Verificar');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`moneda`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`moneda` (`id_moneda`, `abreviatura`, `descripcion`) VALUES (1, 'MXN', 'Pesos Mexicanos');
INSERT INTO `XRPrestamos`.`moneda` (`id_moneda`, `abreviatura`, `descripcion`) VALUES (2, 'USD', 'Dolar Estadonidense');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`zona_horaria`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`zona_horaria` (`id_zona_horaria`, `utc`, `zona`, `descripcion`) VALUES (1, 'UTC-6', 'America/Mexico_City', 'México');
INSERT INTO `XRPrestamos`.`zona_horaria` (`id_zona_horaria`, `utc`, `zona`, `descripcion`) VALUES (2, 'UTC-7', 'America/Phoenix', 'United States');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`configuracion`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`configuracion` (`id_configuracion`, `no_cobradores`, `licencia_inicio`, `licencia_fin`, `id_moneda`, `id_zona_horaria`, `id_estado`) VALUES (1, 10, '2020/03/01', '2030/03/01', 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`empresa`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`empresa` (`id_empresa`, `razon_social`, `direccion`, `id_ciudad`, `cp`, `telefono`, `id_configuracion`, `id_estado`) VALUES ('RFC45GENERICO', 'CDJ COP Asociados', 'Colonia Centro', 1, 86300, '9331452145', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`sucursal`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`sucursal` (`id_sucursal`, `id_empresa`, `nombre`, `direccion`, `id_ciudad`, `cp`, `telefono`, `id_estado`) VALUES (1, 'RFC45GENERICO', 'Comalcalco', 'Calle Reforma', 1, '86300', '9331490521', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`tipo_inmueble`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`tipo_inmueble` (`id_tipo_inmueble`, `descripcion`) VALUES (1, 'Propio');
INSERT INTO `XRPrestamos`.`tipo_inmueble` (`id_tipo_inmueble`, `descripcion`) VALUES (2, 'Renta');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`pais`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`pais` (`id_pais`, `nombre`) VALUES (1, 'México');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`provincia`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`provincia` (`id_provincia`, `id_pais`, `nombre`) VALUES (1, 1, 'Tabasco');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`ciudad`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`ciudad` (`id_ciudad`, `id_provinvia`, `nombre`) VALUES (1, 1, 'Comalcalco');
INSERT INTO `XRPrestamos`.`ciudad` (`id_ciudad`, `id_provinvia`, `nombre`) VALUES (2, 1, 'Paraiso');
INSERT INTO `XRPrestamos`.`ciudad` (`id_ciudad`, `id_provinvia`, `nombre`) VALUES (3, 1, 'Cunduacan');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`colonia`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`colonia` (`id_colonia`, `id_ciudad`, `nombre`) VALUES (1, 1, 'Centro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`calle`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`calle` (`id_calle`, `id_colonia`, `nombre`) VALUES (1, 1, 'Sin Definir');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`persona`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_ADMIN', NULL, 'Ingeniero', 'Daniel', 'Pérez', 'Cortéz', 1, 'Jalpa de Méndez', '10', 'Centro', NULL, '9141198098', 'pcd510@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_JC', NULL, 'JC', 'Angel', 'Castillo', 'López', 1, 'Comalcalco', '65', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_ANGEL', NULL, 'Angel', 'Maria Elena', 'Gonzalez', 'Ovando', 1, 'Comalcalco', '85', 'Centro', NULL, '9332514561', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_OFICINA', NULL, 'Oficina', 'Oficina', 'Oficina', 'Oficina', 1, 'Comalcalco', '2', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_1', NULL, 'Efren Torres Taxi #294', 'Efren', 'Torrez', 'Pérez', 1, 'Comalcalco', '123', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_2', NULL, 'Tortilleria San Judas Tadeo', 'Susana', 'Jimenez', 'Oliva', 1, 'Comalcalco', '987', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_3', NULL, 'Uñas Arreglos', 'Alejandro', 'Ricardez', 'Garcia', 1, 'Comalcalco', '12', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_4', NULL, 'Amiga Jannet Pollo', 'Maria del Rosario', 'Rivera', 'Salinas', 1, 'Comalcalco', '654', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_5', NULL, 'Raul Joyero', 'Raul', 'Ramirez', 'Falconi', 1, 'Comalcalco', '589', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_6', NULL, 'Peluqueria', 'Fabiola', 'Hernandez', 'Martinez', 1, 'Comalcalco', '35', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_7', NULL, 'Joel Pochi', 'Joel', 'Piña', 'Juarez', 1, 'Comalcalco', '14', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_8', NULL, 'Pochi Tomas Garrido', 'Juan Carlos', 'Méndez', 'Valenzuela', 1, 'Comalcalco', '65', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_9', NULL, 'Ignacio Alfredo Pochi', 'Ignacio', 'Alfredo', 'Perez', 1, 'Comalcalco', '81', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');
INSERT INTO `XRPrestamos`.`persona` (`ine`, `ine_ref`, `alias`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_calle`, `direccion`, `no_casa`, `referencias`, `foto_casa`, `telefono`, `correo`, `foto`, `ine_img`, `id_tipo_inmueble`, `id_estado`, `fecha_reg`) VALUES ('INE_10', NULL, 'Mateo Dominguez Pochi', 'Mateo', 'Dominguez', 'Chable', 1, 'Comalcalco', '21', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020/03/01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('admin', 1, 'INE_ADMIN', '12345', 1, NULL, 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('jc', 1, 'INE_JC', '12345', 2, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('angel', 1, 'INE_ANGEL', '12345', 2, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('oficina', 1, 'INE_OFICINA', '12345', 2, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente1', 1, 'INE_1', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente2', 1, 'INE_2', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente3', 1, 'INE_3', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente4', 1, 'INE_4', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente5', 1, 'INE_5', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente6', 1, 'INE_6', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente7', 1, 'INE_7', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente8', 1, 'INE_8', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente9', 1, 'INE_9', '12345', 3, 'admin', 1);
INSERT INTO `XRPrestamos`.`usuario` (`id_usuario`, `id_sucursal`, `ine`, `password`, `id_rol`, `usuario_padre`, `id_estado`) VALUES ('cliente10', 1, 'INE_10', '12345', 3, 'admin', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`estado_credito`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`estado_credito` (`id_estado_credito`, `descripcion`) VALUES (1, 'Activo');
INSERT INTO `XRPrestamos`.`estado_credito` (`id_estado_credito`, `descripcion`) VALUES (2, 'Inactivo');
INSERT INTO `XRPrestamos`.`estado_credito` (`id_estado_credito`, `descripcion`) VALUES (3, 'Congelado');
INSERT INTO `XRPrestamos`.`estado_credito` (`id_estado_credito`, `descripcion`) VALUES (4, 'Condonado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`periodo`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (1, 1, 2020, 1, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (2, 1, 2020, 2, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (3, 1, 2020, 3, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (4, 1, 2020, 4, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (5, 1, 2020, 5, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (6, 1, 2020, 6, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (7, 1, 2020, 7, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (8, 1, 2020, 8, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (9, 1, 2020, 9, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (10, 1, 2020, 10, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (11, 1, 2020, 11, 0, 0);
INSERT INTO `XRPrestamos`.`periodo` (`id_periodo`, `id_sucursal`, `anio`, `mes`, `capital_inicio`, `capital_fin`) VALUES (12, 1, 2020, 12, 0, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`tipo_cobro`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`tipo_cobro` (`id_tipo_cobro`, `perioricidad_dias`, `descripcion`) VALUES (1, 1, 'Diario');
INSERT INTO `XRPrestamos`.`tipo_cobro` (`id_tipo_cobro`, `perioricidad_dias`, `descripcion`) VALUES (2, 7, 'Semanal');
INSERT INTO `XRPrestamos`.`tipo_cobro` (`id_tipo_cobro`, `perioricidad_dias`, `descripcion`) VALUES (3, 14, 'Catorcenal');
INSERT INTO `XRPrestamos`.`tipo_cobro` (`id_tipo_cobro`, `perioricidad_dias`, `descripcion`) VALUES (4, 15, 'Quincenal');
INSERT INTO `XRPrestamos`.`tipo_cobro` (`id_tipo_cobro`, `perioricidad_dias`, `descripcion`) VALUES (5, 30, 'Mensual');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`tipo_credito`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`tipo_credito` (`id_tipo_credito`, `descripcion`) VALUES (1, 'Nuevo Cliente');
INSERT INTO `XRPrestamos`.`tipo_credito` (`id_tipo_credito`, `descripcion`) VALUES (2, 'Renovación de credito');
INSERT INTO `XRPrestamos`.`tipo_credito` (`id_tipo_credito`, `descripcion`) VALUES (3, 'Nuevo credito');
INSERT INTO `XRPrestamos`.`tipo_credito` (`id_tipo_credito`, `descripcion`) VALUES (4, 'Recuperación');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`actividad_economica`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (1, 'Taqueria');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (2, 'Carniceria');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (3, 'Reparación de Celulares');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (4, 'Pollos aliñados');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (5, 'Estética');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (6, 'Pochi');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (7, 'Taxista');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (8, 'Antojitos');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (9, 'Comerciante');
INSERT INTO `XRPrestamos`.`actividad_economica` (`id_actividad_economica`, `descripcion`) VALUES (10, 'Tienda de Electrónica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`ruta`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`ruta` (`id_ruta`, `id_sucursal`, `descripcion`, `id_estado`) VALUES (1, 1, 'R2-Motorizada', 1);
INSERT INTO `XRPrestamos`.`ruta` (`id_ruta`, `id_sucursal`, `descripcion`, `id_estado`) VALUES (2, 1, 'Mercado', 1);
INSERT INTO `XRPrestamos`.`ruta` (`id_ruta`, `id_sucursal`, `descripcion`, `id_estado`) VALUES (3, 1, 'Oficina', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`tipo_local`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`tipo_local` (`id_tipo_local`, `descripcion`) VALUES (1, 'Fijo');
INSERT INTO `XRPrestamos`.`tipo_local` (`id_tipo_local`, `descripcion`) VALUES (2, 'Ambulante');
INSERT INTO `XRPrestamos`.`tipo_local` (`id_tipo_local`, `descripcion`) VALUES (3, 'Empleado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`usuario_establecimiento`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (1, 'INE_1', 'Taxi #294', 1, '2', NULL, 4, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (2, 'INE_2', 'Tortilleria San Judas Tadeo', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (3, 'INE_3', 'Uñas Arreglos', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (4, 'INE_4', 'Vende Pollo', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 2, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (5, 'INE_5', 'Raul Joyero', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 2, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (6, 'INE_6', 'Peluqueria', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 2, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (7, 'INE_7', 'Joel Pochi', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 3, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (8, 'INE_8', 'Pochi Tomas Garrido', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 3, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (9, 'INE_9', 'Ignacio Alfredo Pochi', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 3, 1);
INSERT INTO `XRPrestamos`.`usuario_establecimiento` (`id_usuario_establecimiento`, `ine`, `nombre`, `id_calle`, `numero_ext`, `referencias`, `id_actividad_economica`, `id_tipo_inmueble`, `id_tipo_local`, `documento_adicional`, `disponibilidad_hr_inicio`, `disponibilidad_hr_fin`, `coordenadas`, `foto`, `id_ruta`, `id_estado`) VALUES (10, 'INE_10', 'Mateo Dominguez Pochi', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`credito`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('1', NULL, 'admin', 1, 3, 1, 5000, 250, 6000, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('2', NULL, 'admin', 2, 3, 1, 3000, 150, 3600, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('3', NULL, 'admin', 3, 3, 1, 2000, 100, 2400, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('4', NULL, 'admin', 4, 3, 1, 1000, 50, 1200, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('5', NULL, 'admin', 5, 3, 1, 3000, 150, 3600, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('6', NULL, 'admin', 6, 3, 1, 2000, 100, 2400, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('7', NULL, 'admin', 7, 3, 1, 1000, 50, 1200, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('8', NULL, 'admin', 8, 3, 1, 2000, 100, 2400, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('9', NULL, 'admin', 9, 3, 1, 3000, 150, 3600, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('10', NULL, 'admin', 10, 3, 1, 2000, 100, 2400, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');
INSERT INTO `XRPrestamos`.`credito` (`folio_credito`, `descripcion`, `id_usuario`, `id_usuario_establecimiento`, `id_periodo`, `id_tipo_cobro`, `monto_credito`, `monto_pago`, `monto_total`, `fecha_entrega`, `fecha_inicio_cobro`, `fecha_siguiente_pago`, `pagos_total`, `id_estado_credito`, `id_estado`, `id_tipo_credito`, `fecha_reg`) VALUES ('11', NULL, 'admin', 1, 3, 1, 4000, 200, 4800, '2020/02/15', '2020/02/16', '2020/06/14', 24, 1, 1, 1, '2020/02/15');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`tipo_pago`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`tipo_pago` (`id_tipo_pago`, `descripcion`) VALUES (1, 'Pago normal');
INSERT INTO `XRPrestamos`.`tipo_pago` (`id_tipo_pago`, `descripcion`) VALUES (2, 'Abono parcial');
INSERT INTO `XRPrestamos`.`tipo_pago` (`id_tipo_pago`, `descripcion`) VALUES (3, 'Extra');
INSERT INTO `XRPrestamos`.`tipo_pago` (`id_tipo_pago`, `descripcion`) VALUES (4, 'No pagó');
INSERT INTO `XRPrestamos`.`tipo_pago` (`id_tipo_pago`, `descripcion`) VALUES (5, 'Sin visitar');
INSERT INTO `XRPrestamos`.`tipo_pago` (`id_tipo_pago`, `descripcion`) VALUES (6, 'Fin de Credito');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`abono`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (1, '1', 250, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (2, '2', 150, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (3, '3', 100, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (4, '4', 50, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (5, '5', 150, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (6, '6', 100, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (7, '7', 50, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (8, '8', 100, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (9, '9', 150, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (10, '10', 100, 1, 1, '2020/03/18', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (11, '1', 500, 2, 3, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (12, '2', 250, 1, 3, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (13, '3', 50, 1, 2, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (14, '4', 300, 6, 3, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (15, '5', 100, 1, 2, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (16, '6', 200, 2, 3, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (17, '7', 50, 1, 1, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (18, '8', 120, 1, 3, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (19, '9', 400, 2, 3, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (20, '10', 90, 1, 2, '2020/03/19', 1, '2020/03/19');
INSERT INTO `XRPrestamos`.`abono` (`id_abono`, `folio_credito`, `monto`, `no_pagos`, `id_tipo_pago`, `fecha_abono`, `id_estado`, `fecha_reg`) VALUES (21, '11', 800, 4, 3, '2020/03/19', 1, '2020/03/19');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`rol`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`rol` (`id_rol`, `descripcion`, `id_estado`) VALUES (1, 'Administrador', 1);
INSERT INTO `XRPrestamos`.`rol` (`id_rol`, `descripcion`, `id_estado`) VALUES (2, 'Cobrador', 1);
INSERT INTO `XRPrestamos`.`rol` (`id_rol`, `descripcion`, `id_estado`) VALUES (3, 'Cliente', 1);
INSERT INTO `XRPrestamos`.`rol` (`id_rol`, `descripcion`, `id_estado`) VALUES (4, 'Master', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`permiso`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`permiso` (`id_permiso`, `categoria`, `descripcion`, `id_estado`) VALUES (1, NULL, 'Registrar Cliente', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`usuario_ruta`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`usuario_ruta` (`id_usuario_ruta`, `id_ruta`, `id_usuario`) VALUES (1, 1, 'jc');
INSERT INTO `XRPrestamos`.`usuario_ruta` (`id_usuario_ruta`, `id_ruta`, `id_usuario`) VALUES (2, 2, 'angel');
INSERT INTO `XRPrestamos`.`usuario_ruta` (`id_usuario_ruta`, `id_ruta`, `id_usuario`) VALUES (3, 3, 'oficina');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`tipo_capital`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`tipo_capital` (`id_tipo_capital`, `descripcion`) VALUES (1, 'Ingreso');
INSERT INTO `XRPrestamos`.`tipo_capital` (`id_tipo_capital`, `descripcion`) VALUES (2, 'Egreso');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`tipo_concepto`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`tipo_concepto` (`id_tipo_concepto`, `id_tipo_capital`, `descripcion`) VALUES (1, 1, 'General');
INSERT INTO `XRPrestamos`.`tipo_concepto` (`id_tipo_concepto`, `id_tipo_capital`, `descripcion`) VALUES (2, 1, 'Remanente de entrega');
INSERT INTO `XRPrestamos`.`tipo_concepto` (`id_tipo_concepto`, `id_tipo_capital`, `descripcion`) VALUES (3, 1, 'Recuperación de deuda');
INSERT INTO `XRPrestamos`.`tipo_concepto` (`id_tipo_concepto`, `id_tipo_capital`, `descripcion`) VALUES (4, 2, 'General');
INSERT INTO `XRPrestamos`.`tipo_concepto` (`id_tipo_concepto`, `id_tipo_capital`, `descripcion`) VALUES (5, 2, 'Gasto oficina');
INSERT INTO `XRPrestamos`.`tipo_concepto` (`id_tipo_concepto`, `id_tipo_capital`, `descripcion`) VALUES (6, 2, 'Mantenimiento vehiculos');

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`capital`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`capital` (`id_capital`, `id_sucursal`, `id_periodo`, `id_usuario`, `id_tipo_capital`, `id_tipo_concepto`, `emisor`, `concepto`, `empresa`, `monto`, `hora`, `folio_ticket`, `comprobante`, `fecha`, `id_estado`, `fecha_reg`) VALUES (1, 1, 1, 'admin', 1, 1, 'admin', 'Capital', NULL, 50000, NULL, NULL, NULL, NULL, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `XRPrestamos`.`estado_solicitud`
-- -----------------------------------------------------
START TRANSACTION;
USE `XRPrestamos`;
INSERT INTO `XRPrestamos`.`estado_solicitud` (`id_estado_solicitud`, `descripcion`) VALUES (1, 'Aprobado');
INSERT INTO `XRPrestamos`.`estado_solicitud` (`id_estado_solicitud`, `descripcion`) VALUES (2, 'En espera');
INSERT INTO `XRPrestamos`.`estado_solicitud` (`id_estado_solicitud`, `descripcion`) VALUES (3, 'Rechazado');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
