
Claude finished the response
make a readme file for this repo :https://github.com/Marwann255/newshttps://github.com/Marwann255/news, i added Article Bottom Sheet View and Full Screen View, & search bar

Searched the web
Which news API does the app pull articles from?
NewsAPI.org
Created a file, read a file
Here's the README, built around the three features you mentioned plus the NewsAPI.org integration. A few things worth checking before you commit it:

Project structure section is a reasonable guess — adjust folder names if yours differ.
API key setup step is generic since I don't know exactly how you're storing the key in this repo (constants file vs .env).
Swap in real screenshots for the placeholder table once you've got them.
Let me know if you'd like it tweaked — e.g., adding a badges row, a demo GIF section, or matching the tone of your Evently README more closely.


Readme
Document·MD


Write a message…


Claude is AI and can make mistakes.


Readme · MD
# News App 📰

A Flutter news app that fetches live headlines and articles from [NewsAPI.org](https://newsapi.org/), with a clean, focused reading experience — search, quick-preview bottom sheets, and full-screen article details.

## Features

- 🔍 **Live Search** — Debounced search bar that queries NewsAPI as you type, without hammering the API on every keystroke.
- 📄 **Article Bottom Sheet** — Tap an article for a quick-glance preview (image, title, source, snippet) in a modal bottom sheet, without leaving the list.
- 🖥️ **Full-Screen Article View** — Expand into a dedicated detail screen for the full article experience.
- 🔗 **Open in Browser** — Jump straight to the original source article via `url_launcher`.
- 📱 **Responsive UI** — Smooth scrolling, image loading, and clean Material design throughout.
## Tech Stack

- **Framework:** Flutter / Dart
- **News Source:** [NewsAPI.org](https://newsapi.org/)
- **Networking:** `http`
- **Navigation:** Flutter Navigator
- **External Links:** `url_launcher`
## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- A free API key from [NewsAPI.org](https://newsapi.org/register)
### Installation

1. Clone the repo
```bash
   git clone https://github.com/Marwann255/news.git
   cd news
```

2. Install dependencies
```bash
   flutter pub get
```

3. Add your NewsAPI key

   Create a file (or update the existing config) with your API key, e.g.:
```dart
   const String newsApiKey = 'YOUR_NEWSAPI_KEY_HERE';
```
> Avoid committing real API keys — use a `.env` file or a git-ignored constants file.

4. Run the app
```bash
   flutter run
```

## Project Structure

```
lib/
├── models/          # Article & response models
├── services/        # NewsAPI service / HTTP calls
├── screens/         # Home, Search, Article Detail screens
├── widgets/         # ArticleBottomSheet, ArticleCard, SearchBar, etc.
└── main.dart
```

## Screenshots

<!-- Add screenshots here -->
| Home | Search | Article Detail |
|------|--------|-----------------|
| _add image_ | _add image_ | _add image_ |

## Roadmap

- [ ] Category filtering (business, sports, tech, etc.)
- [ ] Bookmark / save articles
- [ ] Dark mode
- [ ] Offline caching
## License

This project is open source and available under the [MIT License](LICENSE).
