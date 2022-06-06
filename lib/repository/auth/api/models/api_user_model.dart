import 'dart:convert';

class ApiUserModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? imageUrl;
  ApiUserModel({this.uid, this.email, this.displayName, this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': uid ?? '',
      'user': {
        'email': email ?? '',
        'name': displayName ?? '',
        'url_image': imageUrl ?? '',
      }
    };
  }

  factory ApiUserModel.fromMap(Map<String, dynamic> map) {
    return ApiUserModel(
      uid: map['token'] != null ? map['token'] as String : null,
      email:
          map['user']['email'] != null ? map['user']['email'] as String : null,
      displayName:
          map['user']['name'] != null ? map['user']['name'] as String : null,
      imageUrl: map['user']['url_image'] != null
          ? map['user']['url_image'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiUserModel.fromJson(String source) =>
      ApiUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ApiUserModel copyWith(
      {String? uid, String? email, String? displayName, String? imageUrl}) {
    return ApiUserModel(
        uid: uid, email: email, displayName: displayName, imageUrl: imageUrl);
  }
}
