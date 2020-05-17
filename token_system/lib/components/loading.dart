import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final int size;

  Loading({Key key, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.toDouble(),
        width: size.toDouble(),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
