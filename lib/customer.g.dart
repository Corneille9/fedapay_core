// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      phoneNumber: PhoneNumber.fromJson(json['phone_number'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone_number': instance.phoneNumber.toJson(),
    };
