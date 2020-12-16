import { query } from './database';
import { getDateTime } from '../lib/util';

// VERIFICA SI EL HAST Y NOMBRE DE USUARIO SON VALIDOS. DE SER VALIDOS SE CONTINUA EJECUCION
async function access(vhash, vuser) {
    try {
        let data = query('UPDATE sesion SET ultima_conexion="' + getDateTime() + '" WHERE id_sesion="' + vhash + '" AND id_usuario="' + vuser + '" AND id_estado=1');
        if (data.affectedRows == 0) {
            return false;
        } else {
            return true;
        }
    } catch (error) {
        return false;
    }


}

export default { access };