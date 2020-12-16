DROP PROCEDURE IF EXISTS LISTA_SOLICITUDES;
 DELIMITER //
CREATE PROCEDURE LISTA_SOLICITUDES(IN usuario VARCHAR(100))
	BEGIN
		SELECT a.ine, a.alias, CONCAT_WS(' ', a.nombre, a.apellido_paterno, a.apellido_materno) AS "nombre", b.monto, b.pagos, b.id_estado_solicitud 
		FROM persona a INNER JOIN solicitud AS b ON b.ine = a.ine
		WHERE b.id_usuario = usuario;
	END //
DELIMITER ;