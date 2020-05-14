import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Services/miscServices.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/booking/choose_shop.dart';

enum UserOptions { logout, editProfile }

class ChooseCategory extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;

  ChooseCategory({Key key, @required this.user, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXED: Call the Shop Categories API
    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<String> shopCategories = [];
      for (var item in snapshot.data['result']) {
        shopCategories.add(item['typeName']);
      }
      return shopCategories;
    };

    // Call FutureBuilder to get category list
    return AsyncBuilder(
      future: MiscService.getShopTypesApiCall(),
      builder: (shopCategories) {
        // Construct widget
        return Column(children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Choose Shop Category',
              style: TextStyle(
                fontSize: 20,
                color: Colors.amber,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2.75),
              itemCount: shopCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(2),
                  child: Card(
                    color: Colors.grey[200],
                    child: InkWell(
                      splashColor: Colors.blueGrey[300],
                      onTap: () {
                        // Call next screen
                        tn.currentState.push(
                          context,
                          payload: ChooseShop(
                            user: user,
                            tn: tn,
                            category: shopCategories[index],
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          shopCategories[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[800]),
                        ),
                      ),
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
