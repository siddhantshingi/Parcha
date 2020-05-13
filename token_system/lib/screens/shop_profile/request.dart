import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/components/tab_navigator.dart';

enum ShopOptions { logout, editProfile }

class RequestScreen extends StatefulWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  RequestScreen({Key key, @required this.shop, @required this.tn})
      : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<RequestScreen> {
  String startTime;
  String endTime;
  String category;

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
              widget.shop.name,
              style: TextStyle(color: Colors.amber[800], fontSize: 30),
            ),
          ),
          Row(children: <Widget>[
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone),
                    Text(widget.shop.contactNumber),
                  ]),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email),
                    Text(widget.shop.email),
                  ]),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
