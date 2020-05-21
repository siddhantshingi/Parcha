import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/authority_profile/approve.dart';
import 'package:token_system/screens/authority_profile/auth_history.dart';

class AuthorityTabs extends StatelessWidget {
  final Authority user;
  final GlobalKey<TabNavigatorState> tn;

  AuthorityTabs({Key key, @required this.user, @required this.tn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(children: <Widget>[
          TabBar(labelColor: Colors.blueGrey, tabs: [
            Tab(icon: Icon(Icons.new_releases)),
            Tab(icon: Icon(Icons.history)),
          ]),
          Expanded(
            flex: 1,
            child: TabBarView(children: [
              ApproveScreen(user: user, tn: tn),
              RequestHistory(user: user, tn: tn),
            ]),
          )
        ]),
      ),
    );
  }
}
