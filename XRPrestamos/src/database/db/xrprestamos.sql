/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 100411
 Source Host           : 127.0.0.1:3306
 Source Schema         : xrprestamos

 Target Server Type    : MySQL
 Target Server Version : 100411
 File Encoding         : 65001

 Date: 20/06/2020 15:17:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS xrprestamos;
USE xrprestamos;

-- ----------------------------
-- Table structure for abono
-- ----------------------------
DROP TABLE IF EXISTS `abono`;
CREATE TABLE `abono`  (
  `id_abono` int(11) NOT NULL AUTO_INCREMENT,
  `folio_credito` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `monto` decimal(10, 2) NOT NULL,
  `no_pagos` decimal(10, 2) NULL DEFAULT NULL COMMENT 'Cantidad de pagos (adelantado - atrasado)',
  `id_tipo_pago` int(11) NOT NULL COMMENT 'Tipo de pago:\n1- Pago normal completo\n2- Pago parcial\n3- Extra\n4- No pago\n5- Sin visitar',
  `hora_abono` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fecha_abono` date NOT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_reg` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id_abono`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of abono
-- ----------------------------
INSERT INTO `abono` VALUES (1, '1', 250.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (2, '2', 150.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (3, '3', 100.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (4, '4', 50.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (5, '5', 150.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (6, '6', 100.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (7, '7', 50.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (8, '8', 100.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (9, '9', 150.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (10, '10', 100.00, 1.00, 1, NULL, '2020-03-18', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (11, '1', 500.00, 2.00, 3, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (12, '2', 250.00, 1.00, 3, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (13, '3', 50.00, 1.00, 2, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (14, '4', 300.00, 6.00, 3, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (15, '5', 100.00, 1.00, 2, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (16, '6', 200.00, 2.00, 3, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (17, '7', 50.00, 1.00, 1, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (18, '8', 120.00, 1.00, 3, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (19, '9', 400.00, 2.00, 3, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (20, '10', 90.00, 1.00, 2, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (21, '11', 800.00, 4.00, 3, NULL, '2020-03-19', 1, '2020-03-19 00:00:00');
INSERT INTO `abono` VALUES (22, '1', 250.00, 1.00, 1, NULL, '2020-06-20', 1, '2020-06-20 15:00:00');

-- ----------------------------
-- Table structure for actividad_economica
-- ----------------------------
DROP TABLE IF EXISTS `actividad_economica`;
CREATE TABLE `actividad_economica`  (
  `id_actividad_economica` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_actividad_economica`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actividad_economica
-- ----------------------------
INSERT INTO `actividad_economica` VALUES (1, 'Taqueria');
INSERT INTO `actividad_economica` VALUES (2, 'Carniceria');
INSERT INTO `actividad_economica` VALUES (3, 'Reparación de Celulares');
INSERT INTO `actividad_economica` VALUES (4, 'Pollos aliñados');
INSERT INTO `actividad_economica` VALUES (5, 'Estética');
INSERT INTO `actividad_economica` VALUES (6, 'Pochi');
INSERT INTO `actividad_economica` VALUES (7, 'Taxista');
INSERT INTO `actividad_economica` VALUES (8, 'Antojitos');
INSERT INTO `actividad_economica` VALUES (9, 'Comerciante');
INSERT INTO `actividad_economica` VALUES (10, 'Tienda de Electrónica');

-- ----------------------------
-- Table structure for aval
-- ----------------------------
DROP TABLE IF EXISTS `aval`;
CREATE TABLE `aval`  (
  `id_aval` int(11) NOT NULL AUTO_INCREMENT,
  `ine` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellido_paterno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `apellido_materno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `direccion` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telefono` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parentesco` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_aval`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aval
-- ----------------------------
INSERT INTO `aval` VALUES (2, 'INE_11', 'David', 'Jimenez', 'Perez', NULL, '933645824', 'Primo');

-- ----------------------------
-- Table structure for calle
-- ----------------------------
DROP TABLE IF EXISTS `calle`;
CREATE TABLE `calle`  (
  `id_calle` int(11) NOT NULL AUTO_INCREMENT,
  `id_colonia` int(11) NULL DEFAULT NULL,
  `nombre` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_calle`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of calle
-- ----------------------------
INSERT INTO `calle` VALUES (1, 1, 'Sin Definir');

-- ----------------------------
-- Table structure for capital
-- ----------------------------
DROP TABLE IF EXISTS `capital`;
CREATE TABLE `capital`  (
  `id_capital` int(11) NOT NULL AUTO_INCREMENT,
  `id_sucursal` int(11) NOT NULL,
  `id_periodo` int(11) NOT NULL,
  `id_usuario` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_tipo_capital` int(11) NOT NULL COMMENT '- Ingreso\n- Egreso',
  `id_tipo_concepto` int(11) NOT NULL COMMENT 'Tipo de consecto de ingreso o egreso:\n- Ingreso\n--- Remanente de entrega\n--- Recuperación de deuda\n--- General\n\n- Egreso\n--- Gasto oficina\n--- Mantenimiento Vehiculos\n--- General\n',
  `emisor` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `concepto` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empresa` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `monto` decimal(10, 2) NULL DEFAULT NULL,
  `hora` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `folio_ticket` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `comprobante` longblob NULL,
  `fecha` date NULL DEFAULT NULL COMMENT 'Fecha del Ingreso/Egreso',
  `id_estado` int(11) NOT NULL,
  `fecha_reg` datetime(0) NULL DEFAULT NULL COMMENT 'Fecha en que se registro',
  PRIMARY KEY (`id_capital`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of capital
-- ----------------------------
INSERT INTO `capital` VALUES (1, 1, 1, 'admin', 1, 1, 'admin', 'Capital', NULL, 50000.00, NULL, NULL, NULL, NULL, 1, NULL);

-- ----------------------------
-- Table structure for ciudad
-- ----------------------------
DROP TABLE IF EXISTS `ciudad`;
CREATE TABLE `ciudad`  (
  `id_ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `id_provinvia` int(11) NULL DEFAULT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_ciudad`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ciudad
-- ----------------------------
INSERT INTO `ciudad` VALUES (1, 1, 'Comalcalco');
INSERT INTO `ciudad` VALUES (2, 1, 'Paraiso');
INSERT INTO `ciudad` VALUES (3, 1, 'Cunduacan');

-- ----------------------------
-- Table structure for cobro_dia
-- ----------------------------
DROP TABLE IF EXISTS `cobro_dia`;
CREATE TABLE `cobro_dia`  (
  `folio_credito` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ine` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_ruta` int(11) NULL DEFAULT NULL,
  `id_usuario` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`folio_credito`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cobro_dia
-- ----------------------------
INSERT INTO `cobro_dia` VALUES ('1', 'INE_1', 1, 'jc');
INSERT INTO `cobro_dia` VALUES ('10', 'INE_10', 1, 'jc');
INSERT INTO `cobro_dia` VALUES ('11', 'INE_1', 1, 'jc');
INSERT INTO `cobro_dia` VALUES ('2', 'INE_2', 1, 'jc');
INSERT INTO `cobro_dia` VALUES ('3', 'INE_3', 1, 'jc');
INSERT INTO `cobro_dia` VALUES ('4', 'INE_4', 2, 'angel');
INSERT INTO `cobro_dia` VALUES ('5', 'INE_5', 2, 'angel');
INSERT INTO `cobro_dia` VALUES ('6', 'INE_6', 2, 'angel');
INSERT INTO `cobro_dia` VALUES ('7', 'INE_7', 3, 'oficina');
INSERT INTO `cobro_dia` VALUES ('8', 'INE_8', 3, 'oficina');
INSERT INTO `cobro_dia` VALUES ('9', 'INE_9', 3, 'oficina');

-- ----------------------------
-- Table structure for colonia
-- ----------------------------
DROP TABLE IF EXISTS `colonia`;
CREATE TABLE `colonia`  (
  `id_colonia` int(11) NOT NULL AUTO_INCREMENT,
  `id_ciudad` int(11) NULL DEFAULT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_colonia`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of colonia
-- ----------------------------
INSERT INTO `colonia` VALUES (1, 1, 'Centro');

-- ----------------------------
-- Table structure for configuracion
-- ----------------------------
DROP TABLE IF EXISTS `configuracion`;
CREATE TABLE `configuracion`  (
  `id_configuracion` int(11) NOT NULL AUTO_INCREMENT,
  `no_cobradores` int(11) NULL DEFAULT NULL,
  `licencia_inicio` date NULL DEFAULT NULL,
  `licencia_fin` date NULL DEFAULT NULL,
  `id_moneda` int(11) NULL DEFAULT NULL,
  `id_zona_horaria` int(11) NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_configuracion`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of configuracion
-- ----------------------------
INSERT INTO `configuracion` VALUES (1, 10, '2020-03-01', '2030-03-01', 1, 1, 1);

-- ----------------------------
-- Table structure for credito
-- ----------------------------
DROP TABLE IF EXISTS `credito`;
CREATE TABLE `credito`  (
  `folio_credito` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Barcode or QR code',
  `descripcion` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_usuario` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Usuario quien registra el credito',
  `id_usuario_establecimiento` int(11) NOT NULL COMMENT 'Usuario a quien se le otorga el credito',
  `id_periodo` int(11) NULL DEFAULT NULL,
  `id_tipo_cobro` int(11) NOT NULL,
  `monto_credito` decimal(10, 2) NOT NULL COMMENT 'Monto del prestamo',
  `monto_pago` decimal(10, 2) NOT NULL COMMENT 'Monto Pago Diario',
  `monto_total` decimal(10, 2) NOT NULL COMMENT 'Monto Total a Pagar con intereses',
  `fecha_entrega` date NOT NULL,
  `fecha_inicio_cobro` date NOT NULL,
  `fecha_siguiente_pago` date NULL DEFAULT NULL,
  `pagos_total` int(11) NULL DEFAULT NULL COMMENT 'Numero de pagos total a realizar',
  `id_estado_credito` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `id_tipo_credito` int(11) NOT NULL COMMENT 'Tipo de operqación:\n1- Nuevo cliente\n2- Renovación credito\n3- Nuevo credito a cliente Con credito activo\n4- Moroso',
  `fecha_reg` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`folio_credito`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of credito
-- ----------------------------
INSERT INTO `credito` VALUES ('1', NULL, 'admin', 1, 3, 1, 5000.00, 250.00, 6000.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('10', NULL, 'admin', 10, 3, 1, 2000.00, 100.00, 2400.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 2, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('11', NULL, 'admin', 1, 3, 1, 4000.00, 200.00, 4800.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('2', NULL, 'admin', 2, 3, 1, 3000.00, 150.00, 3600.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('3', NULL, 'admin', 3, 3, 1, 2000.00, 100.00, 2400.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('4', NULL, 'admin', 4, 3, 1, 1000.00, 50.00, 1200.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('5', NULL, 'admin', 5, 3, 1, 3000.00, 150.00, 3600.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('6', NULL, 'admin', 6, 3, 1, 2000.00, 100.00, 2400.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('7', NULL, 'admin', 7, 3, 1, 1000.00, 50.00, 1200.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('8', NULL, 'admin', 8, 3, 1, 2000.00, 100.00, 2400.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');
INSERT INTO `credito` VALUES ('9', NULL, 'admin', 9, 3, 1, 3000.00, 150.00, 3600.00, '2020-02-15', '2020-02-16', '2020-06-20', 24, 1, 1, 1, '2020-02-15 00:00:00');

-- ----------------------------
-- Table structure for empresa
-- ----------------------------
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa`  (
  `id_empresa` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `razon_social` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `direccion` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_ciudad` int(11) NULL DEFAULT NULL,
  `cp` int(11) NULL DEFAULT NULL,
  `telefono` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_configuracion` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_empresa`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empresa
-- ----------------------------
INSERT INTO `empresa` VALUES ('RFC45GENERICO', 'CDJ COP Asociados', 'Colonia Centro', 1, 86300, '9331452145', 1, 1);

-- ----------------------------
-- Table structure for estadistica_cliente
-- ----------------------------
DROP TABLE IF EXISTS `estadistica_cliente`;
CREATE TABLE `estadistica_cliente`  (
  `id_estadistica_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `ine` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_credito` int(11) NULL DEFAULT NULL,
  `monto_credito` decimal(10, 2) NULL DEFAULT NULL,
  `fecha_entrega` date NULL DEFAULT NULL,
  `pagos_total` int(11) NULL DEFAULT NULL,
  `no_pagos` int(11) NULL DEFAULT NULL,
  `no_abonos` int(11) NULL DEFAULT NULL,
  `no_adelantados` int(11) NULL DEFAULT NULL,
  `no_adelantado_parcial` int(11) NULL DEFAULT NULL,
  `no_atrasados` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_estadistica_cliente`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for estado
-- ----------------------------
DROP TABLE IF EXISTS `estado`;
CREATE TABLE `estado`  (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT COMMENT '1 - Activo\n2 - Inactivo\n3 - Suspendido \n4 - Eliminado\n5 - Verificar',
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_estado`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estado
-- ----------------------------
INSERT INTO `estado` VALUES (1, 'Activo');
INSERT INTO `estado` VALUES (2, 'Inactivo');
INSERT INTO `estado` VALUES (3, 'Suspendido');
INSERT INTO `estado` VALUES (4, 'Eliminado');
INSERT INTO `estado` VALUES (5, 'Verificar');

-- ----------------------------
-- Table structure for estado_credito
-- ----------------------------
DROP TABLE IF EXISTS `estado_credito`;
CREATE TABLE `estado_credito`  (
  `id_estado_credito` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_estado_credito`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estado_credito
-- ----------------------------
INSERT INTO `estado_credito` VALUES (1, 'Activo');
INSERT INTO `estado_credito` VALUES (2, 'Inactivo');
INSERT INTO `estado_credito` VALUES (3, 'Congelado');
INSERT INTO `estado_credito` VALUES (4, 'Condonado');

-- ----------------------------
-- Table structure for estado_solicitud
-- ----------------------------
DROP TABLE IF EXISTS `estado_solicitud`;
CREATE TABLE `estado_solicitud`  (
  `id_estado_solicitud` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_estado_solicitud`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estado_solicitud
-- ----------------------------
INSERT INTO `estado_solicitud` VALUES (1, 'Aprobado');
INSERT INTO `estado_solicitud` VALUES (2, 'En espera');
INSERT INTO `estado_solicitud` VALUES (3, 'Rechazado');

-- ----------------------------
-- Table structure for moneda
-- ----------------------------
DROP TABLE IF EXISTS `moneda`;
CREATE TABLE `moneda`  (
  `id_moneda` int(11) NOT NULL AUTO_INCREMENT,
  `abreviatura` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_moneda`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of moneda
-- ----------------------------
INSERT INTO `moneda` VALUES (1, 'MXN', 'Pesos Mexicanos');
INSERT INTO `moneda` VALUES (2, 'USD', 'Dolar Estadonidense');

-- ----------------------------
-- Table structure for pais
-- ----------------------------
DROP TABLE IF EXISTS `pais`;
CREATE TABLE `pais`  (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_pais`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pais
-- ----------------------------
INSERT INTO `pais` VALUES (1, 'México');

-- ----------------------------
-- Table structure for periodo
-- ----------------------------
DROP TABLE IF EXISTS `periodo`;
CREATE TABLE `periodo`  (
  `id_periodo` int(11) NOT NULL AUTO_INCREMENT,
  `id_sucursal` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `capital_inicio` decimal(10, 2) NULL DEFAULT NULL,
  `capital_fin` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_periodo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of periodo
-- ----------------------------
INSERT INTO `periodo` VALUES (1, 1, 2020, 1, 0.00, 0.00);
INSERT INTO `periodo` VALUES (2, 1, 2020, 2, 0.00, 0.00);
INSERT INTO `periodo` VALUES (3, 1, 2020, 3, 0.00, 0.00);
INSERT INTO `periodo` VALUES (4, 1, 2020, 4, 0.00, 0.00);
INSERT INTO `periodo` VALUES (5, 1, 2020, 5, 0.00, 0.00);
INSERT INTO `periodo` VALUES (6, 1, 2020, 6, 0.00, 0.00);
INSERT INTO `periodo` VALUES (7, 1, 2020, 7, 0.00, 0.00);
INSERT INTO `periodo` VALUES (8, 1, 2020, 8, 0.00, 0.00);
INSERT INTO `periodo` VALUES (9, 1, 2020, 9, 0.00, 0.00);
INSERT INTO `periodo` VALUES (10, 1, 2020, 10, 0.00, 0.00);
INSERT INTO `periodo` VALUES (11, 1, 2020, 11, 0.00, 0.00);
INSERT INTO `periodo` VALUES (12, 1, 2020, 12, 0.00, 0.00);

-- ----------------------------
-- Table structure for permiso
-- ----------------------------
DROP TABLE IF EXISTS `permiso`;
CREATE TABLE `permiso`  (
  `id_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripcion` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_permiso`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permiso
-- ----------------------------
INSERT INTO `permiso` VALUES (1, NULL, 'Registrar Cliente', 1);

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona`  (
  `ine` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ine_ref` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'INE de usuario que está refiriendo',
  `alias` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellido_paterno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellido_materno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_calle` int(11) NULL DEFAULT NULL,
  `direccion` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `no_casa` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `referencias` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `foto_casa` longblob NULL,
  `telefono` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `correo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `foto` longblob NULL,
  `ine_img` longblob NULL,
  `id_tipo_inmueble` int(11) NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_reg` datetime(0) NOT NULL COMMENT 'Fecha de Registro de Persona',
  PRIMARY KEY (`ine`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of persona
-- ----------------------------
INSERT INTO `persona` VALUES ('INE_1', NULL, 'Efren Torres Taxi #294', 'Efren', 'Torrez', 'Pérez', 1, 'Comalcalco', '123', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_10', NULL, 'Mateo Dominguez Pochi', 'Mateo', 'Dominguez', 'Chable', 1, 'Comalcalco', '21', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_11', NULL, 'Canul', 'Francisco', 'Javier', 'Arellanos', 1, 'Comalcalco', '', 'Centro', NULL, '9634525468', '', NULL, NULL, 2, 5, '2020-06-19 05:44:45');
INSERT INTO `persona` VALUES ('INE_2', NULL, 'Tortilleria San Judas Tadeo', 'Susana', 'Jimenez', 'Oliva', 1, 'Comalcalco', '987', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_3', NULL, 'Uñas Arreglos', 'Alejandro', 'Ricardez', 'Garcia', 1, 'Comalcalco', '12', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_4', NULL, 'Amiga Jannet Pollo', 'Maria del Rosario', 'Rivera', 'Salinas', 1, 'Comalcalco', '654', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_5', NULL, 'Raul Joyero', 'Raul', 'Ramirez', 'Falconi', 1, 'Comalcalco', '589', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_6', NULL, 'Peluqueria', 'Fabiola', 'Hernandez', 'Martinez', 1, 'Comalcalco', '35', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_7', NULL, 'Joel Pochi', 'Joel', 'Piña', 'Juarez', 1, 'Comalcalco', '14', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_8', NULL, 'Pochi Tomas Garrido', 'Juan Carlos', 'Méndez', 'Valenzuela', 1, 'Comalcalco', '65', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_9', NULL, 'Ignacio Alfredo Pochi', 'Ignacio', 'Alfredo', 'Perez', 1, 'Comalcalco', '81', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_ADMIN', NULL, 'Ingeniero', 'Daniel', 'Pérez', 'Cortéz', 1, 'Jalpa de Méndez', '10', 'Centro', NULL, '9141198098', 'pcd510@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_ANGEL', NULL, 'Angel', 'Maria Elena', 'Gonzalez', 'Ovando', 1, 'Comalcalco', '85', 'Centro', NULL, '9332514561', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_JC', NULL, 'JC', 'Angel', 'Castillo', 'López', 1, 'Comalcalco', '65', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 1, 1, '2020-03-01 00:00:00');
INSERT INTO `persona` VALUES ('INE_OFICINA', NULL, 'Oficina', 'Oficina', 'Oficina', 'Oficina', 1, 'Comalcalco', '2', 'Centro', NULL, '9331036538', 'ejemplo@hotmail.com', NULL, NULL, 2, 1, '2020-03-01 00:00:00');

-- ----------------------------
-- Table structure for provincia
-- ----------------------------
DROP TABLE IF EXISTS `provincia`;
CREATE TABLE `provincia`  (
  `id_provincia` int(11) NOT NULL AUTO_INCREMENT,
  `id_pais` int(11) NULL DEFAULT NULL,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_provincia`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of provincia
-- ----------------------------
INSERT INTO `provincia` VALUES (1, 1, 'Tabasco');

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_rol`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rol
-- ----------------------------
INSERT INTO `rol` VALUES (1, 'Administrador', 1);
INSERT INTO `rol` VALUES (2, 'Cobrador', 1);
INSERT INTO `rol` VALUES (3, 'Cliente', 1);
INSERT INTO `rol` VALUES (4, 'Master', 1);

-- ----------------------------
-- Table structure for rol_permiso
-- ----------------------------
DROP TABLE IF EXISTS `rol_permiso`;
CREATE TABLE `rol_permiso`  (
  `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) NULL DEFAULT NULL,
  `id_permiso` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol_permiso`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ruta
-- ----------------------------
DROP TABLE IF EXISTS `ruta`;
CREATE TABLE `ruta`  (
  `id_ruta` int(11) NOT NULL AUTO_INCREMENT,
  `id_sucursal` int(11) NOT NULL,
  `descripcion` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_ruta`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ruta
-- ----------------------------
INSERT INTO `ruta` VALUES (1, 1, 'R2-Motorizada', 1);
INSERT INTO `ruta` VALUES (2, 1, 'Mercado', 1);
INSERT INTO `ruta` VALUES (3, 1, 'Oficina', 1);

-- ----------------------------
-- Table structure for sesion
-- ----------------------------
DROP TABLE IF EXISTS `sesion`;
CREATE TABLE `sesion`  (
  `id_sesion` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_usuario` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inicio_sesion` datetime(0) NOT NULL,
  `ultima_conexion` datetime(0) NULL DEFAULT NULL,
  `fin_sesion` datetime(0) NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_sesion`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sesion
-- ----------------------------
INSERT INTO `sesion` VALUES ('7hkAHrW7Pxh1SN20PW5%2BEQpb9hw3Kxo5TLUqS1bkZ5s%3D', 'angel', '2020-06-18 07:27:52', '2020-06-18 07:30:52', NULL, 1);
INSERT INTO `sesion` VALUES ('aLe72x1mF7qCUlXih1yaiPVgM2Q2MiVl%2FU59M0fapG0%3D', 'jc', '2020-06-19 06:39:07', '2020-06-19 06:39:07', '2020-06-19 06:57:21', 2);
INSERT INTO `sesion` VALUES ('e1FzRUPDQwgB0engWQQlK%2Bgl2zfvV%2BcnAXfI%2Favl%2Byg%3D', 'admin', '2020-06-19 12:38:16', '2020-06-19 12:38:18', NULL, 1);
INSERT INTO `sesion` VALUES ('e1FzRUPDQwgB0engWQQlK0KL1GU7Ehy0CW0E4r2ZSjo%3D', 'jc', '2020-06-19 12:38:32', '2020-06-19 12:41:05', '2020-06-19 12:51:03', 2);
INSERT INTO `sesion` VALUES ('L0cKCN9RoRfAZdtI%2BSVpcL0MZB6MhBiINTkjX55TAUo%3D', 'jc', '2020-06-19 06:57:21', '2020-06-19 06:57:30', '2020-06-20 10:29:40', 2);
INSERT INTO `sesion` VALUES ('MBCvAWvegWJ2QwgohkLBNDQy%2FT3lcG9nqVYl%2B0jAn10%3D', 'jc', '2020-06-19 06:20:13', '2020-06-19 06:35:39', '2020-06-19 06:39:07', 2);
INSERT INTO `sesion` VALUES ('qToJLKqx%2BWttEcmZI8hic6Mu9uCz9eliZnvGiqNU6Oo%3D', 'jc', '2020-06-19 05:40:50', '2020-06-19 05:55:56', '2020-06-19 06:20:13', 2);
INSERT INTO `sesion` VALUES ('TKCfQ2xdn%2FV%2BZ%2BgfhNyMJSpBK5T4806djU3Oa84SeVU%3D', 'jc', '2020-06-19 12:51:03', '2020-06-19 12:53:40', '2020-06-19 05:40:50', 2);
INSERT INTO `sesion` VALUES ('V6RGJ3K9luF1P%2BGA%2FDxTfqt4uDD2jEUGwoBvDLZnHxk%3D', 'angel', '2020-06-18 07:21:52', '2020-06-18 07:26:34', '2020-06-18 07:27:52', 2);
INSERT INTO `sesion` VALUES ('VVkY%2Bc94RwsiaByTU5AkLcve9E72z%2FUKU2piSPJAZpc%3D', 'jc', '2020-06-20 10:29:40', '2020-06-20 11:37:45', NULL, 1);
INSERT INTO `sesion` VALUES ('WD1W8kPBYa8kq1UyCBBu21pTTyn%2FmA4hWkgyb%2FyiZww%3D', 'admin', '2020-06-18 06:28:03', '2020-06-18 06:28:10', '2020-06-19 12:38:16', 2);
INSERT INTO `sesion` VALUES ('WD1W8kPBYa8kq1UyCBBu2x3mv7dYnMlWRZmrcYIFSS8%3D', 'jc', '2020-06-18 06:28:23', '2020-06-18 06:30:43', '2020-06-18 07:17:33', 2);
INSERT INTO `sesion` VALUES ('WYKdCk7PyqCSi3kVvnoElQ7oAXiYE27D%2FuPJFAzLV0s%3D', 'jc', '2020-06-18 07:17:33', '2020-06-18 07:21:09', '2020-06-19 12:38:32', 2);

-- ----------------------------
-- Table structure for solicitud
-- ----------------------------
DROP TABLE IF EXISTS `solicitud`;
CREATE TABLE `solicitud`  (
  `id_solicitud` int(11) NOT NULL AUTO_INCREMENT,
  `id_sucursal` int(11) NOT NULL,
  `id_usuario` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ine` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `monto` decimal(10, 0) NOT NULL,
  `pagos` int(11) NULL DEFAULT NULL COMMENT 'Número de pagos',
  `id_tipo_cobro` int(11) NULL DEFAULT NULL COMMENT 'Tipo / perioricidad de pagos',
  `fecha_requerida` date NOT NULL COMMENT 'Fecha en que se requiere el prestamo.',
  `id_estado_solicitud` int(11) NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  `fecha_reg` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of solicitud
-- ----------------------------
INSERT INTO `solicitud` VALUES (1, 1, 'jc', 'INE_9', 5000, 24, 1, '2020-06-26', 2, 1, '2020-06-18 07:19:53');
INSERT INTO `solicitud` VALUES (2, 1, 'jc', 'INE_8', 1000, 24, 1, '2020-06-30', 2, 1, '2020-06-18 07:20:57');
INSERT INTO `solicitud` VALUES (3, 1, 'angel', 'INE_1', 3000, 24, 1, '2020-06-19', 2, 1, '2020-06-18 07:22:41');
INSERT INTO `solicitud` VALUES (4, 1, 'jc', 'INE_11', 6000, 30, 1, '2020-06-23', 2, 1, '2020-06-19 05:48:44');

-- ----------------------------
-- Table structure for sucursal
-- ----------------------------
DROP TABLE IF EXISTS `sucursal`;
CREATE TABLE `sucursal`  (
  `id_sucursal` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nombre` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_ciudad` int(11) NULL DEFAULT NULL,
  `cp` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telefono` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_sucursal`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sucursal
-- ----------------------------
INSERT INTO `sucursal` VALUES (1, 'RFC45GENERICO', 'Comalcalco', 'Calle Reforma', 1, '86300', '9331490521', 1);

-- ----------------------------
-- Table structure for tipo_capital
-- ----------------------------
DROP TABLE IF EXISTS `tipo_capital`;
CREATE TABLE `tipo_capital`  (
  `id_tipo_capital` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_tipo_capital`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_capital
-- ----------------------------
INSERT INTO `tipo_capital` VALUES (1, 'Ingreso');
INSERT INTO `tipo_capital` VALUES (2, 'Egreso');

-- ----------------------------
-- Table structure for tipo_cobro
-- ----------------------------
DROP TABLE IF EXISTS `tipo_cobro`;
CREATE TABLE `tipo_cobro`  (
  `id_tipo_cobro` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Al cambiar los valores de la pestaña Insert debe actualizarce el código de la función CAL_FECHA_PAGO que esta ligada\na dicha información de esta tabla.',
  `perioricidad_dias` int(11) NOT NULL COMMENT 'Periodo de cobro en dias. Cada cuantos dias se cobrará.\n\nAl cambiar los valores de la pestaña Insert debe actualizarce el código de la función CAL_FECHA_PAGO que esta ligada\na dicha información de esta tabla.',
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Al cambiar los valores de la pestaña Insert debe actualizarce el código de la función CAL_FECHA_PAGO que esta ligada\na dicha información de esta tabla.',
  PRIMARY KEY (`id_tipo_cobro`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_cobro
-- ----------------------------
INSERT INTO `tipo_cobro` VALUES (1, 1, 'Diario');
INSERT INTO `tipo_cobro` VALUES (2, 7, 'Semanal');
INSERT INTO `tipo_cobro` VALUES (3, 14, 'Catorcenal');
INSERT INTO `tipo_cobro` VALUES (4, 15, 'Quincenal');
INSERT INTO `tipo_cobro` VALUES (5, 30, 'Mensual');

-- ----------------------------
-- Table structure for tipo_concepto
-- ----------------------------
DROP TABLE IF EXISTS `tipo_concepto`;
CREATE TABLE `tipo_concepto`  (
  `id_tipo_concepto` int(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_capital` int(11) NOT NULL,
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_concepto`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_concepto
-- ----------------------------
INSERT INTO `tipo_concepto` VALUES (1, 1, 'General');
INSERT INTO `tipo_concepto` VALUES (2, 1, 'Remanente de entrega');
INSERT INTO `tipo_concepto` VALUES (3, 1, 'Recuperación de deuda');
INSERT INTO `tipo_concepto` VALUES (4, 2, 'General');
INSERT INTO `tipo_concepto` VALUES (5, 2, 'Gasto oficina');
INSERT INTO `tipo_concepto` VALUES (6, 2, 'Mantenimiento vehiculos');

-- ----------------------------
-- Table structure for tipo_credito
-- ----------------------------
DROP TABLE IF EXISTS `tipo_credito`;
CREATE TABLE `tipo_credito`  (
  `id_tipo_credito` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tipo de operqación:\n1- Nuevo cliente\n2- Renovación credito\n3- Nuevo credito a cliente Con credito activo\n4- Moroso',
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_credito`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_credito
-- ----------------------------
INSERT INTO `tipo_credito` VALUES (1, 'Nuevo Cliente');
INSERT INTO `tipo_credito` VALUES (2, 'Renovación de credito');
INSERT INTO `tipo_credito` VALUES (3, 'Nuevo credito');
INSERT INTO `tipo_credito` VALUES (4, 'Recuperación');

-- ----------------------------
-- Table structure for tipo_inmueble
-- ----------------------------
DROP TABLE IF EXISTS `tipo_inmueble`;
CREATE TABLE `tipo_inmueble`  (
  `id_tipo_inmueble` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_inmueble`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_inmueble
-- ----------------------------
INSERT INTO `tipo_inmueble` VALUES (1, 'Propio');
INSERT INTO `tipo_inmueble` VALUES (2, 'Renta');

-- ----------------------------
-- Table structure for tipo_local
-- ----------------------------
DROP TABLE IF EXISTS `tipo_local`;
CREATE TABLE `tipo_local`  (
  `id_tipo_local` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_local`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_local
-- ----------------------------
INSERT INTO `tipo_local` VALUES (1, 'Fijo');
INSERT INTO `tipo_local` VALUES (2, 'Ambulante');
INSERT INTO `tipo_local` VALUES (3, 'Empleado');

-- ----------------------------
-- Table structure for tipo_pago
-- ----------------------------
DROP TABLE IF EXISTS `tipo_pago`;
CREATE TABLE `tipo_pago`  (
  `id_tipo_pago` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tipo de pago:\n1- Pago normal completo\n2- Pago parcial\n3- Extra\n4- No pago\n5- Sin visitar',
  `descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_pago`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_pago
-- ----------------------------
INSERT INTO `tipo_pago` VALUES (1, 'Pago normal');
INSERT INTO `tipo_pago` VALUES (2, 'Abono parcial');
INSERT INTO `tipo_pago` VALUES (3, 'Extra');
INSERT INTO `tipo_pago` VALUES (4, 'No pagó');
INSERT INTO `tipo_pago` VALUES (5, 'Sin visitar');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `id_usuario` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_sucursal` int(11) NOT NULL DEFAULT 0,
  `ine` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id_rol` int(11) NOT NULL,
  `usuario_padre` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('admin', 1, 'INE_ADMIN', '12345', 1, NULL, 1);
INSERT INTO `usuario` VALUES ('angel', 1, 'INE_ANGEL', '12345', 2, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente1', 1, 'INE_1', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente10', 1, 'INE_10', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente2', 1, 'INE_2', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente3', 1, 'INE_3', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente4', 1, 'INE_4', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente5', 1, 'INE_5', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente6', 1, 'INE_6', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente7', 1, 'INE_7', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente8', 1, 'INE_8', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('cliente9', 1, 'INE_9', '12345', 3, 'admin', 1);
INSERT INTO `usuario` VALUES ('INE_11', 1, 'INE_11', '12345', 3, 'jc', 5);
INSERT INTO `usuario` VALUES ('jc', 1, 'INE_JC', '12345', 2, 'admin', 1);
INSERT INTO `usuario` VALUES ('oficina', 1, 'INE_OFICINA', '12345', 2, 'admin', 1);

-- ----------------------------
-- Table structure for usuario_establecimiento
-- ----------------------------
DROP TABLE IF EXISTS `usuario_establecimiento`;
CREATE TABLE `usuario_establecimiento`  (
  `id_usuario_establecimiento` int(11) NOT NULL AUTO_INCREMENT,
  `ine` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_calle` int(11) NULL DEFAULT NULL,
  `numero_ext` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `referencias` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id_actividad_economica` int(11) NULL DEFAULT NULL,
  `id_tipo_inmueble` int(11) NULL DEFAULT NULL,
  `id_tipo_local` int(11) NULL DEFAULT NULL COMMENT 'Fijo\nAmbulante\nEmpleado',
  `documento_adicional` longblob NULL,
  `disponibilidad_hr_inicio` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Hora de paertura de local | Hora de inicio de disponibilidad',
  `disponibilidad_hr_fin` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Hora de cierre de local | Hora de fin de disponibilidad',
  `coordenadas` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `foto` longblob NULL,
  `id_ruta` int(11) NULL DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario_establecimiento`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario_establecimiento
-- ----------------------------
INSERT INTO `usuario_establecimiento` VALUES (1, 'INE_1', 'Taxi #294', 1, '2', NULL, 4, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);
INSERT INTO `usuario_establecimiento` VALUES (2, 'INE_2', 'Tortilleria San Judas Tadeo', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);
INSERT INTO `usuario_establecimiento` VALUES (3, 'INE_3', 'Uñas Arreglos', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);
INSERT INTO `usuario_establecimiento` VALUES (4, 'INE_4', 'Vende Pollo', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 2, 1);
INSERT INTO `usuario_establecimiento` VALUES (5, 'INE_5', 'Raul Joyero', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 2, 1);
INSERT INTO `usuario_establecimiento` VALUES (6, 'INE_6', 'Peluqueria', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 2, 1);
INSERT INTO `usuario_establecimiento` VALUES (7, 'INE_7', 'Joel Pochi', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 3, 1);
INSERT INTO `usuario_establecimiento` VALUES (8, 'INE_8', 'Pochi Tomas Garrido', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 3, 1);
INSERT INTO `usuario_establecimiento` VALUES (9, 'INE_9', 'Ignacio Alfredo Pochi', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 3, 1);
INSERT INTO `usuario_establecimiento` VALUES (10, 'INE_10', 'Mateo Dominguez Pochi', NULL, NULL, NULL, NULL, 1, 2, NULL, '8:00', '18:00', NULL, NULL, 1, 1);
INSERT INTO `usuario_establecimiento` VALUES (12, 'INE_11', 'Salbutes Canul', NULL, NULL, 'Banco santander', NULL, 2, 2, NULL, '09:00', '16:00', '', NULL, 2, 5);

-- ----------------------------
-- Table structure for usuario_permiso
-- ----------------------------
DROP TABLE IF EXISTS `usuario_permiso`;
CREATE TABLE `usuario_permiso`  (
  `id_usuario_permiso` int(11) NOT NULL AUTO_INCREMENT,
  `id_permiso` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario_permiso`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for usuario_ruta
-- ----------------------------
DROP TABLE IF EXISTS `usuario_ruta`;
CREATE TABLE `usuario_ruta`  (
  `id_usuario_ruta` int(11) NOT NULL AUTO_INCREMENT,
  `id_ruta` int(11) NOT NULL,
  `id_usuario` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_usuario_ruta`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario_ruta
-- ----------------------------
INSERT INTO `usuario_ruta` VALUES (1, 1, 'jc');
INSERT INTO `usuario_ruta` VALUES (2, 2, 'angel');
INSERT INTO `usuario_ruta` VALUES (3, 3, 'oficina');

-- ----------------------------
-- Table structure for zona_horaria
-- ----------------------------
DROP TABLE IF EXISTS `zona_horaria`;
CREATE TABLE `zona_horaria`  (
  `id_zona_horaria` int(11) NOT NULL AUTO_INCREMENT,
  `utc` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zona` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_zona_horaria`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zona_horaria
-- ----------------------------
INSERT INTO `zona_horaria` VALUES (1, 'UTC-6', 'America/Mexico_City', 'México');
INSERT INTO `zona_horaria` VALUES (2, 'UTC-7', 'America/Phoenix', 'United States');

-- ----------------------------
-- Procedure structure for CARTERA_CLIENTES
-- ----------------------------
DROP PROCEDURE IF EXISTS `CARTERA_CLIENTES`;
delimiter ;;
CREATE DEFINER=`xcoru`@`%` PROCEDURE `CARTERA_CLIENTES`(IN usuario VARCHAR(30))
BEGIN
		-- a Persona
		-- b Credito
		-- c Abono
		-- d Usuario_establecimiento
		-- e Usuario_ruta
		-- f Usuario

		SELECT a.alias, a.nombre, a.apellido_paterno, a.apellido_materno, b.monto_total, SUM(c.monto) AS "pagado", (b.monto_total - SUM(c.monto)) AS "restante" FROM credito b
			INNER JOIN usuario_establecimiento AS d ON d.id_usuario_establecimiento = b.id_usuario_establecimiento
			INNER JOIN persona AS a ON a.ine = d.ine
			INNER JOIN usuario_ruta AS e ON e.id_ruta = d.id_ruta
			INNER JOIN usuario AS f ON f.id_usuario = e.id_usuario
			JOIN abono AS c 
			WHERE f.id_usuario = usuario AND b.id_estado_credito = 1
			GROUP BY b.folio_credito;
   END
;;
delimiter ;

-- ----------------------------
-- Function structure for COBRODIA_CAL_FECHA_PAGO
-- ----------------------------
DROP FUNCTION IF EXISTS `COBRODIA_CAL_FECHA_PAGO`;
delimiter ;;
CREATE DEFINER=`xcoru`@`%` FUNCTION `COBRODIA_CAL_FECHA_PAGO`(fecha_pago DATE, tipo_cobro INT) RETURNS varchar(20) CHARSET utf8
BEGIN 
	DECLARE fecha DATE;

	CASE tipo_cobro
		WHEN 1 THEN # AGREGAR UN DIA A LA FECHA
			SET fecha = NOW();
			RETURN fecha;
			-- --------------------------------------------------------------------------------------------------
		WHEN 2 THEN #
			SET fecha = DATE_ADD(fecha_pago, INTERVAL 7 DAY);
			RETURN fecha;
			-- --------------------------------------------------------------------------------------------------
		WHEN 3 THEN # 
			SET fecha = DATE_ADD(fecha_pago, INTERVAL 14 DAY);
			RETURN fecha;
			-- --------------------------------------------------------------------------------------------------
		WHEN 4 THEN # 
			SET fecha = DATE_ADD(fecha_pago, INTERVAL 15 DAY);
			RETURN fecha;
			-- --------------------------------------------------------------------------------------------------
		WHEN 5 THEN # 
			SET fecha = DATE_ADD(fecha_pago, INTERVAL 1 MONTH);
			RETURN fecha;
			-- --------------------------------------------------------------------------------------------------
		END CASE;
		RETURN '2020-01-01';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for COBRODIA_PROC_CALCULAR
-- ----------------------------
DROP PROCEDURE IF EXISTS `COBRODIA_PROC_CALCULAR`;
delimiter ;;
CREATE DEFINER=`xcoru`@`%` PROCEDURE `COBRODIA_PROC_CALCULAR`()
BEGIN

	-- DECLARACION DE VARIABLES ---------------------------------------------------------------------------------------
	DECLARE done INT DEFAULT FALSE;								-- Control de error de FOR(CURSOR)
	DECLARE var_folio VARCHAR(50) DEFAULT "";			-- Folio del credito
	DECLARE var_id_tipo INT DEFAULT 0;						-- Tipo de cobro del credito
	DECLARE var_fecha DATE;												-- Fecha del siguiente pago
	DECLARE var_ruta INT DEFAULT 0;								-- Ruta
	DECLARE var_usuario VARCHAR(30) DEFAULT ""; 	-- Usuario (cobrador)
	DECLARE var_ine VARCHAR(100);

	-- DECLARACION DEL CURSOR -----------------------------------------------------------------------------------------
	DEClARE curLista 
		CURSOR FOR 
			SELECT a.folio_credito, a.id_tipo_cobro, a.fecha_siguiente_pago, b.id_ruta, c.id_usuario, b.ine FROM credito a
				INNER JOIN usuario_establecimiento AS b ON b.id_usuario_establecimiento = a.id_usuario_establecimiento
				INNER JOIN usuario_ruta AS c ON c.id_ruta = b.id_ruta
				WHERE a.fecha_siguiente_pago <= CURDATE() ORDER BY a.folio_credito ASC;

	-- DECLARACION DE ERROR PARA FOR(CURSOR) --------------------------------------------------------------------------
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	-- Se inicializa el cursor
	OPEN curLista;
	
	-- Borrar datos anteriores de la tabla COBRO_DIA
	TRUNCATE TABLE cobro_dia;

	-- Se inicia ciclo repetitivo -------------------------------------------------------------------------------------
	ciclo: LOOP
		FETCH curLista INTO var_folio, var_id_tipo, var_fecha, var_ruta, var_usuario, var_ine;
		
		IF done THEN 
			LEAVE ciclo;
		END IF;
		
		IF var_fecha < CURDATE() THEN
			SET var_fecha = COBRODIA_CAL_FECHA_PAGO(var_fecha, var_id_tipo);
			UPDATE credito SET fecha_siguiente_pago = var_fecha WHERE folio_credito = var_folio;
		END IF;
		
		IF var_fecha = CURDATE() THEN
			INSERT INTO cobro_dia VALUES(var_folio, var_ine, var_ruta, var_usuario);
		END IF;
		
	END LOOP ciclo;
	CLOSE curLista;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for COBRO_DIA
-- ----------------------------
DROP PROCEDURE IF EXISTS `COBRO_DIA`;
delimiter ;;
CREATE DEFINER=`xcoru`@`%` PROCEDURE `COBRO_DIA`(IN usuario VARCHAR(100))
BEGIN
		-- a Persona
-- b Credito
-- c Abono
-- d Cobro_dia

SELECT D.folio_credito,a.ine, a.alias, CONCAT_WS(' ', a.nombre, a.apellido_paterno, a.apellido_materno) AS "nombre", b.monto_pago, c.id_tipo_pago, c.monto
FROM credito b
INNER JOIN cobro_dia AS d ON d.folio_credito = b.folio_credito
INNER JOIN persona AS a ON a.ine = d.ine
LEFT JOIN abono AS c ON c.folio_credito = d.folio_credito AND DATE(c.fecha_reg) = CURDATE()

WHERE d.id_usuario = usuario;
	END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for FILTRAR_CLIENTES
-- ----------------------------
DROP PROCEDURE IF EXISTS `FILTRAR_CLIENTES`;
delimiter ;;
CREATE DEFINER=`xcoru`@`%` PROCEDURE `FILTRAR_CLIENTES`(IN filtro VARCHAR(100))
BEGIN
		SELECT a.ine, concat_ws(' ',a.alias, " - ", a.nombre, a.apellido_paterno, a.apellido_materno) AS "nombre" FROM persona a
		INNER JOIN usuario AS b ON b.ine = a.ine
		WHERE b.id_rol = 3 AND concat_ws(' ', a.ine, a.alias, a.nombre, a.apellido_paterno, a.apellido_materno) 
		LIKE CONCAT('%',filtro,'%') ORDER BY nombre ASC LIMIT 10;
	END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for LISTA_SOLICITUDES
-- ----------------------------
DROP PROCEDURE IF EXISTS `LISTA_SOLICITUDES`;
delimiter ;;
CREATE DEFINER=`xcoru`@`%` PROCEDURE `LISTA_SOLICITUDES`(IN usuario VARCHAR(100))
BEGIN
		SELECT a.ine, a.alias, CONCAT_WS(' ', a.nombre, a.apellido_paterno, a.apellido_materno) AS "nombre", b.monto, b.pagos, b.id_estado_solicitud 
		FROM persona a INNER JOIN solicitud AS b ON b.ine = a.ine
		WHERE b.id_usuario = usuario;
	END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
