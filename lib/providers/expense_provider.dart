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
    expenses.getList()!.add(expense);
    dynamic result = await _expenseRepo.createExpense(
      expense.title,
      expense.type.id,
      expense.cost,
      expense.createdDate,
      token,
    );
    ExpenseModel? resultExpense = _expenseFromServer(result);

    if (resultExpense == null) {
      expenses.getList()!.remove(expense);
    } else {
      expense.id = resultExpense.id;
    }

    return resultExpense;
  }

  Future editExpense(ExpenseModel expense, String token) async {
    ExpenseModel existingModel =
        expenses.getList()!.where((element) => element.id == expense.id).first;
    existingModel.createdDate = expense.createdDate;
    existingModel.cost = expense.cost;
    existingModel.title = expense.title;
    existingModel.type = expense.type;

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
    expenses.getList()!.removeWhere((element) => element.id == id);
    return await _expenseRepo.deleteExpense(id, token);
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
    return _list;
  }

  bool getIsDone() {
    return _isDone;
  }
}
