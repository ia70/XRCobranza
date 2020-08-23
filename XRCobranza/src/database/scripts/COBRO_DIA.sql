DROP PROCEDURE IF EXISTS COBRO_DIA;
DELIMITER //
CREATE PROCEDURE COBRO_DIA(IN var_usuario VARCHAR(100))
BEGIN

		-- DECLARACION DE VARIABLES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DECLARE done 								INT DEFAULT FALSE;
	
	DECLARE var_folio_credito		VARCHAR(50) DEFAULT "";
	DECLARE var_id_ruta 				INT DEFAULT 0;
	DECLARE var_ine 						VARCHAR(100) DEFAULT "";
	DECLARE var_nombre 					VARCHAR(100) DEFAULT "";
	DECLARE var_alias 					VARCHAR(60) DEFAULT "";
	DECLARE var_telefono 				VARCHAR(12) DEFAULT "";
	DECLARE var_monto_credito 	DECIMAL(10,2) DEFAULT 0;
	DECLARE var_pagos_total 		INT DEFAULT 0;
	DECLARE var_monto_total 		DECIMAL(10,2) DEFAULT 0;
	DECLARE var_monto_pago 			DECIMAL(10,2) DEFAULT 0;
	DECLARE var_fecha_entrega 	DATE DEFAULT "";
	DECLARE var_pagado 					DECIMAL(10,2) DEFAULT 0;
	DECLARE var_atrasos_no 			DECIMAL(10,2) DEFAULT 0;
	DECLARE var_atrasos_monto 	DECIMAL(10,2) DEFAULT 0;
	DECLARE var_extras_no 				DECIMAL(10,2) DEFAULT 0;
	DECLARE var_extras_monto 		DECIMAL(10,2) DEFAULT 0;
	DECLARE var_id_estado 			INT DEFAULT 0;
	DECLARE var_id_estado_credito INT DEFAULT 0;
	
	DECLARE var_restante_no 		INT DEFAULT 0;
	DECLARE var_restante_monto 	DECIMAL(10,2) DEFAULT 0;
	DECLARE var_restante_total 	DECIMAL(10,2) DEFAULT 0;
	DECLARE var_abono_hoy 			DECIMAL(10,2) DEFAULT 0;
	DECLARE var_id_tipo_pago 		INT DEFAULT 0;
	DECLARE var_descripcion 		VARCHAR(50) DEFAULT "";
	
	DECLARE var_abonos_no 			INT DEFAULT 0;
	DECLARE var_id_tipo_pago_aux INT DEFAULT 0;

	
	-- DECLARACION DEL CURSOR ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		
		-- a Persona
		-- b Credito
		-- c Abono
		-- d Cobro_dia
		-- e Tipo_pago

	DEClARE curLista 
		CURSOR FOR 
				SELECT 
					d.folio_credito,
					d.id_ruta,
					a.ine, 
					CONCAT_WS(' ', a.nombre, a.apellido_paterno, a.apellido_materno) AS "nombre", 
					a.alias, 
					a.telefono, 
					b.monto_credito, 
					b.pagos_total, 
					(b.monto_pago * b.pagos_total) AS "monto_total", 
					b.monto_pago, 
					b.fecha_entrega, 
					COUNT(IF(c.id_tipo_pago = 4,c.id_tipo_pago,NULL)) AS "atrasos_no", 
					SUM(IF(c.id_tipo_pago = 4, b.monto_pago,IF(c.id_tipo_pago = 2, b.monto_pago - c.monto, 0))) AS "atrasos_monto",
					COUNT(IF(c.id_tipo_pago = 3,c.id_tipo_pago,NULL)) AS "extras_no", 
					SUM(IF(c.id_tipo_pago = 3, c.monto - b.monto_pago, 0)) AS "extras_monto",
					b.id_estado,
					b.id_estado_credito
				FROM credito b
				INNER JOIN cobro_dia AS d ON d.folio_credito = b.folio_credito 
				INNER JOIN persona AS a ON a.ine = d.ine 
				LEFT JOIN abono AS c ON c.folio_credito = d.folio_credito 
				
				WHERE d.id_usuario = var_usuario OR var_usuario = "0"
				GROUP BY b.folio_credito ORDER BY a.alias;
		-- FIN CURSOR -----------------------------------------------------------------------------------------------------------------------
		

	-- DECLARACION DE ERROR PARA FOR(CURSOR) ----------------------------------------------------------------------------------------------
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


		-- TABLA TEMPORAL ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	CREATE TEMPORARY TABLE IF NOT EXISTS ttcobrodia1 ( 
		folio_credito 		VARCHAR(50) PRIMARY KEY,
		id_ruta						INT,
		ine								VARCHAR(100) NULL,
		nombre 						VARCHAR(100) NULL,
		alias 						VARCHAR(60) NULL,
		telefono 					VARCHAR(12) NULL,
		monto_credito 		DECIMAL(10,2) NULL,
		pagos_total 			INT(11) NULL,
		monto_total 			DECIMAL(10,2) NULL,
		monto_pago 				DECIMAL(10,2) NULL,
		fecha_entrega 		DATE NOT NULL,
		pagado 						DECIMAL(10,2) NULL,
		atrasos_no 				DECIMAL(10,2) NULL,
		atrasos_monto 		DECIMAL(10,2) NULL,
		extras_no 					DECIMAL(10,2) NULL,
		extras_monto 			DECIMAL(10,2) NULL,
		restante_no 			DECIMAL(10,2) NULL,
		restante_monto 		DECIMAL(10,2) NULL,
		restante_total 		DECIMAL(10,2) NULL,
		abono_hoy 				DECIMAL(10,2) NULL,
		id_tipo_pago 			INT(11) NULL,
		descripcion 			VARCHAR(50) NULL
	); 
		-- FIN TABLA TEMPORAL ----------------------------------------------------------------------------------------------------------------
		
	


	-- Se inicializa el cursor
	OPEN curLista;

	-- INICIO DE CICLO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ciclo: LOOP
		FETCH curLista INTO 
													var_folio_credito,
													var_id_ruta,
													var_ine, 
													var_nombre, 
													var_alias, 
													var_telefono, 
													var_monto_credito, 
													var_pagos_total, 
													var_monto_total, 
													var_monto_pago, 
													var_fecha_entrega, 
													var_atrasos_no, 
													var_atrasos_monto, 
													var_extras_no, 
													var_extras_monto,
													var_id_estado,
													var_id_estado_credito;
		
		IF done THEN 
			LEAVE ciclo;
		END IF;
		
		# **************************************************************************************************************************************************************************
		
		SET var_pagado = (SELECT SUM(monto) FROM abono WHERE folio_credito = var_folio_credito);
		IF var_pagado IS NULL THEN
			SET var_pagado = 0;
		END IF;
		SET var_restante_no = (SELECT (var_pagos_total - COUNT(id_abono)) FROM abono WHERE folio_credito = var_folio_credito);
		IF var_restante_no IS NULL OR var_restante_no < 0 THEN
			SET var_restante_no = 0;
		END IF;
		SET var_restante_monto = var_restante_no * var_monto_pago;
		IF var_restante_monto IS NULL THEN
			SET var_restante_monto = 0;
		END IF;
		SET var_restante_total = var_monto_total - var_pagado;
		IF var_restante_total IS NULL THEN
			SET var_restante_total = 0;
		END IF;
		SET var_abono_hoy = (SELECT SUM(monto) FROM abono WHERE folio_credito = var_folio_credito AND fecha_abono = CURDATE());
		IF var_abono_hoy IS NULL THEN
			SET var_abono_hoy = 0;
		END IF;
		
		
		SET var_id_tipo_pago_aux = (SELECT COUNT(id_tipo_pago) FROM abono WHERE folio_credito= var_folio_credito AND fecha_abono = CURDATE());
		
		
		
		IF var_id_estado_credito > 1 THEN
			SET var_id_tipo_pago = var_id_estado_credito;
		ELSEIF (var_pagos_total * var_monto_pago) <= var_pagado THEN
			SET var_id_tipo_pago = 6;
		ELSEIF var_id_tipo_pago_aux = 0 THEN
			SET var_id_tipo_pago = 5;
		ELSEIF var_abono_hoy = 0 THEN
			SET var_id_tipo_pago = 4;
		ELSEIF var_abono_hoy > var_monto_pago THEN
			SET var_id_tipo_pago = 3;
		ELSEIF var_abono_hoy = var_monto_pago THEN
			SET var_id_tipo_pago = 1;
		ELSE
			SET var_id_tipo_pago = 2;
		END IF;
		
		SET var_descripcion = (SELECT descripcion FROM tipo_pago WHERE id_tipo_pago = var_id_tipo_pago);
		
		-- SE INSERTAN LOS DATOS EN LA TABLA TEMPORAL
		INSERT INTO ttcobrodia1 VALUES(
																			var_folio_credito,
																			var_id_ruta,
																			var_ine, 
																			var_nombre, 
																			var_alias, 
																			var_telefono, 
																			var_monto_credito, 
																			var_pagos_total, 
																			var_monto_total, 
																			var_monto_pago, 
																			var_fecha_entrega, 
																			var_pagado, 
																			var_atrasos_no, 
																			var_atrasos_monto, 
																			var_extras_no, 
																			var_extras_monto, 
																			var_restante_no, 
																			var_restante_monto, 
																			var_restante_total, 
																			var_abono_hoy, 
																			var_id_tipo_pago, 
																			var_descripcion
																		);
		
		# *************************************************************************************************************************************************************************
		
	END LOOP ciclo;
	-- FIN DE CICLO ---------------------------------------------------------------------------------------------------------------------
	CLOSE curLista;
	
	SELECT * FROM ttcobrodia1;
	DROP TABLE ttcobrodia1;

END // 
DELIMITER;