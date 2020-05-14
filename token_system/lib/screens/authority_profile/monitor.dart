import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/screens/shop_list.dart';

class MonitorShops extends StatelessWidget {
  final Authority user;

  MonitorShops({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Call shop list API to get all shops in a pin code
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 100,
                child: ExpansionTile(
                  title: Text(
                    shops[index].name,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(shops[index].pincode.toString()),
                        Text(shops[index].shopType.toString()),
                        Text(shops[index].contactNumber)
                      ]),
                  children: <Widget>[
                    // TODO: Update with shop bookings graph
                    Text('Content to show when the Tile expands'),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
