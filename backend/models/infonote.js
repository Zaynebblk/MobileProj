const mongoose = require('mongoose');

const infoNoteSchema = mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    date: { type: String, required: true },
    category: { type: String, required: true }
});

// IMPORTANT : 
// Le premier argument 'InfoNote' dit à Mongoose de chercher 
// la collection au pluriel et en minuscules : 'infonotes'.
// C'est exactement ce qu'il vous faut.
module.exports = mongoose.model('InfoNote', infoNoteSchema);