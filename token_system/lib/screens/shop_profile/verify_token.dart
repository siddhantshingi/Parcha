import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/components/tab_navigator.dart';

enum ShopOptions { logout, editProfile }

class VerifyScreen extends StatefulWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  VerifyScreen({Key key, @required this.shop, @required this.tn})
      : super(key: key);
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<VerifyScreen> {
  String _scan;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        textColor: Colors.white,
        color: Colors.blueGrey,
        child: Text('Scan', style: TextStyle(fontSize: 20, letterSpacing: 1.5)),
        onPressed: () {
          scanner.scan().then((result) {
            _scan = result;
            print (_scan);
          });
        },
      )
    );
  }
}
