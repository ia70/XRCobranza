const pool = require('../../database');

async function calcular_abono(abono) {
    try {
        let info = await pool.query('CALL COBRO_DIA_CONSULTA(?)', abono.folio_credito);

        info = info[0][0];
        // CALCULAR CAMPOS ABONO --------------------------------------------------------------------------------------------------------------

        if (abono.id_tipo_pago == 7) {
            abono.no_pagos = info.pagos_total - (abono.monto / info.monto_pago);
            try {
                let db_credito = await pool.query('UPDATE credito SET id_estado_credito=7, id_estado=2 WHERE folio_credito = ?', [abono.folio_credito]);
            } catch (error) {
                console.log(error);
            }
        } else if (info.restante_total <= abono.monto) {
            abono.id_tipo_pago = 6;
            abono.no_pagos = abono.monto / info.monto_pago;
            // Modificar tabla credito
            try {
                let db_credito = await pool.query('UPDATE credito SET id_estado_credito=6, id_estado=2 WHERE folio_credito = ?', [abono.folio_credito]);
            } catch (error) {
                console.log(error);
            }
            
        } else if (abono.monto > info.monto_pago) {
            abono.id_tipo_pago = 3;
            abono.no_pagos = abono.monto / info.monto_pago;
        } else if (abono.monto == info.monto_pago) {
            abono.id_tipo_pago = 1;
            abono.no_pagos = 1;
        } else if (abono.monto > 0) {
            abono.id_tipo_pago = 2;
            abono.no_pagos = abono.monto / info.monto_pago;
        } else {
            abono.id_tipo_pago = 4;
            abono.no_pagos = 0;
        }
        let queryAbono = [];
        try {
            queryAbono = await pool.query('INSERT INTO abono SET ?', [abono]);
        } catch (error) {
            console.log(error);
        }



        // CALCULO DE ESTADISTICAS -------------------------------------------------------------------------------------------------------------
        let estadistica_ = await pool.query('SELECT * FROM estadistica_cliente WHERE folio_credito = ?', [abono.folio_credito]);
        let estadistica_existe = true;
        let estadistica = [];

        if (estadistica_ == "") {
            estadistica_existe = false;
            estadistica = {
                folio_credito: info.folio_credito,
                ine: info.ine,
                monto_credito: info.monto_credito,
                fecha_entrega: info.fecha_entrega,
                pagos_total: info.pagos_total,
                no_pagos: abono.no_pagos,
                no_abonos: (abono.id_tipo_pago == 2 ? 1 : 0),
                no_adelantos: (abono.id_tipo_pago == 3 ? (abono.monto - info.monto_pago) / info.monto_pago : 0),
                no_atrasos: (abono.id_tipo_pago == 4 ? 1 : 0)
            };
        } else {
            estadistica = estadistica_[0];

            // NO_PAGOS
            if (abono.id_tipo_pago == 6 || abono.id_tipo_pago == 7) {
                estadistica.no_pagos = info.pagos_total;
            } else {
                estadistica.no_pagos = estadistica.no_pagos + abono.no_pagos;
            }

            // NO_ABONOS
            if (abono.id_tipo_pago == 2) {
                estadistica.no_abonos = estadistica.no_abonos + 1;
            }

            // NO_ATRASOS
            if (abono.id_tipo_pago == 4) {
                estadistica.no_atrasos = estadistica.no_atrasos + 1;
            }

            // NO_ADELANTOS
            if (abono.id_tipo_pago == 3) {
                let cal_extra = (abono.monto - info.monto_pago);
                if ((info.extras_monto + cal_extra) > info.atrasos_monto) {
                    estadistica.no_adelantos += cal_extra / info.monto_pago;
                }
            }
        }

        // INSERTAR O ACTUALIZAR BASE DE DATOS DE ESTADISTICA
        if (estadistica_existe) {
            let queryEstadistica = await pool.query('UPDATE estadistica_cliente SET ? WHERE folio_credito = ?', [estadistica, abono.folio_credito]);
        } else {
            let queryEstadistica = await pool.query('INSERT INTO estadistica_cliente SET ?', [estadistica]);
        }

        // FIN CALCULO ESTADISTICA -------------------------------------------------------------------------------------------------------------
        if (queryAbono.affectedRows > 0) {
            return true;
        }
        return false;
    } catch (error) {
        return false;
    }
}

module.exports = { calcular_abono };