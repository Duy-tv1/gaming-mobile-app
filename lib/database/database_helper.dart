import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/game.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('games.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    const realType = 'REAL';

    // Games cache table
    await db.execute('''
      CREATE TABLE games (
        id $idType,
        name $textType NOT NULL,
        background_image $textType,
        rating $realType NOT NULL,
        ratings_count $intType NOT NULL,
        released $textType,
        genres $textType NOT NULL,
        platforms $textType NOT NULL,
        description $textType,
        metacritic $intType,
        playtime $intType
      )
    ''');

    // Favorites table
    await db.execute('''
      CREATE TABLE favorites (
        id $idType,
        name $textType NOT NULL,
        background_image $textType,
        rating $realType NOT NULL,
        ratings_count $intType NOT NULL,
        released $textType,
        genres $textType NOT NULL,
        platforms $textType NOT NULL,
        description $textType,
        metacritic $intType,
        playtime $intType
      )
    ''');
  }

  // ==================== GAMES CACHE OPERATIONS ====================

  Future<void> cacheGames(List<Game> games) async {
    final db = await database;
    
    // Clear old cache and insert new data
    await db.delete('games');
    
    for (var game in games) {
      await db.insert(
        'games',
        game.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Game>> getCachedGames() async {
    final db = await database;
    final maps = await db.query('games');
    
    return maps.map((map) => Game.fromMap(map)).toList();
  }

  Future<Game?> getCachedGameById(int id) async {
    final db = await database;
    final maps = await db.query(
      'games',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return Game.fromMap(maps.first);
  }

  // ==================== FAVORITES OPERATIONS ====================

  Future<void> addFavorite(Game game) async {
    final db = await database;
    await db.insert(
      'favorites',
      game.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(int gameId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [gameId],
    );
  }

  Future<bool> isFavorite(int gameId) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [gameId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<List<Game>> getFavorites() async {
    final db = await database;
    final maps = await db.query('favorites');
    
    return maps.map((map) => Game.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
