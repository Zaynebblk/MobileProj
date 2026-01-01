const mongoose = require('mongoose');

const groupSchema = mongoose.Schema({
    name: { type: String, required: true },
    role: { type: String, default: "" },
    email: { type: String, required: true },
    phone: { type: String, default: "" }
});

module.exports = mongoose.model('Group', groupSchema);