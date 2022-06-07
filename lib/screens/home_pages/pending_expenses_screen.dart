import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/expense_provider.dart';
import '../../providers/models/expense_model.dart';
import '../../providers/models/user_model.dart';
import '../../theme/themes.dart';

class PendingExpensesScreen extends StatefulWidget {
  const PendingExpensesScreen({Key? key}) : super(key: key);

  @override
  State<PendingExpensesScreen> createState() => _PendingExpensesScreenState();
}

class _PendingExpensesScreenState extends State<PendingExpensesScreen> {
  bool _loading = false;
  bool _isInit = true;
  List<ExpenseModel> filteredList = [];

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      final _user = Provider.of<UserModel>(context, listen: false);
      final _expense = Provider.of<ExpenseProvider>(context, listen: false);
      if (!_expense.pendingExpenses.getIsDone()) {
        _expense.pendingExpenses.setList(
          await _expense.getExpenses(
            _user.uid,
            status: 'Unknown',
          ),
        );
        if (_expense.pendingExpenses.getList() != null) {
          _expense.pendingExpenses.setIsDone(true);
        }
      }

      //Only approved Expenses
      if (_expense.pendingExpenses.getList() != null) {
        filteredList = _expense.pendingExpenses.getList()!;
      }

      setState(() {
        _loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? loading
            : ListView.builder(
                itemCount: filteredList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ExpenseTile(
                      title: filteredList[index].expenseFor,
                      subTitle: filteredList[index].expenseTypeName.toString(),
                      price: filteredList[index].expenseCost.toString(),
                      image: filteredList[index].expenseTypeImage);
                },
              ));
  }
}
