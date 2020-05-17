import 'package:flutter/material.dart';
import 'package:token_system/Entities/abstract.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Services/authorityService.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/Services/userService.dart';

class EditProfileScreen extends StatefulWidget {
  final Entity user;
  final int userType;

  EditProfileScreen({Key key, @required this.user, this.userType: 0})
      : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _mobile = '----------';
  String _aadhar = '------------';
  String _pincode = '';

  // Required for Shops
  String _address = 'XXX';
  String _landmark = 'XXX';

  String validateMobile(String value) {
    // Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digits';
    else
      return null;
  }

  String validateAadhar(String value) {
    // Indian Mobile number are of 10 digit only
    if (value == null) return null;
    if (value.length != 12)
      return 'Aadhar must be of 12 digits only';
    else
      return null;
  }

  String validatePincode(String value) {
    // Indian Mobile number are of 10 digit only
    if (value.length != 6)
      return 'Pincode must be of 6 digits';
    else
      return null;
  }

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
          Container(
            padding: EdgeInsets.only(
              top: 150,
              bottom: 80,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Wrap(children: <Widget>[
                Card(
                  elevation: 8.0,
                  child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:
                                widget.userType == 1 ? 'Shop Name' : 'Name',
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return widget.userType == 1
                                  ? 'Please enter your Shop name'
                                  : 'Please enter your name';
                            else
                              return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                        ),
                      ),
                      Visibility(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Shop Owner Name',
                            ),
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter your name';
                              else
                                return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                        ),
                        visible: widget.userType == 1,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contact number',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: validateMobile,
                          onSaved: (value) {
                            setState(() {
                              _mobile = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Aadhar number',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: validateAadhar,
                          onSaved: (value) {
                            setState(() {
                              _aadhar = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Pincode',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: validatePincode,
                          onSaved: (value) {
                            setState(() {
                              _pincode = value;
                            });
                          },
                        ),
                      ),
                      Visibility(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Address',
                            ),
                            onSaved: (value) {
                              setState(() {
                                _address = value;
                              });
                            },
                          ),
                        ),
                        visible: widget.userType == 1,
                      ),
                      Visibility(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Landmark',
                            ),
                            onSaved: (value) {
                              setState(() {
                                _landmark = value;
                              });
                            },
                          ),
                        ),
                        visible: widget.userType == 1,
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Call update user API and relevant status codes
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if (widget.userType == 0) {
              User newUser = new User(
                id: 0,
                name: _name,
                contactNumber: _mobile,
                aadharNumber: _aadhar,
                pincode: _pincode,
              );
              UserService.registerApiCall(newUser).then((code) {
                if (code == 200) {
                  final snackbar = SnackBar(
                    content: Text('Registration successful!'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                  // Pop screen if successful
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                } else if (code == 409) {
                  final snackbar = SnackBar(
                    content: Text('This Email ID already exists'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                } else {
                  final snackbar = SnackBar(
                    content:
                        Text('Registration not successful. Please try again!'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              });
            } else if (widget.userType == 1) {
              Shop newShop = new Shop(
                  id: 0,
                  name: _name,
                  contactNumber: _mobile,
                  shopType: 1,
                  address: _address,
                  landmark: _landmark,
                  pincode: _pincode);
              ShopService.registerApiCall(newShop).then((code) {
                print('Inside Api call');
                if (code == 200) {
                  final snackbar = SnackBar(
                    content: Text('Registration successful!'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                  // Pop screen if successful
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                } else if (code == 409) {
                  final snackbar = SnackBar(
                    content: Text('This Email ID already exists'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                } else {
                  final snackbar = SnackBar(
                    content:
                        Text('Registration not successful. Please try again!'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              });
            } else {
              Authority newAuth = new Authority(
                id: 0,
                name: _name,
                contactNumber: _mobile,
                aadharNumber: _aadhar,
                pincode: _pincode,
              );
              AuthorityService.registerApiCall(newAuth).then((code) {
                if (code == 200) {
                  final snackbar = SnackBar(
                    content: Text('Registration successful!'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                  // Pop screen if successful
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                } else if (code == 409) {
                  final snackbar = SnackBar(
                    content: Text('This Email ID already exists'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                } else {
                  final snackbar = SnackBar(
                    content:
                        Text('Registration not successful. Please try again!'),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              });
            }
          }
        },
        label: Text('Update Profile'),
        icon: Icon(Icons.check),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
