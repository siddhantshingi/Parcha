import 'package:flutter/material.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/request.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/request_card.dart';

enum RequestOptions { small, medium, large }

class RequestScreen extends StatefulWidget {
  final Shop shop;
  final GlobalKey<TabNavigatorState> tn;

  RequestScreen({Key key, @required this.shop, @required this.tn})
      : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

//class _DoubleConv extends RangeValues {
//
//}

class _RequestState extends State<RequestScreen> {
  int _startHour = 10;
  String _startMinutes = '00';
  String _startMeridian = 'AM';
  int _endHour = 16;
  String _endMinutes = '00';
  String _endMeridian = 'PM';
  RangeValues _timings = RangeValues(6.0, 22.0);
  RequestOptions _category;

  @override
  Widget build(BuildContext context) {

    List<Request> requests = [
      Request(shopId: 0, openTime: '11:00', closeTime: '16:00', maxCapacity: 5, duration: '15 mins', bufferTime: '5 mins', status: 0, timestamp: '14 May'),
      Request(shopId: 0, openTime: '11:00', closeTime: '18:00', maxCapacity: 5, duration: '15 mins', bufferTime: '5 mins', status: 1, timestamp: '14 May'),
      Request(shopId: 0, openTime: '11:00', closeTime: '18:00', maxCapacity: 10, duration: '30 mins', bufferTime: '10 mins', status: 1, timestamp: '15 May'),
      Request(shopId: 0, openTime: '11:00', closeTime: '20:00', maxCapacity: 15, duration: '30 mins', bufferTime: '10 mins', status: 2, timestamp: '15 May'),
    ];

    var _color = [Colors.cyan[700], Colors.cyan[800], Colors.cyan[900], Colors.cyan[900], Colors.cyan[800], Colors.cyan[700]];
    var _stops = [0.01, 0.03, 0.07, 0.93, 0.97, 0.99];

    return Column(children: <Widget>[
      Expanded(
        flex: 4,
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Column (
              children: <Widget> [
                Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical (
                        top: Radius.elliptical(10.0, 6.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _color,
                        stops: _stops,
                      ),
                    ),
                    child: Text (
                      'Request',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.5),
                    )
                  )
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient (
                      colors: _color,
                      stops: _stops,
                      begin : Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only (
                      topRight: Radius.elliptical(10.0, 6.0),
                    )
                  ),
                  child: Row (
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
                                }
                            ),
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
                                }
                            ),
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
                                }
                            ),
                            Text('Large', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ]
                    ),
                ),
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
                        if (newValue.end - _endHour > 0.4)
                          _endMinutes = '30';

                        if (_endHour > 11) {
                          _endMeridian = 'PM';
                          if (_endHour > 12)
                            _endHour -= 12;
                        }
                        else
                          _endMeridian = 'AM';

                        if (_startHour > 11) {
                          _startMeridian = 'PM';
                          if (_startHour > 12)
                            _startHour -= 12;
                        }
                        else
                          _startMeridian = 'AM';

                      });
                      },
                  )
                ),
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
                    ),
                  ),
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10),
                        child: Row (
                          children: <Widget> [
                            Text(
                            'Opening Time: ',
                              style: TextStyle(fontSize: 20, color: Color(0xE1FFFFFF))
                            ),
                            Text(
                                _startHour.toString() + ':' + _startMinutes + ' ' + _startMeridian,
                                style: TextStyle(fontSize: 20, color: Colors.white70)
                            ),
                          ]
                        )
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Row (
                              children: <Widget> [
                                Text(
                                    'Closing Time: ',
                                    style: TextStyle(fontSize: 20, color: Color(0xE1FFFFFF))
                                ),
                                Text(
                                    _endHour.toString() + ':' + _endMinutes + ' ' + _endMeridian,
                                    style: TextStyle(fontSize: 20, color: Colors.white70)
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.vertical (
                            bottom: Radius.elliptical(10.0, 6.0),
                          ),
                        ),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          textColor: Colors.white,
                          color: Colors.transparent,
                          child: Text(
                            'Submit Request',
                            style: TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 1.0),
                        ),
                          onPressed: () {},
                      )
                  )
                ),
              ],
            ),
          )
        ),
      Divider(height: 10.0, color: Colors.blueGrey, indent: 20, endIndent: 20,),
      Expanded(
        flex: 6,
        child: Container(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              return RequestCard(
              openTime: '${requests[index].openTime}',
              closeTime: '${requests[index].closeTime}',
              maxCapacity: requests[index].maxCapacity,
              duration: '${requests[index].duration}',
              bufferTime: '${requests[index].bufferTime}',
              status: requests[index].status,
              timestamp: '${requests[index].timestamp}'
              );
            }
          )
        )
      )
    ]);
  }
}
