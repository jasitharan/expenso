import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String prevDate = DateTime.now().subtract(const Duration(days: 1)).toString();
  String currentDate = '';

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      currentDate = prevDate;
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
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sizedBox40,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, bottom: 8),
                        child: Text(
                          'Pending Expenses',
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
                        String tempPrev = prevDate;
                        currentDate = DateFormat.yMMMMEEEEd()
                            .format(filteredList[index].createdDate);
                        prevDate = currentDate;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (currentDate != tempPrev) sizedBox10,
                            if (currentDate != tempPrev)
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  currentDate,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            if (currentDate != tempPrev) sizedBox20,
                            ExpenseTile(
                              title: filteredList[index].expenseFor,
                              subTitle: filteredList[index]
                                  .expenseTypeName
                                  .toString(),
                              status: filteredList[index].status,
                              price: filteredList[index].expenseCost.toString(),
                              image: filteredList[index].expenseTypeImage,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
