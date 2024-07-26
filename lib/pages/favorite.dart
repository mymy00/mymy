import 'package:flutter/material.dart';
import 'package:flutter_application_1/barell.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Map<String, String>>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = LikedSongs().loadFavorites();
  }

  void _removeFavorite(Map<String, String> song) async {
    await LikedSongs().removeFavorite(song);
    setState(() {
      _favoritesFuture = LikedSongs().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.blueGrey.shade800,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Create Album',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Favorites Available'));
          } else {
            final favorites = snapshot.data!;

            final uniqueFavorites = favorites.toSet().toList();

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListView.builder(
                itemCount: uniqueFavorites.length,
                itemBuilder: (context, index) {
                  final song = uniqueFavorites[index];
                  return ListTile(
                    leading: Icon(Icons.music_note, color: Colors.white),
                    title: Text(
                      song['title']!,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      song['artist']!,
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        _removeFavorite(song);
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
