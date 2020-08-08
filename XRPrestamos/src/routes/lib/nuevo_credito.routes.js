'use strict';
const express = require('express');
const router = express.Router();

const pool = require('../../database');
const { access } = require('../../lib/security');
const { calcular_abono } = require('../../routes/functions/calcular_abono');
const { getDateTime } = require('../../lib/util');

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {
    try {
        var user = req.body.user;
        if (await access(user.hash, user.user)) {
            let r_d_solicitud = false;

            let persona = req.body.persona;
            let credito = req.body.credito;
            let pagos = req.body.abonos;

            //--> PERSONA -----------------------------------------------------------------

            if (persona.telefono != "") {
                let query = await pool.query('UPDATE persona SET telefono=? WHERE ine = ?', [persona.telefono, persona.ine]);
            }

            //--> CREDITO ------------------------------------------------------------------ 
            let periodo = await pool.query('SELECT GET_PERIODO(?) AS "periodo"', [credito.fecha_entrega]);

            credito.id_periodo = periodo[0].periodo;
            if (credito.folio_credito == "") {
                let num = await pool.query('SELECT COUNT(folio_credito) AS "num" FROM credito WHERE fecha_entrega=?', [credito.fecha_entrega])
                credito.folio_credito = credito.fecha_entrega + "#" + num[0].num;
            }

            let datos = [];

            datos = await pool.query('INSERT INTO credito SET ?', [credito]);

            if (JSON.stringify(datos) != '[]') {
                r_d_solicitud = true;
            }
            let respuesta = {
                response: r_d_solicitud,
                session: true,
                solicitud: datos[0]
            };

            //--> ABONOS ------------------------------------------------------------------
            if (pagos.length > 0) {
                let total = pagos.length;
                

                let i = 0;
                for (i=0; i < total; i++) {
                    let abono = {
                        folio_credito: credito.folio_credito,
                        monto: pagos[i].monto,
                        no_pagos: parseFloat("0.0001"),
                        id_tipo_pago: 0,
                        fecha_abono: pagos[i].fecha_abono,
                        id_estado: 1,
                        fecha_reg: getDateTime()
                    };
                    await calcular_abono(abono);
                }
            }
            // FIN ABONOS -----------------------------------------------------------------

            let corte = await pool.query('CALL COBRO_DIA_PROC_CALCULAR()');

            res.status(200).send(respuesta);

        } else {
            res.status(400).send({
                session: false
            });
        }
    } catch (e) {
        console.log(e);
        res.status(400).send({
            response: false,
            session: true,
            error: e
        });
    }
});

module.exports = router;