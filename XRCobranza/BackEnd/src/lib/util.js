const moment = require('moment');

// FECHA Y HORA
function getDateTime() {
    return moment().format('YYYY-MM-DD hh:mm:ss');
}

// FECHA GENERAL
function getShortDate(){
    return moment().format('YYYY-MM-DD');
}

// FECHA MEXICO
function getShortDateMX(){
    return moment().format('DD-MM-YYYY');
}

module.exports = { getDateTime, getShortDate, getShortDateMX};