import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String openTime;
  final String closeTime;
  final int maxCapacity;
  final String duration;
  final String bufferTime;
  final int status;
  final String timestamp;

  RequestCard(
      {Key key,
        @required this.openTime,
        @required this.closeTime,
        @required this.maxCapacity,
        @required this.duration,
        @required this.bufferTime,
        @required this.status,
        @required this.timestamp,})
      : super(key: key);

  void setStatus (String date) {
    //TODO: Compare with current date to set status
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Make a call to get Shop Name and pincode from the shopId
    String shopName = 'SAD General Store';
    int pinCode = 226010;

    var borderColor;
    var statusText;
    var icon;
    switch (this.status) {
      case 0:
        borderColor = Colors.greenAccent;
        statusText = 'Accepted';
        icon = Icons.done_all;
        break;
      case 1:
        borderColor = Colors.lightBlue[100];
        statusText = 'Rejected';
        icon = Icons.do_not_disturb_alt;
        break;
      case 2:
        borderColor = Colors.amber[300];
        statusText = 'Pending';
        icon = Icons.done;
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
                  icon,
                  size: 48,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Timings:  ' + openTime + ' - ' + closeTime,
                      style: TextStyle(fontSize: 18),
                    ),
//                    Text(
//                      'Close: ' + closeTime,
//                      style: TextStyle(fontSize: 18),
//                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[Text('Duration: '), Text('Buffer: ')],
                    ),
                    Column(
                        children: <Widget>[Text(this.duration), Text(this.bufferTime)],
                    ),
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
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Chip(
                    backgroundColor: Colors.grey[400],
                    label: Text(timestamp),
                    padding: EdgeInsets.all(5),
                  ),
                ),
              ]
          ),
        ]),
      ),
    );
  }
}
