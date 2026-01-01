const express = require('express');
const router = express.Router();
const Student = require('../models/student');

// Route pour récupérer un étudiant par son ID
router.get('/:id', async (req, res) => {
    try {
        const student = await Student.findById(req.params.id);
        if (student) {
            res.json(student);
        } else {
            res.status(404).json({ message: "Étudiant introuvable" });
        }
    } catch (error) {
        res.status(500).json({ message: "Erreur serveur" });
    }
});

module.exports = router; 