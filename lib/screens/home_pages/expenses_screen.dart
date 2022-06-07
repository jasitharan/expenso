import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/expense_provider.dart';
import '../../providers/models/expense_model.dart';
import '../../providers/models/user_model.dart';
import '../../theme/themes.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
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
      if (!_expense.todayExpenses.getIsDone()) {
        _expense.todayExpenses.setList(await _expense.getExpenses(
          _user.uid,
          startDate: DateTime(
            DateTime.now().year,
            DateTime.now().month - 1,
            DateTime.now().day,
          ),
          endDate: DateTime.now(),
        ));
        if (_expense.todayExpenses.getList() != null) {
          _expense.todayExpenses.setIsDone(true);
        }
      }

      //Only approved Expenses
      if (_expense.todayExpenses.getList() != null) {
        filteredList = _expense.todayExpenses
            .getList()!
            .where((element) => element.status != 'Unknown')
            .toList();
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
          : SafeArea(
              child: Column(
                children: [
                  sizedBox40,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, bottom: 8),
                      child: Text(
                        'Expenses',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  sizedBox30,
                  ListView.builder(
                    itemCount: filteredList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExpenseTile(
                        title: filteredList[index].expenseFor,
                        subTitle:
                            filteredList[index].expenseTypeName.toString(),
                        status: filteredList[index].status,
                        price: filteredList[index].expenseCost.toString(),
                        image: filteredList[index].expenseTypeImage,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
