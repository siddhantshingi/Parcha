import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/shop_booking.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/shop_booking_card.dart';

class ShopHistory extends StatelessWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;
  final List<ShopBooking> bookings;

  ShopHistory({Key key, @required this.shop, @required this.tn, @required this.bookings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          maxCapacity: bookings[index].maxCapacity,
        );
      },
    );
  }
}
