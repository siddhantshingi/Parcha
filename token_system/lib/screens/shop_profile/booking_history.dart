import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop_booking.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/shop_booking_card.dart';

enum ShopOptions { logout, editProfile }

class ShopHistory extends StatelessWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  ShopHistory({Key key, @required this.shop, @required this.tn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Make call to User History API
    List<ShopBooking> bookings = [
      ShopBooking(shopId: 0, date: '12 May', startTime: '11:00', duration: '15 mins', capacityLeft: 0, tokensVerified: 5),
      ShopBooking(shopId: 0, date: '12 May', startTime: '13:00', duration: '15 mins', capacityLeft: 0, tokensVerified: 5),
      ShopBooking(shopId: 0, date: '13 May', startTime: '14:00', duration: '30 mins', capacityLeft: 2, tokensVerified: 7),
      ShopBooking(shopId: 0, date: '13 May', startTime: '15:00', duration: '30 mins', capacityLeft: 3, tokensVerified: 7),
      ShopBooking(shopId: 0, date: '14 May', startTime: '15:30', duration: '30 mins', capacityLeft: 1, tokensVerified: 13),
      ShopBooking(shopId: 0, date: '14 May', startTime: '10:30', duration: '30 mins', capacityLeft: 3, tokensVerified: 10),
    ];

    List<int> statuses = [1, 1, 0, 2, 2, 2];
    List<int> capacities = [5, 5, 10, 10, 15, 15];

    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          itemCount: bookings.length,
          itemBuilder: (BuildContext context, int index) {
            return ShopBookingCard(
                date: '${bookings[index].date}',
                startTime: '${bookings[index].startTime}',
                duration: '${bookings[index].duration}',
                capacityLeft: bookings[index].capacityLeft,
                tokensVerified: bookings[index].tokensVerified,
                maxCapacity: capacities[index],
                status: statuses[index]);
          }),
    );
  }
}
