# 📰 News App

A clean, feature-rich Flutter news application that fetches real-time news from [NewsAPI](https://newsapi.org/), organized by categories and sources, with full support for dark/light themes and English/Arabic localization.

---

## 📸 Screenshots

> **Home Screen – Category List (Light)**
>
> ![Home Screen Light](screenshots/home_light.png)

> **Home Screen – Category List (Dark)**
>
> ![Home Screen Dark](screenshots/home_dark.png)

> **Sources Tab – Browsing News Sources**
>
> ![Sources Screen](screenshots/sources_screen.png)

> **News List – Articles by Source**
>
> ![News List](screenshots/news_list.png)

> **News Article – Web View**
>
> ![Web View](screenshots/web_view.png)

> **Search – Filtering News**
>
> ![Search](screenshots/search.png)

> **Side Drawer – Settings (Theme & Language)**
>
> ![Drawer](screenshots/drawer.png)

> **Arabic Localization**
>
> ![Arabic](screenshots/arabic_locale.png)

---

## ✨ Features

- 🗂 **7 News Categories** — General, Business, Entertainment, Health, Science, Technology, Sports
- 📡 **Live News Feed** via [NewsAPI.org](https://newsapi.org/)
- 🔍 **Search** within any category
- 📄 **Pagination** with infinite scroll (load more articles)
- 🌙 **Dark / Light Theme** — persisted across sessions via SharedPreferences
- 🌐 **English / Arabic Localization** — full RTL support
- 🔗 **In-app WebView** to read full articles
- 🗃 **Drawer Menu** for theme and language switching

---

## 🏗 Architecture

The project follows **Clean Architecture** principles with a clear separation of layers:

```
lib/
├── api/
│   ├── models/              # JSON-serializable data models (News, Source, Articles)
│   ├── Data_Sources/
│   │   └── Remote/          # RemoteDataSource & implementation
│   ├── dio_standers/        # Dio module with global config & PrettyDioLogger
│   └── web_services.dart    # Retrofit API client
│
├── config/
│   └── dependency_injection/ # Injectable / GetIt DI setup
│
├── core/
│   ├── cache/               # SharedPreferences utilities
│   ├── error/               # Custom exceptions & Dio interceptors
│   └── utils/               # Colors, styles, themes, routes, assets
│
├── data/
│   └── Repositories_impl/   # Concrete repository implementations
│
├── domain/
│   └── Repositories_interface/ # Abstract repository contracts
│
└── features/
    └── presentation/
        ├── Home/             # HomeScreen, CategoryFragment, Theme & Language BLoCs
        ├── News/             # NewsWidget, NewsItem, WebView, NewsBloc
        └── Sources/          # SourceTabWidget, CategorySourcesBloc
```

---

## 🧠 State Management

State management is handled with **Flutter BLoC**:

| BLoC | Responsibility |
|---|---|
| `ThemeBloc` | Toggle and persist light/dark theme |
| `LanguageBloc` | Switch and persist app locale (en/ar) |
| `CategorySourcesBloc` | Fetch news sources for a selected category |
| `NewsBloc` | Fetch articles, handle pagination and search |

---

## 🛠 Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | UI framework |
| Dart | Programming language |
| flutter_bloc | State management |
| Dio | HTTP client |
| Retrofit | Type-safe REST API client (code generation) |
| injectable + get_it | Dependency injection |
| json_serializable | JSON model code generation |
| easy_localization | i18n (English & Arabic) |
| flutter_screenutil | Responsive sizing |
| shared_preferences | Local persistence (theme, language) |
| pretty_dio_logger | Network request logging |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A free API key from [https://newsapi.org](https://newsapi.org)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/news_app.git
   cd news_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add your NewsAPI key**

   Open `lib/api/dio_standers/dio_module.dart` and replace the placeholder:
   ```dart
   const String apiKey = 'YOUR_API_KEY_HERE';
   ```
   > ⚠️ For production, store keys securely using `flutter_dotenv` or a similar package — never commit API keys to version control.

4. **Run code generation** (for Retrofit, injectable, json_serializable)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 📡 API Reference

This app uses the [NewsAPI](https://newsapi.org/) REST API.

| Endpoint | Usage |
|---|---|
| `GET /v2/top-headlines/sources` | Fetch news sources by category |
| `GET /v2/everything` | Fetch news articles by source, with pagination |

Base URL: `https://newsapi.org/v2/`

---

## 📁 Project Structure Notes

- All assets (category images for light and dark themes) are defined in `AppAssets` and registered in `pubspec.yaml` under `assets/`.
- Translations live in `assets/translations/en.json` and `assets/translations/ar.json`.
- The app design size is `393×852` (iPhone 14 Pro) — scaled responsively via `flutter_screenutil`.

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Zahira Hamza**
- LinkedIn: [your-linkedin](www.linkedin.com/in/zahira-hamza-91b6ba379)
- Email: zahirahamza726@gmail.com
