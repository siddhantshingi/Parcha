import 'package:flutter/material.dart';
import 'package:token_system/components/search_bar.dart';
import 'package:token_system/components/section_title.dart';
import 'package:token_system/utils.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/request.dart';
import 'package:token_system/components/request_card_auth.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/Services/requestService.dart';

class RequestHistory extends StatelessWidget {
  final Authority user;
  final GlobalKey<TabNavigatorState> tn;

  RequestHistory({Key key, @required this.user, @required this.tn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<Request> requests = [];
      if (snapshot.data['statusCode'] == 200) {
        for (var item in snapshot.data['result']) {
          requests.add(Request.authRequestFromJson(item));
        }
      }
      return requests;
    };

    var filterSearchResults = (List<Request> requests, String query) {
      if (query.isNotEmpty) {
        List<Request> requestsToDisplay = [];
        requests.forEach((item) {
          if (item.shopName.toLowerCase().contains(query.toLowerCase())) {
            requestsToDisplay.add(item);
          }
        });
        return requestsToDisplay;
      }
      return requests;
    };

    var statusText = (int status) {
      if (status == 1) {
        return 'Accepted';
      }
      return 'Rejected';
    };

    // FIXED: Call API to get shop listings for approval
    return Column(children: <Widget>[
      SectionTitle(heading: 'Past Requests'),
      AsyncBuilder(
        future: RequestService.getAuthRequestApi(user),
        builder: (allRequests) {
          return Expanded(
            child: SearchBar(
              filterSearch: filterSearchResults,
              totalItems: allRequests,
              builder: (requests) {
                return Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    itemCount: requests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        borderOnForeground: true,
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 80,
                            child: RequestAuth(
                              request: requests[index],
                              minimal: false,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Chip(
                                      label: Text(readableTimestamp(requests[index].createdAt)),
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Chip(
                                      label: Text(statusText(requests[index].status)),
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Visibility(
                                    visible: requests[index].status == 1,
                                    child: ButtonTheme(
                                      padding: EdgeInsets.all(10),
                                      child: FlatButton(
                                        onPressed: () {
                                          RequestService.resolveRequestApi(requests[index], user, 0)
                                              .then((code) {
                                            // TODO: Need to add a proper message on UI.
                                            if (code == 200)
                                              print('Rejected.');
                                            else if (code == 404)
                                              print('Request not found!');
                                            else if (code == 409)
                                              print('Someone else resolved ot already!');
                                            else if (code == 412)
                                              print('Shop has changed its pincode.');
                                            else
                                              print('Request resolution failed.');
                                          });
                                        },
                                        textColor: Colors.red,
                                        child: const Text('REJECT'),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: requests[index].status == 0,
                                    child: ButtonTheme(
                                      padding: EdgeInsets.all(10),
                                      child: FlatButton(
                                        onPressed: () {
                                          RequestService.resolveRequestApi(requests[index], user, 1)
                                              .then((code) {
                                            // TODO: Need to add a proper message on UI.
                                            if (code == 200)
                                              print('Authorized.');
                                            else if (code == 404)
                                              print('Request not found!');
                                            else if (code == 409)
                                              print('Someone else resolved ot already!');
                                            else if (code == 412)
                                              print('Shop has changed its pincode.');
                                            else
                                              print('Request resolution failed.');
                                          });
                                        },
                                        textColor: Colors.blue,
                                        child: const Text('AUTHORIZE'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        onReceiveJson: onReceiveJson,
      ),
    ]);
  }
}
