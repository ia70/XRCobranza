DROP PROCEDURE IF EXISTS COBRO_DIA_CORTE;
DELIMITER //
CREATE PROCEDURE COBRO_DIA_CORTE()
BEGIN
/*

	id_ruta
	ruta_descripcion
	id_usuario
	total_recolectado
	total_deberia_recolectar_dia
	total_recolectado_sin_extras
	monto_abonos
	monto_extras
	monto_normal
	monto_no_pagos
	monto_defici_abonos
	monto_defici_total
	monto_remanente
	total_cli_visitar
	total_cli_visitados
	total_cli_no_pago
	total_cli_pago
	total_cli_abonaron
	total_cli_extra
	total_cli_no_vicitaron
	no_creditos_terminados
	no_renovaciones
	
*/
		SELECT 
					a.id_ruta,
					b.descripcion AS "ruta_descripcion",
					a.id_usuario,
					SUM(IF(c.monto IS NULL,0, c.monto)) AS "total_recolectado",
					SUM(d.monto_pago) AS "total_deberia_recolectar_dia",
					SUM(IF(c.monto IS NULL, 0, IF(c.monto < d.monto_pago, c.monto, d.monto_pago ))) AS "total_recolectado_sin_extras",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 2, c.monto,0))) AS "monto_abonos",
					
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 3 OR c.id_tipo_pago = 6, c.monto - d.monto_pago, 0))) AS "monto_extras",
					
					
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 1, c.monto, 0))) AS "monto_normal",
					SUM(IF(c.monto IS NULL,d.monto_pago,IF(c.id_tipo_pago = 4, d.monto_pago, IF(c.id_tipo_pago IS NULL,d.monto_pago,0)))) AS "monto_no_pagos",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 2, d.monto_pago - c.monto, 0))) AS "monto_defici_abonos",
					SUM(IF(c.monto IS NULL,d.monto_pago,IF(c.id_tipo_pago = 4, d.monto_pago, IF(c.id_tipo_pago = 2, d.monto_pago - c.monto,IF(c.id_tipo_pago IS NULL,d.monto_pago,0))))) AS "monto_defici_total",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 7, IF(c.monto >= d.monto_pago, c.monto - d.monto_pago, c.monto), 0))) AS "monto_remanente",
					COUNT(a.folio_credito) 	AS "total_cli_visitar",
					SUM(IF(c.id_abono IS NULL, 0,1)) 			AS "total_cli_visitados",
					SUM(IF(c.monto IS NULL,1,IF(c.id_tipo_pago = 4, 1, IF(c.id_tipo_pago IS NULL,1,0)))) AS "total_cli_no_pago",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 1, 1, 0))) AS "total_cli_pago",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 2, 1, 0))) AS "total_cli_abonaron",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 3, 1, 0))) AS "total_cli_extra",
					(COUNT(a.id_ruta) - COUNT(c.id_abono)) 									AS "total_cli_no_vicitaron",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago >= 6, 1, 0))) AS "no_creditos_terminados",
					SUM(IF(c.monto IS NULL,0,IF(c.id_tipo_pago = 7, 1, 0))) AS "no_renovaciones"

					FROM cobro_dia a
					INNER JOIN ruta AS b ON a.id_ruta = b.id_ruta
					INNER JOIN credito AS d ON d.folio_credito = a.folio_credito
					LEFT JOIN abono AS c ON c.folio_credito = a.folio_credito AND c.fecha_abono = CURDATE()
					WHERE d.fecha_siguiente_pago = CURDATE()
					GROUP BY a.id_ruta;
					
END // 
DELIMITER;

























