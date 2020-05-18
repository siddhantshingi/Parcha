import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:rsa_pkcs/rsa_pkcs.dart' as parserLib;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:token_system/screens/shop_profile/key_storage.dart';

enum ShopOptions { logout, editProfile }

class VerifyScreen extends StatefulWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;
  final KeyStorage keyStorage;

  VerifyScreen({Key key, @required this.shop, @required this.tn, @required this.keyStorage})
      : super(key: key);
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<VerifyScreen> {
  String _scan;
  String _publicKey;
  encrypt.Signer _signer;
//  String verificationStatus = "Not scanned yet";
  String tokenValue = "";
//  String verificationStatusShopId = "";
  bool scanStatus = false;
  bool verificationStatusSignature;
  bool verificationStatusShopId;
  @override
  void initState() {
    super.initState();
    widget.keyStorage.readKey().then((String value) {
      setState(() {
        print(value);
        _publicKey = value;
        _signer = encrypt.Signer(
            encrypt.RSASigner(encrypt.RSASignDigest.SHA256,
                publicKey: encrypt.RSAKeyParser().parse(_publicKey),
                privateKey: null));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
                  String token = _scan.split("\n")[0];
                  String signature = _scan.split("\n")[1];
                  bool serverSigned = _signer.verify64(token, signature);
                  print("Token assigned by server: $serverSigned");
                  print("Token is:");
                  print(token);
                  var tokenJson = json.decode(token);
                  bool shopIdVerified;
                  if(tokenJson["shopId"]==widget.shop.id){
                    shopIdVerified = true;
                  }else{
                    shopIdVerified = false;
                  }
                  //TODO: compare time
                  setState(() {
                    scanStatus = true;
                    verificationStatusSignature = serverSigned;
                    verificationStatusShopId = shopIdVerified;
                    tokenValue = token;
                  });
                });
              },
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Scan status: "),
            Icon(
                (scanStatus)?Icons.check_circle_outline:Icons.close
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Real token: "),
            Icon(
                (scanStatus)?((verificationStatusSignature)?Icons.check_circle_outline:Icons.close):Icons.timer
            )
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Same Shop: "),
            Icon(
                (scanStatus)?((verificationStatusShopId)?Icons.check_circle_outline:Icons.close):Icons.timer
            )
          ],
        ),
        Container(
          alignment: Alignment.center,
          child: Text("$tokenValue")
        )
      ],
    );
  }
}
