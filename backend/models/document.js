const mongoose = require('mongoose');

const documentSchema = mongoose.Schema({
    title: { type: String, required: true },      // Ex: "Relevé de notes S1"
    category: { type: String, required: true },   // Ex: "Notes", "Attestations"
    fileType: { type: String, required: true },   // Ex: "PDF", "JPEG"
    fileSize: { type: String, required: true },   // Ex: "150 KB"
    date: { type: String, required: true }        // Ex: "5 Nov 2025"
});

module.exports = mongoose.model('Document', documentSchema);