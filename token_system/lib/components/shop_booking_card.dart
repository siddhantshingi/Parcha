import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ShopBookingCard extends StatelessWidget {
  final String date;
  final String startTime;
  final String duration;
  final int capacityLeft;
  final int tokensVerified;
  final int maxCapacity;
  final int status;

  ShopBookingCard(
      {Key key,
        @required this.date,
        @required this.startTime,
        @required this.duration,
        @required this.capacityLeft,
        @required this.tokensVerified,
        @required this.maxCapacity,
        this.status})
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
    switch (this.status) {
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
                  size: 48,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Bookings: ' + (maxCapacity - capacityLeft).toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Verified: ' + (tokensVerified).toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(this.date),
                    Text(this.startTime),
                    Text(this.duration),
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
