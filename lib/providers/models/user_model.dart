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
  UserModel({
    required this.uid,
    required this.id,
    required this.email,
    required this.isVerified,
    this.name,
    this.imageUrl,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
