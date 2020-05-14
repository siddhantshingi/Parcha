import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/shop.dart';

class ShopProfile extends StatelessWidget {
  final Authority user;
  final Shop shop;

  ShopProfile({Key key, @required this.user, @required this.shop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: API Call for getting shop profile
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Monitor and Track Shops',
          style: TextStyle(
            fontSize: 20,
            color: Colors.amber,
          ),
        ),
      ),
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
                    Text('------'),
                  ]),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
