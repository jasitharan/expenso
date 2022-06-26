// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<CompanyModel> companiesFromJson(String str) => List<CompanyModel>.from(
    json.decode(str).map((x) => CompanyModel.fromMap(x)));

String companiesToJson(List<CompanyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyModel {
  final int id;
  final String name;

  CompanyModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
