import 'package:token_system/Entities/abstract.dart';

class Authority extends Entity {
  int id;
  String email;
  String contactNumber;
  String name;
  String aadharNumber;
  String password;
  String state;
  String district;
  String pincode;
  int verificationStatus;

  Authority({
    this.id,
    this.email,
    this.contactNumber,
    this.name,
    this.aadharNumber,
    this.password,
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
        "aadharNumber": this.aadharNumber,
        "password": this.password,
        "state": this.state,
        "district": this.district,
        "pincode": this.pincode,
        "verificationStatus": this.verificationStatus.toString(),
      };
  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        contactNumber: json['contactNumber'] as String,
        aadharNumber: json['aadharNumber'] as String,
        password: json['password'] as String,
        state: json['state'] as String,
        district: json['district'] as String,
        pincode: json['pincode'] as String,
        verificationStatus: json['verificationStatus'] as int
    );
  }
}
