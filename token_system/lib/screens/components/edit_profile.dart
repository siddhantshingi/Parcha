import 'package:flutter/material.dart';
import 'package:token_system/Entities/abstract.dart';
import 'package:token_system/Services/authorityService.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/Services/userService.dart';
import 'package:token_system/utils.dart';

class EditProfileScreen extends StatefulWidget {
  final Entity user;
  final int userType;

  EditProfileScreen({Key key, @required this.user, this.userType: 0}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _ownerName = '';
  String _mobile = '----------';
  String _aadhaar = '------------';
  String _pincode = '';

  // Required for Shops
  String _address = 'XXX';
  String _landmark = 'XXX';

  String successMessage(int statusCode) {
    // FIXED: UI popup to show this message
    if (statusCode == 200)
      return 'Profile updated.';
    else if (statusCode == 412)
      return 'Bad pincode!';
    else
      return 'Update failed!';
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
                            labelText: widget.userType == 1 ? 'Shop Name' : 'Name',
                          ),
                          initialValue: widget.user.name ?? widget.user.shopName,
                          validator: (value) {
                            if (value.isEmpty || value.trim() == '')
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
                            initialValue: widget.user.ownerName,
                            validator: (value) {
                              if (value.isEmpty || value.trim() == '')
                                return 'Please enter your name';
                              else
                                return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _ownerName = value;
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
                          initialValue: widget.user.mobileNumber,
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
                            labelText: 'aadhaar number',
                          ),
                          initialValue: widget.user.aadhaarNumber,
                          keyboardType: TextInputType.phone,
                          validator: validateAadhaar,
                          onSaved: (value) {
                            setState(() {
                              _aadhaar = value;
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
                          initialValue: widget.user.pincode,
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
                            initialValue: widget.user.address,
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
                            initialValue: widget.user.landmark,
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
          // FIXED: Call update user API and relevant status codes
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if (widget.userType == 0) {
              UserService.updateProfileApi(widget.user,
                      name: _name.trim(),
                      mobileNumber: _mobile.trim(),
                      aadhaarNumber: _aadhaar.trim(),
                      pincode: _pincode.trim())
                  .then((code) {
                final snackbar = SnackBar(
                  content: Text(successMessage(code)),
                );
                Scaffold.of(context).showSnackBar(snackbar);
                // Pop screen if successful
                if (code == 200) {
                  Navigator.pop(context);
                }
              });
            } else if (widget.userType == 1) {
              ShopService.updateProfileApi(widget.user,
                      shopName: _name.trim(),
                      ownerName: _ownerName.trim(),
                      mobileNumber: _mobile.trim(),
                      aadhaarNumber: _aadhaar.trim(),
                      address: _address.trim(),
                      landmark: _landmark.trim(),
                      pincode: _pincode.trim())
                  .then((code) {
                print('Inside Api call');
                final snackbar = SnackBar(
                  content: Text(successMessage(code)),
                );
                Scaffold.of(context).showSnackBar(snackbar);
                // Pop screen if successful
                if (code == 200) {
                  Navigator.pop(context);
                }
              });
            } else {
              AuthorityService.updateProfileApi(widget.user,
                      name: _name.trim(),
                      mobileNumber: _mobile.trim(),
                      aadhaarNumber: _aadhaar.trim(),
                      pincode: _pincode.trim())
                  .then((code) {
                final snackbar = SnackBar(
                  content: Text(successMessage(code)),
                );
                Scaffold.of(context).showSnackBar(snackbar);
                // Pop screen if successful
                if (code == 200) {
                  Navigator.pop(context);
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
