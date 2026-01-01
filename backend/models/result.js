const mongoose = require('mongoose');

const resultSchema = mongoose.Schema({
    moduleName: { type: String, required: true }, // Ex: "Réseaux"
    cc: { type: Number, required: true },         // Ex: 12.0
    exam: { type: Number, required: true },       // Ex: 9.5
    credits: { type: Number, required: true }     // Ex: 3 (Sert à pondérer la moyenne générale)
});

module.exports = mongoose.model('Result', resultSchema);