import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenso/constants.dart';
import 'package:expenso/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
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
  final List<bool> _graphSelectButton = List.filled(3, false);

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });
      _graphSelectButton[0] = true;
      final _user = Provider.of<UserModel>(context, listen: false);
      final _expense = Provider.of<ExpenseProvider>(context, listen: false);
      if (!_expense.isFetchRecExpDone) {
        _expense.recentExpensesList = await _expense.getExpenses(_user.uid,
            date: null, skip: 0, take: 10, status: 'Approved');
        if (_expense.recentExpensesList != null) {
          _expense.isFetchRecExpDone = true;
        }
      }

      //Only approved Expenses
      if (_expense.recentExpensesList != null) {
        filteredList = _expense.recentExpensesList!;
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
    final _user = Provider.of<UserModel>(context, listen: false);
    final _auth = Provider.of<AuthProvider>(context, listen: false);

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
                      trailing: InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          setState(() {
                            _loading = true;
                          });
                          await _auth.signOut();
                        },
                        child: const Image(
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/bell.png'),
                        ),
                      ),
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
                            setState(() {
                              _graphSelectButton[0] = true;
                              _graphSelectButton[1] = false;
                              _graphSelectButton[2] = false;
                            });
                          },
                          title: 'Month',
                          isClicked: _graphSelectButton[0],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ClassicStylishButton(
                          handler: () {
                            setState(() {
                              _graphSelectButton[0] = false;
                              _graphSelectButton[1] = true;
                              _graphSelectButton[2] = false;
                            });
                          },
                          title: 'Week',
                          isClicked: _graphSelectButton[1],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ClassicStylishButton(
                          handler: () {
                            setState(() {
                              _graphSelectButton[0] = false;
                              _graphSelectButton[1] = false;
                              _graphSelectButton[2] = true;
                            });
                          },
                          title: 'Day',
                          isClicked: _graphSelectButton[2],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 300,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: LineChartSample2(),
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
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 28.0, top: 40, bottom: 8),
                            child: Text(
                              'Today',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ListView.builder(
                            itemCount: filteredList.length > 15
                                ? 15
                                : filteredList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ExpenseTile(
                                  title: filteredList[index].expenseFor,
                                  subTitle: filteredList[index]
                                      .expenseTypeName
                                      .toString(),
                                  price: filteredList[index]
                                      .expenseCost
                                      .toString(),
                                  image: filteredList[index].expenseTypeImage);
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
