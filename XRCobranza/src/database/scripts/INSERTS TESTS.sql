-- PERSONA - USUARIO ------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO persona VALUES("I01", NULL, "Administrador", "Daniel", "Pérez", "C", "Comalcalco", NULL, NULL, "9141198098", 1, NULL, NULL, NULL, NULL, 4, NULL, 1, "2020-08-23");
INSERT INTO usuario VALUES("U01", NULL, "I01", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("I02", NULL, "Cobrador", "Elias", "Ovando", "Caña", "Comalcalco", NULL, NULL, "993452189", 1, NULL, NULL, NULL, NULL, 2, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U02", I01, "I02", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("I03", NULL, "Vende tacos", "Sara", "Laines", "Lopez", "Comalcalco", NULL, NULL, "933452158", 1, NULL, NULL, NULL, NULL, 3, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U03", I01, "I03", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("I04", NULL, "Salbutes canul", "Eduardo", "Canul", "Arias", "Comalcalco", NULL, NULL, "9339852365", 1, NULL, NULL, NULL, NULL, 3, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U04", I01, "I04", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("I05", NULL, "Guero Zapatos", "Marcos", "Carrillo", "Jimenez", "Comalcalco", NULL, NULL, "9334568130", 1, NULL, NULL, NULL, NULL, 3, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U05", I01, "I05", "12345", NULL, 1, "2020-08-23");


-- RUTAS -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ruta VALUES(DEFAULT, 1, "Ruta 01", 1);
INSERT INTO ruta VALUES(DEFAULT, 1, "Ruta 02", 1);


-- EMPRESA -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO empresa VALUES("E01", "XCORU - Desarrollo de Software", "Comalcalco", "Comalcalco", 86300, "9141198098", NULL, 1, "2020-08-24");


-- SUCURSAL ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO sucursal VALUES(DEFAULT, "E01", "SUCURSAL 01", "COMALCALCO", 86300, "0000000000", 1, "2020-08-24");


-- CREDITO -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO credito VALUES("C01", "SILLA", "U02", "I03", 1, 3000, 150, "2020-08-24", "2020-08-24", "2020-08-24", 24, 1, 1, "2020-08-24");
INSERT INTO credito VALUES("C02", "SILLA", "U02", "I04", 1, 2000, 100, "2020-08-24", "2020-08-24", "2020-08-24", 24, 1, 1, "2020-08-24");
INSERT INTO credito VALUES("C03", "SILLA", "U02", "I04", 1, 2000, 100, "2020-08-24", "2020-08-24", "2020-08-24", 24, 1, 1, "2020-08-24");
INSERT INTO credito VALUES("C04", "SILLA", "U02", "I05", 1, 4000, 200, "2020-08-24", "2020-08-24", "2020-08-24", 24, 1, 1, "2020-08-24");