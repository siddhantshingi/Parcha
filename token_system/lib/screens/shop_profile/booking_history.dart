import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/shop_booking.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/shop_booking_card.dart';
import 'package:token_system/Services/miscServices.dart';

enum ShopOptions { logout, editProfile }

class ShopHistory extends StatelessWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  ShopHistory({Key key, @required this.shop, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Make call to User History API

    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<ShopBooking> shopBookings = [];
      for (var item in snapshot.data['result']) {
        shopBookings.add(ShopBooking.fromJson(item, shop.id));
      }
      return shopBookings;
    };

    return Scaffold(
      body: AsyncBuilder(
        future: MiscService.getShopBookingsApi(shop),
        builder: (bookings) {
          return ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              itemCount: bookings.length,
              itemBuilder: (BuildContext context, int index) {
                return ShopBookingCard(
                    date: '${bookings[index].date}',
                    startTime: '${slotNumStartTime(bookings[index].slotNumber)}',
                    endTime: '${slotNumEndTime(bookings[index].slotNumber)}',
                    capacityLeft: bookings[index].capacityLeft,
                    tokensVerified: bookings[index].tokensVerified,
                    maxCapacity: bookings[index].maxCapacity);
              });
        },
        onReceiveJson: onReceiveJson,
    )
    );
  }
}
