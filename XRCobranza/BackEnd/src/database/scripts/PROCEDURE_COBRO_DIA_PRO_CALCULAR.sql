DROP PROCEDURE IF EXISTS COBRO_DIA_PROC_CALCULAR;
DELIMITER //
CREATE PROCEDURE COBRO_DIA_PROC_CALCULAR ()
BEGIN

	-- DECLARACION DE VARIABLES ---------------------------------------------------------------------------------------
	DECLARE done INT DEFAULT FALSE;								-- Control de error de FOR(CURSOR)
	DECLARE var_folio VARCHAR(50) DEFAULT "";			-- Folio del credito
	DECLARE var_id_tipo INT DEFAULT 0;						-- Tipo de cobro del credito
	DECLARE var_fecha DATE;												-- Fecha del siguiente pago
	DECLARE var_ruta INT DEFAULT 0;								-- Ruta
	DECLARE var_usuario VARCHAR(30) DEFAULT ""; 	-- Usuario (cobrador)
	DECLARE var_ine VARCHAR(100);
	DECLARE var_id_estado INT DEFAULT 0;
	DECLARE var_id_estado_credito INT DEFAULT 0;

	-- DECLARACION DEL CURSOR -----------------------------------------------------------------------------------------
	DEClARE curLista 
		CURSOR FOR 
			SELECT a.folio_credito, a.id_tipo_cobro, a.fecha_siguiente_pago, b.id_ruta, c.id_usuario, b.ine, a.id_estado, a.id_estado_credito FROM credito a
				INNER JOIN usuario_establecimiento AS b ON b.id_usuario_establecimiento = a.id_usuario_establecimiento
				INNER JOIN usuario_ruta AS c ON c.id_ruta = b.id_ruta
				WHERE (a.fecha_siguiente_pago <= CURDATE() AND a.id_estado_credito = 1) OR (a.fecha_siguiente_pago = CURDATE() AND a.id_estado_credito>2)  ORDER BY a.folio_credito ASC;

	-- DECLARACION DE ERROR PARA FOR(CURSOR) --------------------------------------------------------------------------
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

 -- Se procesan los clientes que no se les especifico tipo de pago.
	CALL COBRO_DIA_PROC_NO_PAGO();

	-- Se inicializa el cursor
	OPEN curLista;

	-- Se inicia ciclo repetitivo -------------------------------------------------------------------------------------
	ciclo: LOOP
		FETCH curLista INTO var_folio, var_id_tipo, var_fecha, var_ruta, var_usuario, var_ine, var_id_estado, var_id_estado_credito;
		
		IF done THEN 
			LEAVE ciclo;
		END IF;
		
		IF var_fecha < CURDATE() AND var_id_estado = 1 THEN
			SET var_fecha = COBRO_DIA_CAL_FECHA_PAGO(var_fecha, var_id_tipo);
			UPDATE credito SET fecha_siguiente_pago = var_fecha WHERE folio_credito = var_folio;
		END IF;
		
		IF var_fecha = CURDATE() THEN
			INSERT INTO cobro_dia VALUES(var_folio, var_ine, var_ruta, var_usuario);
		END IF;
		
	END LOOP ciclo;
	CLOSE curLista;

END //
DELIMITER ;