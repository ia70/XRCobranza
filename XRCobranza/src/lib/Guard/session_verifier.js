const path = require('path');
const pool = require(path.resolve('src/lib', 'database'));

// SECURITY >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

const cipher = require(path.resolve('src/lib/guard', 'cipher'));
const keys = require(path.resolve('src/lib/guard', 'keys'));

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

async function session_verifier(abono) {
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
}

module.exports = { session_verifier };