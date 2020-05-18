import 'package:token_system/Entities/abstract.dart';

class Shop extends Entity {
  int id;
  String shopName;
  String ownerName;
  String email;
  String mobileNumber;
  String aadhaarNumber;
  String address;
  String landmark;
  String shopType;
  String currOpeningTime;
  String currClosingTime;
  int capacityApp;
  String openingTimeApp;
  String closingTimeApp;
  String state;
  String district;
  String pincode;
//  int emailVerification;
  int mobileVerification;
  int authVerification;

  Shop(
      {this.id,
      this.shopName,
      this.ownerName,
      this.email,
      this.mobileNumber,
      this.aadhaarNumber,
      this.address,
      this.landmark,
      this.shopType,
      this.currOpeningTime,
      this.currClosingTime,
      this.capacityApp,
      this.openingTimeApp,
      this.closingTimeApp,
      this.state,
      this.district,
      this.pincode,
      this.mobileVerification,
      this.authVerification});

  Map<String, dynamic> registerToJson(String password, int shopTypeId) => {
        "shopName": this.shopName,
        "ownerName": this.ownerName,
        "email": this.email,
        "password": password,
        "mobileNumber": this.mobileNumber,
        "aadhaarNumber": this.aadhaarNumber,
        "address": this.address,
        "landmark": this.landmark,
        "shopTypeId": shopTypeId.toString(),
        "shopType": this.shopType,
        "pincode": this.pincode
      };

  Map<String, dynamic> updateToJson(
          {String shopName,
          String ownerName,
          String mobileNumber,
          String aadhaarNumber,
          String address,
          String landmark,
          int shopTypeId,
          String shopType,
          String currOpeningTime,
          String currClosingTime,
          String pincode}) =>
      {
        "id": this.id.toString(),
        "shopName": shopName ?? this.shopName,
        "ownerName": ownerName ?? this.ownerName,
        "mobileNumber": mobileNumber ?? this.mobileNumber,
        "aadhaarNumber": aadhaarNumber ?? this.aadhaarNumber,
        "address": address ?? this.address,
        "landmark": landmark ?? this.landmark,
        "shopTypeId": shopTypeId?.toString() ?? "0",
        "shopType": shopType ?? this.shopType,
        "currOpeningTime": currOpeningTime ?? this.currOpeningTime,
        "currClosingTime": currClosingTime ?? this.currClosingTime,
        "pincode": pincode ?? this.pincode
      };

  factory Shop.verifyFromJson(Map<String, dynamic> json, String email) {
    return Shop(
        id: json['id'] as int,
        shopName: json['shopName'] as String,
        ownerName: json['ownerName'] as String,
        email: json['email'] as String,
        mobileNumber: json['mobileNumber'] as String,
        aadhaarNumber: json['aadhaarNumber'] as String,
        address: json['address'] as String,
        landmark: json['landmark'] as String,
        shopType: json['shopType'] as String,
        currOpeningTime: json['currOpeningTime'] as String,
        currClosingTime: json['currClosingTime'] as String,
        capacityApp: json['capacityApp'] as int,
        openingTimeApp: json['openingTimeApp'] as String,
        closingTimeApp: json['closingTimeApp'] as String,
        state: json['state'] as String,
        district: json['district'] as String,
        pincode: json['pincode'] as String,
        mobileVerification: json['mobileVerification'] as int,
        authVerification: json['authVerification'] as int);
  }

  factory Shop.shopUserFromJson(Map<String, dynamic> json) {
    return Shop(
        id: json['id'] as int,
        shopName: json['shopName'] as String,
        ownerName: json['ownerName'] as String,
        mobileNumber: json['mobileNumber'] as String,
        address: json['address'] as String,
        landmark: json['landmark'] as String,
        shopType: json['shopType'] as String,
        currOpeningTime: json['currOpeningTime'] as String,
        currClosingTime: json['currClosingTime'] as String,
        capacityApp: json['capacityApp'] as int);
  }

  factory Shop.shopAuthFromJson(Map<String, dynamic> json, String email) {
    return Shop(
        id: json['id'] as int,
        shopName: json['shopName'] as String,
        ownerName: json['ownerName'] as String,
        mobileNumber: json['mobileNumber'] as String,
        aadhaarNumber: json['aadhaarNumber'] as String,
        address: json['address'] as String,
        landmark: json['landmark'] as String,
        shopType: json['shopType'] as String,
        capacityApp: json['capacityApp'] as int,
        openingTimeApp: json['openingTimeApp'] as String,
        closingTimeApp: json['closingTimeApp'] as String,
//        emailVerification: json['emailVerification'] as int,
        mobileVerification: json['mobileVerification'] as int,
        authVerification: json['authVerification'] as int);
  }
}
