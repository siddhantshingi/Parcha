import 'package:flutter/material.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/search_bar.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/shop_card.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/booking/book_token.dart';

class ChooseShop extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;
  final String category;

  ChooseShop({Key key, @required this.user, @required this.tn, @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXED: Get shops list based on category
    var onReceiveJson = (snapshot) {
      // Construct List of Shops
      List<Shop> shops = [];
      for (var item in snapshot.data['result']) {
        shops.add(Shop.shopUserFromJson(item));
      }

      return shops;
    };

    // Filter results using this function
    var filterSearchResults = (List<Shop> shops, String query) {
      print('In filter search');
      if (query.isNotEmpty) {
        List<Shop> shopsToDisplay = [];
        shops.forEach((item) {
          if (item.shopName.contains(query)) {
            shopsToDisplay.add(item);
          }
        });

        return shopsToDisplay;
      }
      return shops;
    };

    return Column(children: <Widget>[
      SectionTitle(heading: 'Choose Shop'),
      AsyncBuilder(
        future: ShopService.getShopUserApi(user, shopType: category),
        builder: (allShops) {
          return Expanded(
              child: SearchBar(
            filterSearch: filterSearchResults,
            totalItems: allShops,
            builder: (shopsToDisplay) {
              return Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  itemCount: shopsToDisplay.length,
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
                              payload: BookScreen(user: user, tn: tn, shop: shopsToDisplay[index]),
                            );
                          },
                          child: ShopCard(shop: shopsToDisplay[index]),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ));
        },
        onReceiveJson: onReceiveJson,
      ),
    ]);
  }
}
