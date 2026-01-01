const express = require('express');
const router = express.Router();
const Absence = require('../models/absence');

// GET : Récupérer toutes les absences
router.get('/', async (req, res) => {
    try {
        const absences = await Absence.find();
        res.status(200).json(absences);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;