import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class LikedSongs {
  Future<String> _getUserKey() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    return 'favorites_$userId';
  }

  Future<void> addFavorite(Map<String, String> song) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = await _getUserKey();
      final favoritesJson = prefs.getString(key) ?? '[]';
      final List<dynamic> favorites = json.decode(favoritesJson);

      if (!favorites.any((item) => item['title'] == song['title'])) {
        favorites.add(song);
        await prefs.setString(key, json.encode(favorites));
      }
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  Future<void> removeFavorite(Map<String, String> song) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = await _getUserKey();
      final favoritesJson = prefs.getString(key) ?? '[]';
      final List<dynamic> favorites = json.decode(favoritesJson);

      favorites.removeWhere((item) => item['title'] == song['title']);
      await prefs.setString(key, json.encode(favorites));
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  Future<bool> isFavorite(Map<String, String> song) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = await _getUserKey();
      final favoritesJson = prefs.getString(key) ?? '[]';
      final List<dynamic> favorites = json.decode(favoritesJson);

      return favorites.any((item) => item['title'] == song['title']);
    } catch (e) {
      print('Error checking favorite: $e');
      return false;
    }
  }

  Future<List<Map<String, String>>> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = await _getUserKey();
      final favoritesJson = prefs.getString(key) ?? '[]';
      final List<dynamic> favorites = json.decode(favoritesJson);
      return favorites.map((item) => Map<String, String>.from(item)).toList();
    } catch (e) {
      print('Error loading favorites: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = await _getUserKey();
      final favoritesJson = prefs.getString(key) ?? '[]';
      final List<dynamic> favorites = json.decode(favoritesJson);
      return favorites.map((item) => Map<String, String>.from(item)).toList();
    } catch (e) {
      print('Error retrieving favorites: $e');
      return [];
    }
  }
}
