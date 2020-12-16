DROP FUNCTION IF EXISTS COBRO_DIA_CAL_FECHA_PAGO;
DELIMITER //
CREATE FUNCTION COBRO_DIA_CAL_FECHA_PAGO (fecha_pago DATE, tipo_cobro INT)
	RETURNS VARCHAR(20)
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

END//
DELIMITER;