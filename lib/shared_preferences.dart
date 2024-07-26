import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static Future<List<Map<String, String>>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('favorites') ?? '[]';
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((jsonItem) => Map<String, String>.from(jsonItem))
        .toList();
  }

  static Future<void> saveFavorites(List<Map<String, String>> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = json.encode(favorites);
    await prefs.setString('favorites', jsonList);
  }
}
