'use strict';
const express = require('express');
const router = express.Router();

const path = require('path');
const pool = require(path.resolve('src/lib','database'));

const { access } = require('../../lib/security');

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {
    try {
        if (await access(req.body.hash, req.body.user)) {
            let r_d_solicitud = false;

            const d_sol = await pool.query('CALL lista_solicitudes(?)', [req.body.user]);

            if (JSON.stringify(d_sol) != '[]') {
                r_d_solicitud = true;
            }
            let respuesta = {
                response: r_d_solicitud,
                session: true,
                solicitud: d_sol[0]
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