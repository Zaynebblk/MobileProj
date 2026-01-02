const mongoose = require('mongoose');

const studentSchema = mongoose.Schema({
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    email: { type: String, required: true },
    studentClass: { type: String, required: true }, // Ex: INDP2C
    photoUrl: { type: String }, // L'URL de l'image
    phone: { type: String, default: "" },
    address: { type: String, default: "" },
    birthDate: { type: String, default: "" }
});

module.exports = mongoose.model('Student', studentSchema);