import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:rsa_pkcs/rsa_pkcs.dart' as parserLib;
import 'package:encrypt/encrypt.dart' as encrypt;

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

class KeyStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/publicTest2.pem');
  }

  Future<String> readKey() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      print("Fetching already stored public key");
      return contents;

    } catch (e) {
      // If encountering an error, return 0
      String key = await downloadKey();
      return key;
    }
  }

  Future<String> downloadKey() async {
    try{
      print("Downloading public key");
      String content = await ShopService.getPublicKey().then((json){
        return json["result"];
      });
      await writeKey(content);
      return content;
    }catch (e) {
      print("Can not download key");
      //TODO: See how to handle error here
      return "ERROR";
    }
  }

  Future<File> writeKey(String key) async {
    final file = await _localFile;

    // Write the file
    print("writing to file");
    return file.writeAsString(key);
  }
}

class _VerifyState extends State<VerifyScreen> {
  String _scan;
  String _publicKey;
  encrypt.Signer _signer;

  @override
  void initState() {
    super.initState();
    widget.keyStorage.readKey().then((String value) {
      setState(() {
        print("got value as");
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
            String token = _scan.split("\n")[0];
            String signature = _scan.split("\n")[1];
            bool serverSigned = _signer.verify64(token, signature);
            print("Token assigned by server: $serverSigned");
            print("Token is:");
            print(token);
          });
        },
      )
    );
  }
}
