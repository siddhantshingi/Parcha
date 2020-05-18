import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/Services/miscServices.dart';
import 'package:token_system/Services/userService.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/Services/authorityService.dart';
import 'package:token_system/components/async_builder.dart';
import 'package:token_system/components/title.dart';
import 'package:token_system/screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  String _name = '';
  String _ownerName = '';
  String _email = '';
  String _mobile = '----------';
  String _aadhar = '------------';
  String _pincode = '';

  // Required for Shops
  String _address = 'XXX';
  String _landmark = 'XXX';
  int _shopType;
  SignAs _selected = SignAs.user;

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

  String validateEmail(String value) {
    if (!EmailValidator.validate(value))
      return 'Please enter a valid email address';
    else
      return null;
  }

  String validateConfirmPassword(String value) {
    if (value.isEmpty) return 'Enter confirm password';
    var password = _passKey.currentState.value;
    if (!(value == password)) return 'Confirm Password mismatch';
    return null;
  }

  bool isShop() {
    if (_selected == SignAs.shop) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Call the Shop Categories API
    var onReceiveJson = (snapshot) {
      // Construct List of Categories
      List<String> shopCategories = [];
      for (var item in snapshot.data['result']) {
        shopCategories.add(item['typeName']);
      }
      return shopCategories;
    };

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
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Register as : ',
                        style: TextStyle(fontSize: 20),
                      ),
                      DropdownButton<SignAs>(
                        value: _selected,
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.blueGrey,
                        ),
                        iconSize: 24,
                        elevation: 8,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                        ),
                        onChanged: (SignAs result) {
                          setState(() {
                            _selected = result;
                          });
                        },
                        items: <DropdownMenuItem<SignAs>>[
                          const DropdownMenuItem<SignAs>(
                            child: Text('User'),
                            value: SignAs.user,
                          ),
                          const DropdownMenuItem<SignAs>(
                            child: Text('Shop'),
                            value: SignAs.shop,
                          ),
                          const DropdownMenuItem<SignAs>(
                            child: Text('Authority'),
                            value: SignAs.authority,
                          ),
                        ],
                      ),
                    ],
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
                          labelText: isShop() ? 'Shop Name' : 'Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return isShop()
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
                              _ownerName = value;
                            });
                          },
                        ),
                      ),
                      visible: isShop(),
                    ),
                    Visibility(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueGrey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child: AsyncBuilder(
                            future: MiscService.getShopTypesApiCall(),
                            builder: (shopCategories) {
                              List<DropdownMenuItem> items = [];
                              for (var index = 0;
                                  index < shopCategories.length;
                                  index++) {
                                items.add(DropdownMenuItem(
                                  child: Text(shopCategories[index]),
                                  value: 2*index,
                                ));
                                items.add(DropdownMenuItem(
                                  child: Text(shopCategories[index]),
                                  value: 2*index + 1,
                                ));
                              }
                              return DropdownButton(
                                iconDisabledColor: Colors.blueGrey,
                                iconEnabledColor: Colors.blue,
                                hint: Text('Shop Type'),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                underline: Container(height: 0),
                                isExpanded: true,
                                items: items,
                                value: _shopType,
                                onChanged: (value) {
                                  setState(() {
                                    _shopType = value;
                                    print(_shopType);
                                  });
                                },
                              );
                            },
                            onReceiveJson: onReceiveJson,
                            size: 40,
                          ),
                        ),
                      ),
                      visible: isShop(),
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
                          if (value.length < 6)
                            return 'Password should be atleast 6 characters';
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
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Builder(builder: (BuildContext context) {
                        return RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blueGrey,
                            child: Text('Register'),
                            onPressed: () {
                              // FIXED: add validation function
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (_selected == SignAs.user) {
                                  User newUser = new User(
                                    id: 0,
                                    name: _name,
                                    email: _email,
                                    contactNumber: _mobile,
                                    password: _passKey.currentState.value,
                                    aadharNumber: _aadhar,
                                    pincode: _pincode,
                                    verificationStatus: 0,
                                  );
                                  UserService.registerApiCall(newUser)
                                      .then((code) {
                                    if (code == 200) {
                                      final snackbar = SnackBar(
                                        content:
                                            Text('Registration successful!'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                      // Pop screen if successful
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    } else if (code == 409) {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            'This Email ID already exists'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    } else {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            'Registration not successful. Please try again!'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    }
                                  });
                                } else if (_selected == SignAs.shop) {
                                  Shop newShop = new Shop(
                                      id: 0,
                                      name: _name,
                                      ownerName: _ownerName,
                                      email: _email,
                                      contactNumber: _mobile,
                                      password: _passKey.currentState.value,
                                      shopType: 1,
                                      address: _address,
                                      landmark: _landmark,
                                      pincode: _pincode,
                                      verificationStatus: 0,
                                      shopSize: _shopType);
                                  ShopService.registerApiCall(newShop)
                                      .then((code) {
                                    print('Inside Api call');
                                    if (code == 200) {
                                      final snackbar = SnackBar(
                                        content:
                                            Text('Registration successful!'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                      // Pop screen if successful
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    } else if (code == 409) {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            'This Email ID already exists'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    } else {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            'Registration not successful. Please try again!'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    }
                                  });
                                } else {
                                  Authority newAuth = new Authority(
                                    id: 0,
                                    name: _name,
                                    email: _email,
                                    contactNumber: _mobile,
                                    password: _passKey.currentState.value,
                                    aadharNumber: _aadhar,
                                    pincode: _pincode,
                                    verificationStatus: 0,
                                  );
                                  AuthorityService.registerApiCall(newAuth)
                                      .then((code) {
                                    if (code == 200) {
                                      final snackbar = SnackBar(
                                        content:
                                            Text('Registration successful!'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                      // Pop screen if successful
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.pop(context);
                                      });
                                    } else if (code == 409) {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            'This Email ID already exists'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    } else {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            'Registration not successful. Please try again!'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    }
                                  });
                                }
                              }
                            });
                      }),
                    )
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
