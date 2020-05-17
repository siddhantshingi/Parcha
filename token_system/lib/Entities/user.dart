import 'package:token_system/Entities/abstract.dart';

class User extends Entity {
  int id;
  String name;
  String email;
  String contactNumber = '----------';
  String password;
  String aadharNumber = '------------';
  String state;
  String district;
  String pincode;
  int verificationStatus=0;

  User({
    this.id,
    this.name,
    this.email,
    this.contactNumber,
    this.password,
    this.aadharNumber,
    this.state,
    this.district,
    this.pincode,
    this.verificationStatus,
  });

  Map<String, dynamic> toJson() =>
  {
    "id": this.id.toString(),
    "name": this.name,
    "email": this.email,
    "contactNumber": this.contactNumber,
    "password": this.password,
    "aadharNumber": this.aadharNumber,
    "state": this.state,
    "district": this.district,
    "pincode": this.pincode,
    "verificationStatus": this.verificationStatus.toString()
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      contactNumber: json['contactNumber'] as String,
      password: json['password'] as String,
      aadharNumber: json['aadharNumber'] as String,
      state: json['state'] as String,
      district: json['district'] as String,
      pincode: json['pincode'] as String,
      verificationStatus: json['verificationStatus'] as int,
    );
  }

}