// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<ExpenseModel> expenseFromJson(String str) => List<ExpenseModel>.from(
    json.decode(str).map((x) => ExpenseModel.fromMap(x)));

String expenseToJson(List<ExpenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseModel {
  int? id;
  String expenseFor;
  int expenseTypeId;
  double expenseCost;
  DateTime createdDate;
  String? expenseTypeName;
  String? expenseTypeImage;
  String? status;

  ExpenseModel(
      {this.id,
      this.expenseTypeName,
      this.expenseTypeImage,
      this.status,
      required this.expenseFor,
      required this.expenseTypeId,
      required this.expenseCost,
      required this.createdDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'expenseFor': expenseFor,
      'expenseType_id': expenseTypeId,
      'expenseCost': expenseCost,
      'createdDate': createdDate.toString(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map['id'] as int,
        status: map['status'] as String,
        expenseTypeName: map['expenseType_name'] as String,
        expenseTypeImage: map['expenseType_image'] as String,
        expenseFor: map['expenseFor'] as String,
        expenseTypeId: map['expenseType_id'] as int,
        expenseCost: double.tryParse(map['expenseCost'].toString()) ??
            map['expenseCost'].toDouble(),
        createdDate: DateTime.parse(map['createdDate']));
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
