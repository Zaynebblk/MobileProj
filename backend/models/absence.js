const mongoose = require('mongoose');

const absenceSchema = mongoose.Schema({
    subject: { type: String, required: true }, // Ex: "Réseaux Informatiques"
    type: { type: String, required: true },    // Ex: "TD", "TP", "Cours"
    time: { type: String, required: true },    // Ex: "09h00-10h30"
    date: { type: String, required: true },    // Ex: "15 Nov 2025"
    isJustified: { type: Boolean, default: false } // true = vert, false = rouge
});

module.exports = mongoose.model('Absence', absenceSchema);