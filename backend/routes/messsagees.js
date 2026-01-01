const express = require('express');
const router = express.Router();
const Messsagee = require('../models/messsagee');

// Route pour envoyer le message
router.post('/envoyer', async (req, res) => {
    try {
        const nouveauMsg = new Messsagee({
            destinataire: req.body.destinataire, // Reçu depuis Flutter
            objet: req.body.objet,
            contenu: req.body.contenu
        });
        await nouveauMsg.save();
        res.status(201).json({ message: "Enregistré dans MongoDB !" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;