import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';

class ProfileScreen extends StatelessWidget {
  final Authority user;

  ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
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
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email),
                    Text(user.email),
                  ]),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
