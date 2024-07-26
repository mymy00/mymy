import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    if (_notificationsEnabled) {
      print("Notifications enabled");
    } else {
      print("Notifications disabled");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildSectionTitle('Account'),
            _buildListTile(
              icon: Icons.person,
              title: 'Account Info',
              onTap: () {},
            ),
            _buildListTile(
              icon: Icons.security,
              title: 'Privacy',
              onTap: () {},
            ),
            Divider(),
            _buildSectionTitle('Playback'),
            _buildListTile(
              icon: Icons.play_arrow,
              title: 'Audio Quality',
              onTap: () {},
            ),
            _buildListTile(
              icon: Icons.shuffle,
              title: 'Shuffle',
              onTap: () {},
            ),
            Divider(),
            _buildSectionTitle('Notifications'),
            _buildSwitchTile(
              icon: Icons.notifications,
              title: 'Enable Notifications',
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),
            Divider(),
            _buildSectionTitle('About'),
            _buildListTile(
              icon: Icons.info,
              title: 'About App',
              onTap: () {},
            ),
            _buildListTile(
              icon: Icons.star,
              title: 'Rate Us',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      activeColor: Colors.white,
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
