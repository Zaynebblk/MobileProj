const express = require('express');
const router = express.Router();
const Result = require('../models/result');

// GET : Récupérer toutes les notes
router.get('/', async (req, res) => {
    try {
        const results = await Result.find();
        res.status(200).json(results);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;