'use strict';
const mysql = require('mysql');
const { promisify } = require('util');

const path = require('path');
const { database } = require(path.resolve('src/lib/guard', 'keys'));

const pool = mysql.createPool(database);

pool.getConnection((err, connection) => {
    if (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('DATABASE CONNECTION WAS CLOSED!');
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('DATABASE HAS TO MANY CONNECTIONS!');
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('NOT EXIST DATABASE CONNECTION!');
        }
    }

    if (connection) {
        connection.release();
        console.log('DATABASE IS CONNECTED!');
    }




    return;
});

// Promisify Pool Querys
pool.query = promisify(pool.query);

module.exports = pool;