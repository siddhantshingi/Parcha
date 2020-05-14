import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;

  ShopCard({Key key, @required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.shop.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                this.shop.address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(children: <Widget>[
                Icon(Icons.phone, size: 14),
                const Padding(padding: EdgeInsets.only(right: 2.0)),
                Text(
                  this.shop.contactNumber,
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
                  '${this.shop.openTime} - ${this.shop.closeTime}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ]),
            ],
          ),
        ]);
  }
}
