import 'package:flutter/material.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/shop_card.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/booking/book_token.dart';

class ChooseShop extends StatefulWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;
  final String category;

  ChooseShop({Key key, @required this.user, @required this.tn, @required this.category})
      : super(key: key);

  @override
  _ChooseShopState createState() => _ChooseShopState();
}

class _ChooseShopState extends State<ChooseShop> {
  TextEditingController editingController = TextEditingController();
  List<Shop> shops = [];
  List<Shop> shopsToDisplay = [];
  bool firstBuild = true;

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Shop> dummyListData = [];
      shops.forEach((item) {
        if (item.shopName.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        shopsToDisplay.clear();
        shopsToDisplay.addAll(dummyListData);
      });
    } else {
      setState(() {
        shopsToDisplay.clear();
        shopsToDisplay.addAll(shops);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // FIXED: Get shops list based on category
    var onReceiveJson = (snapshot) {
      // Construct List of Shops
      List<Shop> localShops = [];
      for (var item in snapshot.data['result']) {
        localShops.add(Shop.shopUserFromJson(item));
      }

      shops.clear();
      shops.addAll(localShops);

      // Load shopsToDisplay only if built for the first time.
      if (firstBuild) {
        shopsToDisplay.clear();
        shopsToDisplay.addAll(localShops);
        firstBuild = false;
      }

      return localShops;
    };

    return Column(children: <Widget>[
      SectionTitle(heading: 'Choose Shop'),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: editingController,
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            contentPadding: EdgeInsets.all(2.0),
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
      Expanded(
        child: AsyncBuilder(
          future: ShopService.getShopUserApi(widget.user, shopType: widget.category),
          builder: (returnVal) {
            return ListView.builder(
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
                        widget.tn.currentState.push(
                          context,
                          payload: BookScreen(
                              user: widget.user, tn: widget.tn, shop: shopsToDisplay[index]),
                        );
                      },
                      child: ShopCard(shop: shopsToDisplay[index]),
                    ),
                  ),
                );
              },
            );
          },
          onReceiveJson: onReceiveJson,
        ),
      ),
    ]);
  }
}
