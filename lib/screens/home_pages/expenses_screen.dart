import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month - 1,
    DateTime.now().day,
  );
  String prevDate = DateTime(1990, 10, 10).toString();
  String currentDate = '';

  DateTime endDate = DateTime.now();

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      final _user = Provider.of<UserModel>(context, listen: false);
      final _expense = Provider.of<ExpenseProvider>(context, listen: false);
      if (!_expense.expenses.getIsDone()) {
        _expense.expenses.setList(await _expense.getExpenses(
          _user.uid,
          startDate: startDate,
          endDate: endDate,
        ));
        if (_expense.expenses.getList() != null) {
          _expense.expenses.setIsDone(true);
        }
      }

      if (_expense.expenses.getList() != null) {
        filteredList = _expense.expenses.getList()!;
      }

      setState(() {
        _loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void filterList(List<ExpenseModel> list, String filter) {
    prevDate = DateTime(1990, 10, 10).toString();
    currentDate = '';
    filteredList = list
        .where(
          (element) => element.status == filter,
        )
        .toList();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);
    final _expense = Provider.of<ExpenseProvider>(context, listen: false);
    String _filter = 'All';

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
                          'Expenses',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    sizedBox30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              '${DateFormat('dd/MM/yyyy').format(startDate)} => ${DateFormat('dd/MM/yyyy').format(endDate)}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(64, 142, 189, 1)),
                            ),
                            IconButton(
                              onPressed: () async {
                                final picked = await showDateRangePicker(
                                  context: context,
                                  lastDate: DateTime.now(),
                                  firstDate: DateTime(2019),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _loading = true;
                                  });

                                  startDate = picked.start;
                                  endDate = picked.end;

                                  if (_filter != 'All') {
                                    filterList(
                                      await _expense.getExpenses(_user.uid,
                                          startDate: startDate,
                                          endDate: endDate),
                                      _filter,
                                    );
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_today,
                                size: 24,
                                color: Color.fromRGBO(64, 142, 189, 1),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.filter_list,
                                size: 28,
                                color: Color.fromRGBO(64, 142, 189, 1),
                              ),
                              onSelected: (String result) {
                                switch (result) {
                                  case 'Approved':
                                    _filter = 'Approved';
                                    filterList(
                                      _expense.expenses.getList()!,
                                      _filter,
                                    );

                                    break;
                                  case 'Rejected':
                                    _filter = 'Rejected';
                                    filterList(
                                      _expense.expenses.getList()!,
                                      _filter,
                                    );

                                    break;
                                  case 'Pending':
                                    _filter = 'Unknown';
                                    filterList(
                                      _expense.expenses.getList()!,
                                      _filter,
                                    );

                                    break;
                                  case 'All':
                                    _filter = 'All';
                                    prevDate =
                                        DateTime(1990, 10, 10).toString();
                                    currentDate = '';
                                    filteredList = _expense.expenses.getList()!;
                                    setState(() {});
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Approved',
                                  child: Text('Approved'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Rejected',
                                  child: Text('Rejected'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Pending',
                                  child: Text('Pending'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizedBox20,
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
