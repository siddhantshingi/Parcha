// Must be included in a Constrained height environment
import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/shop.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;
  final bool minimal;

  ShopCard({Key key, @required this.shop, this.minimal : false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: const BoxDecoration(color: Colors.pink),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 2, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        shop.shopName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                      Text(
                        shop.address,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !this.minimal,
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(Icons.phone, size: 14),
                          const Padding(padding: EdgeInsets.only(right: 2.0)),
                          Text(
                            shop.mobileNumber,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black87,
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Icon(Icons.timelapse, size: 14),
                          const Padding(padding: EdgeInsets.only(right: 2.0)),
                          Text(
                            '${stripSeconds(shop.currOpeningTime ?? shop.openingTimeApp)} - ${stripSeconds(shop.currClosingTime ?? shop.closingTimeApp)}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      )
    ]);
  }
}
