'use strict';
const express = require('express');
const router = express.Router();
const { access } = require('../../lib/security');

const pool = require('../../database');

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {
    try {
        var persona = req.body.persona;
        var aval = req.body.aval;
        var usuario = req.body.usuario;
        var _global = req.body._global.data;
        
        var data_user = {
            id_usuario: null,
            id_sucursal: user.sucursal,
            ine: persona.ine,
            password: '12345',
            id_rol: 3,
            usuario_padre: user.user,
            id_estado: 5
        };

        if (await access(user.hash, user.user)) {
            let r_d_per = true;

            const d_per = await pool.query('INSERT INTO persona SET ?', [persona]);
            if (d_per.affectedRows > 0) {
                if(aval.nombre != ""){
                    let d_aval = await pool.query('INSERT INTO aval SET ?', [aval]);
                }
                let d_user = await pool.query('INSERT INTO usuario SET ?', [data_user]);
            } else
                r_d_per = false;

            let respuesta = {
                response: r_d_per,
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