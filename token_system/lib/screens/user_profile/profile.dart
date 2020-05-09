import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final int val;

  ProfileScreen({Key key, @required this.val}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("You are here: " + val.toString()),
    );
  }
}
