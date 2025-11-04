import 'package:flutter/foundation.dart';
import '../models/game.dart';
import '../services/game_api_service.dart';
import '../database/database_helper.dart';

class GameProvider with ChangeNotifier {
  final GameApiService _apiService = GameApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // State variables
  List<Game> _allGames = [];
  List<Game> _filteredGames = [];
  List<Game> _favorites = [];
  List<Game> _filteredFavorites = [];
  
  bool _isLoading = false;
  String? _errorMessage;
  
  String _searchQuery = '';
  String? _selectedCategory;
  List<String> _availableCategories = [];

  // Getters
  List<Game> get games => _filteredGames;
  List<Game> get favorites => _filteredFavorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  List<String> get availableCategories => _availableCategories;

  // Initialize - load from cache first, then fetch from API
  Future<void> initialize() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Load cached games first for offline support
      _allGames = await _dbHelper.getCachedGames();
      _filteredGames = List.from(_allGames);
      _extractCategories();
      
      // Load favorites
      await loadFavorites();
      
      notifyListeners();

      // Fetch fresh data from API
      await fetchGames();
    } catch (e) {
      if (_allGames.isEmpty) {
        _errorMessage = 'Could not load data. Please check your connection.';
      }
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch games from API
  Future<void> fetchGames() async {
    try {
      final games = await _apiService.fetchGames(pageSize: 40);
      _allGames = games;
      
      // Cache games for offline use
      await _dbHelper.cacheGames(games);
      
      // Apply current filters
      _applyFilters();
      _extractCategories();
      
      _errorMessage = null;
    } catch (e) {
      // If we have cached data, don't show error
      if (_allGames.isEmpty) {
        _errorMessage = 'Could not load data. Please check your connection.';
      }
    } finally {
      notifyListeners();
    }
  }

  // Search functionality
  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  // Filter by category
  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  // Apply search and category filters to games list
  void _applyFilters() {
    _filteredGames = _allGames.where((game) {
      final matchesSearch = _searchQuery.isEmpty ||
          game.name.toLowerCase().contains(_searchQuery);
      
      final matchesCategory = _selectedCategory == null ||
          _selectedCategory == 'All' ||
          game.genres.any((genre) => genre == _selectedCategory);
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  // Apply filters to favorites list
  void _applyFavoritesFilters() {
    _filteredFavorites = _favorites.where((game) {
      final matchesSearch = _searchQuery.isEmpty ||
          game.name.toLowerCase().contains(_searchQuery);
      
      final matchesCategory = _selectedCategory == null ||
          _selectedCategory == 'All' ||
          game.genres.any((genre) => genre == _selectedCategory);
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  // Extract unique categories from games
  void _extractCategories() {
    final categoriesSet = <String>{};
    for (var game in _allGames) {
      categoriesSet.addAll(game.genres);
    }
    _availableCategories = ['All', ...categoriesSet.toList()..sort()];
  }

  // Search favorites
  void searchFavorites(String query) {
    _searchQuery = query.toLowerCase();
    _applyFavoritesFilters();
    notifyListeners();
  }

  // Filter favorites by category
  void filterFavoritesByCategory(String? category) {
    _selectedCategory = category;
    _applyFavoritesFilters();
    notifyListeners();
  }

  // Load favorites from database
  Future<void> loadFavorites() async {
    _favorites = await _dbHelper.getFavorites();
    _filteredFavorites = List.from(_favorites);
    notifyListeners();
  }

  // Check if a game is favorite
  Future<bool> isFavorite(int gameId) async {
    return await _dbHelper.isFavorite(gameId);
  }

  // Toggle favorite status
  Future<void> toggleFavorite(Game game) async {
    final isFav = await isFavorite(game.id);
    
    if (isFav) {
      await _dbHelper.removeFavorite(game.id);
    } else {
      await _dbHelper.addFavorite(game);
    }
    
    await loadFavorites();
  }

  // Get game by ID (from cache or API)
  Future<Game?> getGameById(int gameId) async {
    try {
      // Try to get from cache first
      var game = await _dbHelper.getCachedGameById(gameId);
      
      if (game != null) return game;
      
      // If not in cache, fetch from API
      game = await _apiService.fetchGameDetails(gameId);
      
      return game;
    } catch (e) {
      return null;
    }
  }

  // Reset filters
  void resetFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _applyFilters();
    notifyListeners();
  }

  // Reset favorites filters
  void resetFavoritesFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _applyFavoritesFilters();
    notifyListeners();
  }
}
