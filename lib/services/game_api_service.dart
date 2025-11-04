import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';

class GameApiService {
  // RAWG API - Register at https://rawg.io/apidocs to get your FREE API key
  // Steps:
  // 1. Go to https://rawg.io/apidocs
  // 2. Click "Get API Key"
  // 3. Sign up for free
  // 4. Copy your API key
  // 5. Replace 'YOUR_API_KEY_HERE' below with your actual key
  
  static const String baseUrl = 'https://api.rawg.io/api';
  static const String apiKey = '3255105158e441d09353abd8197984a2'; 
  
  // Fetch list of games
  Future<List<Game>> fetchGames({int page = 1, int pageSize = 20}) async {
    try {
      final uri = Uri.parse('$baseUrl/games')
          .replace(queryParameters: {
        'key': apiKey,
        'page': page.toString(),
        'page_size': pageSize.toString(),
      });

      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;
        
        return results.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load games: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch games: $e');
    }
  }

  // Fetch game details by ID
  Future<Game> fetchGameDetails(int gameId) async {
    try {
      final uri = Uri.parse('$baseUrl/games/$gameId')
          .replace(queryParameters: {
        'key': apiKey,
      });

      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Game.fromJson(data);
      } else {
        throw Exception('Failed to load game details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch game details: $e');
    }
  }

  // Search games by name
  Future<List<Game>> searchGames(String query, {int page = 1}) async {
    try {
      final uri = Uri.parse('$baseUrl/games')
          .replace(queryParameters: {
        'key': apiKey,
        'search': query,
        'page': page.toString(),
        'page_size': '20',
      });

      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;
        
        return results.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search games: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search games: $e');
    }
  }
}
