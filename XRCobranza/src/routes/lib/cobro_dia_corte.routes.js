'use strict';
const express = require('express');
const router = express.Router();

const pool = require('../../database');
const { access } = require('../../lib/security');

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {
    try {
        if (await access(req.body.hash, req.body.user)) {
            let r_d_solicitud = false;

            let rol = [req.body.rol];

            let datos = [];

            datos = await pool.query('CALL COBRO_DIA_CORTE()');

            if (JSON.stringify(datos) != '[]') {
                r_d_solicitud = true;
            }
            let respuesta = {
                response: r_d_solicitud,
                session: true,
                solicitud: datos[0]
            };

            res.status(200).send(respuesta);

        } else {
            res.status(400).send({
                session: false
            });
        }
    } catch (e) {
        res.status(400).send({
            response: false,
            session: true,
            error: e
        });
    }
});

module.exports = router;