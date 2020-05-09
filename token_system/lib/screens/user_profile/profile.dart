import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;

  ProfileScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome! " + name),
    );
  }
}
