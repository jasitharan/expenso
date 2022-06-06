// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<ExpenseTypeModel> expenseTypesFromJson(String str) =>
    List<ExpenseTypeModel>.from(
        json.decode(str).map((x) => ExpenseTypeModel.fromMap(x)));

String expenseTypesToJson(List<ExpenseTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseTypeModel {
  final int id;
  final String expType;
  final double expCostLimit;
  final String expTypeImage;

  ExpenseTypeModel(
      {required this.id,
      required this.expType,
      required this.expCostLimit,
      required this.expTypeImage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'expType': expType,
      'expCostLimit': expCostLimit,
      'url_image': expTypeImage
    };
  }

  factory ExpenseTypeModel.fromMap(Map<String, dynamic> map) {
    return ExpenseTypeModel(
        id: map['id'] as int,
        expType: map['expType'] as String,
        expCostLimit: double.tryParse(map['expCostLimit'].toString()) ??
            map['expCostLimit'].toDouble(),
        expTypeImage: map['url_image'] as String);
  }

  String toJson() => json.encode(toMap());

  factory ExpenseTypeModel.fromJson(String source) =>
      ExpenseTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
