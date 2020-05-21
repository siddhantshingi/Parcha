import 'package:flutter/material.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/request.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Services/requestService.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/request_card.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/utils.dart';

class ShopProfile extends StatelessWidget {
  final Authority user;
  final Shop shop;

  ShopProfile({Key key, @required this.user, @required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<Request> requests = [];
      for (var item in snapshot.data['result']) {
        requests.add(Request.shopRequestFromJson(item, shop.id));
      }
      return requests;
    };

    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SectionTitle(heading: 'Monitor and Track Shops'),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                shop.shopName,
                style: TextStyle(color: Colors.amber[800], fontSize: 24),
              ),
            ),
            Card(
              elevation: 8.0,
              child: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.account_circle),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(shop.ownerName == null ? 'NA' : shop.ownerName),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.phone),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(shop.mobileNumber),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.shopping_cart),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(shop.shopType),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.access_time),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(shop.openingTimeApp + ' - ' + shop.closingTimeApp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.people),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(shop.capacityApp.toString()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.location_on),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(shop.address == null ? 'NA' : shop.address),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Icon(Icons.location_city),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(shop.landmark == null ? 'NA' : shop.landmark),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Card(
              elevation: 8.0,
              child: Column(children: <Widget>[
                SectionTitle(heading: 'Requests from this shop'),
                AsyncBuilder(
                  future: RequestService.getShopRequestApi(shop),
                  builder: (requests) {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      physics: ClampingScrollPhysics(),
                      itemCount: requests.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RequestCard(
                          openingTime: '${stripSeconds(requests[index].openingTime)}',
                          closingTime: '${stripSeconds(requests[index].closingTime)}',
                          maxCapacity: requests[index].capacity,
                          timestamp: '${readableTimestamp(requests[index].createdAt)}',
                          status: requests[index].status,
                          authMobile: requests[index].authMobile,
                        );
                      },
                    );
                  },
                  onReceiveJson: onReceiveJson,
                ),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }
}
