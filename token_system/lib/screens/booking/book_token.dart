import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/slots_list.dart';

class BookScreen extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;
  final Shop shop;

  BookScreen(
      {Key key, @required this.user, @required this.tn, @required this.shop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Make API call to get the shop bookings
    return Column(children: <Widget>[
      SectionTitle(heading: 'Confirm Token'),
      Text(
        shop.name,
        style: TextStyle(color: Colors.amber[800], fontSize: 24),
      ),
      ListView.builder(
        shrinkWrap: true,
        itemCount: slots.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.confirmation_number),
            title: Text(slots[index].startTime),
            subtitle:
                Text('Capacity Left: ' + slots[index].capacityLeft.toString()),
            trailing: FlatButton.icon(
              onPressed: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm your booking at ' + shop.name),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              'Time: ' + slots[index].startTime,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text('Would you like to confirm this booking?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Confirm'),
                          onPressed: () {
                            // TODO: Call confirmation API Call
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text('Reject'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.check),
              label: Text('Confirm'),
            ),
          );
        },
      ),
    ]);
  }
}
