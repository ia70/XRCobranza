'use strict';
const express = require('express');
const router = express.Router();
const { access } = require('../../lib/security');

const path = require('path');
const pool = require(path.resolve('src/lib','database'));

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {
    try {
        var solicitud = req.body.solicitud;
        var user = req.body.user;
        var db_res = false;

        if (await access(user.hash, user.user)) {
            

            const query = await pool.query('INSERT INTO solicitud SET ?', [solicitud]);
            if (query.affectedRows > 0) {
                db_res = true;
            } 

            let respuesta = {
                response: db_res,
                session: true
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