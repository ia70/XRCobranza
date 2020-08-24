-- PERSONA - USUARIO ------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO persona VALUES("001", NULL, "Administrador", "Daniel", "Pérez", "C", "Comalcalco", NULL, NULL, "9141198098", 1, NULL, NULL, NULL, NULL, 4, NULL, 1, "2020-08-23");
INSERT INTO usuario VALUES("U01", NULL, "001", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("002", NULL, "Cobrador", "Elias", "Ovando", "Caña", "Comalcalco", NULL, NULL, "993452189", 1, NULL, NULL, NULL, NULL, 2, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U02", 001, "002", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("003", NULL, "Vende tacos", "Sara", "Laines", "Lopez", "Comalcalco", NULL, NULL, "933452158", 1, NULL, NULL, NULL, NULL, 3, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U03", 001, "003", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("004", NULL, "Salbutes canul", "Eduardo", "Canul", "Arias", "Comalcalco", NULL, NULL, "9339852365", 1, NULL, NULL, NULL, NULL, 3, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U04", 001, "004", "12345", NULL, 1, "2020-08-23");

INSERT INTO persona VALUES("005", NULL, "Guero Zapatos", "Marcos", "Carrillo", "Jimenez", "Comalcalco", NULL, NULL, "9334568130", 1, NULL, NULL, NULL, NULL, 3, 1, 1, "2020-08-23");
INSERT INTO usuario VALUES("U05", 001, "005", "12345", NULL, 1, "2020-08-23");


-- RUTAS -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ruta VALUES(DEFAULT, 1, "Ruta 01", 1);
INSERT INTO ruta VALUES(DEFAULT, 1, "Ruta 02", 1);


