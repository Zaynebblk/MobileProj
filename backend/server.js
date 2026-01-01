const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const connectDB = require('./config/db'); 
const path = require('path'); // Nécessaire pour les chemins
const fs = require('fs');     // Nécessaire pour créer le dossier si inexistant

// Charger les variables d'environnement (.env)
dotenv.config();

// Connexion à la Base de Données
connectDB();

const app = express();

// Middleware
app.use(express.json());
app.use(cors());

// --- GESTION DU DOSSIER UPLOADS (NOUVEAU) ---
// 1. Créer le dossier 'uploads' s'il n'existe pas
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}
// 2. Rendre le dossier accessible via URL (http://ip:5000/uploads/fichier.pdf)
app.use('/uploads', express.static(uploadDir));
// ---------------------------------------------

// Route de test
app.get('/', (req, res) => {
    res.send("API Mobile Étudiant est en ligne et connectée ! 🚀");
});

// --- ROUTES EXISTANTES (JE N'AI RIEN TOUCHÉ) ---
const studentRoutes = require('./routes/studentroutes');
app.use('/api/students', studentRoutes);

const infoNotesRoutes = require('./routes/infonotes');
app.use('/api/info-notes', infoNotesRoutes);

const absencesRoutes = require('./routes/absences');
app.use('/api/absences', absencesRoutes);

const messagesRoutes = require('./routes/messages');
app.use('/api/messages', messagesRoutes);

const resultsRoutes = require('./routes/results');
app.use('/api/results', resultsRoutes);

const coursesRoutes = require('./routes/courses');
app.use('/api/courses', coursesRoutes);

const groupsRoutes = require('./routes/groups'); 
app.use('/api/groups', groupsRoutes);           

const documentsRoutes = require('./routes/documents');
app.use('/api/documents', documentsRoutes);

const docRequestRoutes = require('./routes/docrequests');
app.use('/api/doc-requests', docRequestRoutes);

app.use('/api/messagees', require('./routes/messsagees'));

// --- NOUVELLE ROUTE PARTAGE ---
const sharedDocsRoutes = require('./routes/shareddocs');
app.use('/api/shared-docs', sharedDocsRoutes);

// Lancement serveur
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Serveur démarré sur le port ${PORT}`);
});