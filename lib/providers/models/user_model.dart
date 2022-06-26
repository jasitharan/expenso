// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final String id;
  bool isVerified = false;
  String email;
  String? name;
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

  UserModel({
    required this.uid,
    required this.id,
    required this.email,
    required this.isVerified,
    this.name,
    this.imageUrl,
    this.phoneNumber,
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
      'uid': uid,
      'id': id,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'dob': dob,
      'address': address,
      'city': city,
      'province': province,
      'country': country,
      'bankNumber': bankNumber,
      'bankName': bankName,
      'bankBranch': bankBranch,
      'companyName': companyName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      id: map['id'] as String,
      isVerified: map['isVerified'],
      email: map['email'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      phoneNumber: map['phoneNumber'],
      dob: map['dob'],
      address: map['address'],
      city: map['city'],
      province: map['province'],
      country: map['country'],
      bankNumber: map['bankNumber'],
      bankName: map['bankName'],
      bankBranch: map['bankBranch'],
      companyName: map['companyName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
