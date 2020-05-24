// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
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
    authVerification: json['authVerification'] as int,
  )..name = json['name'] as String;
}

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'shopName': instance.shopName,
      'ownerName': instance.ownerName,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'aadhaarNumber': instance.aadhaarNumber,
      'address': instance.address,
      'landmark': instance.landmark,
      'shopType': instance.shopType,
      'currOpeningTime': instance.currOpeningTime,
      'currClosingTime': instance.currClosingTime,
      'capacityApp': instance.capacityApp,
      'openingTimeApp': instance.openingTimeApp,
      'closingTimeApp': instance.closingTimeApp,
      'state': instance.state,
      'district': instance.district,
      'pincode': instance.pincode,
      'mobileVerification': instance.mobileVerification,
      'authVerification': instance.authVerification,
    };
