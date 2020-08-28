-- PERSONA - USUARIO ------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO persona VALUES(DEFAULT, "I02", "Cobrador", "Elias", "Ovando", "Caña", "Comalcalco", NULL, NULL, "9934521890", 1, NULL, NULL, NULL, NULL, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES(DEFAULT, "U02", "12345", 2, NULL, 2, 1, 1, 1, "2020-08-23");

INSERT INTO persona VALUES(DEFAULT, "I03", "Vende tacos", "Sara", "Laines", "Lopez", "Comalcalco", NULL, NULL, "9334521587", 1, NULL, NULL, NULL, NULL, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES(DEFAULT, "U03", "12345", 3, NULL, 3, 1, 1, 1, "2020-08-23");

INSERT INTO persona VALUES(DEFAULT, "I04", "Salbutes canul", "Eduardo", "Canul", "Arias", "Comalcalco", NULL, NULL, "9339852365", 1, NULL, NULL, NULL, NULL, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES(DEFAULT, "U04", "12345", 4, NULL, 3, 1, 1, 1, "2020-08-23");

INSERT INTO persona VALUES(DEFAULT, "I05", "Guero Zapatos", "Marcos", "Carrillo", "Jimenez", "Comalcalco", NULL, NULL, "9334568130", 1, NULL, NULL, NULL, NULL, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES(DEFAULT, "U05", "12345", 5, NULL, 3, 1, 1, 1, "2020-08-23");


-- RUTAS -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ruta VALUES(DEFAULT, 1, "Ruta 01", 1);
INSERT INTO ruta VALUES(DEFAULT, 1, "Ruta 02", 1);


-- EMPRESA -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO empresa VALUES(DEFAULT, "XCORU - Desarrollo de Software", "E01", "Comalcalco", "Comalcalco", 86300, "9141198098", 12, 1, "2020-08-24");


-- CONFIGURACION -----------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO configuracion VALUES(DEFAULT, 1, 100, "2020-08-01", "2100-01-01", 1, 1, 1, "2020-08-24");


-- SUCURSAL ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sucursal VALUES(DEFAULT, 1, "SUCURSAL 01", "COMALCALCO", 86300, "0000000000", 1, "2020-08-24");


-- CREDITO -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO credito VALUES("C01", 1, 3, "SILLA", 1, 3000, 150, "2020-08-24", "2020-08-24", "2020-08-24", 24, 0, 1, 1, "2020-08-24");
INSERT INTO credito VALUES("C02", 1, 4, "SILLA", 1, 2000, 100, "2020-08-24", "2020-08-24", "2020-08-24", 24, 0, 1, 1, "2020-08-24");
INSERT INTO credito VALUES("C03", 1, 4, "SILLA", 1, 5000, 250, "2020-08-24", "2020-08-24", "2020-08-24", 24, 0, 1, 1, "2020-08-24");
INSERT INTO credito VALUES("C04", 1, 5, "SILLA", 1, 4000, 200, "2020-08-24", "2020-08-24", "2020-08-24", 24, 0, 1, 1, "2020-08-24");


