const pool = require('../database');
const { getDateTime } = require('../lib/util');

async function access(vhash, vuser) {
    try {
        let data = await pool.query('UPDATE sesion SET ultima_conexion="' + getDateTime() + '" WHERE id_sesion="' + vhash + '" AND id_usuario="' + vuser + '" AND id_estado=1');
        if (data.affectedRows == 0) {
            return false;
        } else {
            return true;
        }
    } catch (error) {
        return false;
    }


}

module.exports = { access };