const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const SharedDoc = require('../models/shareddoc'); // Import du modèle MongoDB

// --- CONFIGURATION MULTER (Stockage des fichiers) ---
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/'); // Les fichiers vont dans le dossier uploads
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, uniqueSuffix + '-' + file.originalname);
    }
});
const upload = multer({ storage: storage });

// --- ROUTES ---

// 1. GET : Récupérer tous les documents depuis MongoDB
router.get('/', async (req, res) => {
    try {
        // .sort({ createdAt: -1 }) permet d'avoir les plus récents en premier
        const documents = await SharedDoc.find().sort({ createdAt: -1 });
        res.status(200).json(documents);
    } catch (err) {
        res.status(500).json({ message: "Erreur lors de la récupération : " + err.message });
    }
});

// 2. POST : Ajouter un nouveau document dans MongoDB
router.post('/', upload.single('pdfFile'), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ message: "Fichier PDF manquant" });
        }

        // Construction de l'URL du fichier
        const protocol = req.protocol;
        const host = req.get('host');
        const fileUrl = `${protocol}://${host}/uploads/${req.file.filename}`;

        // Création de l'objet basé sur le modèle
        const newDoc = new SharedDoc({
            title: req.body.title,
            teacher: req.body.teacher || "Étudiant",
            subject: req.body.subject,
            tag: req.body.tag,
            description: req.body.description,
            date: new Date().toLocaleDateString('fr-FR'), // Date formatée
            fileUrl: fileUrl,
            fileName: req.file.originalname
        });

        // Sauvegarde dans la base de données
        const savedDoc = await newDoc.save();
        console.log("✅ Document enregistré dans MongoDB :", savedDoc.title);
        
        res.status(201).json(savedDoc);
    } catch (err) {
        console.error("❌ Erreur upload :", err);
        res.status(500).json({ message: "Erreur lors de l'enregistrement" });
    }
});

module.exports = router;