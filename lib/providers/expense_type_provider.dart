import 'package:expenso/providers/models/expense_type_model.dart';
import 'package:expenso/repository/expenseType/api/api_expense_types_repo.dart';
import 'package:expenso/repository/expenseType/expense_type_repo.dart';

class ExpenseTypeProvider {
  final ExpenseTypeRepo _expenseTypesRepo = ApiExpenseTypesRepo();

  List<ExpenseTypeModel>? expenseTypes = [];
  bool isDone = false;

  // ExpenseTypeModel? _expenseFromServer(dynamic expense) {
  //   return expense != null ? ExpenseTypeModel.fromJson(expense) : null;
  // }

  Future getExpenseTypes(
    String token,
  ) async {
    dynamic result = await _expenseTypesRepo.getAllExpenseTypes(token);
    List<ExpenseTypeModel>? types;
    if (result != null) {
      types = expenseTypesFromJson(result);
      expenseTypes = types;
    }
    return types;
  }
}
