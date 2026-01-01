const mongoose = require('mongoose');

const docRequestSchema = new mongoose.Schema({
  studentId: { type: String, required: true },   // Pour savoir qui demande
  studentName: { type: String, required: true }, // Nom de l'étudiant
  documentType: { type: String, required: true }, // ex: "Attestation de scolarité"
  comment: { type: String },                     // Message optionnel
  status: { 
    type: String, 
    enum: ['En attente', 'En cours', 'Prêt', 'Rejeté'], 
    default: 'En attente' 
  },
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('DocRequest', docRequestSchema);