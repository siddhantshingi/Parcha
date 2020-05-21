// Must be included in a Constrained height environment
import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/request.dart';

class RequestAuth extends StatelessWidget {
  final Request request;
  final bool minimal;
  final bool resolved;

  RequestAuth({Key key, @required this.request, this.minimal: false, this.resolved: false})
      : super(key: key);

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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.request.shopName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                  Text(
                    this.request.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                      Icon(this.request.capacity != 0 ? Icons.people : Icons.timelapse, size: 14),
                      const Padding(padding: EdgeInsets.only(right: 2.0)),
                      Text(
                        this.request.capacity != 0
                            ? 'Capacity: ' + this.request.capacity.toString()
                            : '${stripSeconds(this.request.openingTime)} - ${stripSeconds(this.request.closingTime)}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    ]),
//                    Row(children: <Widget>[
//                      Icon(Icons.timelapse, size: 14),
//                      const Padding(padding: EdgeInsets.only(right: 2.0)),
//                      Text(
//                        '${stripSeconds(this.request.openingTime)} - ${stripSeconds(this.request.closingTime)}',
//                        style: const TextStyle(
//                          fontSize: 12.0,
//                          color: Colors.black54,
//                        ),
//                      ),
//                    ]),
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
