const express = require('express');
const router = express.Router();
const DocRequest = require('../models/docrequest');

// --- POUR TOI (Étudiant) : Envoyer une demande ---
router.post('/send', async (req, res) => {
    try {
        const newRequest = new DocRequest({
            studentId: req.body.studentId,
            studentName: req.body.studentName,
            documentType: req.body.documentType,
            comment: req.body.comment
        });
        await newRequest.save();
        res.status(201).json({ message: "Demande envoyée avec succès !" });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// --- POUR TON AMI (Admin) : Voir toutes les demandes ---
router.get('/all', async (req, res) => {
    try {
        const requests = await DocRequest.find().sort({ createdAt: -1 });
        res.status(200).json(requests);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

module.exports = router;