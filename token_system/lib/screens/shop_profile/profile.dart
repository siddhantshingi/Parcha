import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';

enum ShopOptions { logout, editProfile }

class ProfileScreen extends StatelessWidget {
  final Shop shop;

  ProfileScreen({Key key, @required this.shop}) : super(key: key);

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
              shop.name,
              style: TextStyle(color: Colors.amber[800], fontSize: 30),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone),
                    Text(shop.contactNumber),
                  ]),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email),
                    Text(shop.email),
                  ]),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
