# Gaming Library App - Tran Van Duy - SE183134

A Flutter mobile application that displays a list of games from the RAWG Video Games Database API with offline-first capabilities and favorites management.

## Features

### Screen 1: Home Screen (List Screen)
- **Data Display**: Displays games in a scrollable list view
- **Item UI**: Each game shows:
  - Game image (cached for offline use)
  - Title
  - Rating with star icon
  - Number of ratings
  - Release date
  - Genre chips
- **Loading State**: Shows CircularProgressIndicator during initial load
- **Error State**: Displays user-friendly error message when network fails and cache is empty
- **Search Bar**: Real-time search functionality to filter games by name
- **Category Filters**: Horizontal scrollable genre filters (automatically populated from API data)
- **Offline Support**: Games are cached in SQLite database for offline viewing
- **Pull to Refresh**: Swipe down to fetch latest data from API
- **Navigation**: Tap any game to view details

### Screen 2: Detail Screen
- **Complete Game Details**:
  - Large game image (hero animation)
  - Game title
  - Rating and number of ratings
  - Metacritic score (color-coded)
  - Release date
  - Average playtime
  - Genres (as chips)
  - Platforms (as chips)
  - Full description
- **Favorite Toggle Button**:
  - Heart icon in app bar
  - Filled heart (red) when favorited
  - Outline heart when not favorited
  - Instant state update on tap
  - Shows snackbar confirmation
- **Offline Support**: Details loaded from cache when available

### Screen 3: Favorites Screen
- **Favorites Display**: Shows only games marked as favorites
- **Data Source**: Loaded entirely from local SQLite database (no network calls)
- **Search Bar**: Filter favorites by name
- **Category Filters**: Filter favorites by genre (automatically populated from favorite games)
- **Real-time Updates**: Automatically updates when favorites are added/removed
- **Empty State**: Shows friendly message when no favorites exist
- **Navigation**: Tap any favorite to view full details

## Technical Implementation

### Architecture
- **State Management**: Provider pattern
- **Local Database**: SQLite (sqflite package)
- **API**: RAWG Video Games Database API
- **Image Caching**: cached_network_image package
- **Offline-First**: Data fetched from API and cached locally for offline access

### Key Components
1. **Models**: `Game` model with JSON serialization and database mapping
2. **Database Helper**: SQLite operations for games cache and favorites
3. **API Service**: HTTP client for fetching games from RAWG API
4. **Provider**: `GameProvider` manages state, search, filters, and favorites
5. **Screens**: Three main screens (Home, Detail, Favorites)

### Project Structure
```
lib/
├── main.dart                      # App entry point
├── models/
│   └── game.dart                  # Game data model
├── database/
│   └── database_helper.dart       # SQLite database operations
├── services/
│   └── game_api_service.dart      # API service for RAWG
├── providers/
│   └── game_provider.dart         # State management
└── screens/
    ├── home_screen.dart           # List screen (main)
    ├── game_detail_screen.dart    # Detail screen
    └── favorites_screen.dart      # Favorites screen
```

## Setup and Run

### Prerequisites
- Flutter SDK (^3.9.2)
- Android Studio / VS Code with Flutter extension
- Android Emulator or Physical Device

### Installation
1. Clone or download the project
2. Navigate to project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

### API Information
- **API**: RAWG Video Games Database API
- **Base URL**: https://api.rawg.io/api
- **Note**: The app uses the free tier which doesn't require an API key for basic usage
- **For Production**: Register at https://rawg.io/apidocs to get an API key for higher rate limits

## Dependencies
- `provider: ^6.1.1` - State management
- `http: ^1.1.0` - HTTP client for API calls
- `sqflite: ^2.3.0` - SQLite database
- `path_provider: ^2.1.1` - File system paths
- `cached_network_image: ^3.3.0` - Image caching

## Features Implemented

✅ Offline-first architecture with SQLite caching
✅ Search functionality on both List and Favorites screens
✅ Category filters (auto-populated from data)
✅ Loading and error states
✅ Favorites management with toggle button
✅ Real-time favorites updates
✅ Pull-to-refresh on home screen
✅ Image caching for better performance
✅ Hero animations for smooth transitions
✅ Material Design 3 theming
✅ Responsive UI with proper error handling

## Student Information
- **Name**: Tran Van Duy
- **Student ID**: SE183134
- **Subject**: PRM392 - Mobile Programming
- **Topic**: Gaming Library Application

## Screenshots
The app displays:
1. A list of popular games with images, ratings, and genres
2. Detailed game information with favorite button
3. User's favorite games collection with filtering

## License
This project is created for educational purposes.
