import 'package:flutter/material.dart';
import 'package:flutter_application_1/barell.dart';

class DetailPage extends StatefulWidget {
  final int index;
  final String dataType; // Add a parameter to specify the data type

  DetailPage({required this.index, required this.dataType});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String itemName;
  late List<String> songs;
  Set<String> favoriteSongs = {}; // Track favorite songs

  @override
  void initState() {
    super.initState();
    _initializeData();
    _loadFavoriteSongs();
  }

  void _initializeData() {
    if (widget.dataType == 'artist') {
      itemName = Data.imageNames[widget.index];
      songs =
          (Data.songs[itemName] ?? []).toSet().toList(); // Ensure no duplicates
    } else if (widget.dataType == 'album') {
      itemName = PopAlbums.imageNames[widget.index];
      songs = (PopAlbums.songs[itemName] ?? []).toSet().toList();
    } else if (widget.dataType == 'radio') {
      itemName = PopularRadio.imageNames[widget.index];
      songs = (PopularRadio.songs[itemName] ?? []).toSet().toList();
    }
  }

  Future<void> _loadFavoriteSongs() async {
    final likedSongs = LikedSongs();
    final allFavorites =
        await likedSongs.getFavorites(); // Method to get all favorites

    // Convert list of maps to set of song titles
    setState(() {
      favoriteSongs = allFavorites.map((song) => song['title']!).toSet();
    });
  }

  Future<void> _toggleFavorite(String songTitle) async {
    final song = {'title': songTitle, 'artist': itemName};
    final likedSongs = LikedSongs();

    if (favoriteSongs.contains(songTitle)) {
      await likedSongs.removeFavorite(song);
      setState(() {
        favoriteSongs.remove(songTitle);
      });
    } else {
      await likedSongs.addFavorite(song);
      setState(() {
        favoriteSongs.add(songTitle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final songTitle = songs[index];
            final isFavorite = favoriteSongs.contains(songTitle);

            return ListTile(
              title: Text(
                songTitle,
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () async {
                  await _toggleFavorite(songTitle);
                  // Rebuild the widget to reflect changes
                  setState(() {});
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
