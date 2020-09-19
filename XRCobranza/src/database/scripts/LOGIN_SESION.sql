DROP PROCEDURE IF EXISTS LOGIN_SESION;
 DELIMITER //
CREATE PROCEDURE LOGIN_SESION(IN sesion VARCHAR(150))
	BEGIN
		SELECT 
			se.id_usuario
		FROM sesion se
		INNER JOIN usuario AS u ON u.id_usuario = se.id_usuario AND u.id_estado = 1
		LEFT JOIN empresa AS e ON e.id_empresa = se.id_empresa AND e.id_estado = 1
		LEFT JOIN sucursal AS su ON su.id_sucursal = se.id_sucursal AND su.id_estado = 1
		LEFT JOIN configuracion AS c ON c.id_empresa = e.id_empresa AND c.id_estado = 1

		WHERE se.id_sesion = sesion AND (DATEDIFF( c.licencia_fin, CURDATE()) > 0 OR u.id_rol = 4);
	END //
DELIMITER ;

/*

id_usuario

*/