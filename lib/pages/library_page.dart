import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/barell.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  List<String> albums = [];
  List<String> subtitles = [];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    final userAlbums = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .collection('albums')
        .get();

    setState(() {
      albums = userAlbums.docs.map((doc) => doc['name'] as String).toList();
      subtitles =
          userAlbums.docs.map((doc) => doc['subtitle'] as String).toList();

      if (!albums.contains('Favorites')) {
        albums.insert(0, 'Favorites');
        subtitles.insert(0, 'My favorite songs');
      }
    });
  }

  Future<void> _saveAlbum(String name, String subtitle) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .collection('albums')
        .add({
      'name': name,
      'subtitle': subtitle,
    });

    _loadAlbums();
  }

  Future<void> _deleteAlbum(int index) async {
    final albumQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .collection('albums')
        .where('name', isEqualTo: albums[index])
        .get();

    for (var doc in albumQuery.docs) {
      await doc.reference.delete();
    }

    _loadAlbums();
  }

  void _showCreateAlbumDialog() {
    TextEditingController albumController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Album'),
          content: TextField(
            controller: albumController,
            decoration: InputDecoration(hintText: "Enter album name"),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () {
                if (albumController.text.isNotEmpty) {
                  setState(() {
                    albums.add(albumController.text);
                    subtitles.add('Newly created album');
                  });
                  _saveAlbum(albumController.text, 'Newly created album');
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SpokefyHomePage()),
            );
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey.shade700,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                title: Text(
                  albums[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  subtitles[index],
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                trailing: albums[index] == 'Favorites'
                    ? null
                    : IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteAlbum(index);
                        },
                      ),
                onTap: () {
                  if (albums[index] == 'Favorites') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesPage(),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateAlbumDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey.shade800,
      ),
    );
  }
}
