'use strict';
const express = require('express');
const router = express.Router();

const pool = require('../../database');
const { access } = require('../../lib/security');

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {
    try {
        if (await access(req.body.hash, req.body.user)) {
            let r_d_cartera = false;
            let rol = [req.body.rol];

            let datos = [];

            if (rol == 1 || rol == 4) {
                datos = await pool.query('CALL cartera_clientes(?)', "0");
            } else if (rol == 2) {
                datos = await pool.query('CALL cartera_clientes(?)', [req.body.user]);
            }


            if (JSON.stringify(datos) != '[]') {
                r_d_cartera = true;
            }
            let respuesta = {
                response: r_d_cartera,
                session: true,
                cartera: datos[0]
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