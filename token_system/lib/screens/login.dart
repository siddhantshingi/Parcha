import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/Entities/shop.dart';
import 'package:token_system/Entities/authority.dart';
import 'package:token_system/components/title.dart';
import 'package:token_system/Services/userService.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/Services/authorityService.dart';
import 'package:token_system/screens/authority_home.dart';
import 'package:token_system/screens/register.dart';
import 'package:token_system/screens/user_home.dart';
import 'package:token_system/screens/shop_home.dart';

enum SignAs { user, shop, authority }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  var _passkey = GlobalKey<FormFieldState>();
  SignAs _selected = SignAs.user;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
        if(prefs.containsKey('signedAs')){
          String signAs = prefs.getString('signedAs');
          if(signAs=="user"){
            String entityString = prefs.getString('entityData');
            print(entityString);
            var userJson = jsonDecode(entityString);
            User u = User.fromJson(userJson);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UserHome(user: u)),
            );
          }else if(signAs=="shop"){
              String entityString = prefs.getString('entityData');
              print(entityString);
              var shopJson = jsonDecode(entityString);
              Shop s = Shop.fromJson(shopJson);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopHome(shop: s)),
              );
          }else if(signAs=="authority"){
              String entityString = prefs.getString('entityData');
              print(entityString);
              var authorityJson = jsonDecode(entityString);
              Authority a = Authority.fromJson(authorityJson);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AuthorityHome(user: a)),
              );
          }
        }else{
          print("SignUp, no saved sign in detected");
        }
    });
  }
  String errorMessage(int statusCode) {
    if (statusCode == 401)
      return 'Wrong password!';
    else if (statusCode == 404)
      return 'Email address not registered!';
    else
      return 'Login failed!';
  }

  String validateMobile(String value) {
    // Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digits';
    else
      return null;
  }

  String validateEmail(String value) {
    if (!EmailValidator.validate(value))
      return 'Please enter a valid email address';
    else
      return null;
  }

  String getAs(SignAs selected) {
    if (selected == SignAs.user)
      return 'User';
    else if (selected == SignAs.shop)
      return 'Shop';
    else
      return 'Authority';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          TitleWidget(),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            child: Row(children: <Widget>[
              Text(
                'Sign in as: ',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: DropdownButton<SignAs>(
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
              ),
            ]),
          ),
          Form(
            key: _formKey,
            child: Column(children: <Widget>[
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
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  obscureText: true,
                  key: _passkey,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  // TODO: forgot password screen
                },
                textColor: Colors.blue,
                child: Text('Forgot Password'),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Builder(builder: (BuildContext context) {
                  return RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blueGrey,
                    child: Text(getAs(_selected) + ' Login'),
                    onPressed: () {
                      // FIXED: add validation function
                      // FIXED: call login API
                      // TODO: don't handle passwords in raw text
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _password = _passkey.currentState.value;
                        if (_selected == SignAs.user) {
                          UserService.verifyApi(_email, _password).then((json) async {
                            if (json['statusCode'] == 200) {
                              User u = User.verifyFromJson(json['result'], _email);
                              // Login successful
                              String userString = jsonEncode(u);
                              var prefs = await SharedPreferences.getInstance();
                              prefs.setString('entityData', userString);
                              prefs.setString('signedAs', 'user');
                              print("set up entityData as");
                              print(userString);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserHome(user: u)),
                              );

                            } else {
                              // Login failed
                              final snackbar = SnackBar(
                                content: Text(errorMessage(json['statusCode'])),
                              );
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          });
                        } else if (_selected == SignAs.shop) {
                          ShopService.verifyApi(_email, _password).then((json) async {
                            if (json['statusCode'] == 200) {
                              Shop s = Shop.verifyFromJson(json['result'], _email);
                              // Login successful
                              String shopString = jsonEncode(s);
                              var prefs = await SharedPreferences.getInstance();
                              prefs.setString('entityData', shopString);
                              prefs.setString('signedAs', 'shop');
                              print("set up entityData as");
                              print(shopString);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShopHome(shop: s)),
                              );

                            } else {
                              // Login failed
                              final snackbar = SnackBar(
                                content: Text(errorMessage(json['statusCode'])),
                              );
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          });
                        } else {
                          AuthorityService.verifyApi(_email, _password).then((json) async {
                            if (json['statusCode'] == 200) {
                              Authority a = Authority.verifyFromJson(json['result'], _email);
                              // Login successful
                              String authorityString = jsonEncode(a);
                              var prefs = await SharedPreferences.getInstance();
                              prefs.setString('entityData', authorityString);
                              prefs.setString('signedAs', 'authority');
                              print("set up entityData as");
                              print(authorityString);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthorityHome(user: a)),
                              );

                            } else {
                              // Login failed
                              final snackbar = SnackBar(
                                content: Text(errorMessage(json['statusCode'])),
                              );
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          });
                        }
                      }
                    },
                  );
                }),
              ),
            ]),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text('Do not have an account?'),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        ]),
      ),
    );
  }
}
