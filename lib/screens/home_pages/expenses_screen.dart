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
  static const routeName = '/expenses-screen';

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  bool _loading = false;
  bool _isInit = true;
  List<ExpenseModel> originalList = [];
  List<ExpenseModel> filteredList = [];
  DateTime startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month - 1,
    DateTime.now().day,
  );
  String prevDate = DateTime(1990, 10, 10).toString();
  String currentDate = '';
  DateTime endDate = DateTime.now();
  int? expTypeId;
  String? expTypeName;
  String _filter = 'All';

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      final modalRoute = ModalRoute.of(context);
      Map<String, dynamic>? arguments;
      if (modalRoute != null) {
        arguments = modalRoute.settings.arguments as Map<String, dynamic>?;
      }
      expTypeId = arguments?['expTypeId'];
      expTypeName = arguments?['expTypeName'];

      final _user = Provider.of<UserModel>(context, listen: false);
      final _expense = Provider.of<ExpenseProvider>(context, listen: false);
      if (!_expense.expenses.getIsDone() || expTypeId != null) {
        List<ExpenseModel>? result = await _expense.getExpenses(
          _user.uid,
          startDate: startDate,
          endDate: endDate,
          expTypeId: expTypeId,
        );

        if (expTypeId == null) {
          _expense.expenses.setList(result);
          if (_expense.expenses.getList() != null) {
            _expense.expenses.setIsDone(true);
          }
        } else {
          filteredList = result ?? [];
          originalList = result ?? [];
        }
      }

      if (_expense.expenses.getIsDone() && expTypeId == null) {
        filteredList = _expense.expenses.getList()!;
        originalList = _expense.expenses.getList()!;
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
    if (filter != 'All') {
      filteredList = list
          .where(
            (element) => element.status == filter,
          )
          .toList();
    } else {
      filteredList = list;
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);
    final _expense = Provider.of<ExpenseProvider>(context, listen: true);

    void updateFilteredList() {
      setState(() {
        filteredList = _expense.expenses.getList()!;
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 241, 245, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(235, 241, 245, 1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _loading
          ? loading
          : SafeArea(
              child: Column(
                children: [
                  sizedBox10,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                      child: Text(
                        expTypeName != null
                            ? '$expTypeName Expenses'
                            : 'Expenses',
                        style: const TextStyle(fontSize: 22),
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

                                List<ExpenseModel> result =
                                    await _expense.getExpenses(
                                  _user.uid,
                                  startDate: startDate,
                                  endDate: endDate,
                                  expTypeId: expTypeId,
                                );

                                filterList(
                                  result,
                                  _filter,
                                );
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
                                    originalList,
                                    _filter,
                                  );

                                  break;
                                case 'Rejected':
                                  _filter = 'Rejected';
                                  filterList(
                                    originalList,
                                    _filter,
                                  );

                                  break;
                                case 'Pending':
                                  _filter = 'Unknown';
                                  filterList(
                                    originalList,
                                    _filter,
                                  );

                                  break;
                                case 'All':
                                  _filter = 'All';
                                  prevDate = DateTime(1990, 10, 10).toString();
                                  currentDate = '';
                                  filteredList = originalList;
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
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 24, left: 8, right: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0)),
                      ),
                      child: ScrollConfiguration(
                        behavior: CustomScroll(),
                        child: ListView.builder(
                          itemCount: filteredList.length,
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
                                  key: UniqueKey(),
                                  expense: filteredList[index],
                                  refresh: () => updateFilteredList(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
