import 'package:flutter/material.dart';
import 'package:token_system/Entities/user.dart';

enum UserOptions { logout, editProfile }

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(600.0, 100.0),
                ),
              ),
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 200,
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
          Positioned.fill(
            top: 150,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Wrap(
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text(
                          user.name,
                          style:
                              TextStyle(color: Colors.amber[800], fontSize: 30),
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
                              child: Text(user.contactNumber),
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
                              child: Icon(Icons.location_on),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(user.pincode),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Edit Profile'),
        icon: Icon(Icons.edit),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
