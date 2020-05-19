import 'package:token_system/Entities/abstract.dart';

class User extends Entity {
  int id;
  String name;
  String email;
  String mobileNumber;
  String aadhaarNumber;
  String state;
  String district;
  String pincode;
  int mobileVerification;

  User({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.aadhaarNumber,
    this.state,
    this.district,
    this.pincode,
    this.mobileVerification,
  });

  Map<String, dynamic> registerToJson(String password) => {
        "name": this.name,
        "email": this.email,
        "mobileNumber": this.mobileNumber,
        "password": password,
        "aadhaarNumber": this.aadhaarNumber,
        "pincode": this.pincode,
      };

  Map<String, dynamic> updateToJson(
          {String name, String mobileNumber, String aadhaarNumber, String pincode}) =>
      {
        "id": this.id.toString(),
        "name": name ?? this.name,
        "mobileNumber": mobileNumber ?? this.mobileNumber,
        "aadhaarNumber": aadhaarNumber ?? this.aadhaarNumber,
        "pincode": pincode ?? this.pincode,
      };

  factory User.verifyFromJson(Map<String, dynamic> json, String email) {
    return User(
        id: json['id'] as int,
        name: json['name'] as String,
        email: email,
        mobileNumber: json['mobileNumber'] as String,
        aadhaarNumber: json['aadhaarNumber'] as String,
        state: json['state'] as String,
        district: json['district'] as String,
        pincode: json['pincode'] as String,
        mobileVerification: json['mobileVerification'] as int);
  }
}
