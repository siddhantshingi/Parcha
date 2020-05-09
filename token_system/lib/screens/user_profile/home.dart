import 'package:flutter/material.dart';
import 'package:token_system/screens/user_profile/profile.dart';

class UserHome extends StatefulWidget {
  final String name;

  UserHome({Key key, @required this.name}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 3) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TokenDown'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ProfileScreen(name: widget.name),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_out),
            title: Text('Token'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text('Logout'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
