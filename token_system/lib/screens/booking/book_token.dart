import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/shop_booking.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/token.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/Services/miscServices.dart';
import 'package:token_system/Services/tokenService.dart';

class BookScreen extends StatelessWidget {
  final User user;
  final GlobalKey<TabNavigatorState> tn;
  final Shop shop;

  BookScreen({Key key, @required this.user, @required this.tn, @required this.shop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Make API call to get the shop bookings

    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<ShopBooking> shopBookings = [];
      for (var item in snapshot.data['result']) {
        shopBookings.add(ShopBooking.fromJson(item, shop.id));
      }
      return shopBookings;
    };

    return Column(children: <Widget>[
      SectionTitle(heading: 'Confirm Token'),
      Text(
        shop.name,
        style: TextStyle(color: Colors.amber[800], fontSize: 24),
      ),
      AsyncBuilder(
          future: MiscService.getShopBookingsApi(shop,
              date: DateTime.now().toString().substring(0, 11)),
          builder: (bookings) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: bookings.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.confirmation_number),
                  title: Text(slotNumStartTime(bookings[index].slotNumber)),
                  subtitle: Text('Capacity Left: ' + bookings[index].capacityLeft.toString()),
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
                                    'Time: ' +
                                        slotNumStartTime(bookings[index].startTime) +
                                        ' - ' +
                                        slotNumEndTime(bookings[index].startTime),
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
                                  TokenService.bookTokenApi(Token(shopId: shop.id,
                                      shopName: shop.shopName,
                                      userId: user.id,
                                      userEmail: user.email,
                                      userName: user.name,
                                      date: DateTime.now().toString().substring(0, 11),
                                      slotNumber: bookings[index].slotNumber)).then((code) {
                                        //TODO: Need a proper UI message.
                                    if (code == 200)
                                      print('Confirmed.');
                                    else if (code == 201)
                                      print ('Waitlist.');
                                    else if (code == 409)
                                      print('Token already exists!');
                                    else if (code == 412)
                                      print ('Slot does not exist');
                                    else
                                      print ('booking failed');
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text('Cancel'),
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
            );
          },
          onReceiveJson: onReceiveJson,
      )
    ]);
  }
}
