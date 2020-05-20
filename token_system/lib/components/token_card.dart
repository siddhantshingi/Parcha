import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:token_system/Services/tokenService.dart';
import 'package:token_system/screens/user_profile/qr_code_display.dart';

class TokenCard extends StatelessWidget {
  final String shopName;
  final String date;
  final String startTime;
  final String endTime;
  final String createdAt;
  final int status;
  final int verified;
  final int tokenId;
  final DateTime start;
  final DateTime end;
  final VoidCallback bookAgain;

  TokenCard({Key key,
    @required this.shopName,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    @required this.createdAt,
    @required this.status,
    @required this.verified,
    @required this.tokenId,
    @required this.start,
    @required this.end,
    @required this.bookAgain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderColor;
    var statusText;
    switch (this.status) {
      case 0:
        borderColor = Colors.grey;
        statusText = 'Cancelled';
        break;
      case 1:
        borderColor = Colors.greenAccent;
        statusText = 'Confirmed';
        break;
      case 2:
        borderColor = Colors.amber[300];
        statusText = 'Waitlisted';
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text(this.date), Text(this.startTime), Text(this.endTime)],
                )),
            color: borderColor,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
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
                  print(this.tokenId);
                  String signedToken =
                  await TokenService.getSignedTokenApiCall(this.tokenId).then((json) {
                    print (json);
                    return json['result'];
                  });
                  print(signedToken);
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QrCodeScreen(message: signedToken)));
                },
                textColor: Colors.green,
                child: const Text('QR CODE'),
              ),
            ),
            Visibility(
              child: ButtonTheme(
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
              visible: !((status == 0) || (DateTime.now().isAfter(end))),
            ),
            Visibility(
              child: ButtonTheme(
                padding: EdgeInsets.all(10),
                child: FlatButton(
                  onPressed: () {
                    // TODO: Cancel this token and redraw this card only.
                  },
                  textColor: Colors.redAccent,
                  child: const Text('CANCEL'),
                ),
              ),
              visible: (status == 0) || (DateTime.now().isAfter(end)),
            ),
          ]),
        ]),
      ),
    );
  }
}
