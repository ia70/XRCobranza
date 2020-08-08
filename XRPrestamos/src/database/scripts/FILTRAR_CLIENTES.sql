DROP PROCEDURE IF EXISTS FILTRAR_CLIENTES;
 DELIMITER //
CREATE PROCEDURE FILTRAR_CLIENTES(IN filtro VARCHAR(100))
	BEGIN
	
	
	
		-- DECLARACION DE VARIABLES ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	DECLARE done 								INT DEFAULT FALSE;
	
	DECLARE var_ine						VARCHAR(100) DEFAULT "";
	DECLARE var_nombre 				VARCHAR(100) DEFAULT "";
	DECLARE var_no_creditos   INT DEFAULT 0;
	DECLARE var_pagos_total 	INT DEFAULT 0;
	DECLARE var_no_pagos			DECIMAL(10,2) DEFAULT 0;
	DECLARE var_no_abonos			INT DEFAULT 0;
	DECLARE var_no_atrasos		DECIMAL(10,2) DEFAULT 0; 
	DECLARE var_no_adelantos 	DECIMAL(10,2) DEFAULT 0;
	DECLARE var_calificacion  DECIMAL(10,2) DEFAULT 0;
	DECLARE var_extras 				DECIMAL(10,2) DEFAULT 0;
	DECLARE var_telefono 			VARCHAR(15) DEFAULT "";
	DECLARE var_id_usuario_establecimiento INT DEFAULT 0;
	


	
	-- DECLARACION DEL CURSOR ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		

	DEClARE curLista 
		CURSOR FOR 
						SELECT 
							a.ine, 
							concat_ws(' ',a.alias, " - ", a.nombre, a.apellido_paterno, a.apellido_materno) AS "nombre",
							COUNT(c.ine) AS "no_creditos",
							SUM(c.pagos_total) AS "pagos_total",
							SUM(c.no_pagos) AS "no_pagos",
							SUM(c.no_abonos) AS "no_abonos",
							SUM(c.no_atrasos) AS "no_atrasos",
							SUM(c.no_adelantos) AS "no_adelantos",
							a.telefono,
							d.id_usuario_establecimiento
						FROM persona a
						INNER JOIN usuario AS b ON b.ine = a.ine
						INNER JOIN usuario_establecimiento AS d ON d.ine = a.ine
						LEFT JOIN estadistica_cliente AS c ON c.ine = a.ine
						
						WHERE b.id_rol = 3 AND concat_ws(' ', a.ine, a.alias, a.nombre, a.apellido_paterno, a.apellido_materno) 
						LIKE CONCAT('%',filtro,'%') GROUP BY a.ine ORDER BY a.nombre ASC LIMIT 20;
		-- FIN CURSOR -----------------------------------------------------------------------------------------------------------------------
		

	-- DECLARACION DE ERROR PARA FOR(CURSOR) ----------------------------------------------------------------------------------------------
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


		-- TABLA TEMPORAL ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpClientes ( 
		ine								VARCHAR(100) NOT NULL PRIMARY KEY,
		nombre 						VARCHAR(100) NOT NULL,
		telefono 					VARCHAR(15),
		no_creditos 			INT,
		calificacion 			DECIMAL(10,2),
		id_usuario_establecimiento INT
	); 
		-- FIN TABLA TEMPORAL ----------------------------------------------------------------------------------------------------------------
		
	


	-- Se inicializa el cursor
	OPEN curLista;

	-- INICIO DE CICLO +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	ciclo: LOOP
		FETCH curLista INTO 
												var_ine,
												var_nombre,
												var_no_creditos,
												var_pagos_total,
												var_no_pagos,
												var_no_abonos,
												var_no_atrasos,
												var_no_adelantos,
												var_telefono,
												var_id_usuario_establecimiento;
		
		IF done THEN 
			LEAVE ciclo;
		END IF;
		
		#  CALCULOS DE CALIFICACION *************************************************************************************************************
		
		SET var_calificacion = ((100 / var_pagos_total) * (var_no_pagos + var_no_abonos * 0.5) * (80/100));
		
		IF (var_pagos_total * 0.25) <= var_no_adelantos THEN
			SET var_extras = 20;
		ELSE
			SET var_extras = (20 / (var_pagos_total * 0.25) * var_no_adelantos);
		END IF;
		
		SET var_calificacion = var_calificacion + var_extras;
		
		IF var_calificacion IS NULL THEN
			SET var_calificacion = 0;
		ELSEIF var_calificacion > 100 THEN
			SET var_calificacion = 100;
		ELSEIF var_calificacion < 0 THEN
			SET var_calificacion = 0;
		END IF;
		
		-- SE INSERTAN LOS DATOS EN LA TABLA TEMPORAL
		INSERT INTO tmpClientes VALUES(var_ine, var_nombre, var_telefono, var_no_creditos, var_calificacion, var_id_usuario_establecimiento);
		
		# *************************************************************************************************************************************************************************
		
	END LOOP ciclo;
	-- FIN DE CICLO ---------------------------------------------------------------------------------------------------------------------
	CLOSE curLista;
	
	SELECT * FROM tmpClientes;
	DROP TABLE tmpClientes;

	END //
DELIMITER ;