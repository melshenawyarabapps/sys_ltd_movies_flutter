# Movies Flutter Module

A Flutter module that displays a list of popular movies from TMDB API, designed to be integrated with native Android and iOS applications.

## 📋 Overview

This Flutter module is part of a multi-repository project that demonstrates native-Flutter integration:

| Repository | Description |
|------------|-------------|
| **sys_ltd_movies_flutter** (this repo) | Flutter module for displaying movies |
| **sys_ltd_movies_android** | Native Android app that hosts the Flutter module |
| **sys_ltd_movies_ios** | Native iOS app that hosts the Flutter module |

### Features

- 🎬 Fetch and display popular movies from TMDB API
- 🖼️ Movie cards with poster, title, and description
- 📱 Seamless integration with native Android/iOS apps
- 🔄 Infinite scroll pagination
- 🌍 Multi-language support (English & Arabic)
- 🎨 Light/Dark theme support
- 📡 Method channel communication for native navigation

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following structure:

```
lib/
├── app/
│   └── movies_app.dart              # App entry point
├── core/
│   ├── config/                      # App configuration
│   ├── enums/                       # Enumerations
│   ├── errors/                      # Exception handling
│   ├── routing/                     # Navigation routes
│   ├── services/
│   │   ├── api/                     # API service & network info
│   │   ├── di/                      # Dependency injection (GetIt)
│   │   ├── localization/            # Language service
│   │   └── observers/               # Bloc & Dio observers
│   ├── themes/                      # App theming
│   ├── translations/                # Localization files
│   ├── utils/                       # Utilities & constants
│   └── widgets/                     # Reusable widgets
├── features/
│   ├── data/
│   │   ├── datasources/             # Remote data sources
│   │   ├── models/                  # Data models
│   │   └── repositories/            # Repository implementations
│   ├── domain/
│   │   ├── entities/                # Business entities
│   │   ├── repositories/            # Repository contracts
│   │   └── usecases/                # Use cases
│   └── presentation/
│       ├── controllers/             # BLoC (events, states, bloc)
│       └── views/                   # UI screens & widgets
└── main.dart                        # Entry point
```

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **State Management** | flutter_bloc |
| **Dependency Injection** | get_it |
| **Networking** | dio |
| **Localization** | easy_localization |
| **Responsive UI** | flutter_screenutil |
| **Image Caching** | cached_network_image |
| **Connectivity** | connectivity_plus |
| **Testing** | flutter_test, bloc_test, mocktail |

## 📱 Native Integration

### Method Channel Communication

The Flutter module communicates with native apps via Method Channel:

```dart
// Channel name
const String channelName = 'com.movies.movies_flutter/channel';

// Event sent when a movie is tapped
const String eventName = 'onMovieTap';

// Payload
{'movieId': int}
```

### Flow

1. User taps "Show List of Movies" button in native app
2. Native app launches Flutter module
3. Flutter module displays movie list from TMDB
4. User selects a movie
5. Flutter sends movie ID via Method Channel
6. Native app receives ID and shows movie trailer

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.10.0
- Dart SDK ^3.10.0
- Android Studio / Xcode (for native integration)
- TMDB API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/melshenawyarabapps/sys_ltd_movies_flutter.git
   cd sys_ltd_movies_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   
   Open `lib/core/utils/end_points.dart` and add your TMDB API key:
   ```dart
   static const String apiKey = '2a81b0f3fbbe3656bd9be040bdeed583';
   ```

4. **Generate localization files** (if needed)
   ```bash
   flutter pub run easy_localization:generate -S assets/translations -f keys -O lib/core/translations -o locale_keys.g.dart
   ```

### Running the Module

**Standalone (for development):**
```bash
flutter run
```

**As a module in Android:**
```bash
# Build the Flutter module
flutter build aar

# Integrate into native Android project (see Android repo)
```

**As a module in iOS:**
```bash
# Build the Flutter module
flutter build ios-framework --output=build/ios/framework

# Integrate into native iOS project (see iOS repo)
```

## 🧪 Testing

This project implements comprehensive testing following TDD principles.

### Test Structure

```
test/
├── fixtures/
│   ├── movie_fixtures.dart         # Test data
│   └── mocks.dart                  # Mock classes
├── features/
│   ├── data/
│   │   ├── datasources/            # Data source tests
│   │   ├── models/                 # Model tests
│   │   └── repositories/           # Repository tests
│   ├── domain/
│   │   └── usecases/               # Use case tests
│   └── presentation/
│       ├── controllers/            # BLoC tests
│       └── views/                  # Widget tests
└── helpers/
    └── test_helper.dart            # Test utilities

integration_test/
└── app_test.dart                   # Integration tests
```

### Running Tests

```bash
# Run all unit & widget tests
flutter test

# Run unit tests only
flutter test test/features/data/ test/features/domain/

# Run BLoC tests
flutter test test/features/presentation/controllers/

# Run widget tests
flutter test test/features/presentation/views/

# Run integration tests (requires device/emulator)
flutter test integration_test/

# Run tests with coverage
flutter test --coverage
```

## 📁 Project Configuration

### Supported Locales
- English (en) - Default
- Arabic (ar)

### Design Size
- Width: 375
- Height: 812

### API Configuration
- Base URL: `https://api.themoviedb.org/3`
- Image Base URL: `https://image.tmdb.org/t/p/w500`

## 🔧 Key Implementation Details

### BLoC Pattern

Events use a single class with event types for cleaner API:

```dart
// Usage
context.read<MoviesBloc>().add(const MoviesEvent.fetch());
context.read<MoviesBloc>().add(const MoviesEvent.loadMore());
```

### Error Handling

Comprehensive exception handling with localized error messages:

- `ServerException` - API/network errors
- `NoInternetException` - Connectivity issues

### State Management

```dart
MoviesState(
  movies: List<Movie>,
  status: RequestStatus,       // initial, loading, loaded, loadingMore, error
  errorMessage: String,
  currentPage: int,
  totalPages: int,
  hasReachedMax: bool,
)
```

## 📄 API Reference

### TMDB Endpoints Used

| Endpoint | Description |
|----------|-------------|
| `GET /movie/popular` | Fetch popular movies with pagination |

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `api_key` | String | Your TMDB API key |
| `language` | String | Device language (e.g., `en-US`, `ar-EG`) |
| `page` | int | Page number for pagination |

## 👤 Author

**Mohamed Elshenawy**

## 🔗 Related Repositories

- [sys_ltd_movies_android](https://github.com/melshenawyarabapps/sys_ltd_movies_android.git) - Native Android host app
- [sys_ltd_movies_ios](https://github.com/melshenawyarabapps/sys_ltd_movies_ios.git) - Native iOS host app

---

Made with ❤️ using Flutter
