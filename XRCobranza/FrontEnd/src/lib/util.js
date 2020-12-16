const moment = require('moment');

function getDateTime() {
    return moment().format('YYYY-MM-DD hh:mm:ss');
}

function getShortDate(){
    return moment().format('YYYY-MM-DD');
}

function getShortDateMX(){
    return moment().format('DD-MM-YYYY');
}

module.exports = { getDateTime, getShortDate, getShortDateMX};