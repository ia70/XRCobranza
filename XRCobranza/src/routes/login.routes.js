'use strict';
const express = require('express');
const router = express.Router();

const pool = require('../database');
const tabla = "usuario";

const cipher = require('../cipher.js');
const keys = require('../keys');
const fecha = require('../lib/util').getDateTime;

//->>>>>    LISTA         ------------------------------------------------------------------
router.post('/', async (req, res) => {

    var usr = cipher.decode(keys.security.client_password, req.body.usr);
    var pwd = cipher.decode(keys.security.client_password, req.body.pwd);

    let _global = {
        id_usuario: null,
        nombre: null,
        id_empresa: null,
        id_sucursal: null,
        id_rol: null,
        id_ruta: null,
        id_moneda: null,
        id_zona_horaria: null,
        dias_restantes: null,
        hash: null
    };

    try {
        let data = await pool.query('CALL LOGIN(?, ?)', [usr, pwd]);

        if (JSON.stringify(data) == '[]' || JSON.stringify(data) == "" || JSON.stringify(data) == null) {
            res.status(400).send({
                oVlrXrrt: cipher.encode(keys.security.client_password, JSON.stringify(_global))
            });
        } else {
            var id = fecha() + '_' + usr;
            var hash = cipher.encode(keys.security.client_password, id);
            var sucu = (data[0][0].id_sucursal != null ? data[0][0].id_sucursal : 0);

            try {
                login(hash, usr, sucu);
            } catch (e) {
                console.log(e);
            }

            _global = {
                id_usuario: data[0][0].id_usuario,
                nombre: data[0][0].nombre,
                id_empresa: data[0][0].id_empresa,
                id_sucursal: data[0][0].id_sucursal,
                id_rol: data[0][0].id_rol,
                id_ruta: data[0][0].id_ruta,
                id_moneda: data[0][0].id_moneda,
                id_zona_horaria: data[0][0].id_zona_horaria,
                dias_restantes: data[0][0].dias_restantes,
                hash: (data[0][0].dias_restantes > 0 ? hash : null)
            };

            res.status(200).send({
                oVlrXrrt: cipher.encode(keys.security.client_password, JSON.stringify(_global))
            });
        }
    } catch (e) {
        console.log(e);
        res.status(400).send({
            oVlrXrrt: cipher.encode(keys.security.client_password, JSON.stringify(_global))
        });
    }
});

async function login(hash, user, sucu) {
    let data = await pool.query('SELECT * FROM sesion WHERE usuario="' + user + '" AND id_estado=1');
    if (JSON.stringify(data) != '[]') {
        data = await pool.query('UPDATE sesion SET id_estado=2, sesion_fin="' + fecha() + '" WHERE usuario="' + user + '" AND id_estado=1');
    }
    try {
        data = await pool.query('INSERT INTO sesion VALUES("' + hash + '", "' + user + '", ' + sucu + ', "' + fecha() + '", "' + fecha() + '", null, 1)');
    } catch (e) {
        console.log(e);
        return false;
    }
    return true;
}

module.exports = router;