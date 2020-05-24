// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    mobileNumber: json['mobileNumber'] as String,
    aadhaarNumber: json['aadhaarNumber'] as String,
    state: json['state'] as String,
    district: json['district'] as String,
    pincode: json['pincode'] as String,
    mobileVerification: json['mobileVerification'] as int,
  )
    ..shopName = json['shopName'] as String
    ..ownerName = json['ownerName'] as String
    ..address = json['address'] as String
    ..landmark = json['landmark'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'shopName': instance.shopName,
      'ownerName': instance.ownerName,
      'address': instance.address,
      'landmark': instance.landmark,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'aadhaarNumber': instance.aadhaarNumber,
      'state': instance.state,
      'district': instance.district,
      'pincode': instance.pincode,
      'mobileVerification': instance.mobileVerification,
    };
