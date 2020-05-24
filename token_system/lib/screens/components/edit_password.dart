import 'package:flutter/material.dart';
import 'package:token_system/Entities/abstract.dart';
import 'package:token_system/Services/authorityService.dart';
import 'package:token_system/Services/shopService.dart';
import 'package:token_system/Services/userService.dart';

class EditPasswordScreen extends StatefulWidget {
  final Entity user;
  final int userType;

  EditPasswordScreen({Key key, @required this.user, this.userType: 0}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  var _oldPassKey = GlobalKey<FormFieldState>();

  String successMessage(int statusCode) {
    if (statusCode == 200)
      return 'Profile updated.';
    else
      return 'Update failed!';
  }

  String validateConfirmPassword(String value) {
    if (value.isEmpty) return 'Enter confirm password';
    var password = _passKey.currentState.value;
    if (!(value == password)) return 'Confirm Password mismatch';
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: TextFormField(
                          key: _oldPassKey,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Old Password',
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'Please Enter password';
                            if (value.length < 6) return 'Password should be atleast 6 characters';
                            return null;
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
                            labelText: 'New Password',
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'Please Enter password';
                            if (value.length < 6) return 'Password should be atleast 6 characters';
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
                            labelText: 'Confirm new password',
                          ),
                          validator: validateConfirmPassword,
                        ),
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
            String _password = _passKey.currentState.value;
            String _oldPassword = _oldPassKey.currentState.value;

            if (widget.userType == 0) {
              UserService.updatePasswordApi(widget.user.id, _oldPassword, _password).then((code) {
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
              ShopService.updatePasswordApi(widget.user.id, _oldPassword, _password).then((code) {
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
              AuthorityService.updatePasswordApi(widget.user.id, _oldPassword, _password)
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
        label: Text('Update Password'),
        icon: Icon(Icons.check),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
