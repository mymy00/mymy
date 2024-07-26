import 'package:flutter/material.dart';

class SongListPage extends StatelessWidget {
  final String artistName;
  final List<String> songs;

  SongListPage({required this.artistName, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Songs by $artistName'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songs[index]),
            trailing: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
