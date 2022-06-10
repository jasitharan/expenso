abstract class ExpenseRepo {
  Future createExpense(
    String expenseFor,
    int expenseTypeId,
    double expenseCost,
    DateTime createdDate,
    String token,
  );
  Future getExpense(
    int id,
    String token,
  );
  Future getAllExpense(
    String token,
    String query,
  );
  Future editExpense(
    int id,
    String expenseFor,
    int expenseTypeId,
    double expenseCost,
    DateTime createdDate,
    String token,
  );
  Future deleteExpense(
    int id,
    String token,
  );

  Future getStats(
    String token,
  );
}
