# 🎮 Gaming Library App - Tran Van Duy SE183134

**Student:** Tran Van Duy - SE183134  
**Subject:** PRM392 - Mobile Programming  
**Topic:** Gaming Library Application with Offline-First Architecture

A Flutter mobile application that fetches gaming data from RAWG Video Games Database API, displays it to users, and provides a robust offline-first experience by caching all data in a local SQLite database. Users can also favorite games for later viewing.

---

## 📱 Demo Video

### App Demonstration
> **Note:** Place your demo video in the `video` folder with name `demo.mp4`

![App Demo](video/tranvanduy_se183134.mp4)

**Or watch online:** [Demo Video Link](video/tranvanduy_se183134.mp4)

**Alternative:** If video doesn't display on GitHub, upload to YouTube/Google Drive and add link here.

---

## ✨ Features Overview

### 🏠 Screen 1: Home Screen (List Screen)
- ✅ Display games in scrollable list view (ListView)
- ✅ Each item shows: Title, Image, Rating, Genres
- ✅ Loading indicator (CircularProgressIndicator)
- ✅ Error state with user-friendly message
- ✅ Real-time search bar
- ✅ Category filters (auto-populated from API data)
- ✅ SQLite database caching for offline use
- ✅ Pull-to-refresh functionality
- ✅ Navigation to detail screen on tap

### 📋 Screen 2: Detail Screen
- ✅ Complete game details (image, rating, description, etc.)
- ✅ Receives game ID as navigation argument
- ✅ Favorite toggle button (heart icon)
- ✅ Button state reflects favorite status
- ✅ Immediate UI update on tap
- ✅ Confirmation snackbar

### ❤️ Screen 3: Favorites Screen
- ✅ Shows only favorited games
- ✅ Data loaded from local database only
- ✅ Real-time updates when favorites change
- ✅ Empty state message
- ✅ Search and filter functionality
- ✅ Category filters (auto-populated)

---

## 🎨 UI/UX Highlights

- 🌑 **Dark Gaming Theme** - Professional gaming aesthetic
- 💜 **Electric Purple & Red** - Vibrant color scheme
- ✨ **Gradient Effects** - Modern visual design
- 🎯 **Smooth Animations** - Hero transitions and loading states
- 📱 **Responsive Layout** - Works on all screen sizes

---

## 🏗️ Project Architecture

### Layered Architecture Pattern

```
📁 lib/
├── 📄 main.dart                      # Entry point with Provider setup
├── 📁 models/                        # Data models
│   └── game.dart                     # Game model with JSON/DB mapping
├── 📁 database/                      # Local database layer
│   └── database_helper.dart          # SQLite operations
├── 📁 services/                      # API service layer
│   └── game_api_service.dart         # RAWG API integration
├── 📁 providers/                     # State management
│   └── game_provider.dart            # Provider pattern
└── 📁 screens/                       # UI layer
    ├── home_screen.dart              # List screen
    ├── game_detail_screen.dart       # Detail screen
    └── favorites_screen.dart         # Favorites screen
```

### Technology Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter (Dart) |
| **State Management** | Provider Pattern |
| **Local Database** | SQLite (sqflite) |
| **API** | RAWG Video Games Database |
| **HTTP Client** | http package |
| **Image Caching** | cached_network_image |

---

## 🗄️ Database Structure

### SQLite Database (Local Storage)

**Location:** `/data/data/com.example.pe_project/databases/games.db`

#### Table 1: `games` (Cache)
Stores all fetched games for offline access
```sql
CREATE TABLE games (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  background_image TEXT,
  rating REAL NOT NULL,
  ratings_count INTEGER NOT NULL,
  released TEXT,
  genres TEXT NOT NULL,
  platforms TEXT NOT NULL,
  description TEXT,
  metacritic INTEGER,
  playtime INTEGER
)
```

#### Table 2: `favorites` (User Favorites)
Stores user's favorite games
```sql
CREATE TABLE favorites (
  -- Same structure as games table
)
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.9.2)
- Android Studio / VS Code with Flutter extension
- Android Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd tranvanduy_se183134
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Get RAWG API Key** (Required)
   - Visit: https://rawg.io/apidocs
   - Sign up for free
   - Copy your API key
   - Open `lib/services/game_api_service.dart`
   - Replace `YOUR_API_KEY_HERE` with your actual key:
   ```dart
   static const String apiKey = 'your-api-key-here';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

5. **Build APK (Optional)**
   ```bash
   flutter build apk --release
   ```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0                    # API calls
  sqflite: ^2.3.0                 # Local database
  path_provider: ^2.1.1           # File paths
  cached_network_image: ^3.3.0   # Image caching
  provider: ^6.1.1                # State management
```

---

## 🎯 Requirements Checklist

### ✅ All Requirements Met

#### Screen 1: List Screen
- [x] LazyColumn (ListView) display
- [x] Title and image per item
- [x] Loading indicator
- [x] Error state with retry
- [x] Navigation on tap
- [x] Search bar (real-time)
- [x] Category filters (auto-populated)
- [x] Database caching for offline use

#### Screen 2: Detail Screen
- [x] Complete game details
- [x] Receives ID as navigation argument
- [x] Favorite toggle button
- [x] Button state reflects favorite status
- [x] Immediate state update

#### Screen 3: Favorites Screen
- [x] Data from local database only
- [x] ListView display
- [x] Real-time updates
- [x] Empty state message
- [x] Search and filter functionality

---

## 📸 Screenshots

### Home Screen
![Home Screen](screenshots/home.png)

### Detail Screen
![Detail Screen](screenshots/detail.png)

### Favorites Screen
![Favorites Screen](screenshots/favorites.png)

> **Note:** Add screenshots in `screenshots` folder

---

## 🔄 Data Flow

```
User Interface (Screens)
        ↕️
State Management (Provider)
        ↕️
    ┌───┴───┐
    ↓       ↓
API Service  Database Helper
(RAWG API)  (SQLite)
    ↓       ↓
Network     Local Storage
```

---

## 🌟 Key Features

### Offline-First Architecture
- ✅ Data cached in SQLite database
- ✅ Works without internet after first load
- ✅ Background sync when online

### Search & Filter
- 🔍 Real-time search
- 🎮 Genre-based filtering
- 📱 Works on all screens

### Favorites Management
- ❤️ Toggle with heart button
- 💾 Persistent storage
- 🔄 Real-time sync

### Performance
- ⚡ Image caching
- 🚀 Efficient queries
- 💫 Smooth animations

---

## 🧪 Testing

### Test Offline Functionality
1. Launch app (loads games from API)
2. Turn off WiFi/Mobile data
3. Close and reopen app
4. Games still display (from cache)
5. Favorites work offline

### Test Features
```bash
✅ Search games by name
✅ Filter by genre
✅ Add/remove favorites
✅ Pull to refresh
✅ Navigate to details
✅ View game information
```

---

## 📚 Documentation Files

- `APP_README.md` - Complete project documentation
- `QUICK_START.md` - Quick start and testing guide
- `PROJECT_SUMMARY.md` - Implementation summary
- `API_SETUP_GUIDE.md` - API key setup instructions
- `VISUAL_GUIDE.txt` - Visual overview

---

## 🎓 Learning Outcomes

- Flutter app architecture and best practices
- State management with Provider pattern
- SQLite database operations
- REST API integration
- Offline-first mobile development
- Search and filter implementation
- Material Design 3 theming

---

## 🐛 Troubleshooting

### "Failed to load data"
- Check internet connection on first launch
- Verify API key is set correctly

### Images not loading
- Check internet permission in AndroidManifest.xml
- Verify device has internet access

### Database errors
- Uninstall and reinstall app
- Or run: `flutter clean && flutter pub get`

---

## 📄 License

This project is created for educational purposes.

---

## 👨‍💻 Author

**Tran Van Duy**
- Student ID: SE183134
- Course: PRM392 - Mobile Programming
- Date: November 4, 2025

---

## 🙏 Acknowledgments

- [RAWG Video Games Database API](https://rawg.io/apidocs)
- Flutter Team
- FPT University

---

**⭐ If you find this project helpful, please give it a star!**
