DROP PROCEDURE
IF
	EXISTS CARTERA_CLIENTES;

DELIMITER //
CREATE PROCEDURE CARTERA_CLIENTES (
	IN usuario VARCHAR ( 30 )) 
	
	BEGIN

	IF
		usuario = "0" THEN
		SELECT
			u.id_usuario,
			u.id_ruta,
			p.alias,
			CONCAT_WS( ' ', p.nombre, p.apellido_paterno, p.apellido_materno ) AS "nombre",
			IF((c.total_pagos * c.monto_pago ) - SUM( a.monto ) IS NULL, c.total_pagos * c.monto_pago , (c.total_pagos * c.monto_pago ) - SUM( a.monto ) ) AS "restante",
			c.folio
		FROM
			credito c
			INNER JOIN usuario AS u ON c.id_usuario = u.id_usuario
			INNER JOIN persona AS p ON u.id_persona = p.id_persona
			LEFT JOIN abono AS a ON c.folio = c.folio
		WHERE
			c.id_estado = 1 
		GROUP BY
			c.folio;
	ELSE 
		
		SELECT
			u.id_usuario,
			u.id_ruta,
			p.alias,
			CONCAT_WS( ' ', p.nombre, p.apellido_paterno, p.apellido_materno ) AS "nombre",
			IF((c.total_pagos * c.monto_pago ) - SUM( a.monto ) IS NULL, c.total_pagos * c.monto_pago , (c.total_pagos * c.monto_pago ) - SUM( a.monto ) ) AS "restante",
			c.folio
		FROM
			credito c
			INNER JOIN usuario AS u ON c.id_usuario = u.id_usuario
			INNER JOIN persona AS p ON u.id_persona = p.id_persona
			LEFT JOIN abono AS a ON c.folio = c.folio
		WHERE
			c.id_usuario = usuario AND c.id_estado = 1 
		GROUP BY
			c.folio;
		
	END IF;

END // 
DELIMITER;