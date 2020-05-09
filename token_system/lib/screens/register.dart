import 'package:flutter/material.dart';
import '../Entities/user.dart';
import '../Services/userService.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  UserService userService;

  _RegisterState(){
    userService = new UserService();
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
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'TokenDown',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: contactNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact number',
                    ),
                  ),
                ),Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm password',
                    ),
                  ),
                ),Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: aadharNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Aadhar number',
                    ),
                  ),
                ),Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: stateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'State',
                    ),
                  ),
                ),Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: districtController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'District',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: pincodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pincode',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blueGrey,
                      child: Text('Register'),
                      onPressed: () {
                        // TODO: add validation function
                        User newUser = new User();
                        newUser.id = 0;
                        newUser.name = nameController.text;
                        newUser.email = emailController.text;
                        newUser.contactNumber = contactNumberController.text;
                        newUser.password = passwordController.text;
                        newUser.aadharNumber = aadharNumberController.text;
                        newUser.state = stateController.text;
                        newUser.district = districtController.text;
                        newUser.email = emailController.text;
                        newUser.pincode = pincodeController.text;
                        newUser.verificationStatus = 0;
                        print (newUser.toJson());
                        userService.registerApiCall(newUser);
                      },
                    )),
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
