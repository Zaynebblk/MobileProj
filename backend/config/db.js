const mongoose = require('mongoose');

const connectDB = async () => {
    try {
        // On tente de se connecter à l'URL définie dans le fichier .env
        const conn = await mongoose.connect(process.env.MONGO_URI);

        console.log(`MongoDB Connecté: ${conn.connection.host}`);
    } catch (error) {
        console.error(`Erreur de connexion: ${error.message}`);
        process.exit(1); // On arrête le serveur si la BDD ne répond pas
    }
};

module.exports = connectDB;