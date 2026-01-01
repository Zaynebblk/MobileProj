const mongoose = require('mongoose');

const messsageeSchema = new mongoose.Schema({
  expediteur: { type: String, default: "Étudiant Test" },
  destinataire: { type: String, required: true }, // Sera 'Professeur' ou 'Administrateur'
  objet: { type: String, required: true },
  contenu: { type: String, required: true },
  date: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Messsagee', messsageeSchema);