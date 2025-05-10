const express = require('express');
const router = express.Router();
const newsController = require('../controllers/news.controller');

router.get('/headlines', newsController.getHeadlines);
router.get('/category/:category', newsController.getNewsByCategory);
router.get('/search', newsController.searchNews);

module.exports = router; 