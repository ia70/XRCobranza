'use strict';
const express = require('express');
const router = express.Router();
const { access } = require('../../lib/security');
const { calcular_abono } = require('../../routes/functions/calcular_abono');

const pool = require('../../database');

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {
    try {
        var solicitud = req.body.solicitud;
        var user = req.body.user;
        var db_res = false;

        if (await access(user.hash, user.user)) {

            db_res = await calcular_abono(solicitud);
            
            let queryDataAbono = await pool.query('CALL COBRO_DIA_CONSULTA(?)', solicitud.folio_credito);

            let respuesta = {
                response: db_res,
                data: queryDataAbono,
                session: true
            };

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