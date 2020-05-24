import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/shop_booking.dart';
import 'package:token_system/Services/miscServices.dart';
import 'package:token_system/components/pull_refresh.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/shop_profile/booking_history.dart';
import 'package:token_system/utils.dart';

class ShopTabs extends StatelessWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  ShopTabs({Key key, @required this.shop, @required this.tn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onReceiveJson = (snapshot) {
      // Construct List of Bookings
      List<ShopBooking> upcomingBookings = [];
      List<ShopBooking> pastBookings = [];
      for (var item in snapshot.data['result']) {
        ShopBooking sb = ShopBooking.fromJson(item, shop.id);
        if (DateTime.now().isBefore(stampEnd(sb.date, sb.slotNumber))) {
          upcomingBookings.add(sb);
        } else {
          pastBookings.add(sb);
        }
      }

      // Sort list in order: Live > Future > Past
      upcomingBookings.sort((sb1, sb2) =>
          stampEnd(sb1.date, sb1.slotNumber).compareTo(stampEnd(sb2.date, sb2.slotNumber)));
      pastBookings.sort((sb1, sb2) =>
          stampEnd(sb2.date, sb2.slotNumber).compareTo(stampEnd(sb1.date, sb1.slotNumber)));

      Map<String, List<ShopBooking>> shopBookings = new Map();
      shopBookings['upcoming'] = upcomingBookings;
      shopBookings['past'] = pastBookings;
      return shopBookings;
    };

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            TabBar(labelColor: Colors.blueGrey, tabs: [
              Tab(icon: Icon(Icons.new_releases)),
              Tab(icon: Icon(Icons.history)),
            ]),
            Expanded(
              flex: 1,
              child: TabBarView(children: [
                PullRefresh(
                  futureFn: MiscService.getShopBookingsApi,
                  args1: shop,
                  builder: (bookings) =>
                      ShopHistory(shop: shop, tn: tn, bookings: bookings['upcoming']),
                  onReceiveJson: onReceiveJson,
                ),
                PullRefresh(
                  futureFn: MiscService.getShopBookingsApi,
                  args1: shop,
                  builder: (bookings) =>
                      ShopHistory(shop: shop, tn: tn, bookings: bookings['past']),
                  onReceiveJson: onReceiveJson,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
