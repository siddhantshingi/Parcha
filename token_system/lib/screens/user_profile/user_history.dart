import 'package:flutter/material.dart';
import 'package:token_system/Entities/token.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/token_card.dart';

enum UserOptions { logout, editProfile }

class UserHistory extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;

  UserHistory({Key key, @required this.user, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Make call to User History API
    List<Token> tokens = [
      Token.basic(tokenId: 0, date: '11 May', startTime: '11:00', status: 0),
      Token.basic(tokenId: 1, date: '11 May', startTime: '13:00', status: 1),
      Token.basic(tokenId: 2, date: '11 May', startTime: '14:00', status: 2),
      Token.basic(tokenId: 2, date: '11 May', startTime: '15:00', status: 1),
      Token.basic(tokenId: 2, date: '11 May', startTime: '15:30', status: 4),
      Token.basic(tokenId: 2, date: '11 May', startTime: '10:30', status: 3),
    ];

    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          itemCount: tokens.length,
          itemBuilder: (BuildContext context, int index) {
            return TokenCard(
                date: '${tokens[index].date}',
                startTime: '${tokens[index].startTime}',
                shopId: tokens[index].shopId,
                status: tokens[index].status);
          }),
    );
  }
}
