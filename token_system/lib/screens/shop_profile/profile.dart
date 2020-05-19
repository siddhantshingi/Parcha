import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/components/profile.dart';

class ShopProfile extends StatelessWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  ShopProfile({Key key, @required this.shop, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      user: shop,
      tn: tn,
      userType: 1,
    );
  }
}
