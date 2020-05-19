import 'package:flutter/material.dart';
import 'package:token_system/Entities/abstract.dart';
import 'package:token_system/components/tab_navigator.dart';
import 'package:token_system/screens/components/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  final Entity user;
  final GlobalKey<TabNavigatorState> tn;
  final int userType;

  ProfileScreen(
      {Key key, @required this.user, @required this.tn, this.userType: 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(600.0, 50.0),
                ),
              ),
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 180,
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.person,
                    color: Colors.amber[800],
                    size: 100,
                  ),
                ),
              ),
            ),
          ]),
          Container(
            padding: EdgeInsets.only(
              top: 120,
              bottom: 50,
              left: 20,
              right: 20,
            ),
            child: Wrap(children: <Widget>[
              Card(
                elevation: 8.0,
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      user.name,
                      style: TextStyle(color: Colors.amber[800], fontSize: 30),
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
                          child: Text(user.mobileNumber),
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
                          child: Icon(Icons.email),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(user.email),
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
                          child: Icon(Icons.my_location),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(user.pincode),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Icon(Icons.assignment_ind),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(user.aadhaarNumber == null
                                ? 'NA'
                                : user.aadhaarNumber),
                          ),
                        ],
                      ),
                    ),
                    visible: user.aadhaarNumber == null,
                  ),
                  Visibility(
                    child: Padding(
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
                            child: Text(
                                user.address == null ? 'NA' : user.address),
                          ),
                        ],
                      ),
                    ),
                    visible: userType == 1,
                  ),
                  Visibility(
                    child: Padding(
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
                            child: Text(
                                user.landmark == null ? 'NA' : user.landmark),
                          ),
                        ],
                      ),
                    ),
                    visible: userType == 1,
                  ),
                ]),
              ),
            ]),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          tn.currentState.push(
            context,
            payload: EditProfileScreen(
              user: user,
              userType: this.userType,
            ),
          );
        },
        label: Text('Edit Profile'),
        icon: Icon(Icons.edit),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
