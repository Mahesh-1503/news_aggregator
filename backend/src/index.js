const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const newsRoutes = require('./routes/news.routes');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Routes
app.use('/api/news', newsRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
}); 