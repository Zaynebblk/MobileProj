const mongoose = require('mongoose');

const sharedDocSchema = new mongoose.Schema({
  title: { type: String, required: true },
  teacher: { type: String, required: true }, // L'auteur (Étudiant ou Prof)
  subject: { type: String, required: true }, // La matière
  tag: { type: String, required: true },     // Type (Cours, TD, TP...)
  description: { type: String },
  date: { type: String, required: true },    // Date affichée
  fileUrl: { type: String, required: true }, // Lien vers le fichier PDF
  fileName: { type: String, required: true }, // Nom original du fichier
  views: { type: String, default: "0" },     // Nombre de vues
  note: { type: String, default: "Nouveau" } 
}, { 
  timestamps: true // Crée automatiquement createdAt et updatedAt
});

module.exports = mongoose.model('SharedDoc', sharedDocSchema);