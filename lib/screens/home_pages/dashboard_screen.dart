import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenso/constants.dart';
import 'package:expenso/theme/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';
import '../../providers/expense_type_provider.dart';
import '../../providers/models/expense_model.dart';
import '../../providers/models/user_model.dart';
import '../../theme/themes.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool _loading = false;
  bool _isInit = true;
  List<ExpenseModel> filteredList = [];
  bool isMonth = true;
  GraphType graphType = GraphType.month;
  List<double> graphXValues = [1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4];
  List<double> graphYValues = [10, 30, 50];
  Map<String, List<double>>? statsResult;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      isMonth = true;
      final _user = Provider.of<UserModel>(context, listen: false);

      final _expenseTypes =
          Provider.of<ExpenseTypeProvider>(context, listen: false);

      // For ExpenseTypes
      if (!_expenseTypes.isDone) {
        await _expenseTypes.getExpenseTypes(_user.uid);
      }

      if (_expenseTypes.expenseTypes != null) {
        _expenseTypes.isDone = true;
      }

      final _expense = Provider.of<ExpenseProvider>(context, listen: false);

      // For recentExpenses
      if (!_expense.recentExpenses.getIsDone()) {
        List<ExpenseModel>? result = await _expense.getExpenses(_user.uid,
            startDate: null,
            endDate: null,
            skip: 0,
            take: 10,
            status: 'Approved');
        _expense.recentExpenses.setList(result);

        if (_expense.recentExpenses.getList() != null) {
          _expense.recentExpenses.setIsDone(true);
        }
      }

      if (_expense.recentExpenses.getIsDone()) {
        filteredList = _expense.recentExpenses.getList()!;
      }

      // For Expenses
      if (!_expense.expenses.getIsDone()) {
        List<ExpenseModel>? result = await _expense.getExpenses(
          _user.uid,
          startDate: DateTime(
            DateTime.now().year,
            DateTime.now().month - 1,
            DateTime.now().day,
          ),
          endDate: DateTime.now(),
        );
        _expense.expenses.setList(result);

        if (_expense.expenses.getList() != null) {
          _expense.expenses.setIsDone(true);
        }
      }

      statsResult = await _expense.getStats(_user.uid);

      graphXValues = statsResult!['month'] ?? graphXValues;
      graphYValues = statsResult!['graphYValuesForMonth'] ?? graphYValues;

      setState(() {
        _loading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);

    return _loading
        ? loading
        : SafeArea(
            child: Container(
              color: const Color.fromRGBO(235, 241, 245, 1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      minLeadingWidth: 10,
                      horizontalTitleGap: 10,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: _user.imageUrl == null
                            ? const Image(
                                image: AssetImage('assets/images/check.png'))
                            : CachedNetworkImage(
                                imageUrl: kBackendUrl + _user.imageUrl!,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                                errorWidget: (context, url, error) =>
                                    const Image(
                                        image: AssetImage(
                                            'assets/images/check.png')),
                              ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _user.name!,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(60, 90, 154, 1),
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Recomended actions for you',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: const TextStyle(
                              color: Color.fromRGBO(
                                3,
                                15,
                                40,
                                1,
                              ),
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Image(
                            image: AssetImage('assets/images/calendar.png')),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    sizedBox25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClassicStylishButton(
                          handler: () {
                            graphXValues =
                                statsResult!['month'] ?? graphXValues;
                            graphYValues =
                                statsResult!['graphYValuesForMonth'] ??
                                    graphYValues;

                            setState(() {
                              isMonth = true;
                              graphType = GraphType.month;
                            });
                          },
                          title: 'Month',
                          isClicked: isMonth,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ClassicStylishButton(
                          handler: () {
                            graphXValues = statsResult!['week'] ?? graphXValues;
                            graphYValues =
                                statsResult!['graphYValuesForWeek'] ??
                                    graphYValues;
                            setState(() {
                              isMonth = false;
                              graphType = GraphType.week;
                            });
                          },
                          title: 'Week',
                          isClicked: !isMonth,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LineChartSample2(
                          graphType: graphType,
                          graphXValues: graphXValues,
                          verticalValues: graphYValues,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.0, bottom: 8),
                        child: Text(
                          'Recent Approved Spendings',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox20,
                          ListView.builder(
                            itemCount: filteredList.length > 15
                                ? 15
                                : filteredList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ExpenseTile(
                                expense: filteredList[index],
                              );
                            },
                          )
                        ],
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
