const express = require('express');
const router = express.Router();
const Document = require('../models/document');

// GET : Récupérer tous les documents
router.get('/', async (req, res) => {
    try {
        const docs = await Document.find();
        res.status(200).json(docs);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;