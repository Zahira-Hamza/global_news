# 📰 Global News App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-1A5276?style=for-the-badge&logo=flutter&logoColor=white)
![Clean Architecture](https://img.shields.io/badge/Clean%20Architecture-2E86C1?style=for-the-badge&logo=flutter&logoColor=white)
![Dio](https://img.shields.io/badge/Dio-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![NewsAPI](https://img.shields.io/badge/NewsAPI-FF6600?style=for-the-badge&logo=rss&logoColor=white)

A clean, fast, and modern news browsing application built with Flutter — featuring category-based browsing, source filtering, full-text search, and an in-app article viewer.

</div>

---

## ✨ Features

- 📂 **Browse by Category** — Explore news across Business, Technology, Sports, Health, Entertainment, and more
- 📡 **Filter by Source** — Choose your preferred news outlets and see their latest stories
- 🔍 **Full-Text Search** — Search for any topic and get real-time results from across the web
- 📖 **In-App Article Viewer** — Read full articles inside the app without opening a browser
- ⚡ **BLoC State Management** — Predictable, testable, and reactive UI state across all screens
- 🏗️ **Clean Architecture** — Strictly separated Data / Domain / Presentation layers for scalability

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles:

```
lib/
├── core/                  # Shared utilities, constants, errors
├── features/
│   └── news/
│       ├── data/          # API models, repository implementations, data sources
│       ├── domain/        # Entities, use cases, repository interfaces
│       └── presentation/  # BLoC, pages, widgets
└── main.dart
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| UI Framework | Flutter |
| Language | Dart |
| State Management | BLoC (flutter_bloc) |
| Architecture | Clean Architecture |
| HTTP Client | Dio |
| News Data | NewsAPI |
| Navigation | Flutter Navigator 2.0 |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A free API key from [newsapi.org](https://newsapi.org)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Zahira-Hamza/News_app.git

# 2. Navigate into the project
cd News_app

# 3. Install dependencies
flutter pub get

# 4. Add your NewsAPI key
# Open lib/core/constants/api_constants.dart and replace:
# const String apiKey = 'YOUR_API_KEY_HERE';

# 5. Run the app
flutter run
```

---

## 📸 Screenshots

> *Coming soon — screenshots will be added here*

---

## 👩‍💻 Author

**Zahira Hamza** — Flutter Developer
- GitHub: [@Zahira-Hamza](https://github.com/Zahira-Hamza)
- LinkedIn: [zahira-hamza](https://linkedin.com/in/zahira-hamza-91b6ba379)
- Email: zahirahamza659@gmail.com
