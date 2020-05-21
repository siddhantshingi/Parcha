import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/components/search_bar.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/shop_card.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/screens/authority_profile/shop_view.dart';

class MonitorShops extends StatelessWidget {
  final Authority user;
  final GlobalKey<TabNavigatorState> tn;

  MonitorShops({Key key, @required this.user, @required this.tn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXED: Call shop list API to get all shops in a pin code
    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<Shop> shops = [];
      for (var item in snapshot.data['result']) {
        shops.add(Shop.shopAuthFromJson(item));
      }
      return shops;
    };

    var filterSearchResults = (List<Shop> shops, String query) {
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
      SectionTitle(heading: 'Monitor and Track Shops'),
      AsyncBuilder(
        future: ShopService.getShopAuthApi(user),
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
                        child: InkWell(
                          splashColor: Colors.blueGrey[300],
                          onTap: () {
                            // View shop profile (from Authority view)
                            tn.currentState.push(
                              context,
                              payload: ShopProfile(user: user, shop: shopsToDisplay[index]),
                            );
                          },
                          child: SizedBox(
                            height: 80,
                            child: ShopCard(
                              shop: shopsToDisplay[index],
                              minimal: false,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        onReceiveJson: onReceiveJson,
      )
    ]);
  }
}
