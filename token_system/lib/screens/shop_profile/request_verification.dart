import 'package:flutter/material.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/request.dart';
import 'package:token_system/Services/requestService.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/request_card.dart';

enum RequestOptions { small, medium, large }
const Map<RequestOptions, int> mapRequestOptions = {
  RequestOptions.small: 5,
  RequestOptions.medium: 10,
  RequestOptions.large: 15
};

class RequestScreen extends StatefulWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  RequestScreen({Key key, @required this.shop, @required this.tn})
      : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<RequestScreen> {
  int _startHour = 10;
  String _startMinutes = '00';
  String _startMeridian = 'AM';
  int _endHour = 16;
  String _endMinutes = '00';
  String _endMeridian = 'PM';
  RangeValues _timings = RangeValues(10.0, 16.0);
  RequestOptions _category;

  @override
  Widget build(BuildContext context) {
    var _color = [
      Colors.blueGrey[600],
      Colors.blueGrey[700],
      Colors.blueGrey[800],
      Colors.blueGrey[800],
      Colors.blueGrey[700],
      Colors.blueGrey[600]
    ];
    var _stops = [0.01, 0.03, 0.07, 0.93, 0.97, 0.99];
    String convertFormat(int hours, String minutes, String meridian) {
      if (meridian == 'PM') {
        return (hours + 12).toString() + ":" + minutes + ":00";
      } else {
        return hours.toString() + ":" + minutes + ":00";
      }
    }

    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<Request> requests = [];
      for (var item in snapshot.data['result']) {
        requests.add(Request.shopRequestFromJson(item, widget.shop.id));
      }
      return requests;
    };

    return ListView(shrinkWrap: true, children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: <Widget>[
            SectionTitle(heading: 'Make New Request'),
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _color,
                      stops: _stops,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(10.0, 6.0),
                      topRight: Radius.elliptical(10.0, 6.0),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio<RequestOptions>(
                            value: RequestOptions.small,
                            groupValue: _category,
                            activeColor: Colors.orange,
                            hoverColor: Colors.deepOrange,
                            onChanged: (RequestOptions value) {
                              setState(() {
                                _category = value;
                              });
                            }),
                        Text('Small', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<RequestOptions>(
                            value: RequestOptions.medium,
                            groupValue: _category,
                            activeColor: Colors.orange,
                            hoverColor: Colors.deepOrange,
                            onChanged: (RequestOptions value) {
                              setState(() {
                                _category = value;
                              });
                            }),
                        Text('Medium', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<RequestOptions>(
                            value: RequestOptions.large,
                            groupValue: _category,
                            activeColor: Colors.orange,
                            hoverColor: Colors.deepOrange,
                            onChanged: (RequestOptions value) {
                              setState(() {
                                _category = value;
                              });
                            }),
                        Text('Large', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _color,
                    stops: _stops,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: RangeSlider(
                  labels: RangeLabels('Open', 'Close'),
                  divisions: 32,
                  values: _timings,
                  min: 6.0,
                  max: 22.0,
                  inactiveColor: Colors.white10,
                  activeColor: Colors.orange,
                  onChanged: (RangeValues newValue) {
                    setState(() {
                      _timings = newValue;
                      _startHour = newValue.start.floor();
                      _endHour = newValue.end.floor();

                      _startMinutes = '00';
                      _endMinutes = '00';

                      if (newValue.start - _startHour > 0.4)
                        _startMinutes = '30';
                      if (newValue.end - _endHour > 0.4) _endMinutes = '30';

                      if (_endHour > 11) {
                        _endMeridian = 'PM';
                        if (_endHour > 12) _endHour -= 12;
                      } else
                        _endMeridian = 'AM';

                      if (_startHour > 11) {
                        _startMeridian = 'PM';
                        if (_startHour > 12) _startHour -= 12;
                      } else
                        _startMeridian = 'AM';
                    });
                  },
                )),
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _color,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: _stops,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(10.0, 6.0),
                    bottomRight: Radius.elliptical(10.0, 6.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            child: Row(children: <Widget>[
                              Text('Opening Time: ',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xE1FFFFFF))),
                              Text(
                                  _startHour.toString() +
                                      ':' +
                                      _startMinutes +
                                      ' ' +
                                      _startMeridian,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70)),
                            ])),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Row(children: <Widget>[
                              Text('Closing Time: ',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xE1FFFFFF))),
                              Text(
                                  _endHour.toString() +
                                      ':' +
                                      _endMinutes +
                                      ' ' +
                                      _endMeridian,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70)),
                            ])),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        padding: EdgeInsets.all(10),
                        textColor: Colors.white,
                        color: Colors.transparent,
                        child: Text(
                          'Submit Request',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              letterSpacing: 1.0),
                        ),
                        onPressed: () {
                          if (_category == null) {
                            final snackbar = SnackBar(
                              content: Text('Please Select a Slotting Style'),
                            );
                            Scaffold.of(context).showSnackBar(snackbar);
                          } else {
                            Request newRequest = new Request(
                                shopId: widget.shop.id,
                                shopName: widget.shop.name,
                                address: widget.shop.address,
                                pincode: widget.shop.pincode,
                                openingTime: convertFormat(
                                    _startHour, _startMinutes, _startMeridian),
                                closingTime: convertFormat(
                                    _endHour, _endMinutes, _endMeridian),
                                capacity: mapRequestOptions[_category]);
                            RequestService.createRequestApi(newRequest)
                                .then((code) {
                              if (code == 200) {
                                final snackbar = SnackBar(
                                  content:
                                      Text('Request Registration successful!'),
                                );
                                Scaffold.of(context).showSnackBar(snackbar);
//                                // Pop screen if successful
//                                Future.delayed(Duration(seconds: 2), () {
//                                  Navigator.pop(context);
//                                });
                              } else if (code == 409) {
                                final snackbar = SnackBar(
                                  content: Text(
                                      'You already have this approved'),
                                );
                                Scaffold.of(context).showSnackBar(snackbar);
                              } else {
                                final snackbar = SnackBar(
                                  content: Text(
                                      'Registration not successful. Please try again!'),
                                );
                                Scaffold.of(context).showSnackBar(snackbar);
                              }
                            });
                          }
                        },
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
      Divider(
        height: 10.0,
        color: Colors.blueGrey,
        indent: 20,
        endIndent: 20,
      ),
      Container(
        child: Column(children: <Widget>[
          SectionTitle(heading: 'Submitted Requests'),
          AsyncBuilder(
            future: RequestService.getShopRequestApi(widget.shop),
            builder:  (requests) {
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
                      authMobile: requests[index].authMobile);
                }
            );
          },
          onReceiveJson: onReceiveJson,
          ),
        ]),
      )
    ]);
  }
}
