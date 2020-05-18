import 'package:token_system/Entities/abstract.dart';

class Shop extends Entity {
  int id;
  String email;
  String contactNumber;
  String name;
  String ownerName;
  int shopType;
  String address;
  String landmark;
  String password;
  String state;
  String district;
  String pincode;
  int verificationStatus;
  int shopSize=0;
  String closeTime='08 PM';
  String openTime='11 AM';
  int verifierId=-1;

  // Ctor : For checking only
  Shop.forUser({
    this.id,
    this.name,
    this.openTime,
    this.closeTime,
    this.address,
    this.landmark,
    this.contactNumber,
    this.pincode,
  });

  Shop({
    this.id,
    this.email,
    this.contactNumber,
    this.name,
    this.ownerName,
    this.shopType,
    this.address,
    this.landmark,
    this.password,
    this.state,
    this.district,
    this.pincode,
    this.verificationStatus,
    this.shopSize,
    this.closeTime,
    this.openTime,
    this.verifierId
  });

  Map<String, dynamic> toJson() =>
      {
        "id": this.id.toString(),
        "name": this.name,
        "email": this.email,
        "contactNumber": this.contactNumber,
        "shopType": this.shopType.toString(),
        "address": this.address,
        "landmark": this.landmark,
        "password": this.password,
        "state": this.state,
        "district": this.district,
        "pincode": this.pincode,
        "verificationStatus": this.verificationStatus.toString(),
        "shopSize": this.shopSize.toString(),
        "closeTime": this.closeTime,
        "openTime": this.openTime,
        "verifierId":this.verifierId.toString()
      };
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      contactNumber: json['contactNumber'] as String,
      shopType: json['shopType'] as int,
      address: json['address'] as String,
      landmark: json['landmark'] as String,
      password: json['password'] as String,
      state: json['state'] as String,
      district: json['district'] as String,
      pincode: json['pincode'] as String,
      verificationStatus: json['verificationStatus'] as int,
      shopSize: json['shopSize'] as int,
      closeTime: json['closeTime'] as String,
      openTime: json['openTime'] as String,
      verifierId: json['verifierId'] as int
    );
  }

}
