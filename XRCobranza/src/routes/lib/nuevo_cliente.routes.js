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
        const login_sesion = await pool.query('CALL LOGIN_SESION(?)', [_global.hash]);
        if (JSON.stringify(login_sesion) == '[]' || JSON.stringify(login_sesion) == "" || JSON.stringify(login_sesion) == null) {
            res.status(400).send({
                response: false,
                session: false,
                _global: null
            });
        }
    } catch (error) {
        res.status(400).send({
            response: false,
            session: false,
            _global: null,
            error: error
        });
        console.log(error);
    }

    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    try {
        var persona = req.body.persona;
        var aval = req.body.aval;
        var usuario = req.body.usuario;
        var persona_id = [];
        var d_per = [];

        try {
            d_per = await pool.query('INSERT INTO persona SET ?', [persona]);
        } catch (error) {
            console.log(error);
        }

        if (d_per.affectedRows > 0) {
            persona_id = await pool.query('SELECT id_persona FROM persona WHERE ine=?', [persona.ine]);
            if (JSON.stringify(persona_id) == '[]' || JSON.stringify(persona_id) == "" || JSON.stringify(persona_id) == null) {
                res.status(400).send({
                    response: false,
                    session: true,
                    _global: cipher.encode(keys.security.client_password, JSON.stringify(_global)),
                    error: 'Registro no insertado!'
                });
            } else {
                persona_id = persona_id[0].id_persona;

                if (aval.nombre != "") {
                    aval.id_persona = persona_id;
                    let d_aval = await pool.query('INSERT INTO aval SET ?', [aval]);
                }

                usuario.id_persona = persona_id;
                let d_user = await pool.query('INSERT INTO usuario SET ?', [usuario]);

                res.status(200).send({
                    response: true,
                    session: true,
                    _global: cipher.encode(keys.security.client_password, JSON.stringify(_global))
                });
            }
        } else {

            res.status(400).send({
                response: false,
                session: true,
                _global: cipher.encode(keys.security.client_password, JSON.stringify(_global)),
                error: 'Registro no insertado!'
            });

        }

    } catch (e) {
        res.status(400).send({
            response: false,
            session: true,
            _global: cipher.encode(keys.security.client_password, JSON.stringify(_global)),
            error: e
        });
    }
});

module.exports = router;