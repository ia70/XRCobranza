DROP PROCEDURE
IF
	EXISTS CARTERA_CLIENTES;

DELIMITER //
CREATE PROCEDURE CARTERA_CLIENTES (
	IN usuario VARCHAR ( 30 )) 
	
	BEGIN-- a Persona
-- b Credito
-- c Abono
-- d Usuario_establecimiento
-- e Usuario_ruta
-- f Usuario
-- g Ruta
	IF
		usuario = "0" THEN
		SELECT
			f.id_usuario,
			g.id_ruta,
			a.alias,
			CONCAT_WS( ' ', a.nombre, a.apellido_paterno, a.apellido_materno ) AS "nombre",
			IF((b.pagos_total * b.monto_pago ) - SUM( c.monto ) IS NULL, b.monto_total, (b.pagos_total * b.monto_pago ) - SUM( c.monto ) ) AS "restante",
			b.folio_credito
		FROM
			credito b
			INNER JOIN usuario_establecimiento AS d ON d.id_usuario_establecimiento = b.id_usuario_establecimiento
			INNER JOIN persona AS a ON a.ine = d.ine
			INNER JOIN usuario_ruta AS e ON e.id_ruta = d.id_ruta
			INNER JOIN usuario AS f ON f.id_usuario = e.id_usuario
			INNER JOIN ruta AS g ON g.id_ruta = e.id_ruta
			LEFT JOIN abono AS c ON c.folio_credito = b.folio_credito 
		WHERE
			b.id_estado_credito = 1 
		GROUP BY
			b.folio_credito;
		ELSE 
		
		SELECT
			f.id_usuario,
			g.id_ruta,
			a.alias,
			CONCAT_WS( ' ', a.nombre, a.apellido_paterno, a.apellido_materno ) AS "nombre",
			IF((b.pagos_total * monto_pago ) - SUM( c.monto ) IS NULL, b.monto_total, (b.pagos_total * monto_pago ) - SUM( c.monto ) ) AS "restante",
			b.folio_credito
		FROM
			credito b
			INNER JOIN usuario_establecimiento AS d ON d.id_usuario_establecimiento = b.id_usuario_establecimiento
			INNER JOIN persona AS a ON a.ine = d.ine
			INNER JOIN usuario_ruta AS e ON e.id_ruta = d.id_ruta
			INNER JOIN usuario AS f ON f.id_usuario = e.id_usuario
			INNER JOIN ruta AS g ON g.id_ruta = e.id_ruta
			LEFT JOIN abono AS c ON c.folio_credito = b.folio_credito 
		WHERE
			f.id_usuario = usuario 
			AND b.id_estado_credito = 1 
		GROUP BY
			b.folio_credito;
		
	END IF;

END // 
DELIMITER;