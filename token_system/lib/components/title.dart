import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  static const String _title = 'Parcha';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        _title,
        style: TextStyle(
            color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 30),
      ),
    );
  }
}
