// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:expenso/providers/models/expense_type_model.dart';

List<ExpenseModel> expenseFromJson(String str) => List<ExpenseModel>.from(
    json.decode(str).map((x) => ExpenseModel.fromMap(x)));

String expenseToJson(List<ExpenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseModel {
  int? id;
  String title;
  double cost;
  DateTime createdDate;
  String? status;
  ExpenseTypeModel type;

  ExpenseModel({
    this.id,
    this.status = 'Unknown',
    required this.title,
    required this.cost,
    required this.createdDate,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'expenseFor': title,
      'expenseType_id': type.id,
      'expenseCost': cost,
      'createdDate': createdDate.toString(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map['id'] as int,
        status: map['status'] as String,
        type: ExpenseTypeModel.fromMap(map['expenseType']),
        title: map['expenseFor'] as String,
        cost: double.tryParse(map['expenseCost'].toString()) ??
            map['expenseCost'].toDouble(),
        createdDate: DateTime.parse(map['createdDate']));
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
