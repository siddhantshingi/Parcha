import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/components/tab_navigator.dart';

enum UserOptions { logout, editProfile }

class BookScreen extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;
  final Shop shop;

  BookScreen({Key key, @required this.user, @required this.tn, @required this.shop})
      : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.blur_circular,
              size: 100,
            ),
          ),
        ]),
      ),
      RaisedButton(
        child: Text(
          'CONFIRM',
          style: TextStyle(fontSize: 32.0, color: Colors.orange),
        ),
        onPressed: () {
          // Call Confirm Booking API
        },
      )
    ]);
  }
}
