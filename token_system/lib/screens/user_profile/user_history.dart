import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/token.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/Services/tokenService.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/token_card.dart';
import 'package:token_system/screens/booking/book_token.dart';

enum UserOptions { logout, editProfile }

class UserHistory extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;

  UserHistory({Key key, @required this.user, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXED: Make call to User History API
    var onReceiveJson = (snapshot) {
      // Construct list of tokens
      List<Token> tokens = [];
      for (var item in snapshot.data['result']) {
        tokens.add(Token.getFromJson(item));
      }
      tokens.sort((a, b) => a.status.compareTo(b.status));
      return tokens;
    };

    return Column(children: <Widget>[
      SectionTitle(heading: 'Token History'),
      Expanded(
          child: AsyncBuilder(
          future: TokenService.getTokenApi(user),
          builder: (tokens) {
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              itemCount: tokens.length,
              itemBuilder: (BuildContext context, int index) {
                VoidCallback bookAgain = () {
                  var onReceiveJson = (snapshot) {
                    return Shop.shopUserFromJson(snapshot.data['result'][0]);
                  };
                  tn.currentState.push(
                    context,
                    payload: AsyncBuilder(
                      future:
                          ShopService.getShopUserApi(user, id: tokens[index].shopId),
                      builder: (shop) {
                        return BookScreen(user: user, tn: tn, shop: shop);
                      },
                      onReceiveJson: onReceiveJson,
                    ),
                  );
                };
              return TokenCard(
                  shopName: tokens[index].shopName,
                  date: '${readableDate(tokens[index].date)}',
                  startTime: '${slotNumStartTime(tokens[index].slotNumber)}',
                  endTime: '${slotNumEndTime(tokens[index].slotNumber)}',
                  createdAt: '${readableTimestamp(tokens[index].createdAt)}',
                  status: tokens[index].status,
                  verified: tokens[index].verified,
                  tokenId: tokens[index].id,
                  start: stampStart(tokens[index].date, tokens[index].slotNumber),
                  end: stampEnd(tokens[index].date, tokens[index].slotNumber),
                  bookAgain: bookAgain
              );
            },
          );
        },
        onReceiveJson: onReceiveJson,
      ))
    ]);
  }
}
