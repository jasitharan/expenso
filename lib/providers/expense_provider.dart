import 'dart:convert';
import 'dart:math';

import 'package:expenso/providers/models/expense_model.dart';
import 'package:expenso/repository/expense/api/api_expense_repo.dart';
import 'package:expenso/repository/expense/expense_repo.dart';
import 'package:intl/intl.dart';

class ExpenseProvider {
  final ExpenseRepo _expenseRepo = ApiExpenseRepo();

  ExpenseStore recentExpenses = ExpenseStore([], false);
  ExpenseStore expenses = ExpenseStore([], false);

  ExpenseModel? _expenseFromServer(dynamic expense) {
    return expense != null ? ExpenseModel.fromJson(expense) : null;
  }

  Future createExpense(ExpenseModel expense, String token) async {
    dynamic result = await _expenseRepo.createExpense(
      expense.title,
      expense.type.id,
      expense.cost,
      expense.createdDate,
      token,
    );
    ExpenseModel? resultExpense = _expenseFromServer(result);

    if (resultExpense == null) {
      expenses.removeExpense(expense);
    } else {
      expense.id = resultExpense.id;
    }

    return resultExpense;
  }

  Future editExpense(ExpenseModel expense, String token) async {
    dynamic result = await _expenseRepo.editExpense(expense.id!, expense.title,
        expense.type.id, expense.cost, expense.createdDate, token);

    ExpenseModel? resultExpense = _expenseFromServer(result);

    return resultExpense;
  }

  Future getExpense(int id, String token) async {
    dynamic result = await _expenseRepo.getExpense(id, token);
    return _expenseFromServer(result);
  }

  Future getExpenses(
    String token, {
    DateTime? startDate,
    DateTime? endDate,
    int? skip,
    int? take,
    String? status,
    int? expTypeId,
  }) async {
    String query = '';
    if (startDate != null && endDate != null) {
      query =
          'startDate=${DateFormat("yyyy-MM-dd").format(startDate)}&endDate=${DateFormat("yyyy-MM-dd").format(endDate)}&';
    }

    if (status != null) {
      query += 'status=$status&';
    }

    if (skip != null && take != null) {
      query += 'skip=$skip&take=$take&';
    }

    if (expTypeId != null) {
      query += 'expenseType_id=$expTypeId';
    }

    dynamic result = await _expenseRepo.getAllExpense(token, query);

    return result == null ? result : expenseFromJson(result);
  }

  Future deleteExpense(int id, String token) async {
    return await _expenseRepo.deleteExpense(id, token);
  }

  Future<Map<String, List<double>>> getStats(String token) async {
    final result = await _expenseRepo.getStats(token);
    final resultObj = json.decode(result) as Map<String, dynamic>;
    List<double> months = [
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0
    ];

    List<double> weeks = [0.0, 0.0, 0.0, 0.0];

    for (var i = 0; i < resultObj['month'].length; i++) {
      int month = DateTime.parse(resultObj['month'][i]['createdDate']).month;
      double currentValue = double.parse(resultObj['month'][i]['expenseCost']);

      double value = months[month - 1];
      months[month - 1] = value + currentValue;
    }

    for (var i = 0; i < resultObj['week'].length; i++) {
      int week =
          (DateTime.parse(resultObj['week'][i]['createdDate']).day / 7).ceil();
      double currentValue = double.parse(resultObj['week'][i]['expenseCost']);
      double value = weeks[week - 1];

      weeks[week - 1] = value + currentValue;
    }

    Map<String, List<double>> stats = {
      'month': months,
      'week': weeks,
      'graphYValuesForMonth': [
        months.reduce(min),
        (months.reduce(max) + months.reduce(min)) / 2,
        months.reduce(max)
      ],
      'graphYValuesForWeek': [
        weeks.reduce(min),
        (weeks.reduce(max) + weeks.reduce(min)) / 2,
        weeks.reduce(max)
      ],
    };

    return stats;
  }
}

class ExpenseStore {
  List<ExpenseModel>? _list;
  bool _isDone = false;

  ExpenseStore(this._list, this._isDone);

  void setList(List<ExpenseModel>? list) {
    _list = list;
  }

  void setIsDone(bool isDone) {
    _isDone = isDone;
  }

  List<ExpenseModel>? getList() {
    return _list == null ? null : [..._list!];
  }

  bool getIsDone() {
    return _isDone;
  }

  void addExpense(ExpenseModel expense) {
    if (_list == null) return;
    int index = 0;

    if (_list!.isNotEmpty) {
      while (expense.createdDate.isBefore(_list![index].createdDate)) {
        index++;
        if (_list!.length == index) break;
      }
    }

    _list!.insert(index, expense);
  }

  void editExpense(ExpenseModel expense) {
    if (_list == null) return;
    ExpenseModel existingModel =
        _list!.where((element) => element.id == expense.id).first;
    int index = _list!.indexOf(existingModel);
    _list!.remove(existingModel);
    _list!.insert(index, expense);
  }

  void removeExpenseWithId(int id) {
    if (_list == null) return;
    ExpenseModel expense = _list!.where((element) => element.id == id).first;
    _list!.remove(expense);
  }

  void removeExpense(ExpenseModel expense) {
    if (_list == null) return;
    _list!.remove(expense);
  }
}
