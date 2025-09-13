import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movies_response.dart';

class WatchlistRepository {
  static const String _watchlistKey = 'watchlist_movies';

  // Add movie to watchlist
  Future<void> addToWatchlist(Movies movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<Movies> watchlist = await getWatchlistMovies();

    // Check if movie already exists in watchlist
    if (!watchlist.any((m) => m.id == movie.id)) {
      watchlist.add(movie);
      await _saveWatchlist(watchlist);
    }
  }

  // Remove movie from watchlist
  Future<void> removeFromWatchlist(int movieId) async {
    List<Movies> watchlist = await getWatchlistMovies();
    watchlist.removeWhere((movie) => movie.id == movieId);
    await _saveWatchlist(watchlist);
  }

  // Get all watchlist movies
  Future<List<Movies>> getWatchlistMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final watchlistJson = prefs.getString(_watchlistKey);

    if (watchlistJson != null) {
      try {
        final List<dynamic> moviesList = jsonDecode(watchlistJson);
        return moviesList.map((movieJson) => Movies.fromJson(movieJson)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // Check if movie is in watchlist
  Future<bool> isMovieInWatchlist(int movieId) async {
    List<Movies> watchlist = await getWatchlistMovies();
    return watchlist.any((movie) => movie.id == movieId);
  }

  // Clear all watchlist
  Future<void> clearWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_watchlistKey);
  }

  // Private method to save watchlist
  Future<void> _saveWatchlist(List<Movies> watchlist) async {
    final prefs = await SharedPreferences.getInstance();
    final watchlistJson = jsonEncode(watchlist.map((movie) => movie.toJson()).toList());
    await prefs.setString(_watchlistKey, watchlistJson);
  }

  // Get watchlist count
  Future<int> getWatchlistCount() async {
    List<Movies> watchlist = await getWatchlistMovies();
    return watchlist.length;
  }
}