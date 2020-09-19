'use strict';
const express = require('express');
const router = express.Router();

const path = require('path');
const pool = require(path.resolve('src/lib', 'database'));

// SECURITY >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

const cipher = require(path.resolve('src/lib/guard', 'cipher'));
const keys = require(path.resolve('src/lib/guard', 'keys'));

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

//->>>>>    AGREGAR     --------------------------------------------------------------------
router.post('/', async (req, res) => {

    // SECURITY >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    var _global = [];

    try {
        _global = cipher.decode(keys.security.client_password, req.body._global.data);
        console.log(_global);
        const login_sesion = await pool.query('CALL LOGIN_SESION(?)', [_global.hash]);
        if (JSON.stringify(login_sesion) == '[]' || JSON.stringify(login_sesion) == "" || JSON.stringify(login_sesion) == null) {
            res.status(400).send({
                response: false,
                session: false,
                error: e
            });
        }
    } catch (error) {
        res.status(400).send({
            response: false,
            session: false,
            error: e
        });
        console.log(error);
    }

    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    try {
        var persona = req.body.persona;
        var aval = req.body.aval;
        var usuario = req.body.usuario;


        var data_user = {
            id_usuario: null,
            id_sucursal: user.sucursal,
            ine: persona.ine,
            password: '12345',
            id_rol: 3,
            usuario_padre: user.user,
            id_estado: 5
        };

        let r_d_per = true;

        const d_per = await pool.query('INSERT INTO persona SET ?', [persona]);
        if (d_per.affectedRows > 0) {
            var persona_id = await pool.query('SELECT id_persona FROM persona WHERE ine="?"', [persona.ine]);
            if (JSON.stringify(persona_id) == '[]' || JSON.stringify(persona_id) == "" || JSON.stringify(persona_id) == null) {

            }

            if (aval.nombre != "") {
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


    } catch (e) {
        res.status(400).send({
            response: false,
            session: true,
            error: e
        });
    }
});

module.exports = router;