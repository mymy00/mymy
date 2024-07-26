import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/barell.dart';

void main() => runApp(MaterialApp(home: SpokefyHomePage()));

class SpokefyHomePage extends StatefulWidget {
  @override
  _SpokefyHomePageState createState() => _SpokefyHomePageState();
}

class _SpokefyHomePageState extends State<SpokefyHomePage> {
  int _selectedIndex = 0; // Track the current selected index

  // Scroll controllers for each row
  ScrollController _row1Controller = ScrollController();
  ScrollController _row2Controller = ScrollController();
  ScrollController _row3Controller = ScrollController();

  void _scrollRight(ScrollController controller) {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _row1Controller.dispose();
    _row2Controller.dispose();
    _row3Controller.dispose();
    super.dispose();
  }

  // Method to handle navigation between tabs
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LibraryPage()),
        );
        break;
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpokefyHomePage()),
        );
        break;
      default:
        break;
    }
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
                  // Add logic to create the album and update the library
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onSearchTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(
          context, '/login'); // Replace '/login' with your actual login route
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spokefy'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearchTap,
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey.shade800,
                      Colors.blueGrey.shade600
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spokefy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.white),
                      title: Text('View Profile',
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey.shade900,
                      Colors.blueGrey.shade600
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int i = 0; i < 2; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _selectedIndex == i
                                        ? Colors.green
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedIndex = i;
                                      if (i == 1) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SongListPage(
                                              artistName: '',
                                              songs: [],
                                            ),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  child: Text([
                                    'All',
                                    'Music',
                                  ][i]),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildRow(
                      title: 'Popular Artists',
                      controller: _row1Controller,
                      itemCount: Data.imageUrls.length,
                      itemBuilder: (context, index) {
                        return _buildImageItem(
                          context,
                          Data.imageUrls[index],
                          Data.imageNames[index],
                          150.0,
                          150.0,
                          (context) => _onImageTap(context, index, 'artist'),
                        );
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildRow(
                      title: 'Popular Albums',
                      controller: _row2Controller,
                      itemCount: PopAlbums.imageUrls.length,
                      itemBuilder: (context, index) {
                        return _buildImageItem(
                          context,
                          PopAlbums.imageUrls[index],
                          PopAlbums.imageNames[index],
                          150.0,
                          150.0,
                          (context) => _onImageTap(context, index, 'album'),
                        );
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildRow(
                      title: 'Popular Radio',
                      controller: _row3Controller,
                      itemCount: PopularRadio.imageUrls.length,
                      itemBuilder: (context, index) {
                        return _buildImageItem(
                          context,
                          PopularRadio.imageUrls[index],
                          PopularRadio.imageNames[index],
                          150.0,
                          150.0,
                          (context) => _onImageTap(context, index, 'radio'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          : Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music, color: Colors.black),
            label: 'Library',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildRow({
    required String title,
    required ScrollController controller,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
  }) {
    return MouseRegion(
      onEnter: (_) => _scrollRight(controller),
      child: Container(
        height: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemCount: itemCount,
                itemBuilder: itemBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(
    BuildContext context,
    String imageUrl,
    String imageName,
    double width,
    double height,
    void Function(BuildContext) onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            ClipRect(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              imageName,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onImageTap(BuildContext context, int index, String dataType) {
    if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SongListPage(
            artistName: '',
            songs: [],
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(index: index, dataType: dataType),
        ),
      );
    }
  }
}
