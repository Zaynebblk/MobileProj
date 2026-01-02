const express = require('express');
const router = express.Router();
const Student = require('../models/student');

// 1. Récupérer le profil complet (Utilisé par StudentHome ET ProfileView)
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

// 2. Mettre à jour le profil (Téléphone, Adresse...)
router.put('/:id', async (req, res) => {
    try {
        const updatedStudent = await Student.findByIdAndUpdate(
            req.params.id,
            { $set: req.body }, // Met à jour uniquement les champs envoyés
            { new: true }       // Renvoie l'objet modifié
        );
        res.json(updatedStudent);
    } catch (error) {
        res.status(500).json({ message: "Erreur lors de la mise à jour" });
    }
});

module.exports = router;