import 'package:flutter/material.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/components/profile.dart';

class UserProfile extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;

  UserProfile({Key key, @required this.user, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      tn: tn,
      user: user,
      userType: 0,
    );
  }
}
