const mongoose = require('mongoose');

const messageSchema = mongoose.Schema({
    sender: { type: String, required: true },  // Ex: "Dr. BENALI Ahmed"
    role: { type: String, required: true },    // Ex: "Professeur"
    preview: { type: String, required: true }, // Ex: "Votre projet est..."
    time: { type: String, default: "" },       // Ex: "10:30"
    unread: { type: Number, default: 0 }       // Ex: 2 (pour la pastille rouge)
});

module.exports = mongoose.model('Message', messageSchema);