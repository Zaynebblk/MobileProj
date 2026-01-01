const express = require('express');
const router = express.Router();
const Group = require('../models/group');

// GET : Récupérer la liste des membres du groupe
router.get('/', async (req, res) => {
    try {
        const groupMembers = await Group.find();
        res.status(200).json(groupMembers);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = router;