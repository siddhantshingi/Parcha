import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String heading;

  SectionTitle({Key key, @required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(
          this.heading,
          style: TextStyle(
              fontSize: 18,
              color: Colors.blueGrey[800]),
        ),
      ),
    );
  }
}
