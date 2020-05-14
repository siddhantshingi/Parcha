import 'package:flutter/material.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/shop_card.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/booking/book_token.dart';
//import '../shop_list.dart';

class ChooseShop extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;
  final String category;

  ChooseShop(
      {Key key,
      @required this.user,
      @required this.tn,
      @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Get shops list based on category
    var onReceiveJson = (snapshot) {
      // Construct List of Shops
      List<Shop> shops = [];
      for (var item in snapshot.data['result']) {
        shops.add(Shop.forUser(
            id: item['id'],
            name: item['name'],
            openTime: item['openTime'],
            closeTime: item['closeTime'],
            address: item['address'],
            landmark: item['landmark'],
            contactNumber: item['contactNumber'],
            pincode: item['pincode']));
      }
      return shops;
    };

    return AsyncBuilder(
      future: ShopService.getShopListApiCall(user, category),
      builder: (shops) {
        return Column(children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Choose Shop',
              style: TextStyle(
                fontSize: 20,
                color: Colors.amber,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              itemCount: shops.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: 100,
                    child: InkWell(
                      splashColor: Colors.blueGrey[300],
                      onTap: () {
                        // Confirm user booking
                        tn.currentState.push(
                          context,
                          payload:
                              BookScreen(user: user, tn: tn, shop: shops[index]),
                        );
                      },
                      child: ShopCard(shop: shops[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      },
      onReceiveJson: onReceiveJson,
    );
  }
}
