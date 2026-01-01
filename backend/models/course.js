const mongoose = require('mongoose');

const courseSchema = mongoose.Schema({
    day: { type: String, required: true },       // Ex: "Lundi"
    time: { type: String, required: true },      // Ex: "08:00 - 10:00"
    subject: { type: String, required: true },   // Ex: "Mathématiques"
    type: { type: String, required: true },      // Ex: "Cours", "TP", "TD"
    professor: { type: String, required: true }, // Ex: "Dr. TRAIBELS"
    room: { type: String, required: true }       // Ex: "Salle B221"
});

module.exports = mongoose.model('Course', courseSchema);