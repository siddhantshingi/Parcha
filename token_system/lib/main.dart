import 'package:flutter/material.dart';
import 'package:token_system/screens/login.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    routes: {
      '/login': (context) => Login(),
    },
  ));
}
