class Game {
  final int id;
  final String name;
  final String? backgroundImage;
  final double rating;
  final int ratingsCount;
  final String? released;
  final List<String> genres;
  final List<String> platforms;
  final String? description;
  final int? metacritic;
  final int? playtime;

  Game({
    required this.id,
    required this.name,
    this.backgroundImage,
    required this.rating,
    required this.ratingsCount,
    this.released,
    required this.genres,
    required this.platforms,
    this.description,
    this.metacritic,
    this.playtime,
  });

  // Convert from JSON (API response)
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as int,
      name: json['name'] as String,
      backgroundImage: json['background_image'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingsCount: json['ratings_count'] as int? ?? 0,
      released: json['released'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((g) => g['name'] as String)
              .toList() ??
          [],
      platforms: (json['platforms'] as List<dynamic>?)
              ?.map((p) => p['platform']['name'] as String)
              .toList() ??
          [],
      description: json['description_raw'] as String?,
      metacritic: json['metacritic'] as int?,
      playtime: json['playtime'] as int?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'background_image': backgroundImage,
      'rating': rating,
      'ratings_count': ratingsCount,
      'released': released,
      'genres': genres.join(','),
      'platforms': platforms.join(','),
      'description': description,
      'metacritic': metacritic,
      'playtime': playtime,
    };
  }

  // Convert from database map
  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as int,
      name: map['name'] as String,
      backgroundImage: map['background_image'] as String?,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      ratingsCount: map['ratings_count'] as int? ?? 0,
      released: map['released'] as String?,
      genres: (map['genres'] as String?)?.split(',') ?? [],
      platforms: (map['platforms'] as String?)?.split(',') ?? [],
      description: map['description'] as String?,
      metacritic: map['metacritic'] as int?,
      playtime: map['playtime'] as int?,
    );
  }

  // Convert to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'background_image': backgroundImage,
      'rating': rating,
      'ratings_count': ratingsCount,
      'released': released,
      'genres': genres.join(','),
      'platforms': platforms.join(','),
      'description': description,
      'metacritic': metacritic,
      'playtime': playtime,
    };
  }

  // Get primary genre for category filtering
  String get primaryGenre => genres.isNotEmpty ? genres.first : 'Unknown';
}
