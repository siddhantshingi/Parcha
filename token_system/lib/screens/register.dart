import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Services/userService.dart';
import 'package:token_system/components/title.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  String _name = '';
  String _email = '';
  String _mobile = '';
  String _aadhar = '';
  String _pincode = '';

  // TODO: State and district dropdown menu.
  String _state = '';
  String _district = '';

  UserService userService;

  _RegisterState() {
    userService = new UserService();
  }

  String validateMobile(String value) {
    // Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digits';
    else
      return null;
  }

  String validateAadhar(String value) {
    // Indian Mobile number are of 10 digit only
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

  String validateEmail(String value) {
    if (!EmailValidator.validate(value))
      return 'Please enter a valid email address';
    else
      return null;
  }

  String validateConfirmPassword(String value) {
    if (value.isEmpty) return 'Enter confirm password';
    var password = _passKey.currentState.value;
    if (!(value == password))
      return 'Confirm Password mismatch';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                TitleWidget(),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: validateEmail,
                        onSaved: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
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
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        key: _passKey,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Please Enter password';
                          if (value.length < 8)
                            return 'Password should be atleast 8 characters';
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm password',
                        ),
                        validator: validateConfirmPassword,
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
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'State',
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Please enter your state';
                          else
                            return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _state = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'District',
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Please enter your district';
                          else
                            return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _state = value;
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
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blueGrey,
                          child: Text('Register'),
                          onPressed: () {
                            // FIXED: add validation function
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              User newUser = new User();
                              newUser.id = 0;
                              newUser.name = _name;
                              newUser.email = _email;
                              newUser.contactNumber = _mobile;
                              newUser.password = _passKey.currentState.value;
                              newUser.aadharNumber = _aadhar;
                              newUser.state = _state;
                              newUser.district = _district;
                              newUser.pincode = _pincode;
                              newUser.verificationStatus = 0;
                              print(newUser.toJson());
                              userService.registerApiCall(newUser);
                              Navigator.pop(context);
                            }
                          },
                        )),
                  ]),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Already have an account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signin screen
                        Navigator.pop(context);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
