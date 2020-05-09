import 'package:flutter/material.dart';
import './screens/login.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    routes: {
      '/login': (context) => Login(),
    },
  ));
}
