# News Aggregator App
APK DRIVE LINK: https://drive.google.com/file/d/1n5aFJ8EYZClmTtakr8fzxO3yEuV0bsi0/view?usp=sharing
A modern news aggregation application built with Flutter and Node.js, featuring real-time news updates, category filtering, and favorite article management.

## Features

- 📰 Latest news headlines from multiple categories
- 🔍 Real-time news search functionality
- ❤️ Save and manage favorite articles
- 🎨 Beautiful and responsive UI with animations
- 🌐 Category-based news filtering
- 📱 Cross-platform support (iOS & Android)
- 🔄 Pull-to-refresh functionality
- 🌙 Modern UI with smooth transitions

## Tech Stack

### Frontend
- Flutter (Latest stable version)
- GetX (State Management)
- Hive (Local Storage)
- Cached Network Image
- URL Launcher
- Intl (Internationalization)

### Backend
- Node.js
- Express.js
- NewsAPI Integration
- Environment Variables Management

## Project Structure

```
news_aggregator/
├── frontend/                 # Flutter application
│   ├── lib/
│   │   ├── controllers/     # GetX controllers
│   │   ├── models/         # Data models
│   │   ├── screens/        # UI screens
│   │   ├── services/       # API services
│   │   ├── theme/          # App theme
│   │   └── widgets/        # Reusable widgets
│   └── pubspec.yaml        # Flutter dependencies
│
└── backend/                 # Node.js server
    ├── controllers/        # Route controllers
    ├── routes/            # API routes
    ├── config/            # Configuration files
    └── package.json       # Node.js dependencies
```

## Getting Started

### Prerequisites

- Flutter SDK (Latest stable version)
- Node.js (v14 or higher)
- NewsAPI API Key

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/news_aggregator.git
cd news_aggregator
```

2. Frontend Setup:
```bash
cd frontend
flutter pub get
```

3. Backend Setup:
```bash
cd backend
npm install
```

4. Environment Setup:
   - Create a `.env` file in the backend directory
   - Add your NewsAPI key:
   ```
   NEWS_API_KEY=your_api_key_here
   ```

### Running the Application

1. Start the backend server:
```bash
cd backend
npm start
```

2. Run the Flutter app:
```bash
cd frontend
flutter run
```

## API Documentation

### Endpoints

- `GET /api/news/headlines` - Get latest headlines
- `GET /api/news/category/:category` - Get news by category
- `GET /api/news/search/:query` - Search news articles

## Features in Detail

### News Feed
- Real-time news updates
- Category-based filtering
- Pull-to-refresh functionality
- Infinite scroll support

### Search
- Real-time search results
- Search history
- Category-based search

### Favorites
- Save articles for offline reading
- Manage favorite articles
- Sync across devices

### UI/UX
- Material Design 3
- Smooth animations
- Responsive layout
- Dark/Light theme support

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- NewsAPI for providing the news data
- Flutter team for the amazing framework
- All contributors who have helped in the development

## Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)
Project Link: [https://github.com/yourusername/news_aggregator](https://github.com/yourusername/news_aggregator)
```

Now, let's create a LICENSE file:

```text:LICENSE
MIT License

Copyright (c) 2024 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

For submission, you should:

1. **Create a GitHub repository:**
   - Initialize git in your project
   - Add all files
   - Make initial commit
   - Push to GitHub

2. **Prepare the APK:**
```bash
cd frontend
flutter build apk --release
```
The APK will be located at: `frontend/build/app/outputs/flutter-apk/app-release.apk`

3. **Final Checklist:**
   - [ ] All code is properly formatted
   - [ ] All dependencies are up to date
   - [ ] Environment variables are properly set
   - [ ] README.md is complete
   - [ ] LICENSE file is included
   - [ ] .gitignore is properly configured
   - [ ] APK is built and tested
   - [ ] Backend is deployed and tested
   - [ ] All features are working as expected
   - [ ] UI is responsive and works on different screen sizes
   - [ ] Error handling is implemented
   - [ ] Loading states are handled
   - [ ] Animations are smooth
   - [ ] Code is well-documented
