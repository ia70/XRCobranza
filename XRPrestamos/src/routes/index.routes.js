'use strict';
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.json({
        info: 'API XRPrestamos'
    });
});

module.exports = router;