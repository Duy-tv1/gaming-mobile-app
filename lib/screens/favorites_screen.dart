import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/game_provider.dart';
import '../models/game.dart';
import 'game_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Reset filters when entering favorites screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().resetFavoritesFilters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: Color(0xFFFF6B6B)),
            const SizedBox(width: 8),
            const Text('MY FAVORITES'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF6B6B).withOpacity(0.1),
                    const Color(0xFF1A1E3E),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFF2D3561),
                  width: 2,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '❤️ Search your favorites...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFF6B6B)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Color(0xFFFF6B6B)),
                          onPressed: () {
                            _searchController.clear();
                            context.read<GameProvider>().searchFavorites('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: (value) {
                  context.read<GameProvider>().searchFavorites(value);
                },
              ),
            ),
          ),

          // Category Filter
          Consumer<GameProvider>(
            builder: (context, provider, child) {
              // Get unique categories from favorites
              final favoriteCategories = <String>{'All'};
              for (var game in provider.favorites) {
                favoriteCategories.addAll(game.genres);
              }
              final categories = favoriteCategories.toList()..sort();

              if (categories.length <= 1) {
                return const SizedBox.shrink();
              }

              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = provider.selectedCategory == category ||
                        (provider.selectedCategory == null && category == 'All');

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          provider.filterFavoritesByCategory(
                            category == 'All' ? null : category,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          // Favorites List
          Expanded(
            child: Consumer<GameProvider>(
              builder: (context, provider, child) {
                // Empty State
                if (provider.favorites.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFF6B6B).withOpacity(0.2),
                                const Color(0xFF6C5CE7).withOpacity(0.2),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 80,
                            color: Color(0xFFFF6B6B),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'NO FAVORITES YET',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tap the ❤️ icon on game details\nto add your favorites',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // No results after filtering
                if (provider.favorites.isNotEmpty && provider.favorites.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No favorites match your search',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Favorites List
                return ListView.builder(
                  itemCount: provider.favorites.length,
                  itemBuilder: (context, index) {
                    final game = provider.favorites[index];
                    return _FavoriteListItem(game: game);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteListItem extends StatelessWidget {
  final Game game;

  const _FavoriteListItem({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () async {
          // Navigate to detail screen and refresh favorites when coming back
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameDetailScreen(gameId: game.id),
            ),
          );
          
          // Reload favorites to reflect any changes
          if (context.mounted) {
            context.read<GameProvider>().loadFavorites();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Game Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: game.backgroundImage != null
                    ? CachedNetworkImage(
                        imageUrl: game.backgroundImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 40),
                        ),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.videogame_asset, size: 40),
                      ),
              ),

              const SizedBox(width: 12),

              // Game Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            game.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          game.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${game.ratingsCount})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (game.released != null)
                      Text(
                        'Released: ${game.released}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: game.genres.take(3).map((genre) {
                        return Chip(
                          label: Text(
                            genre,
                            style: const TextStyle(fontSize: 10),
                          ),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
