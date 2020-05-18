import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:token_system/Services/userService.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:token_system/screens/qr_code_display.dart';

class TokenCard extends StatelessWidget {
  final String date;
  final String startTime;
  final String shopName;
  final String pincode;
  final int status;
  final VoidCallback bookAgain;
  final int tokenId;

  TokenCard(
      {Key key,
      @required this.date,
      @required this.startTime,
      @required this.shopName,
      @required this.pincode,
      @required this.status,
      @required this.bookAgain,
      @required this.tokenId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderColor;
    var statusText;
    switch (this.status) {
      case 0:
        borderColor = Colors.greenAccent;
        statusText = 'Live';
        break;
      case 1:
        borderColor = Colors.blue[300];
        statusText = 'Confirmed';
        break;
      case 2:
        borderColor = Colors.amber[300];
        statusText = 'Waitlisted';
        break;
      case 3:
        borderColor = Colors.grey;
        statusText = 'Expired';
        break;
      case 4:
        borderColor = Colors.red[300];
        statusText = 'Cancelled';
        break;
      default:
    }

    return Card(
      child: DottedBorder(
        color: borderColor,
        dashPattern: [8, 4],
        strokeWidth: 2,
        padding: EdgeInsets.all(5),
        child: Column(children: <Widget>[
          Ink(
            child: ListTile(
                leading: Icon(
                  Icons.bookmark,
                  size: 36,
                ),
                title: Text(
                  this.shopName,
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(this.pincode),
                    Text(this.date),
                    Text(this.startTime)
                  ],
                )),
            color: borderColor,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Chip(
                    backgroundColor: Colors.grey[400],
                    label: Text(statusText),
                    padding: EdgeInsets.all(5),
                  ),
                ),
                ButtonTheme(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    onPressed: () async {
                      print("fetch token");
                      print(this.tokenId);
                      String signedToken = await UserService.getSignedTokenApiCall(this.tokenId).then((json){
                        return json["result"];
                      });
                      print(signedToken);
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => QrCodeScreen(message: signedToken)));

                    },
                    textColor: Colors.blue,
                    child: const Text('Download Token'),
                  ),
                ),
                ButtonTheme(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    onPressed: () {
                      // TODO: Book slot in the same shop again
                      bookAgain();
                    },
                    textColor: Colors.blue,
                    child: const Text('BOOK AGAIN'),
                  ),
                ),
              ]),
        ]),
      ),
    );
  }
}
