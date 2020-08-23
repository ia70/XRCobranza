DROP PROCEDURE IF EXISTS COBRO_DIA_PROC_NO_PAGO;
DELIMITER //
CREATE PROCEDURE COBRO_DIA_PROC_NO_PAGO()
BEGIN

	-- DECLARACION DE VARIABLES ---------------------------------------------------------------------------------------
	DECLARE done INT DEFAULT FALSE;								-- Control de error de FOR(CURSOR)
	DECLARE var_folio_credito VARCHAR(50) DEFAULT "";			-- Folio del credito
	DECLARE var_ine VARCHAR(100) DEFAULT "";
	DECLARE var_monto_credito DECIMAL(10,2) DEFAULT 0;
	DECLARE var_fecha_entrega DATE DEFAULT "";
	DECLARE var_pagos_total INT DEFAULT 0;
	DECLARE var_fecha_abono DATE DEFAULT "";
	DECLARE var_estadistica_existe INT DEFAULT 0;
 
	-- DECLARACION DEL CURSOR -----------------------------------------------------------------------------------------
	DEClARE curLista 
			CURSOR FOR 
				SELECT a.folio_credito, d.ine, c.monto_credito, c.fecha_entrega, c.pagos_total
				FROM cobro_dia a
				INNER JOIN credito AS c ON a.folio_credito = c.folio_credito
				INNER JOIN usuario_establecimiento AS d ON c.id_usuario_establecimiento = d.id_usuario_establecimiento
				LEFT JOIN abono AS b ON a.folio_credito = b.folio_credito and b.fecha_abono = DATE(DATE_SUB( NOW(), INTERVAL 1 DAY))
				WHERE b.fecha_abono IS NULL;

	-- DECLARACION DE ERROR PARA FOR(CURSOR) --------------------------------------------------------------------------
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	
	SET var_fecha_abono = (DATE_SUB( NOW(), INTERVAL 1 DAY));
	OPEN curLista;
	
	ciclo: LOOP
			FETCH curLista INTO var_folio_credito, var_ine, var_monto_credito, var_fecha_entrega, var_pagos_total;
			
			IF done THEN 
				LEAVE ciclo;
			END IF;
			
				INSERT INTO abono VALUES(NULL, var_folio_credito, 0, 0, 4, var_fecha_abono, 1, NOW());
				
				SET var_estadistica_existe = (SELECT COUNT(ine) FROM estadistica_cliente WHERE folio_credito = var_folio_credito);
				IF var_estadistica_existe > 0 THEN
					UPDATE estadistica_cliente SET no_atrasos = (no_atrasos + 1) WHERE folio_credito = var_folio_credito;
				ELSE
					INSERT INTO estadistica_cliente VALUES(var_folio_credito, var_ine, var_monto_credito, var_fecha_entrega, var_pagos_total, 0, 0, 0, 1);
				END IF;
			
		
	END LOOP ciclo;
	CLOSE curLista;
	
	TRUNCATE TABLE cobro_dia;

END //
DELIMITER ;