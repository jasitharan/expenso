// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<ExpenseTypeModel> expenseTypesFromJson(String str) =>
    List<ExpenseTypeModel>.from(
        json.decode(str).map((x) => ExpenseTypeModel.fromMap(x)));

String expenseTypesToJson(List<ExpenseTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseTypeModel {
  final int id;
  final String name;
  final double costLimit;
  final String image;

  ExpenseTypeModel({
    required this.id,
    required this.name,
    required this.costLimit,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'expType': name,
      'expCostLimit': costLimit,
      'url_image': image
    };
  }

  factory ExpenseTypeModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTypeModel(
        id: map['id'] as int,
        name: map['expType'] as String,
        costLimit: double.tryParse(map['expCostLimit'].toString()) ??
            map['expCostLimit'].toDouble(),
        image: map['url_image'] as String);
  }

  String toJson() => json.encode(toMap());

  factory ExpenseTypeModel.fromJson(String source) =>
      ExpenseTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
