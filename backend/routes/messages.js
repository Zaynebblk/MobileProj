const express = require('express');
const router = express.Router();
const Message = require('../models/message');

// GET : Récupérer tous les messages
router.get('/', async (req, res) => {
    try {
        // On récupère tout
        const messages = await Message.find();
        res.status(200).json(messages);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;