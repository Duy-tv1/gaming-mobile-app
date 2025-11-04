# Quick Start Guide - Gaming Library App

## 🚀 How to Run the App

### Method 1: Using VS Code
1. Open the project in VS Code
2. Make sure you have an Android emulator running or a device connected
3. Press `F5` or click "Run > Start Debugging"
4. Or use the terminal:
   ```bash
   flutter run
   ```

### Method 2: Using Android Studio
1. Open the project in Android Studio
2. Wait for Gradle sync to complete
3. Select your device/emulator from the dropdown
4. Click the green "Run" button (▶️)

## 📱 Testing the App

### Test Offline Functionality:
1. Launch the app (loads games from API and caches them)
2. Turn off WiFi/Mobile data
3. Close and reopen the app
4. You should see the cached games from the database
5. Navigate to detail screens (works offline)
6. Add/remove favorites (works offline)

### Test Search Functionality:
1. On Home screen, type in the search bar
2. Games are filtered in real-time
3. Try searching for: "witcher", "mario", "zelda", etc.

### Test Category Filters:
1. Scroll the horizontal genre chips (Action, RPG, Strategy, etc.)
2. Tap any genre to filter games
3. Tap "All" to reset filter

### Test Favorites:
1. Open any game detail
2. Tap the heart icon in the app bar
3. Go back to home
4. Tap the heart icon in the home app bar to see favorites
5. Search and filter favorites work the same way
6. Remove favorites by tapping the heart again in detail screen

### Test Pull-to-Refresh:
1. On Home screen, pull down the list
2. App fetches fresh data from API
3. Database is updated with new data

## 🔧 Troubleshooting

### Issue: "Failed to load data"
- **Solution**: Check internet connection on first launch
- The app needs internet to fetch data initially
- After first successful load, works offline

### Issue: Images not loading
- **Solution**: Make sure internet permission is added (already done in AndroidManifest.xml)
- Check if emulator/device has internet access

### Issue: App crashes on startup
- **Solution**: 
  ```bash
  flutter clean
  flutter pub get
  flutter run
  ```

### Issue: Database errors
- **Solution**: Uninstall and reinstall the app to reset database

## 📊 App Flow

1. **First Launch** → Loads from API → Caches to database → Shows games
2. **Subsequent Launches** → Shows cached data immediately → Fetches updates in background
3. **Offline Mode** → Shows cached data → No error messages (seamless experience)
4. **Add Favorite** → Saves to favorites table → Updates UI immediately
5. **Remove Favorite** → Removes from favorites table → Updates UI immediately

## 🎮 Sample Actions to Try

```
1. Launch app → See loading indicator → Games appear
2. Search "GTA" → See filtered results
3. Tap "Action" genre → See only action games
4. Tap any game → See full details
5. Tap heart icon → Add to favorites
6. Press back → Return to home
7. Tap heart in app bar → See favorites list
8. Search favorites → Filter by name
9. Turn off internet → Close and reopen app → Still works!
10. Pull to refresh → Gets latest games (if online)
```

## 🌟 Key Features to Demonstrate

✅ **Offline-First**: Works without internet after first load
✅ **Real-time Search**: Instant filtering as you type
✅ **Smart Categories**: Auto-extracted from game data
✅ **Persistent Favorites**: Saved in local database
✅ **Image Caching**: Fast loading with cached images
✅ **Error Handling**: User-friendly messages
✅ **Loading States**: Progress indicators while loading
✅ **Empty States**: Helpful messages when no data

## 📝 Notes

- First launch requires internet connection
- Games are cached for offline viewing
- Favorites work completely offline
- Pull-to-refresh updates the cache
- Search and filters work on cached data

## 🎯 Assignment Requirements Checklist

✅ App title shows: "Tran Van Duy - SE183134"
✅ List Screen with LazyColumn (ListView)
✅ Each item shows title and image
✅ Loading indicator (CircularProgressIndicator)
✅ Error state with retry button
✅ Navigation to detail screen on tap
✅ Search bar on List Screen
✅ Category filters (auto-populated)
✅ Detail Screen with complete game info
✅ Favorite toggle button (heart icon)
✅ Button state reflects favorite status
✅ Favorites Screen with list from database only
✅ Real-time favorites updates
✅ Empty state message in favorites
✅ Search bar on Favorites Screen
✅ Category filters on Favorites Screen
✅ Offline-first with SQLite database

## 💡 Tips for Best Experience

1. Use a real device or fast emulator for best performance
2. Make sure device has good internet for first launch
3. Try offline mode to see database caching in action
4. Add multiple favorites to test filtering
5. Search for popular games: "witcher", "portal", "minecraft"

---

**Student**: Tran Van Duy - SE183134
**Subject**: PRM392 - Mobile Programming
**Topic**: Gaming Library Application
