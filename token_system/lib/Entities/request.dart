import 'package:token_system/Entities/authority.dart';

class Request {
  int shopId;
  String shopName;
  String address;
  String openingTime;
  String closingTime;
  int capacity;
  String pincode;
  String createdAt;
  int status;
  int authId;
  String authMobile;
  String resolvedAt;

  Request(
      {this.shopId,
      this.shopName,
      this.address,
      this.openingTime,
      this.closingTime,
      this.capacity,
      this.pincode,
      this.createdAt,
      this.status,
      this.authId,
      this.authMobile,
      this.resolvedAt});

  Map<String, dynamic> createToJson() {
    if (this.capacity != null)
      return {
        "shopId": this.shopId.toString(),
        "shopName": this.shopName,
        "address": this.address,
        "pincode": this.pincode,
        "capacity": this.capacity.toString(),
      };
    else
      return {
        "shopId": this.shopId.toString(),
        "shopName": this.shopName,
        "address": this.address,
        "pincode": this.pincode,
        "openingTime": this.openingTime,
        "closingTime": this.closingTime,
      };
  }

  Map<String, dynamic> resolveToJson(Authority auth, int accepted) =>
      {
        "shopId": this.shopId.toString(),
        "createdAt": this.createdAt,
        "authId": auth.id.toString(),
        "authMobile": auth.mobileNumber,
        "authPincode": auth.pincode,
        "accepted": accepted.toString()
      };

  factory Request.pendingFromJson(Map<String, dynamic> json) {
    return Request(
        shopId: json['shopId'] as int,
        shopName: json['shopName'] as String,
        address: json['address'] as String,
        openingTime: json['openingTime'] as String,
        closingTime: json['closingTime'] as String,
        capacity : json['capacity'] as int,
        createdAt: json['createdAt'] as String);
  }

  factory Request.shopRequestFromJson(Map<String, dynamic> json, int shopId) {
    return Request(
        shopId: shopId,
        openingTime: json['openingTime'] as String,
        closingTime: json['closingTime'] as String,
        capacity : json['capacity'] as int,
        createdAt: json['createdAt'] as String,
        status: json['status'] as int,
        authId: json['authId'] as int,
        authMobile: json['authMobile'] as String,
        resolvedAt: json['resolvedAt'] as String);
  }

  factory Request.authRequestFromJson(Map<String, dynamic> json) {
    return Request(
        shopId: json['shopId'] as int,
        shopName: json['shopName'] as String,
        address: json['address'] as String,
        openingTime: json['openingTime'] as String,
        closingTime: json['closingTime'] as String,
        capacity : json['capacity'] as int,
        createdAt: json['createdAt'] as String,
        status: json['status'] as int,
        resolvedAt: json['resolvedAt'] as String);
  }

}
