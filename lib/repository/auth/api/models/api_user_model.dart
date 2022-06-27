import 'dart:convert';

import 'package:intl/intl.dart';

class ApiUserModel {
  String? uid;
  final String? id;
  bool? isVerified;
  String? email;
  String? displayName;
  String? imageUrl;
  String? phoneNumber;
  DateTime? dob;
  String? address;
  String? city;
  String? province;
  String? country;
  String? bankNumber;
  String? bankName;
  String? bankBranch;
  String? companyName;

  ApiUserModel({
    this.uid,
    this.email,
    this.displayName,
    this.imageUrl,
    this.phoneNumber,
    this.id,
    this.isVerified,
    this.dob,
    this.address,
    this.city,
    this.province,
    this.country,
    this.bankNumber,
    this.bankName,
    this.bankBranch,
    this.companyName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': uid ?? '',
      'user': {
        'email': email ?? '',
        'name': displayName ?? '',
        'url_image': imageUrl ?? '',
        'phoneNumber': phoneNumber ?? '',
        'id': id ?? '',
        'isVerified': isVerified,
        'dob': dob == null ? null : DateFormat('dd/MM/yyyy').format(dob!),
        'company_name': companyName,
        'address': {
          'address': address,
          'city': city,
          'province': province,
          'country': country,
        },
        'bank': {
          'number': bankNumber,
          'name': bankName,
          'branch': bankBranch,
        },
      }
    };
  }

  factory ApiUserModel.fromMap(Map<String, dynamic> map) {
    return ApiUserModel(
      uid: map['token'] != null ? map['token'] as String : null,
      id: map['user']['id'].toString(),
      isVerified: map['user']['isVerified'],
      companyName: map['user']['company_name'],
      email:
          map['user']['email'] != null ? map['user']['email'] as String : null,
      phoneNumber: map['user']['phoneNumber'] != null
          ? map['user']['phoneNumber'] as String
          : null,
      displayName:
          map['user']['name'] != null ? map['user']['name'] as String : null,
      imageUrl: map['user']['url_image'] != null
          ? map['user']['url_image'] as String
          : null,
      dob: map['user']['dob'] != null
          ? DateTime.parse(map['user']['dob'])
          : null,
      address: map['user']['address']['address'] != null
          ? map['user']['address']['address'] as String
          : null,
      city: map['user']['address']['city'] != null
          ? map['user']['address']['city'] as String
          : null,
      province: map['user']['address']['province'] != null
          ? map['user']['address']['province'] as String
          : null,
      country: map['user']['address']['country'] != null
          ? map['user']['address']['country'] as String
          : null,
      bankNumber:
          map['user']['bank'] != null ? map['user']['bank']['number'] : null,
      bankName:
          map['user']['bank'] != null ? map['user']['bank']['name'] : null,
      bankBranch:
          map['user']['bank'] != null ? map['user']['bank']['branch'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiUserModel.fromJson(String source) =>
      ApiUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
