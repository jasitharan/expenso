import 'package:expenso/providers/models/expense_model.dart';
import 'package:expenso/repository/expense/api/api_expense_repo.dart';
import 'package:expenso/repository/expense/expense_repo.dart';

class ExpenseProvider {
  final ExpenseRepo _expenseRepo = ApiExpenseRepo();

  List<ExpenseModel>? recentExpensesList = [];
  bool isFetchRecExpDone = false;

  ExpenseModel? _expenseFromServer(dynamic expense) {
    return expense != null ? ExpenseModel.fromJson(expense) : null;
  }

  Future createExpense(ExpenseModel expense, String token) async {
    dynamic result = await _expenseRepo.createExpense(expense.expenseFor,
        expense.expenseTypeId, expense.expenseCost, expense.createdDate, token);
    return _expenseFromServer(result);
  }

  Future editExpense(ExpenseModel expense, String token) async {
    dynamic result = await _expenseRepo.editExpense(
        expense.id!,
        expense.expenseFor,
        expense.expenseTypeId,
        expense.expenseCost,
        expense.createdDate,
        token);

    return _expenseFromServer(result);
  }

  Future getExpense(int id, String token) async {
    dynamic result = await _expenseRepo.getExpense(id, token);
    return _expenseFromServer(result);
  }

  Future getExpenses(String token,
      {DateTime? date, int? skip, int? take, String? status}) async {
    String query = '';
    if (date != null) {
      query = 'createdDate=${date.year}-${date.month}-${date.day}&';
    }

    if (status != null) {
      query += 'status=$status&';
    }

    if (skip != null && take != null) {
      query += 'skip=$skip&take=$take';
    }

    dynamic result = await _expenseRepo.getAllExpense(token, query);

    return result == null ? result : expenseFromJson(result);
  }

  Future deleteExpense(int id, String token) async {
    return await _expenseRepo.deleteExpense(id, token);
  }
}
