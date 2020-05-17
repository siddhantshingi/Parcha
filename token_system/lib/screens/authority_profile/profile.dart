import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/components/profile.dart';

class AuthProfile extends StatelessWidget {
  final Authority user;
  final GlobalKey<TabNavigatorState> tn;

  AuthProfile({Key key, @required this.user, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      user: user,
      tn: tn,
      userType: 2,
    );
  }
}
