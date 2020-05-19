import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';

class ShopBookingCard extends StatelessWidget {
  final String date;
  final String startTime;
  final String endTime;
  final int capacityLeft;
  final int tokensVerified;
  final int maxCapacity;

  ShopBookingCard(
      {Key key,
        @required this.date,
        @required this.startTime,
        @required this.endTime,
        @required this.capacityLeft,
        @required this.tokensVerified,
        @required this.maxCapacity,
      })
      : super(key: key);

  int status (String date, String startTime, String endTime) {
    DateTime _from = stamp(date, startTime);
    DateTime _to = stamp(date, endTime);
    DateTime _now = DateTime.now();

    if (_now.isBefore(_from))
      return 2;
    else if (_now.isAfter(_to))
      return 1;
    else
      return 0;

  }

  @override
  Widget build(BuildContext context) {

    var borderColor;
    var statusText;
    switch (status(date, startTime, endTime)) {
      case 0:
        borderColor = Colors.greenAccent;
        statusText = 'Live';
        break;
      case 1:
        borderColor = Colors.lightBlue[100];
        statusText = 'Past';
        break;
      case 2:
        borderColor = Colors.amber[300];
        statusText = 'Future';
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Bookings: ' + (maxCapacity - capacityLeft).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Verified: ' + (tokensVerified).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(this.date),
                    Text(this.startTime),
                    Text(this.endTime),
                  ],
                )),
            color: borderColor,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Chip(
                  backgroundColor: Colors.grey[400],
                  label: Text(statusText),
                  padding: EdgeInsets.all(5),
                ),
              )
          ),
        ]),
      ),
    );
  }
}
