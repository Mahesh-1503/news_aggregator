const axios = require('axios');

const NEWS_API_KEY = '07ef64cec4684d13ac9de33d01ebd515';
const NEWS_API_BASE_URL = 'https://newsapi.org/v2';

const newsController = {
  getHeadlines: async (req, res) => {
    try {
      const response = await axios.get(`${NEWS_API_BASE_URL}/top-headlines`, {
        params: {
          country: 'us',
          apiKey: NEWS_API_KEY
        }
      });
      res.json(response.data);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  getNewsByCategory: async (req, res) => {
    try {
      const { category } = req.params;
      const response = await axios.get(`${NEWS_API_BASE_URL}/top-headlines`, {
        params: {
          country: 'us',
          category,
          apiKey: NEWS_API_KEY
        }
      });
      res.json(response.data);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  searchNews: async (req, res) => {
    try {
      const { query } = req.query;
      const response = await axios.get(`${NEWS_API_BASE_URL}/everything`, {
        params: {
          q: query,
          apiKey: NEWS_API_KEY
        }
      });
      res.json(response.data);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
};

module.exports = newsController; 