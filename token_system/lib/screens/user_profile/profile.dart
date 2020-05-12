import 'package:flutter/material.dart';
import 'package:token_system/Entities/user.dart';

enum UserOptions { logout, editProfile }

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.topRight,
        child: PopupMenuButton<UserOptions>(
            onSelected: (UserOptions result) {
              if (result == UserOptions.logout) {
                Navigator.pushReplacementNamed(context, '/login');
              }
              if (result == UserOptions.editProfile) {
                // TODO: Navigate to Edit Profile screen
                // Navigator.push(context, '/edit')
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<UserOptions>>[
                  const PopupMenuItem<UserOptions>(
                    value: UserOptions.editProfile,
                    child: Text('Edit Profile'),
                  ),
                  const PopupMenuItem<UserOptions>(
                    value: UserOptions.logout,
                    child: Text('Logout'),
                  ),
                ]),
      ),
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.account_circle,
              size: 100,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(
              user.name,
              style: TextStyle(color: Colors.amber[800], fontSize: 30),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone),
                    Text(user.contactNumber),
                  ]),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Icon(Icons.email),
                    Text(user.email),
                  ]),

          ]),
        ]),
      ),
    ]);
  }
}
