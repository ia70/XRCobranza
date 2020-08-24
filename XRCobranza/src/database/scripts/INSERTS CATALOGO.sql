-- ESTADO -------------------------------------------------------

INSERT INTO estado VALUES(DEFAULT, "Activo");
INSERT INTO estado VALUES(DEFAULT, "Inactivo");
INSERT INTO estado VALUES(DEFAULT, "Eliminado");
INSERT INTO estado VALUES(DEFAULT, "Congelado");
INSERT INTO estado VALUES(DEFAULT, "Condonado");
INSERT INTO estado VALUES(DEFAULT, "Terminado");


-- MONEDA -------------------------------------------------------

INSERT INTO moneda VALUES(DEFAULT, "MXN", "Pesos Mexicanos");
INSERT INTO moneda VALUES(DEFAULT, "USD", "Dolar Estadonidense");


-- ROL ----------------------------------------------------------

INSERT INTO rol VALUES(DEFAULT, "Administrador");
INSERT INTO rol VALUES(DEFAULT, "Cobrador");
INSERT INTO rol VALUES(DEFAULT, "Cliente");
INSERT INTO rol VALUES(DEFAULT, "Master");



-- TIPO_CAPITAL ------------------------------------------------

INSERT INTO tipo_capital VALUES(DEFAULT, "Ingreso");
INSERT INTO tipo_capital VALUES(DEFAULT, "Egreso");


-- TIPO_CAPITAL ------------------------------------------------

INSERT INTO tipo_capital VALUES(DEFAULT, "Ingreso");
INSERT INTO tipo_capital VALUES(DEFAULT, "Egreso");


-- TIPO_COBRO -------------------------------------------------

INSERT INTO tipo_cobro VALUES(DEFAULT, 1, "Diario");
INSERT INTO tipo_cobro VALUES(DEFAULT, 7, "Semanal");
INSERT INTO tipo_cobro VALUES(DEFAULT, 14, "Catorcenal");
INSERT INTO tipo_cobro VALUES(DEFAULT, 15, "Quincenal");
INSERT INTO tipo_cobro VALUES(DEFAULT, 30, "Mensual");


-- TIPO_CREDITO -----------------------------------------------

INSERT INTO tipo_credito VALUES(DEFAULT, "Cliente nuevo");
INSERT INTO tipo_credito VALUES(DEFAULT, "Nueva venta");


-- TIPO_INMUEBLE ----------------------------------------------

INSERT INTO tipo_inmueble VALUES(DEFAULT, "Propio");
INSERT INTO tipo_inmueble VALUES(DEFAULT, "Rentado");


-- TIPO_MEDIA ------------------------------------------------

INSERT INTO tipo_media VALUES(DEFAULT, "Credencial lado A");
INSERT INTO tipo_media VALUES(DEFAULT, "Credencial lado B");
INSERT INTO tipo_media VALUES(DEFAULT, "Fotografia personal");
INSERT INTO tipo_media VALUES(DEFAULT, "Fotoggrafia domicilio");
INSERT INTO tipo_media VALUES(DEFAULT, "CURP");


-- TIPO_PAGO ----------------------------------------------

INSERT INTO tipo_pago VALUES(DEFAULT, "Pago normal");
INSERT INTO tipo_pago VALUES(DEFAULT, "Pago parcial");
INSERT INTO tipo_pago VALUES(DEFAULT, "Pago extra");
INSERT INTO tipo_pago VALUES(DEFAULT, "Sin pago");
INSERT INTO tipo_pago VALUES(DEFAULT, "Sin visitar");
INSERT INTO tipo_pago VALUES(DEFAULT, "Fin de credito");