const express = require('express');
const router = express.Router();
// On importe le modèle créé à l'étape 1.1
const InfoNote = require('../models/infonote');

// GET : Cette route va lire les données dans la collection 'infonotes'
// URL finale : http://localhost:5000/api/info-notes
router.get('/', async (req, res) => {
    try {
        // .find() va chercher TOUS les documents dans la collection 'infonotes'
        const notes = await InfoNote.find(); 
        
        // On renvoie la liste au format JSON vers Flutter
        res.status(200).json(notes);
    } catch (error) {
        res.status(500).json({ message: "Erreur lors de la récupération des notes", error: error });
    }
});

module.exports = router;