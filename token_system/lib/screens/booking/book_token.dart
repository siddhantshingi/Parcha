import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:token_system/components/pull_refresh.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/shop_booking.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/token.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/Services/miscServices.dart';
import 'package:token_system/Services/tokenService.dart';

class BookScreen extends StatelessWidget {
  final Shop shop;
  final User user;
  final GlobalKey<TabNavigatorState> tn;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  BookScreen({Key key, @required this.user, @required this.tn, @required this.shop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIXED: Make API call to get the shop bookings

    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<ShopBooking> shopBookings = [];
      for (var item in snapshot.data['result']) {
        ShopBooking sb = ShopBooking.fromJson(item, shop.id);
        if (DateTime.now().isBefore(stampEnd(sb.date, sb.slotNumber))) {
          shopBookings.add(sb);
        }
      }
      return shopBookings;
    };

    return Scaffold(
      key: _scaffoldKey,
      body: Column(children: <Widget>[
        SectionTitle(heading: 'Confirm Token'),
        Text(
          shop.shopName,
          style: TextStyle(color: Colors.amber[800], fontSize: 24),
        ),
        Expanded(
          child: PullRefresh(
            futureFn: MiscService.getShopBookingsApi,
            args1: shop,
            builder: (bookings) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: bookings.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.confirmation_number),
                    title: Text(slotNumStartTime(bookings[index].slotNumber) +
                        "  " +
                        bookings[index].date.toString()),
                    subtitle: Text('Capacity \u{2192}   Left: ' +
                        bookings[index].capacityLeft.toString() +
                        '   Max: ' +
                        bookings[index].maxCapacity.toString()),
                    trailing: FlatButton.icon(
                      color: Color.fromARGB(255, 255, 69, 0),
                      onPressed: () async {
                        await showDialog<String>(
                          context: _scaffoldKey.currentContext,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm your booking at ' + shop.shopName),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      'Time: ' +
                                          slotNumStartTime(bookings[index].slotNumber) +
                                          ' - ' +
                                          slotNumEndTime(bookings[index].slotNumber),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text('Would you like to confirm this booking?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Confirm'),
                                  onPressed: () async {
                                    final status = await TokenService.bookTokenApi(Token(
                                            shopId: shop.id,
                                            shopName: shop.shopName,
                                            userId: user.id,
                                            userEmail: user.email,
                                            userName: user.name,
                                            date: bookings[index].date,
                                            slotNumber: bookings[index].slotNumber))
                                        .then((code) {
                                      // FIXED: Need a proper UI message.
                                      if (code == 200)
                                        return 'Confirmed';
                                      else if (code == 201)
                                        return 'Waitlisted';
                                      else if (code == 409)
                                        return 'Token already exists';
                                      else if (code == 404)
                                        return 'Slot does not exist';
                                      else
                                        return 'Server Error';
                                    });

                                    if (status != null) {
                                      final snackbar = SnackBar(
                                        content: Text('Status of booking: ' +
                                            status +
                                            '. Please check User History for further actions.'),
                                      );
                                      _scaffoldKey.currentState.showSnackBar(snackbar);
                                    }
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
                      icon: Icon(Icons.add_circle),
                      label: Text('Book'),
                    ),
                  );
                },
              );
            },
            onReceiveJson: onReceiveJson,
          ),
        )
      ]),
    );
  }
}
