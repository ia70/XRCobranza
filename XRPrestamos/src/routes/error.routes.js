'use strict';
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.redirect(301, 'http://192.168.2.80');
});

module.exports = router;