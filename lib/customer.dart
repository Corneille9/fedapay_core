import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer extends Equatable{
  final String firstname;
  final String lastname;
  final String email;
  final PhoneNumber phoneNumber;

  const Customer({required this.firstname, required this.lastname, required this.email, required this.phoneNumber});

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  List<Object?> get props => [
    firstname,
    lastname,
    email,
    phoneNumber
  ];
}

class PhoneNumber{
  static const String defaultCountry = 'bj';
  final String number;
  final String country;

  PhoneNumber({required this.number, this.country=defaultCountry});

  Map<String, dynamic> toJson(){
    return {
      "number":number,
      "country":country
    };
  }
  factory PhoneNumber.fromJson(Map<String, dynamic> json)=>PhoneNumber(number: json["number"], country: json["country"]);
}