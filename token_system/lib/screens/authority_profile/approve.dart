import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/components/shop_card.dart';
import 'package:token_system/components/tab_navigator.dart';
import '../shop_list.dart';

class ApproveScreen extends StatelessWidget {
  final Authority user;
  final GlobalKey<TabNavigatorState> tn;

  ApproveScreen({Key key, @required this.user, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Call API to get shop listings for approval
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Approve Shops',
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
              return Card(
                borderOnForeground: true,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.pink),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ShopCard(shop: shops[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Chip(
                          label: Text(shops[index].shopType.toString()),
                          padding: EdgeInsets.all(5),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ButtonTheme(
                            padding: EdgeInsets.all(10),
                            child: FlatButton(
                              onPressed: () {
                                // TODO: Reject shop authorization request
                              },
                              textColor: Colors.red,
                              child: const Text('REJECT'),
                            ),
                          ),
                          ButtonTheme(
                            padding: EdgeInsets.all(10),
                            child: FlatButton(
                              onPressed: () {
                                // TODO: Validate shop
                              },
                              textColor: Colors.blue,
                              child: const Text('AUTHORIZE'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              );
            }),
      ),
    ]);
  }
}
