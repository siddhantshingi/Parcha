import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:token_system/Entities/user.dart';
import 'package:token_system/components/title.dart';
import 'package:token_system/screens/register.dart';
import 'package:token_system/screens/home.dart';

enum SignAs { user, shop, authority }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  var _passkey = GlobalKey<FormFieldState>();
  SignAs _selected = SignAs.user;

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
                  //forgot password screen
                },
                textColor: Colors.blue,
                child: Text('Forgot Password'),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blueGrey,
                  child: Text(getAs(_selected) + ' Login'),
                  onPressed: () {
                    // FIXED: add validation function
                    // TODO: call login API
                    // TODO: don't handle passwords in raw text
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      print(_email);
                      print(_passkey.currentState.value);

                      // TODO: get user from Login API here
                      User u = new User();
                      u.email = _email;
                      u.contactNumber = 'Not added';
                      u.aadharNumber = 'Not added';
                      u.pincode = '000000';
                      u.name = 'User';

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserHome(user: u)),
                      );
                    }
                  },
                ),
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
